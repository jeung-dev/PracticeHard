//
//  CustomPopup.swift
//  Personal
//
//  Created by 으정이 on 2021/09/22.
//

import UIKit

struct CustomPopup {
    
    typealias CustomPopupButton = (String, CustomPopup.ButtonType)
    
    enum ButtonType: Int {
        case `default` = 0
        
        case cancel = 1
        
        case destructive = 2
    }
    
    enum ContentType {
        case View
        case ImageView
        case Label
    }
    
    enum CustomError: Error {
        case contentViewIsNotRight
    }
    
    //MARK: Properties
    let view: UIView = UIView()
    var quitButton: UIButton?
    var title: UILabel?
    var contentViews: [Any]?
    var buttons: [Int:CustomPopupButton]?
    let width = UIScreen.main.bounds.width * 0.9
    
    //MARK: Methods
    /// CustomPopup 생성
    /// - Parameters:
    ///   - title: 타이틀
    ///   - contentViews: View, ImageView, Label
    ///   - button: 최대 3개까지. [버튼순서:(버튼이름, 버튼타입)]
    init(title: String?, contentViews: [Any]?, buttons: [Int:CustomPopupButton]?, isQuitButton: Bool) {
        self.contentViews = contentViews
        //버튼 순서, 버튼 이름, 버튼 타입
        guard buttons != nil else {
            setup(isQuitButton: isQuitButton, titleString: title)
            return
        }
        if buttons!.count <= 3 {
            self.buttons = buttons
        } else {
            var _buttons: [Int:CustomPopupButton] = [:]
            for i in 0...2 {
                _buttons[i] = buttons![i]
            }
            self.buttons = _buttons
        }
        setup(isQuitButton: isQuitButton, titleString: title)
    }
    
    mutating func setup(isQuitButton: Bool, titleString: String?) {
        if true == isQuitButton {
            self.quitButton = UIButton()
            self.view.addSubview(self.quitButton!)
        }
        
        if titleString != nil {
            self.title = UILabel()
            self.title?.text = titleString
            self.view.addSubview(self.title!)
        }
        
        if self.contentViews != nil, self.contentViews!.count > 0 {
            var views: [UIView] = []
            var imageViews: [UIImageView] = []
            var labels: [UILabel] = []
            for contentView in self.contentViews! {
                do {
                    let type = try getContentType(contentView: contentView)
                    switch type {
                    case .View:
                        views.append(contentView as! UIView)
                        break
                    case .ImageView:
                        imageViews.append(contentView as! UIImageView)
                        break
                    case .Label:
                        labels.append(contentView as! UILabel)
                        break
                    }
                } catch { }
                self.view.addSubViews(views)
                self.view.addSubViews(imageViews)
                self.view.addSubViews(labels)
            }
        }
        
        if self.buttons != nil, self.buttons!.count > 0 {
            for i in 0...(self.buttons!.count - 1) {
                let button = UIButton()
                let data = self.buttons![i]
                let title = data!.0
                let type = data!.1
                button.setTitle(title, for: .normal)
                self.view.addSubview(button)
            }
        }
        
    }
    
    func viewSetting() {
//        let contentView =
        
        //MARK: ButtonView 추가
        let buttonView = creatButtonsView(firstTitle: "확인", secondTitle2: "취소", thirdTitle3: nil)
        self.view.addSubview(buttonView)
    }
    
    func createContentView(contents: [Any]?) -> UIView {
        
        let view = UIView()
        let viewWidth = UIScreen.main.bounds.width * 0.9
        var height: CGFloat = 50
        view.frame.size.width = viewWidth
        view.frame.size.height = height
        
        
        //컨텐츠의 종류에 따라 view에서의 위치가 다름
        //같은 종류의 컨텐츠가 여러개 들어왔을 경우도 생각해야 함
        //컨텐츠가 아애 없을 수도 있음
        
        //컨텐츠가 있는지 확인
        guard let _contents = contents else {
            return view
        }
        
        //컨텐츠의 종류를 나눔
        var views: [UIView] = []
        var imageViews: [UIImageView] = []
        var labels: [UILabel] = []
        
        for content in _contents {
            do {
                let type = try getContentType(contentView: content)
                switch type {
                case .View:
                    views.append(content as! UIView)
                    break
                case .ImageView:
                    imageViews.append(content as! UIImageView)
                    break
                case .Label:
                    labels.append(content as! UILabel)
                    break
                }
            } catch {
                //do Somthing...
            }
        }
        
        
        return view
    }
    
