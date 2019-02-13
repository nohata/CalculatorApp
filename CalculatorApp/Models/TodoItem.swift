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
    @objc dynamic var title = ""
}
