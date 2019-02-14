//
//  TodoItem.swift
//  CalculatorApp
//
//  Created by Yusuke Nohata on 2019/02/13.
//  Copyright © 2019年 yusuke nohata. All rights reserved.
//

import Foundation
import RealmSwift

// Todoアイテム
class TodoItem: Object {

    @objc dynamic var id = 0
    @objc dynamic var title = ""

    // idセット
    func SetId() {
        // if realm.isInWriteTransaction {} で既に書き込みトランザクション内にいるかどうかを判断できる
        self.id = self.createNewId()
    }

    // 新しいIDを採番します。
    private func createNewId() -> Int {
        let realm = try! Realm()
        return (realm.objects(type(of: self).self).sorted(byKeyPath: "id", ascending: false).first?.id ?? 0) + 1
    }

    // プライマリーキーの設定
    override static func primaryKey() -> String? {
        return "id"
    }

    /*
    titleにインデックスを貼る
    override static func indexedProperties() -> [String] {
        return ["title"]
    }
    インデックスが指定出来るのは整数型、Bool、String、NSDateのプロパティ
    */

    /*
    tmpIDは保存しない
    override static func ignoredProperties() -> [String] {
        return ["tmpID"]
    }
    */

    /*
    リレーションシップ
    本のクラス
    class Book: Object {
        dynamic var name = ""
        dynamic var owner: User?  // 持ち主は1人
    }
    持ち主クラス
    class User: Object {
        dynamic var name = ""
        let books = List<Book>()      // 1人で複数の本を所有
        let books = LinkingObjects(fromType: Book.self, property: "owner") // 所有する本を逆引き
    }
    */
}

/*
チート早見表

非Optional
Bool  dynamic var value = false
Int dynamic var value = 0
Float dynamic var value: Float = 0.0
Double  dynamic var value: Double = 0.0
String  dynamic var value = ""
Data  dynamic var value = Data()
Date  dynamic var value = Date()
Object  n/a: 非Optionalにはできません
List  let value = List<Class>()
LinkingObjects  let value = LinkingObjects(fromType: Class.self, property: "property")

Optional
let value = RealmOptional<Bool>()
let value = RealmOptional<Int>()
let value = RealmOptional<Float>()
let value = RealmOptional<Double>()
dynamic var value: String? = nil
dynamic var value: Data? = nil
dynamic var value: Date? = nil
dynamic var value: Class?
n/a: Optionalにはできません
n/a: Optionalにはできません
*/