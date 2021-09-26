//
//  ScrollViewTestViewController.swift
//  Personal
//
//  Created by 으정이 on 2021/09/24.
//

import UIKit

class ScrollViewTestViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .lightGray
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //왜 View만 안됨? 왜 Label은 됨?
    //아무것도 안 바꾸고 이것만 바꿨는데 되고 안됨... 왜그러는거야 나한테 ㅠㅠㅠ
    //이것 때문에라도... 이건 Storyboard 써야겠어
    let yellowView: UILabel = {
        let view = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 240, height: 150)))
        view.backgroundColor = .systemYellow
        view.text = "AAA"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let greenView: UILabel = {
        let view = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
        view.backgroundColor = .systemGreen
        view.text = "BBB"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setup() {
        //Add Views
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(yellowView)
        contentView.addSubview(greenView)
        
        //get layout guides
        let layoutGuide = view.safeAreaLayoutGuide
        let scrrollViewContentLayoutGuid = scrollView.contentLayoutGuide
        
        //update constraint
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrrollViewContentLayoutGuid.topAnchor, constant: 20),
            contentView.leadingAnchor.constraint(equalTo: scrrollViewContentLayoutGuid.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: scrrollViewContentLayoutGuid.trailingAnchor, constant: -20),
            contentView.bottomAnchor.constraint(equalTo: scrrollViewContentLayoutGuid.bottomAnchor, constant: -20),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40),
            
            yellowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            yellowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            greenView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1500),
            greenView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            greenView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
