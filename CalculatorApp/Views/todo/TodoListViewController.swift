//
//  TodoListViewController.swift
//  CalculatorApp
//
//  Created by Yusuke Nohata on 2019/02/13.
//  Copyright © 2019年 yusuke nohata. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UIViewController {
    private var realm: Realm!
    private var todoList: Results<TodoItem>!
    private var token: NotificationToken!
    @IBOutlet weak var tableView: UITableView!

    override func awakeFromNib() {
      super.awakeFromNib()

      // RealmのTodoリストを取得し，更新を監視
      realm = try! Realm() // Realmのインスタンスを取得
      todoList = realm.objects(TodoItem.self)
      // token = todoList.observe { [weak self] _ in
      //   self?.reload()
      // }

      // TodoItemの一覧を指すResultsに通知を設定
      token = todoList.observe { changes in
        switch changes {

        case .initial(let todo):    // 最初に1回だけ呼ばれる？
            print("Initial todo.count: \(todo.count)")
            print("Initial todo: \(todo)")
            break

        case .update(let todo, _, _, _):    // 更新された
            print("Update todo.count: \(todo.count)")
            break

        case .error:    // エラーが発生した
            print("Error todo")
            break
        }

        self.reload()
      }

      /*
      プライマリキーを指定してオブジェクトを取得
      if let data = realm.objectForPrimaryKey(PrimaryData.self, key: 1) {
        print("id:1 \(data.name)")
      }
      */

      /*
      名前で並び替えてPrimaryDataのオブジェクトを取得
      let result = realm.objects(PrimaryData).sorted("name", ascending: true)

      名前が『f』ではじまるオブジェクト（大文字小文字の違いは無視）だけを取得
      let result = realm.objects(PrimaryData).filter("name BEGINSWITH[c] %@", "f")

      objects()もfilter()もsorted()もResultsを返す
      realm.objects().filter().sorted()
      */


      /*
      ファイルを指定して初期化
      let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
      let path = paths[0] + "/test.realm"
      let url = NSURL(fileURLWithPath: path)
      let realm = try! Realm(fileURL: url)
      */

      /*
      インメモリで初期化
      let config = Realm.Configuration(inMemoryIdentifier: "inMemory")
      let realm = try! Realm(configuration: config)
      */
    }

    deinit {
      token.invalidate()
    }

    override func viewDidLoad() {
      super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
    }

    @IBAction func addTapped(_ sender: Any) {
      // 新規Todo追加用のダイアログを表示
      let dlg = UIAlertController(title: "新規Todo", message: "", preferredStyle: .alert)
      dlg.addTextField(configurationHandler: nil)
      dlg.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        if let t = dlg.textFields![0].text,
          !t.isEmpty {
          self.addTodoItem(title: t)
        }
      }))
      present(dlg, animated: true)
    }

    // Todoを追加
    func addTodoItem(title: String) {
      try! realm.write {
        // TodoItemモデルのオブジェクトを取得
        let todoitem = TodoItem()
        todoitem.title = title
        todoitem.SetId()
        realm.add(todoitem, update: true)

        // まとめて追加
        //realm.add(TodoItem(value: ["title": title]))
      }
    }

    // Todoを削除
    func deleteTodoItem(at index: Int) {
      try! realm.write {
        realm.delete(todoList[index])
        // リレーション先を削除
        // let users = realm.objects(User)
        // realm.delete(users.books)
        // realm.delete(users)
      }
    }

    func reload() {
      tableView.reloadData()
    }
}

extension TodoListViewController: UITableViewDelegate {
}

extension TodoListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return todoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "todoItem", for: indexPath)
      cell.textLabel?.text = todoList[indexPath.row].title
      return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      deleteTodoItem(at: indexPath.row)
    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
