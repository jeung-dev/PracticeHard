//
//  PopupTestViewController.swift
//  Personal
//
//  Created by 으정이 on 2021/09/23.
//

import UIKit

class PopupTestViewController: UIViewController {
    
    let displaySize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    let labelOne: UILabel = {
      let label = UILabel()
        
      label.text = "Scroll Top"
      label.backgroundColor = .red
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    
    let labelTwo: UILabel = {
      let label = UILabel()
      label.text = "Scroll Bottom"
      label.backgroundColor = .red
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()

    let scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      scrollView.backgroundColor = .blue
      return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let dimmedView = getDimmedView()
        let popupView = getPopupView()
        
        setPopupSubViews(popupView)
        
        dimmedView.addSubview(popupView)
        self.view.addSubview(dimmedView)
 */
        //ContentView테스트
        let testView = UIView()
        testView.backgroundColor = UIColor.yellow
        let viewOrder: PopupTestViewController.OrderContent = PopupTestViewController.OrderContent(type: .View, content: testView, rect: CGRect(x: 0, y: 0, width: 300, height: 300), isLastContent: true)

        let testImageView = UIImageView()
        testImageView.contentMode = .scaleAspectFit
        testImageView.image = UIImage(named: "Logo")
        testImageView.backgroundColor = .blue
        let imageViewOrder: PopupTestViewController.OrderContent = PopupTestViewController.OrderContent(type: .ImageView, content: testImageView, rect: CGRect(x: 0, y: 0, width: 300, height: 400), isLastContent: nil)

        let testLabel = UILabel()
        testLabel.backgroundColor = UIColor.red
        testLabel.text = "안녕하세요"
        let labelOrder: PopupTestViewController.OrderContent = PopupTestViewController.OrderContent(type: .Label, content: testLabel, rect: CGRect(x: 0, y: 0, width: 300, height: 50), isLastContent: nil)
        
        do {
            if let contentsView = try getCombineContents(contents: [viewOrder, imageViewOrder, labelOrder]) {
                self.view.addSubview(contentsView)
                
//                contentsView.frame.size.height = 400
            }
        } catch {
            //error .... something
        }
        
        
    }
    
    //MARK: Test 완료
    
    /// popupView의 subView들을 만들고 추가하고 위치시킨다.
    /// - Parameter source: subView를 추가시킬 popupView
    func setPopupSubViews(_ source: UIView) {
        
        //get views <- it has false value of a translate... property
        let quitView = getQuitButton()
        let titleView = getTitle("타이틀")
        let contentsView = getContentViewFromNib()
        let buttonsView = UIView()
        buttonsView.backgroundColor = .red
        
        //add views
        source.addSubview(quitView)
        source.addSubview(titleView)
        source.addSubview(contentsView)
        source.addSubview(buttonsView)
        
        let leading = (displaySize.width * 0.9) - 30
        var bottom = (displaySize.height * 0.8) - 30
        
        //set constraint
        //height dynamicHeight - quitView.Height - titleView.Height - buttonsViewHeight - safeAreaTop&Bottom
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
        self.view.safeAreaLayoutGuide.topAnchor
        let limitHeight = (self.view.frame.size.height * 0.8) - quitView.frame.size.height - titleView.frame.size.height - buttonsView.frame.size.height - self.view.safeAreaLayoutGuide.topAnchor - self.view.safeAreaLayoutGuide.bottomAnchor
        if contentsView.frame.size.height > limitHeight {
            let viewForContentHeight = UIView()
            viewForContentHeight.frame.size.height = limitHeight
        }
        
        NSLayoutConstraint.activate([
            //quit view
            quitView.topAnchor.constraint(equalTo: source.topAnchor, constant: 0),
            quitView.leadingAnchor.constraint(equalTo: source.leadingAnchor, constant: leading),
            quitView.trailingAnchor.constraint(equalTo: source.trailingAnchor, constant: 0),
//            quitView.bottomAnchor.constraint(equalTo: source.bottomAnchor, constant: -bottom),
            
            //title view
            titleView.topAnchor.constraint(equalTo: quitView.bottomAnchor, constant: 0),
            titleView.leadingAnchor.constraint(equalTo: source.leadingAnchor, constant: 0),
            titleView.trailingAnchor.constraint(equalTo: source.trailingAnchor, constant: 0),
//        titleView.bottomAnchor.constraint(equalTo: source.bottomAnchor, constant: -bottom).isActive = true
            //contents View
            contentsView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 0),
            contentsView.leadingAnchor.constraint(equalTo: source.leadingAnchor, constant: 0),
            contentsView.trailingAnchor.constraint(equalTo: source.trailingAnchor, constant: 0),
            contentsView.heightAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutDimension>#>)
//            contentsView.bottomAnchor.constraint(equalTo: source.bottomAnchor, constant: -50),
            //buttonsView
            buttonsView.topAnchor.constraint(equalTo: contentsView.bottomAnchor, constant: 0),
            buttonsView.leadingAnchor.constraint(equalTo: source.leadingAnchor, constant: 0),
            buttonsView.trailingAnchor.constraint(equalTo: source.trailingAnchor, constant: 0),
            buttonsView.bottomAnchor.constraint(equalTo: source.bottomAnchor, constant: 0)
        ])
        
        
        
        
        //height 50
//        bottom -= 50
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    /// 팝업뷰의 베이스 뷰를 만든다.
    /// - Returns: 팝업 베이스 뷰
    func getPopupView() -> UIView {
        let dynamicWidth = displaySize.width * 0.9
        let dynamicHeight = displaySize.height * 0.8
        let popupView = UIView()
        popupView.backgroundColor = .yellow
        popupView.frame.size.width = dynamicWidth
        popupView.frame.size.height = dynamicHeight
        popupView.center = self.view.center
        
        //cornerRadius Mask!!!
        //mask로 안하면 subview들이 튀어나옴 ㅠ
        let path = UIBezierPath(roundedRect:popupView.bounds,
                                byRoundingCorners:[.topRight, .bottomLeft, .topLeft, .bottomRight],
                                cornerRadii: CGSize(width: 20, height:  20))

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        popupView.layer.mask = maskLayer
        
        return popupView
    }
    
    
    /// DimmedView를 리턴하는 메서드
    /// - Returns: DimmedView
    func getDimmedView() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: displaySize.width, height: displaySize.height))
        view.backgroundColor = UIColor(named: "systemDimmedBlack")
        return view
    }
    
    
    /// QuitButton을 리턴하는 메서드
    /// - Returns: QuitButton
    func getQuitButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "quit"), for: .normal)
        button.backgroundColor = UIColor.red    //실제 사용할 때는 삭제
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    
    /// TitleLabel을 리턴하는 메서드
    /// - Parameter text: Title 문구
    /// - Returns: Title Label
    func getTitle(_ text: String) -> UILabel {
        let label = UILabel()
        let attributes: [NSAttributedString.Key : Any] = [.font : UIFont.boldSystemFont(ofSize: 20)]
        label.attributedText = NSAttributedString(string: text, attributes: attributes)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    
    func getContentViewFromNib() -> UIView {
        let view = PopupTestView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    //MARK: Test 미완료
    
    //MARK: Combine All Views
    //여러 뷰를 합치는 메서드
    func combineT(_ views: [PopupView], padding: CGFloat?) -> UIView {
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let backV = UIView(frame: rect)
        backV.backgroundColor = .lightGray
        let _padding: CGFloat = padding ?? 30
        
        //추가
        for v in views {
            backV.addSubview(v.body)
        }
        
        //frame 조절
        var preView: UIView = backV
        var count = 0
        //Logger.d("subViews: \(backV.subviews)")
        //잘 뽑아짐. 대신에 해당하는 view가 하나도 없으면 nil이 아닌 []로 리턴됨.
        let limitHeightContents = views.filter { popupView in
            return popupView.part == .content && popupView.body.frame.size.height > 400
        }
    //    Logger.d("높이가 400 이상인 view: \(a.debugDescription)")
        if limitHeightContents.count > 0 {
    //        Logger.d("잘들어옴?") //ㅇㅇ 들어옴
            for limitView in limitHeightContents {
                limitView.body.frame.size.height = 200
            }
        }
        
        for subV in backV.subviews {
            if count == 0 {
                subV.frame.origin.x = _padding
                subV.frame.origin.y = preView.frame.origin.y
                count += 1
            } else {
                subV.frame.origin.x = _padding
                subV.frame.origin.y = preView.frame.origin.y + preView.frame.size.height + _padding
                count += 1
            }
            preView = subV
        }
        
        //subViews의 높이가 backV보다 큰 경우 처리
        //컨텐츠 영역만 스크롤이 되게 해야함.
        //각 영역이 무슨 영역인지 알아야 하고
            //OK
        //컨텐츠 영역은 특정 높이가 넘지 않도록 한다.
            //OK
        //그리고 컨텐츠 뷰를 만드는 곳에서 스크롤이 들어가게 하면 된다.
            //MARK: TODO

        return backV
    }
    
    //MARK: Contents Make

    enum ContentType {
        case View
        case ImageView
        case Label
    }

    enum CustomError: Error {
        case contentViewIsNotRight
        case contentNil
        case lastContentNil
        case lastContentTooMany
    }

    struct OrderContent {
        var type: ContentType?
        var content: Any?
        var rect: CGRect?
        var isLastContent: Bool?
        init(type t: ContentType, content c: Any, rect r: CGRect, isLastContent: Bool?) {
            self.type = t
            self.content = c
            self.rect = r
            self.isLastContent = isLastContent ?? false
        }
    }
    
    //컨텐츠뷰를 합쳐서 하나의 뷰로 만드는 메서드
    //컨텐츠뷰는 스크롤되어야 한다.
    //컨텐츠뷰는 특정 높이 이상이 될 수 없다.
    //이 높이는 고정되어 있지 않다. 추후 뷰를 합칠 때 달라 질 수 있다.
    func getCombineContents(contents: [PopupTestViewController.OrderContent]?) throws -> UIView? {
        
        /**
         1. 유효성검사
         */
        //컨텐츠가 있는지 확인
        guard let _contents = contents, _contents.count > 0 else {
            //없으면 초기설정만 한 view 리턴
            throw CustomError.contentNil
            return nil
        }
        
        //마지막 컨텐츠를 등록하지 않으면 스크롤뷰가 망가질 수 있으므로 리턴
        //마지막 컨텐츠가 2개 이상이어도 리턴
        var lastContent = false
        var lastContentCount = 0
        for content in _contents {
            if true == content.isLastContent {
                lastContent = true
                lastContentCount += 1
            }
        }
        
        guard lastContent == true else {
            throw CustomError.lastContentNil
        }
        
        guard lastContentCount == 1 else {
            throw CustomError.lastContentTooMany
        }
        
        /**
         2. ScrollView 추가 후 Anchor 조절
         */
        //view에 먼저 scrollView를 넣기
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: displaySize.width * 0.9, height: 300))
        contentView.addSubview(scrollView)
        
        
        //scrollView를 contentView에 맞추기
        scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        /**
         3. contents를 Add -> ScrollView
         - 컨텐츠의 종류에 따라 view에서의 위치가 다름
         - 같은 종류의 컨텐츠가 여러개 들어왔을 경우도 생각해야 함
         - 컨텐츠가 아애 없을 수도 있음
         */
        
        //컨텐츠의 종류에 따라 순서에 맞춰 view에 추가
        let viewOrders = _contents.filter { content in
            return content.type == .View
        }
        let views: [Any] = {
            var vs: [Any] = []
            for v in viewOrders {
                vs.append(v.content!)
            }
            return vs
        }()
        scrollView.addSubViews(views)
        
        let imageViewOrders = _contents.filter { content in
            return content.type == .ImageView
        }
        let imageViews: [Any] = {
            var ivs: [Any] = []
            for iv in imageViewOrders {
                ivs.append(iv.content!)
            }
            return ivs
        }()
//        scrollView.addSubViews(imageViews)
        
        let labelOrders = _contents.filter { content in
            return content.type == .Label
        }
        let labels: [Any] = {
            var ls: [Any] = []
            for l in labelOrders {
                ls.append(l.content!)
            }
            return ls
        }()
//        scrollView.addSubViews(labels)
        
        /**
         4.Anchor 조정
         - view
         - image
         - label
         */
        
        let width = UIScreen.main.bounds.width * 0.9
        var height: CGFloat = 0
        var preView: UIView = scrollView
        var count = 0
        for viewOrder in viewOrders {
            let view = viewOrder.content as! UIView
            height = viewOrder.rect?.height ?? 0
            view.frame = CGRect(x: viewOrder.rect?.origin.x ?? 0, y: viewOrder.rect?.origin.y ?? 0, width: viewOrder.rect?.size.width ?? 0, height: viewOrder.rect?.size.height ?? 0)
            
            view.translatesAutoresizingMaskIntoConstraints = false
//            view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40).isActive = true
//            view.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 1000).isActive = true
//            view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40).isActive = true
            view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40).isActive = true
            view.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40).isActive = true
            
