//
//  ToolCodeViewController.swift
//  CalculatorApp
//
//  Created by Yusuke Nohata on 2019/02/18.
//  Copyright © 2019 yusuke nohata. All rights reserved.
//

import UIKit

class ToolCodeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let MyUiBar = UITabBar.appearance()
        //バーの色
        MyUiBar.barTintColor = UIColor.lightGray
        //選択されていないボタンの色
        MyUiBar.unselectedItemTintColor = UIColor.white
        //ボタンを押した時の色
        MyUiBar.tintColor = UIColor.blue
        //背景画像を指定
        //MyUiBar.backgroundImage = UIImage(named: "tooltab.png")
        //選択時の背景画像を指定
        //MyUiBar.selectionIndicatorImage = UIImage(named: "tooltab.png")

        var viewControllers = [UIViewController]()

        let firstSB = UIStoryboard(name: "First", bundle: nil)
        let firstVC = firstSB.instantiateInitialViewController()! as UIViewController
        firstVC.tabBarItem = UITabBarItem(title: "First", image: UIImage(named:"first50.png")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), tag: 0)
        firstVC.tabBarItem.selectedImage = UIImage(named:"home50.png")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        viewControllers.append(firstVC)

        let secondSB = UIStoryboard(name: "Second", bundle: nil)
        let secondVC = secondSB.instantiateInitialViewController()! as UIViewController
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        viewControllers.append(secondVC)

        let thirdSB = UIStoryboard(name: "Third", bundle: nil)
        let thirddVC = thirdSB.instantiateInitialViewController()! as UIViewController
        thirddVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        viewControllers.append(thirddVC)

        self.viewControllers = viewControllers.map{ UINavigationController(rootViewController: $0)}
        self.setViewControllers(viewControllers, animated: false)
    }

    //ボタンをタップされた時のアクション
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            switch item.tag{
            case 0:
                print("0")
            case 1:
                print("１")
            case 2:
                print("２")
            case 3:
                print("３")
            case 4:
                print("４")
            case 5:
                print("５")
            default : return
            }
    }

}
