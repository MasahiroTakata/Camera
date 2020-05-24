//
//  ViewController.swift
//  Camera
//
//  Created by 高田将弘 on 2020/05/20.
//  Copyright © 2020 高田将弘. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    // カメラアプリ起動
    @IBAction func launchCamera(_ sender: UIBarButtonItem) {
        let camera = UIImagePickerController.SourceType.camera
        
        if UIImagePickerController.isSourceTypeAvailable(camera){
            let picker = UIImagePickerController()
            picker.sourceType = camera
            picker.delegate = self
            self.present(picker, animated: true)
        }
    }

    // 撮影終了時（撮影が終了すると自動的に呼び出されるメソッド）
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imageView.image = image
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil) // 写真を保存する
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

