//
//  RankingViewController.swift
//  SwiftFirstApp
//
//  Created by Natsumo Ikeda on 2016/06/23.
//  Copyright © 2016年 NIFTY Corporation. All rights reserved.
//

import UIKit
import NCMB

class RankingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // rankingTableView
    @IBOutlet weak var rankingTableView: UITableView!
    // エラーを表示するラベル
    @IBOutlet weak var label: UILabel!
    // 取得したランキングデータの配列
    var rankingArray: Array<NCMBObject> = []
    // テーブルビューに表示する件数
    let rankingNumber = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rankingTableView.delegate = self
        self.rankingTableView.dataSource = self
        
        // ラベルの文字数によって文字サイズを自動調整
        self.label.adjustsFontSizeToFitWidth = true
        
        // **********【問題２】ランキングを表示しよう！**********
//        //【答え】
//        let query = NCMBQuery(className: "GameScore")
//        query.orderByDescending("score")
//        
//        query.findObjectsInBackgroundWithBlock { (objects, error:NSError!) in
//            if error == nil {
//                // 検索に成功した場合の処理
//                print("検索に成功しました。")
//                self.label.text = "検索に成功しました。"
//                // 取得したランキングデータをプロパティに格納
//                self.rankingArray = objects as! Array;
//                // テーブルビューをリロード
//                self.rankingTableView.reloadData()
//            } else {
//                // 検索に失敗した場合の処理
//                print("検索に失敗しました。エラーコード:\(error.code)")
//                self.label.text = "検索に失敗しました。エラーコード:\(error.code)"
//            }
//        }
        // **************************************************
        
    }
    
    // rankingTableViewのセルの数を指定
    func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 5件で固定
        return rankingNumber
    }
    
    // rankingTableViewのセルの内容を設定
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = rankingTableView.dequeueReusableCellWithIdentifier("rankingTableCell", forIndexPath: indexPath)
        
        var object:NCMBObject?
        // 表示件数よりデータ件数の方が少ない場合は、objectを作成しない
        if indexPath.row < self.rankingArray.count {
           object = self.rankingArray[indexPath.row]
        }
        
        // Ranking
        let ranking = cell.viewWithTag(1) as! UILabel
        ranking.text = "\(indexPath.row+1)位"
        
        if let unwrapObject = object {
            // name
            let name = cell.viewWithTag(2) as! UILabel
            name.text = "\(unwrapObject.objectForKey("name"))さん"
            // score
            let score = cell.viewWithTag(3) as! UILabel
            score.text = "\(unwrapObject.objectForKey("score"))連打"
        }
        
        return cell
    }
}