//
//  Covid19ViewController.swift
//  Personal
//
//  Created by 으정이 on 2021/09/09.
//

import UIKit

protocol SubDisplayLogic: AnyObject {
    var data: [Sub.FetchData.Covid19] { get set }
    func displayFetchedCovidData(data: [Sub.FetchData.Covid19])
    func displayUserInfo(user: Sub.FetchData.UserInfo)
}
@available(iOS 13.0, *)
class SubViewController: BaseViewController, SubDisplayLogic {
    
    var interactor: SubBusinessLogic?
    var router: (NSObjectProtocol & SubRoutingLogic & SubDataPassing)?
    
    //MARK: - Properties
    let tableView: UITableView = UITableView()
    var pagingNum: Int = 0
    var data: [Sub.FetchData.Covid19] = []
    private var refreshControl = UIRefreshControl()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Delete indicator
        //        loadingIndicator.isAnimating = false
        //        loadingIndicator.isHidden = true
        //        removeLoadingIndicator()
        
        uiSetup()
        
        
    }
    
    func setup() {
        let viewController = self
        let interactor = SubInteractor()
        let presenter = SubPresenter()
        let router = SubRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.viewId = interactor
        
        //        worker = SubWorker()
    }
    
    func uiSetup() {
        //UI Create and Setting
        guard let viewId = router?.viewId?.viewId?.viewId else {
            return
        }
        switch viewId {
        case "Covid19":
            Logger.i("SubVC Name is Covid19.")
            
            //TableView Setting
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.prefetchDataSource = self
            self.tableView.refreshControl = self.refreshControl
            self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
            tableView.register(CenterEachCell.self, forCellReuseIdentifier: "CenterEachCell")
            
            
            //Indicator
            overrideUserInterfaceStyle = .light
            
            //Add Views
            self.view.addSubViews([tableView])
            
            tableView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            
            //로딩을 시작해야 하는 부분에서 호출
            //            loadingIndicator.isAnimating = true
            //            loadingIndicator.isHidden = false
            
            //Data Setting
            self.fetchDataFromServer("\(self.pagingNum)")
            break
        case "KakaoLogin":
            self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
            
            //View Create
            let loginButton = UIButton()
            loginButton.addTarget(self, action: #selector(kakaoLoginClicked), for: .touchUpInside)
            loginButton.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            loginButton.setTitle("카카오 간편로그인", for: .normal)
            
            //Add Views
            self.view.addSubViews([loginButton])
            
            loginButton.snp.makeConstraints { make in
                make.height.equalTo(50)
                
                //safeArea top inset과 navigationbar height와 지정 padding을 더하여 버튼 위치를 정함.
                let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
                let window = UIApplication.shared.windows.first
                let topPadding: CGFloat = 10
                
                if let topSafeArea = window?.safeAreaInsets.top {
                    Logger.d("safeAria top inset = \(topSafeArea)")
                    Logger.d("navigationBar Height = \(navigationBarHeight)")
                    make.top.equalTo(topSafeArea + topPadding + navigationBarHeight)
                } else {
                    Logger.d("navigationBar Height = \(navigationBarHeight)")
                    make.top.equalTo(44 + topPadding + navigationBarHeight)
                }
                make.leading.equalTo(10)
                make.trailing.equalTo(-10)
                
            }
            break
        default:
            Logger.i("SubVC Name is : \(self.router?.viewId?.viewId?.viewId)...")
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @objc func refresh() {
        self.data.removeAll()
        self.pagingNum = 0
        self.tableView.reloadData()
    }
    
    @objc func kakaoLoginClicked(sender: Any?) {
        
        interactor?.kakaoLogin()
    }
    
    func displayUserInfo(user: Sub.FetchData.UserInfo) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
            //데이터 다시 받기
            self.fetchDataFromServer("\(self.pagingNum)")
        }
    }
    
    
    /// 데이터 업데이트
    /// - Parameter pagingNum: 페이지 번호
    func fetchDataFromServer(_ pagingNum: String) {
        self.startLoadingIndicator()
        interactor?.fetchCovid19DataFromServer(page: "\(self.pagingNum)", perPage: "20")
        
        
    }
    func displayFetchedCovidData(data: [Sub.FetchData.Covid19]) {
        self.data = data
        self.tableView.reloadData()
        self.stopLoadingIndicator()
    }
}

