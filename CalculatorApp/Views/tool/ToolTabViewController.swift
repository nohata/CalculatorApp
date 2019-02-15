//
//  ToolTabViewController.swift
//  CalculatorApp
//
//  Created by Yusuke Nohata on 2019/02/15.
//  Copyright © 2019年 yusuke nohata. All rights reserved.
//

import UIKit

class ToolTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //ホームを初期選択にする。
        self.selectedIndex = 0

        //ボタンの個数ループ
        for item in tabBar.items! {
            if( item.tag != self.selectedIndex ) {
                //選択されていないボタンにバッチをつける。
                item.badgeValue = "1"
            }
        }
        // Do any additional setup after loading the view.
    }

    //ボタン押下時の呼び出しメソッド
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //バッチを消す。
        item.badgeValue = nil
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