//            let label = UILabel()

            let label = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//            label.text = "Scroll Top"
              label.backgroundColor = .red
            scrollView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40).isActive = true
            label.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 1000).isActive = true
            label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40).isActive = true
            
//            label.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
//            label.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 2.0)
//
//            view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40).isActive = true
//            view.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 1000).isActive = true
//            view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 40).isActive = true
            
////            view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
            
            
            //Last View인지 먼저 체크 -- scrollView의 바닥을 짚어야 함
//            if true == viewOrder.isLastContent {
//
//                if count == 0 {
//                    view.topAnchor.constraint(equalTo: preView.topAnchor, constant: 0).isActive = true
//                    view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
//                    view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
//                    view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
//
//                    preView = view
//                    count += 1
//                } else {
//                    view.topAnchor.constraint(equalTo: preView.bottomAnchor, constant: 0).isActive = true
//                    view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
//                    view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
//                    view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
//
//                    preView = view
//                    count += 1
//                }
//
//            } else {
//                //First View인지 체크 -- scrollView의 topAnchor에 붙여야 함
//                if count == 0 {
//                    view.topAnchor.constraint(equalTo: preView.topAnchor, constant: 0).isActive = true
//                    view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
//                    view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
//
//                    preView = view
//                    count += 1
//
//                } else {
//                    view.topAnchor.constraint(equalTo: preView.bottomAnchor, constant: 0).isActive = true
//                    view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
//                    view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
//
//                    preView = view
//                    count += 1
//                }
//            }
            
        }
        /*
        
        for imgViewOrder in imageViewOrders {
            let imgView = imgViewOrder.content as! UIImageView
            height = imgViewOrder.rect?.height ?? 0
            imgView.translatesAutoresizingMaskIntoConstraints = false
            //Last View인지 먼저 체크 -- scrollView의 바닥을 짚어야 함
            if true == imgViewOrder.isLastContent {
                if count == 0 {
                    imgView.topAnchor.constraint(equalTo: preView.topAnchor, constant: 0).isActive = true
                    imgView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
                    imgView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
                    imgView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
                    
                    preView = imgView
                    count += 1
                } else {
                    imgView.topAnchor.constraint(equalTo: preView.bottomAnchor, constant: 0).isActive = true
                    imgView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
                    imgView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
                    imgView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
                    
                    preView = imgView
                    count += 1
                }
                
            } else {
                //First View인지 체크 -- scrollView의 topAnchor에 붙여야 함
                if count == 0 {
                    imgView.topAnchor.constraint(equalTo: preView.topAnchor, constant: 0).isActive = true
                    imgView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
                    imgView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
                    
                    preView = imgView
                    count += 1
                    
                } else {
                    imgView.topAnchor.constraint(equalTo: preView.bottomAnchor, constant: 0).isActive = true
                    imgView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
                    imgView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
                    
                    preView = imgView
                    count += 1
                }
            }
            
        }
        
        for labelOrder in labelOrders {
            let label = labelOrder.content as! UILabel
            height = labelOrder.rect?.height ?? 0
            label.translatesAutoresizingMaskIntoConstraints = false
            //Last View인지 먼저 체크 -- scrollView의 바닥을 짚어야 함
            if true == labelOrder.isLastContent {
                if count == 0 {
                    label.topAnchor.constraint(equalTo: preView.topAnchor, constant: 0).isActive = true
                    label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
                    label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
                    label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
                    
                    preView = label
                    count += 1
                } else {
                    label.topAnchor.constraint(equalTo: preView.bottomAnchor, constant: 0).isActive = true
                    label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
                    label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
                    label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
                    
                    preView = label
                    count += 1
                }
                
            } else {
                //First View인지 체크 -- scrollView의 topAnchor에 붙여야 함
                if count == 0 {
                    label.topAnchor.constraint(equalTo: preView.topAnchor, constant: 0).isActive = true
                    label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
                    label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
                    
                    preView = label
                    count += 1
                    
                } else {
                    label.topAnchor.constraint(equalTo: preView.bottomAnchor, constant: 0).isActive = true
                    label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
                    label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
                    
                    preView = label
                    count += 1
                }
            }
        }
        
        /**
         5. Content의 높이를 정함.
         - 특정 높이 이상 되었을 때 고정하는 것은 팝업뷰를 만들 때 하는 게 좋을 듯.
         */
 */
        Logger.d("height: \(height)")
        Logger.d("subViews: \(scrollView.subviews.debugDescription)")
        contentView.frame = CGRect(x: 0, y: 0, width: displaySize.width * 0.9, height: height)
        contentView.center = self.view.center
        contentView.frame.size.height = height
        return contentView
    }
    
    //source에 추가했다고 가정
    //content의 width가 있다고 가정
    //content의 height가 있다고 가정
    //endPoint를 return함
    func makeConstraint(_ source: UIView, order: OrderContent, yPoint y: CGFloat) -> CGFloat{
        guard let width = order.rect?.width, let height = order.rect?.height else {
            return y
        }
        
        let leading = ((displaySize.width * 0.9) - width) / 2
        
        switch order.type {
        case .ImageView:
            let imgView = order.content as! UIImageView
            //source = contentView
            imgView.translatesAutoresizingMaskIntoConstraints = false
            imgView.topAnchor.constraint(equalTo: source.topAnchor, constant: 0).isActive = true
            
            imgView.frame.origin.y = y
            imgView.frame.origin.x = leading
            imgView.frame.size.width = width
            imgView.frame.size.height = height
            return y + height
        case .Label:
            let label = order.content as! UILabel
            label.frame.origin.y = y
            label.frame.origin.x = leading
            label.frame.size.width = width
            label.frame.size.height = height
            return y + height
        case .View:
            let view = order.content as! UIView
            view.frame.origin.y = y
            view.frame.origin.x = leading
            view.frame.size.width = width
            view.frame.size.height = height
            return y + height
        case .none:
            return y
        }
    }

    struct PopupView {
        enum Part {
            case quitButton
            case title
            case content
            case confirmButton
        }
        
        var body: UIView
        var part: Part
        
        init(_ body: UIView, part: Part) {
            self.body = body
            self.part = part
        }
        
    }

}
