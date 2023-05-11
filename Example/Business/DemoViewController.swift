//
//  DemoViewController.swift
//  Example
//
//  Created by yaochenfeng on 2023/4/30.
//

import UIKit

class DemoViewController: UIViewController {
    @Autowired(required: true)
    var vc: DemoViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Demo"
        view.backgroundColor = Asset.bgColor.color
        print("vc\(String(describing: vc))")
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下页", style: .done, target: nil, action: nil).rx.then({ base in
            base.rx.tap.map { _ in
                RoutePage.home.navigate()
            }.subscribe().disposed(by: rx.disposeBag)
        })
        guard let nav = navigationController, nav.viewControllers.count > 1 else { return  }
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "上一页", style: .done, target: nil, action: nil).rx.then({ base in
            base.rx.tap.map { _ in
                RoutePage.navigateBack()
            }.subscribe().disposed(by: rx.disposeBag)
        })
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

class DemoNav: RXNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
