//
//  DemoViewController.swift
//  Example
//
//  Created by yaochenfeng on 2023/4/30.
//

import UIKit

class DemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = RXContainer.shared.resolve(Self.self)
        print("vc\(vc) : \(vc == self)")
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
