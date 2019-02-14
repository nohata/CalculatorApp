//
//  AppDelegate.swift
//  CalculatorApp
//
//  Created by yusuke nohata on 2019/02/07.
//  Copyright © 2019年 yusuke nohata. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var Text: String = ""

    func gotoMainStoryBoard(){
        //let flg = true//分岐条件

        let storyboard:UIStoryboard = UIStoryboard(name: "Main",bundle:nil)
        let viewController:UIViewController

        //最初に表示するビューコントローラーを指定
        //ストーリーボードで遷移先のビューを選択し、IdentityのStoryboard IDに任意の名前を設定
        // if flg {
        viewController = storyboard.instantiateViewController(withIdentifier: "TopViewController") as UIViewController
        // } else {
        //     viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as UIViewController
        // }

        window?.rootViewController = viewController
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        realmMigration()
        gotoMainStoryBoard()
        return true
    }

    // Realmのマイグレーション
    func realmMigration() {
        let config = Realm.Configuration(
            // 新しいスキーマバージョンを設定、以前のバージョンより大きくなければならない
            // スキーマバージョンを設定したことがなければ、最初は0が設定されている
            schemaVersion: 1,

            // マイグレーション処理を記述
            // 古いスキーマバージョンのRealmを開こうとすると自動的にマイグレーションが実行される
            migrationBlock: { migration, oldSchemaVersion in
                // 最初のマイグレーションの場合、`oldSchemaVersion`は0です
                if (oldSchemaVersion < 1) {
                    // プロパティの消去と追加を認識してディスク上のスキーマを自動的にアップデート
                    // 古いプロパティのデータを新しいプロパティに入れたい場合
                    var nextID = 0
                    migration.enumerateObjects(ofType: TodoItem.className()) { oldObject, newObject in
                        // let firstName = oldObject!["firstName"] as! String
                        // let lastName = oldObject!["lastName"] as! String
                        // newObject!["fullName"] = "\(firstName) \(lastName)"
                        newObject!["id"] = nextID
                        nextID += 1
                    }
                }
        })
        // デフォルトRealmに新しい設定を適用
        Realm.Configuration.defaultConfiguration = config
        // Realmファイルを開こうとしたときスキーマバージョンが異なれば自動的にマイグレーションが実行される
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

