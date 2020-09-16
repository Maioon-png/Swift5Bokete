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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTextView.layer.cornerRadius = 20.0
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status){
                case .authorized: break
                case .denied: break
                case .notDetermined: break
                case .restricted: break
            }
        }
            
        
    }
//

}

