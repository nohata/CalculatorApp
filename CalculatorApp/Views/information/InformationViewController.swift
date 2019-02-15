//
//  InformationViewController.swift
//  CalculatorApp
//
//  Created by Yusuke Nohata on 2019/02/13.
//  Copyright © 2019年 yusuke nohata. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController, EditViewControllerDelegate {

    @IBOutlet weak var outletText: UILabel!

    @IBAction func tapEditButton(_ sender: Any) {
        let view = storyboard?.instantiateViewController(withIdentifier: "editViewController") as! EditViewController
        view.text = outletText.text!
        view.delegate = self
        present(view, animated: true, completion: nil)
    }

    func editDidFinished(modalText: String?){
        outletText.text = modalText
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //　ラベル枠の枠線太さと色
        outletText.layer.borderColor = UIColor.blue.cgColor
        outletText.layer.borderWidth = 2
        // ラベル枠を丸くする
        outletText.layer.masksToBounds = true
        // ラベル丸枠の半径
        outletText.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    // override func viewWillAppear(_ animated: Bool) {
    //     super.viewDidDisappear(animated)
    //     let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    //     textField.text = appDelegate.Text
    // }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
