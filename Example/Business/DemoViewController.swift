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
        print("vc\(String(describing: vc))")
        // Do any additional setup after loading the view.
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