    /// 버튼을 title을 입력한 개수만큼 만들어 하나의 view로 반환한다.
    /// 기본적으로 높이는 50이며, width는 화면 크기를 버튼의 개수로 나뉜 크기이다.
    /// - Parameters:
    ///   - t1: 첫번째 버튼의 title
    ///   - t2: 두번째 버튼의 title
    ///   - t3: 세번째 버튼의 title
    /// - Returns: button을 추가한 하나의 view
    func creatButtonsView(firstTitle t1: String?, secondTitle2 t2: String?, thirdTitle3 t3: String?) -> UIView {
        let view = UIView()
        let height: CGFloat = 50
        let padding: CGFloat = 5
        
        var count = 0
        if t1 != nil {
            count += 1
        }
        if t2 != nil {
            count += 1
        }
        if t3 != nil {
            count += 1
        }
        
        let width = UIScreen.main.bounds.width/CGFloat(count)
        let buttons = createButtonAsMuchCountAs(count: count)
        
        for i in 0...(count - 1) {
            buttons[i].frame.size.width = width
            buttons[i].frame.size.height = height
            if i == 0 {
                buttons[i].tag = i
                buttons[i].setTitle(t1, for: .normal)
                view.addSubview(buttons[i])
                //MARK: TODO: LifeCycle에서 해야할 수도 있음 -> tag 활용
                buttons[i].snp.makeConstraints { make in
                    make.top.equalTo(view.snp.top)
                    make.leading.equalTo(view.snp.leading)
                    make.bottom.equalTo(view.snp.bottom)
                }
            } else if i == 1 {
                buttons[i].tag = i
                buttons[i].setTitle(t2, for: .normal)
                view.addSubview(buttons[i])
                //MARK: TODO: LifeCycle에서 해야할 수도 있음 -> tag 활용
                buttons[i].snp.makeConstraints { make in
                    make.top.equalTo(view.snp.top)
                    make.leading.equalTo(buttons[i-1].snp.leading)
                    make.bottom.equalTo(view.snp.bottom)
                }
            } else if i == 2 {
                buttons[i].tag = i
                buttons[i].setTitle(t3, for: .normal)
                view.addSubview(buttons[i])
                //MARK: TODO: LifeCycle에서 해야할 수도 있음 -> tag 활용
                buttons[i].snp.makeConstraints { make in
                    make.top.equalTo(view.snp.top)
                    make.leading.equalTo(buttons[i-1].snp.leading)
                    make.trailing.equalTo(view.snp.trailing)
                    make.bottom.equalTo(view.snp.bottom)
                }
            } else {
                Logger.e("버튼 없음")
            }
            
        }
        
        return view
    }
    
    
    /// 파라미터로 넘긴 개수만큼 버튼을 만들어서 Array로 반환한다.
    /// - Parameter c: 버튼을 만들 개수
    /// - Returns: 버튼의 Array
    private func createButtonAsMuchCountAs(count c: Int) -> [UIButton]{
        var buttons: [UIButton] = []
        for _ in 0...c - 1 {
            buttons.append(UIButton())
        }
        return buttons
    }
    
    func getContentType(contentView: Any) throws -> CustomPopup.ContentType {
        if contentView is UIView {
            return .View
        } else if contentView is UIImageView {
            return .ImageView
        } else if contentView is UILabel {
            return .Label
        } else {
            Logger.e("contentView is not right...")
            throw CustomError.contentViewIsNotRight
        }
    }
    
}
