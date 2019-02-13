//
//  EditViewController.swift
//  CalculatorApp
//
//  Created by Yusuke Nohata on 2019/02/13.
//  Copyright © 2019年 yusuke nohata. All rights reserved.
//

import UIKit

protocol EditViewControllerDelegate{
    func editDidFinished(modalText: String?)
}

class EditViewController: UIViewController {

    var text = ""
    var delegate: EditViewControllerDelegate! = nil

    @IBOutlet weak var editText: UITextField!

    @IBAction func tapButton(_ sender: UIButton) {
        delegate.editDidFinished(modalText: editText.text)
        dismiss(animated: true, completion: nil)
        // let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // appDelegate.Text = editText.text!
        // dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        editText.text = text
        // let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // editText.text = appDelegate.Text
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