//MARK: UITableView Extension: Delegate, DataSource, DataSourcePrefetching
@available(iOS 13.0, *)
extension SubViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    // 페이징, 데이터 추가
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        //        Logger.i("data Cout : \(self.data.count)")
        for indexPath in indexPaths {
            //            Logger.d("indexPath row : \(indexPath.row)")
            if data.count - 1 == indexPath.row {
                self.pagingNum += 1
                self.fetchDataFromServer("\(self.pagingNum)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eachData = self.data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CenterEachCell", for: indexPath) as? CenterEachCell
        
        //각 데이터 있는지 확인
        guard let address = eachData.address, let facilityName = eachData.facilityName, let updatedAt = eachData.updatedAt else {
            return cell!
        }
        cell?.addressLabel?.text = "주소: \(address)"
        cell?.facilityNameLabel?.text = "\(facilityName)"
        cell?.facilityNameLabel?.setAsMainTitle()
        cell?.updatedAtLabel?.attributedText = "업데이트 일자: \(updatedAt)".strikeThrough()
        return cell!
    }
    
}


//MARK: Kakao Login
extension SubViewController {
    
    func filterConstraint(view: UIView?, filters: [NSLayoutConstraint.Attribute], secondItem: Bool) -> [NSLayoutConstraint]{
        guard let _view = view else {
            return []
        }
        var result: [NSLayoutConstraint] = []
        let constraints = _view.constraints
        
        for attr in filters {
            if secondItem == true {
                result.append(contentsOf: constraints.filter({
                    
                    return $0.firstAttribute == attr
                }))
            } else {
                result.append(contentsOf: constraints.filter({
                    return $0.firstAttribute == attr && $0.secondItem == nil
                }))
            }
        }
        
        return result
    }
    
    /// Deprecated: runtime issue, constraint issue 발생...
    /// - Parameters:
    ///   - alert: alert
    ///   - toSize: 변경하고자 하는 size
    func changeAlertConstraints(alert: UIAlertController, size toSize: CGSize) {
        
        var constraints: [NSLayoutConstraint] = []
        alert.view.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(contentsOf: self.filterConstraint(view: alert.view, filters: [.width, .height], secondItem: true))
        
        //        let alertWidthAndHeightConstraints = alert.view.constraints.filter({
        //            return ($0.firstAttribute == .width || $0.firstAttribute == .height)
        //        })
        
        alert.view.removeConstraints(constraints)
        constraints.removeAll()
        
        let newWidthConstraint = NSLayoutConstraint(item: alert.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: toSize.width)
        let newHeightConstraint = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: toSize.height)
        
        alert.view.addConstraints([newWidthConstraint, newHeightConstraint])
        
        
        let firstContainer = alert.view.subviews[0]
        firstContainer.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(contentsOf: self.filterConstraint(view: firstContainer, filters: [.width, .height], secondItem: false))
        //        let firstContainerWidthAndHeightConstraints = firstContainer.constraints.filter({
        //            return ($0.firstAttribute == .width && $0.secondItem == nil) || ($0.firstAttribute == .height && $0.secondItem == nil)
        //        })
        
        firstContainer.removeConstraints(constraints)
        constraints.removeAll()
        
        let firstContainerNewWidthConstraint = NSLayoutConstraint(item: firstContainer, attribute: .width, relatedBy: .equal, toItem: alert.view, attribute: .width, multiplier: 1, constant: 0)
        let firstContainerNewHeightConstraint = NSLayoutConstraint(item: firstContainer, attribute: .height, relatedBy: .equal, toItem: alert.view, attribute: .height, multiplier: 1, constant: 0)
        
        alert.view.addConstraints([firstContainerNewWidthConstraint, firstContainerNewHeightConstraint])
        
