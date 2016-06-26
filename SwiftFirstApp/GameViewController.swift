//
//  GameViewController.swift
//  SwiftFirstApp
//
//  Created by Natsumo Ikeda on 2016/06/22.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB

class GameViewController: UIViewController{
    // タップ回数
    var count = 0
    // タップフラグ
    var tapFlag = false
    // タイマー（秒）
    var countTimer = 0
    // ゲーム残り時間や、ゲーム開始時間、エラーを表示するラベル
    @IBOutlet weak var label: UILabel!
    // スタートボタン
    @IBOutlet weak var startButton: UIButton!
    // タップ回数を表示するカウンター
    @IBOutlet weak var counter: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ラベルの文字数によって文字サイズを自動調整
        self.label.adjustsFontSizeToFitWidth = true
        // ラベル初期表示
        self.label.text = "↓Startボタンを押してゲームスタート↓"
        // ゲーム中以外は的をタップできないようにする
        self.tapFlag = false
        // タップ回数を表示するカウンターは編集できないようにする
        self.counter.enabled = false
    }
    
    // 名前とスコアの保存処理
    func saveScore (name: String, score: Int) {
        // **********【問題１】名前とスコアを保存しよう！**********

        //        // 保存に失敗した場合の処理
        //        print("エラーが発生しました。エラーコード:\(error.code)")
        
        //        // 保存に成功した場合の処理
        //        print("保存に成功しました。objectId:\(obj.objectId)")
        
//        // 【答え】
//        let object = NCMBObject(className: "GameScore")
//        object.setObject(name, forKey: "name")
//        object.setObject(score, forKey: "score")
//
//        object.saveInBackgroundWithBlock { (error:NSError!) in
//            if error == nil {
//                // 保存に成功した場合の処理
//                print("保存に成功しました。objectId:\(object!.objectId)")
//                // 名前とスコアの表示
//                self.label.text = "保存に成功しました。\(object!.objectForKey("name"))さんのスコアは\(object!.objectForKey("score"))連打でした"
//            } else {
//                // 保存に失敗した場合の処理
//                print("エラーが発生しました。エラーコード:\(error.code)")
//                self.label.text = "エラーが発生しました。エラーコード:\(error.code)"
//            }
//        }
        // **************************************************
    }
    
    // 「Start」ボタン押下時の処理
    @IBAction func startGame(sender: UIButton) {
        // カウンターを0にする
        self.count = 0
        // タイマーを13秒にする (ゲーム時間を10秒　ゲーム開始までの時間を3秒)
        self.countTimer = 13
        // スタートボタンを押せなくする
        self.startButton.enabled = false
        // タイマーを作成
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.timerAction(_:)), userInfo: nil, repeats: true)
    }
    
    // タイマーの処理
    func timerAction(sender:NSTimer){
        if self.countTimer >= 11 {
            // timerが11以上はスタートまでのカウントダウンを表示する
            self.label.text = String(countTimer - 10)
        } else {
            // timerが10以下はゲームスタート
            // 的をタップできるようにする
            self.tapFlag = true
            if self.countTimer == 10{
                // timerが10の時にスタートを表示
                self.label.text = "スタート！"
            } else if self.countTimer <= 9 && self.countTimer >= 1 {
                // timerが1~9の時は、ゲーム中のカウントダウンを表示
                self.label.text = String(self.countTimer)
            } else {
                // timerが0の時のにタイムアップを表示
                self.label.text = "タイムアップ！"
                // 的をタップできないようにする
                self.tapFlag = false
                // タイマーストップ
                sender.invalidate()
                // スタートボタンを押せるようにする
                self.startButton.enabled = true
                // 名前入力アラートの表示
                self.inputName(self.count)
            }
        }
        // TimeInterval毎にtimerを-1する
        self.countTimer -= 1
    }
    
    // 名前入力アラートの表示
    func inputName (sender: Int) {
        // ファイル名を決めるアラートを表示
        let alert = UIAlertController(title: "スコア登録", message: "名前を入力してください", preferredStyle: .Alert)
        // UIAlertControllerにtextFieldを追加
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in }
        // アラートのOK押下時の処理
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { (action: UIAlertAction!) -> Void in
            // 名前とスコアを保存
            self.saveScore(alert.textFields![0].text!, score: sender)
            })
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // viewタップ（シングル）時の処理
    @IBAction func tapView(sender: UITapGestureRecognizer) {
        if self.tapFlag {
            self.count += 1
            self.counter.text = "\(count)"
        }
    }
}