//
//  ZPZActivityViewController.swift
//  ZPZUIActivityVCPractice
//
//  Created by zhoupengzu on 2018/3/27.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

import UIKit

class ZPZActivityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showActivityVC(_ sender: UIButton) {
//        let itemProvider = UIActivityItemProvider(placeholderItem: "hahahaha")
        let fileManager = FileManager.default
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last ?? ""
        path = path + "/1.jpg"
        let localImage = UIImage.init(named: "3.jpg")
        if fileManager.fileExists(atPath: path) == false, let tempImg = localImage  {
            do {
                let localUrl = NSURL.fileURL(withPath: path)
               let data = UIImageJPEGRepresentation(tempImg, 1)
               try  data?.write(to: localUrl, options: .atomicWrite)
            } catch {
                
            }
        }
        
        let image1 = UIImage.init(named: "2.jpg")
        let image2 = UIImage.init(named: "1.jpeg")
        let image3 = UIImage.init(contentsOfFile: path)
        let image4 = UIImage.init(contentsOfFile: Bundle.main.path(forResource: "19791218", ofType: "png", inDirectory: nil) ?? "")
//        let items:[Any] = ["My GitHub", URL(string: "https://github.com/zhoupengzu")!]
        let items:[Any] = [image1!, image2!, image3!, image4!]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityVC.completionWithItemsHandler = {
            (activityType, status, item, error) -> Void in
            if status {
                self.showAlertWithStr(message: "success")
            } else {
                self.showAlertWithStr(message: error?.localizedDescription ?? "failed")
            }
        }
        self.present(activityVC, animated: true, completion: nil)
    }
    func showAlertWithStr(message:String = "") {
        let alertVC = UIAlertController.init(title: "提示", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "好的", style: .default, handler: nil)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}
