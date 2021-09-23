//
//  ViewController.swift
//  Personal
//
//  Created by 으정이 on 2021/09/09.
//

import UIKit
protocol MainDisplayLogic: AnyObject {
    //해당 프로토콜에서는 화면에 데이터를 바인딩 시켜주는 일을 한다.
}
@available(iOS 13.0, *)
class MainViewController: BaseViewController, MainDisplayLogic {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    let category: NSDictionary = ["Covid19" : "코로나19 예방접종센터 조회",
                                       "KakaoLogin" : "카카오 로그인"]
//    var subViewControllerName: String?    //SubViewController는 공통 ViewController이므로, viewName으로 어떤 화면을 띄울지 결정. 해당 메뉴를 눌렀을 때 viewName을 저장하여 SubViewController에 데이터를 넘김.
    var categoryAllKeys : [Any]?
    var categoryAllValues : [Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //TableView Setting
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.setup()
        
    }
    
    //MARK: Setup
    func setup() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.viewId = interactor
        
        self.categoryAllKeys = category.allKeys
        self.categoryAllValues = category.allValues
        
//
//        let viewController = self
//        let interactor = ListOrdersInteractor()
//        let presenter = ListOrdersPresenter()
//        let router = ListOrdersRouter()
        
//        viewController.interactor = interactor
//        viewController.router = router
//        interactor.presenter = presenter
//        presenter.viewController = viewController
//        router.viewController = viewController
//        router.dataStore = interactor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let subVC = segue.destination as? SubViewController, let subViewControllerName = self.subViewControllerName else {
//            return
//        }
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
        
//        subVC.viewName = subViewControllerName
        
        
    }

}

//MARK: UITableView Extension
@available(iOS 13.0, *)
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as? ServiceCell else {
            return UITableViewCell()
        }
        
        guard let categoryLabel = self.categoryAllValues?[indexPath.row] as? String else {
            return cell
        }
        
        cell.listLabel.text = categoryLabel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        addLoadingIndicator()
//        loadingIndicator.isAnimating = true
//        loadingIndicator.isHidden = false
        
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        //prepare 메서드 보다 먼저 오므로 여기서 subViewController의 viewName을 위해 subViewControllerName를 저장
        //메뉴에 따라 달라지므로 indexPath.row가 필요.
        
        if let viewId = categoryAllKeys?[indexPath.row] as? String {
            var vcInfo = VCInfo(viewId: viewId)
            interactor?.fetchViewId(viewId: vcInfo)
        }
        
        return indexPath
    }
    
}
