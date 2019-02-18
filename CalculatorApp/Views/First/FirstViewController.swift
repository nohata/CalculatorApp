//
//  FirstViewController.swift
//  CalculatorApp
//
//  Created by Yusuke Nohata on 2019/02/18.
//  Copyright © 2019 yusuke nohata. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBAction func home(_ sender: Any) {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = mainSB.instantiateInitialViewController()! as UIViewController

        self.present(mainVC, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