        /*
         위의 코드를 아래와 같이 잘 못 써서 오류가 남 (크래시)
         firstContainer.addConstraints([firstContainerNewWidthConstraint, firstContainerNewHeightConstraint])
         
         2021-09-21 22:01:38.875712+0900 Personal[6968:652437] [LayoutConstraints] The view hierarchy is not prepared for the constraint: <NSLayoutConstraint:0x600002ac20d0 UIView:0x7fe42fc20660.width == _UIAlertControllerView:0x7fe42fc20080'카카오 유저 정보'.width   (inactive)>
         When added to a view, the constraint's items must be descendants of that view (or the view itself). This will crash if the constraint needs to be resolved before the view hierarchy is assembled. Break on -[UIView(UIConstraintBasedLayout) _viewHierarchyUnpreparedForConstraint:] to debug.
         2021-09-21 22:01:38.875932+0900 Personal[6968:652437] [LayoutConstraints] The view hierarchy is not prepared for the constraint: <NSLayoutConstraint:0x600002ac5f40 UIView:0x7fe42fc20660.height == _UIAlertControllerView:0x7fe42fc20080'카카오 유저 정보'.height   (inactive)>
         When added to a view, the constraint's items must be descendants of that view (or the view itself). This will crash if the constraint needs to be resolved before the view hierarchy is assembled. Break on -[UIView(UIConstraintBasedLayout) _viewHierarchyUnpreparedForConstraint:] to debug.
         */
        //first child of firstContainer
        let innerBackground = firstContainer.subviews[0]
        constraints.append(contentsOf: self.filterConstraint(view: innerBackground, filters: [.width, .height], secondItem: false))
        let innerWidthAndHeightConstraints = innerBackground.constraints.filter({
            return ($0.firstAttribute == .width && $0.secondItem == nil) || ($0.firstAttribute == .height && $0.secondItem == nil)
        })
        innerBackground.removeConstraints(constraints)
        constraints.removeAll()
        
        let newWidthConstraintOfInnerBackgroud = NSLayoutConstraint(item: innerBackground, attribute: .width, relatedBy: .equal, toItem: firstContainer, attribute: .width, multiplier: 1, constant: 0)
        let newHeightConstraintOfInnerBackgroud = NSLayoutConstraint(item: innerBackground, attribute: .height, relatedBy: .equal, toItem: firstContainer, attribute: .height, multiplier: 1, constant: 0)
        
        firstContainer.addConstraints([newWidthConstraintOfInnerBackgroud,newHeightConstraintOfInnerBackgroud])
        
        //        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func openAlert(user:Sub.FetchData.UserInfo) {
        //로그인 버튼을 클릭하면 팝업뷰를 띄우면서 이미지도 보이게 하기.
        // Logger.i(user)
        /*
         UserInfo(nickname: Optional("닉네임"), profileImageUrl: Optional(프로필 주소), thumbnailImageUrl: Optional(썸네일 주소 - 프로필 이미지보다 크기가 더 작은 것으로 보임 - 같은 이미지인데 화질이 더 안 좋음))
         */
        
        let alert = UIAlertController(title: "카카오 유저 정보", message: "\(user.nickname ?? "이름없음")", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        let imageView = UIImageView()
        let newWidth = UIScreen.main.bounds.width * 0.9
        let newHeight = UIScreen.main.bounds.height * 0.6
        alert.addAction(action)
        alert.view.addSubview(imageView)
        
        //아래 메서드에서 런타임, 컨스트레인트 이슈 발생
        changeAlertConstraints(alert: alert, size: CGSize(width: newWidth, height: newHeight))
        
        
        
        //user 정보에서 이미지 url이 있으면 url에서 이미지를 가져오고 없으면 기본 이미지를 씀
        setUserImage(imageView, url: user.profileImageUrl)
        
        //이미지 크기를 지정
        //단 이 모든 크기가 전체 크기를 넘어서는 안됨.
        //처음에 이미지 크기를 정할 때 화면 크기에 따라 다이나믹하게 변하게 하면 됨.
        let imageSize = self.view.bounds.width * 0.8
        imageView.contentMode = .scaleToFill
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(imageSize)
            make.height.equalTo(imageSize)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func setUserImage(_ imgView: UIImageView, url: URL?) {
        var image: UIImage?
        
        guard let _url = url else {
            //이미지 url이 없음
            image = UIImage.getPlaceholder(size: .zero)
            imgView.image = image
            return
        }
        
        //이미지 url이 있음
        imgView.loadImageWithURL(_url, cacheKey: "\(_url)", filter: nil)
    }
    
    
}
