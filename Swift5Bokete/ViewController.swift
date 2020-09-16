//
//  ViewController.swift
//  Swift5Bokete
//
//  Created by 岩崎舞 on 2020/09/16.
//  Copyright © 2020 岩崎舞. All rights reserved.
//

import UIKit
//ライブラリ記述
import Alamofire
import SwiftyJSON
import SDWebImage
//許可画面
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var odaiImageView: UIImageView!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imageViewの角丸
        commentTextView.layer.cornerRadius = 20.0
        //アルバムの許可
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status){
                case .authorized: break
                case .denied: break
                case .notDetermined: break
                case .restricted: break
            }
        }
            
        getImages(keyword: "funny")
        
    }
//検索キーワードの値をもとに画像をひっぱってくる
//pixabay.comから
    
    func getImages(keyword:String){
        //APIkey
        let url = "https://pixabay.com/api/?key=18328124-1c5ca24b67cda9110ef649247&q=\(keyword)"
        //Alamfireを使ってhttpリクエストを投げる
        //~in　はクロージャーという⇨selfを使う？
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{ (response) in
            
            switch response.result{
            
            //レスポンスが正常に行われていたとき
            case .success:
                let json:JSON = JSON(response.data as Any)
                var imageString = json["hits"][self.count]["webformatURL"].string
                
                //もう配列の次がないよ〜って場合
                if imageString == nil{
                    
                    imageString = json["hits"][0]["webformatURL"].string
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    
                }else{//配列の次がまだある場合
                 
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    
                }
                    
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    //次のお題へ
    @IBAction func nextOdai(_ sender: Any) {
        
        count = count + 1
        //検索ワード欄が空だったら
        if searchTextField.text == ""{
            getImages(keyword: "funny")
        }else{
            getImages(keyword: searchTextField.text!)
        }
    }
    
    //検索ボタンが押されたとき
    @IBAction func serachAction(_ sender: Any) {
        
        self.count = 0
        
        if searchTextField.text == ""{
           getImages(keyword: "funny")
       }else{
           getImages(keyword: searchTextField.text!)
       }
    }
    
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //ShareVCを変数化
        let shareVC = segue.destination as? ShareViewController
        shareVC?.commentString = commentTextView.text
        shareVC?.resultImage = odaiImageView.image!
        
    }
    
}

