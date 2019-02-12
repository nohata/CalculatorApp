//
//  ViewController.swift
//  CalculatorApp
//
//  Created by yusuke nohata on 2019/02/07.
//  Copyright © 2019年 yusuke nohata. All rights reserved.
//

import UIKit
import Expression

class ViewController: UIViewController {
    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet var outletSymbol: [UIButton]!
    @IBOutlet weak var outletAnser: UIButton!
    @IBOutlet weak var outletMessage: UILabel!
    @IBOutlet weak var outletClear: UIButton!

    var LhideNumber:Int?
    var RhideNumber:Int?
    var Symbol:String = ""
    var selfanser = false

    override func viewDidLoad() {
        super.viewDidLoad()
        formulaLabel.adjustsFontSizeToFitWidth = true
        formulaLabel.font = UIFont(name: "HiraKakuProN-W3", size: 70)
        outletMessage.adjustsFontSizeToFitWidth = true
        outletMessage.font = UIFont(name: "HiraKakuProN-W3", size: 50)
        initializeColor()
        // ビューがロードされた時点で式と答えのラベルは空にする
        formulaLabel.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func inputFormula(_ sender: UIButton) {
        // 数値が押されたら式を表示する
        guard var formulaText = formulaLabel.text else {
            return
        }
        guard var senderedText = sender.titleLabel?.text else {
            return
        }
        if LhideNumber != nil && RhideNumber == nil {
            formulaText = "0"
        }
        if formulaText.contains(".") && senderedText.contains(".") {
            senderedText = ""
        }
        var LastformulaText:String = (formulaText != "0") ? formulaText + senderedText : senderedText
        if LastformulaText == "." {
            LastformulaText = "0."
        }
        formulaLabel.text = LastformulaText
        if LhideNumber != nil {
            RhideNumber = Int(LastformulaText)
        }

    }


    @IBAction func inputSymbol(_ sender: UIButton) {
        //記号が入力されたら
        initializeColor()
        sender.backgroundColor = UIColor.red
        guard let formulaText = formulaLabel.text else {
            return
        }
        if RhideNumber == nil {
            LhideNumber = Int(formulaText)
        }
        guard let SymbolText = sender.titleLabel?.text else {
            return
        }
        Symbol = SymbolText
        if RhideNumber != nil {
            selfanser = true
            self.calculateAnswer(outletAnser)
        }
    }

    @IBAction func clearCalculation(_ sender: UIButton) {
        // Cボタンが押されたら式と答えをクリアする
        formulaLabel.text = "0"
        LhideNumber = nil
        RhideNumber = nil
        Symbol = String()
        initializeColor()

    }

    @IBAction func calculateAnswer(_ sender: UIButton) {
        // =か記号が押されたら答えを計算して表示する
        guard let RhideNumberText = RhideNumber else {
            return
        }
        guard let LhideNumberText = LhideNumber else {
            return
        }

        let formula: String = formatFormula(String(RhideNumberText) + Symbol + String(LhideNumberText))
        let formulaLabelText: String = evalFormula(formula)
        formulaLabel.text = formulaLabelText
        LhideNumber = Int(formulaLabelText)
        RhideNumber = nil
        if !selfanser {
            Symbol = String()
            initializeColor()
        }
        selfanser = false
    }

    private func initializeColor() {
        for Label in outletSymbol {
            Label.backgroundColor = UIColor.brown
        }
    }

    private func formatFormula(_ formula: String) -> String {
        // 入力された整数には`.0`を追加して小数として評価する
        // また`÷`を`/`に、`×`を`*`に置換する
        let formattedFormula: String = formula.replacingOccurrences(
            of: "(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)",
            with: "$1.0",
            options: NSString.CompareOptions.regularExpression,
            range: nil
            ).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "×", with: "*")
        return formattedFormula
    }

    private func evalFormula(_ formula: String) -> String {
        do {
            // Expressionで文字列の計算式を評価して答えを求める
            let expression = Expression(formula)
            let answer = try expression.evaluate()
            return formatAnswer(String(answer))
        } catch {
            // 計算式が不当だった場合
            outletMessage.text = "式を正しく入力してください"
            self.clearCalculation(outletClear)
            return "0"
        }
    }

    private func formatAnswer(_ answer: String) -> String {
        // 答えの小数点以下が`.0`だった場合は、`.0`を削除して答えを整数で表示する
        let formattedAnswer: String = answer.replacingOccurrences(
            of: "\\.0$",
            with: "",
            options: NSString.CompareOptions.regularExpression,
            range: nil)
        return formattedAnswer
    }
}
