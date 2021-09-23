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
        
//        self.view.backgroundColor = .yellow
//
//        let v1 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400))
//        v1.translatesAutoresizingMaskIntoConstraints = false
//        v1.backgroundColor = .white
//        self.view.addSubview(v1)
//          v1.addSubview(scrollView)
//
//        v1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        v1.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//        v1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//        v1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//
//          scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//          scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
//          scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//          scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
//
//          scrollView.addSubview(labelOne)
//
//          labelOne.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40).isActive = true
//          labelOne.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40).isActive = true
//
//          scrollView.addSubview(labelTwo)
//
//          labelTwo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40).isActive = true
//          labelTwo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 1000).isActive = true
//          labelTwo.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40).isActive = true

        // Do any additional setup after loading the view.
        
//        let v1 = PopupView(UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 100)), part: .quitButton)
//        v1.body.backgroundColor = .red
//        let v2 = PopupView(UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200)), part: .title)
//        v2.body.backgroundColor = .orange
//        let v3 = PopupView(UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500)), part: .content)
//        v3.body.backgroundColor = .yellow
//        let v4 = PopupView(UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300)), part: .confirmButton)
//        v4.body.backgroundColor = .green
//        let v5 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
//        v5.backgroundColor = .blue
//
//        let combineV = combineT([v1,v2,v3,v4], padding: 10)
//        self.view.addSubview(combineV)
        
        
        
        
//        let view = UIView()
//        view.backgroundColor = UIColor.yellow
//        let viewOrder: OrderContent = OrderContent(type: .View, content: view, rect: CGRect(x: 0, y: 0, width: 300, height: 300))
//
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = UIImage(named: "Logo")
//        imageView.backgroundColor = .blue
//        let imageViewOrder: OrderContent = OrderContent(type: .ImageView, content: imageView, rect: CGRect(x: 0, y: 0, width: 300, height: 400))
//
//        let label = UILabel()
//        label.backgroundColor = UIColor.red
//        label.text = "안녕하세요"
//        let labelOrder: OrderContent = OrderContent(type: .Label, content: label, rect: CGRect(x: 0, y: 0, width: 300, height: 50))
//
//
//
//        let resultView = getCombineContents(contents: [viewOrder, labelOrder, imageViewOrder])
//
//        self.view.addSubview(resultView)
        
        let popupView = getPopupView()
        
        setPopupSubViews(popupView)
        
        self.view.addSubview(popupView)
        
    }
    
    
    /// popupView의 subView들을 만들고 추가하고 위치시킨다.
    /// - Parameter source: subView를 추가시킬 popupView
    func setPopupSubViews(_ source: UIView) {
        
        let quitView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        quitView.backgroundColor = .red
        
        let leading = (displaySize.width * 0.9) - 30
        var bottom = (displaySize.height * 0.8) - 30
        
        quitView.translatesAutoresizingMaskIntoConstraints = false
        
        source.addSubview(quitView)
        
        quitView.topAnchor.constraint(equalTo: source.topAnchor, constant: 0).isActive = true
        quitView.leadingAnchor.constraint(equalTo: source.leadingAnchor, constant: leading).isActive = true
        quitView.trailingAnchor.constraint(equalTo: source.trailingAnchor, constant: 0).isActive = true
        quitView.bottomAnchor.constraint(equalTo: source.bottomAnchor, constant: -bottom).isActive = true
        
        //titleview
        let titleView = UIView()
        titleView.backgroundColor = .white
        
        source.addSubview(titleView)
        
        //height 50
        bottom -= 50
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.topAnchor.constraint(equalTo: quitView.bottomAnchor, constant: 0).isActive = true
        titleView.leadingAnchor.constraint(equalTo: source.leadingAnchor, constant: 0).isActive = true
        titleView.trailingAnchor.constraint(equalTo: source.trailingAnchor, constant: 0).isActive = true
        titleView.bottomAnchor.constraint(equalTo: source.bottomAnchor, constant: -bottom).isActive = true
        
        //contentsView
        let contentsView = UIView()
        contentsView.backgroundColor = .cyan
        
        source.addSubview(contentsView)
        
        //height dynamicHeight - quitView.Height - titleView.Height - buttonsViewHeight
        contentsView.translatesAutoresizingMaskIntoConstraints = false
        contentsView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 0).isActive = true
        contentsView.leadingAnchor.constraint(equalTo: source.leadingAnchor, constant: 0).isActive = true
        contentsView.trailingAnchor.constraint(equalTo: source.trailingAnchor, constant: 0).isActive = true
        contentsView.bottomAnchor.constraint(equalTo: source.bottomAnchor, constant: -50).isActive = true
        
        //buttonsView
        let buttonsView = UIView()
        buttonsView.backgroundColor = .red
        
        source.addSubview(buttonsView)
        
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.topAnchor.constraint(equalTo: contentsView.bottomAnchor, constant: 0).isActive = true
        buttonsView.leadingAnchor.constraint(equalTo: source.leadingAnchor, constant: 0).isActive = true
        buttonsView.trailingAnchor.constraint(equalTo: source.trailingAnchor, constant: 0).isActive = true
        buttonsView.bottomAnchor.constraint(equalTo: source.bottomAnchor, constant: 0).isActive = true
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
    
    func qqq (source: UIView) -> UIView {
        let v = UIView()
        v.layer.cornerRadius = 20
        v.backgroundColor = .brown
        
        let quitV = UIView()
        quitV.backgroundColor = .black
        let titleView = UIView()
        titleView.backgroundColor = .yellow
        let contentView = UIView()
        contentView.backgroundColor = .red
        let buttonView = UIView()
        buttonView.backgroundColor = .orange
        
        //translatesAutoresizingMaskIntoConstraints
        v.translatesAutoresizingMaskIntoConstraints = false
        quitV.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        //width
        let dynamicWidth = displaySize.height * 0.9
        v.frame.size.width = dynamicWidth
//        v.widthAnchor.constraint(equalTo: source.widthAnchor, multiplier: 40).isActive = true
        quitV.frame.size.width = 30
        
        //height
        let dynamicHeight = displaySize.height * 0.8
        let quitVHeight: CGFloat = 30
        let titleViewHeight: CGFloat = 50
        let buttonViewHeight: CGFloat = 50
        let contentViewHeight: CGFloat = (dynamicHeight - (quitVHeight + titleViewHeight + buttonViewHeight))
        
        v.frame.size.height = dynamicHeight
        quitV.frame.size.height = quitVHeight
        titleView.frame.size.height = titleViewHeight
        contentView.frame.size.height = contentViewHeight
        buttonView.frame.size.height = buttonViewHeight
        
        //Add
        v.addSubViews([quitV, titleView, contentView, buttonView])
        
        //constraint
        
        quitV.topAnchor.constraint(equalTo: v.topAnchor, constant: 0).isActive = true
        quitV.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: 0).isActive = true
        
        titleView.topAnchor.constraint(equalTo: quitV.bottomAnchor, constant: 0).isActive = true
        titleView.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 0).isActive = true
        titleView.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: 0).isActive = true
        
        contentView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: 0).isActive = true
        
        buttonView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        buttonView.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 0).isActive = true
        buttonView.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: 0).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0).isActive = true
        
        
        return v
    }
    
    
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
    }

    struct OrderContent {
        var type: ContentType?
        var content: Any?
        var rect: CGRect?
        init(type t: ContentType, content c: Any, rect r: CGRect) {
            self.type = t
            self.content = c
            self.rect = r
        }
    }
    
    //컨텐츠뷰를 합쳐서 하나의 뷰로 만드는 메서드
    //컨텐츠뷰는 스크롤되어야 한다.
    //컨텐츠뷰는 특정 높이 이상이 될 수 없다.
    //이 높이는 고정되어 있지 않다. 추후 뷰를 합칠 때 달라 질 수 있다.
    func getCombineContents(contents: [OrderContent]?) -> UIView {
        
        let viewWidth = UIScreen.main.bounds.width * 0.9
        var height: CGFloat = 0
    //        CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 0))
        let contentView = UIView()
    //    contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //컨텐츠의 종류에 따라 view에서의 위치가 다름
        //같은 종류의 컨텐츠가 여러개 들어왔을 경우도 생각해야 함
        //컨텐츠가 아애 없을 수도 있음
        
        //컨텐츠가 있는지 확인
        guard let _contents = contents else {
            //없으면 초기설정만 한 view 리턴
            contentView.addSubview(scrollView)
            
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
//            contentView.frame.size.width = viewWidth
//            contentView.frame.size.height = height
            return contentView
        }
        
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
        scrollView.addSubViews(imageViews)
        
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
        scrollView.addSubViews(labels)
        
        //Contraint 지정
        //SnapKit 사용하지 않고 하기
        for viewOrder in viewOrders {
            height = makeConstraint(sourceWidth: viewWidth, order: viewOrder, yPoint: height + 5)
        }
        
        for imgViewOrder in imageViewOrders {
            height = makeConstraint(sourceWidth: viewWidth, order: imgViewOrder, yPoint: height + 5)
        }
        
        for labelOrder in labelOrders {
            height = makeConstraint(sourceWidth: viewWidth, order: labelOrder, yPoint: height + 5)
        }
        
        //content의 크기에 따라 view의 height정함
        contentView.addSubview(scrollView)
        let someHeight: CGFloat = 400
        if height > someHeight {
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
//            scrollView.frame.size.width = viewWidth
//            scrollView.frame.size.height = someHeight
            contentView.frame.size.width = viewWidth
            contentView.frame.size.height = someHeight
        } else {
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
//            scrollView.frame.size.width = viewWidth
//            scrollView.frame.size.height = someHeight
            contentView.frame.size.width = viewWidth
            contentView.frame.size.height = someHeight
        }
        
        
        
        //각 종류별로 크기 변경
        return contentView
    }
    
    //source에 추가했다고 가정
    //content의 width가 있다고 가정
    //content의 height가 있다고 가정
    //endPoint를 return함
    func makeConstraint(sourceWidth: CGFloat, order: OrderContent, yPoint y: CGFloat) -> CGFloat{
        guard let width = order.rect?.width, let height = order.rect?.height else {
            return y
        }
        
        let leading = (sourceWidth - width) / 2
        
        switch order.type {
        case .ImageView:
            let imgView = order.content as! UIImageView
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
