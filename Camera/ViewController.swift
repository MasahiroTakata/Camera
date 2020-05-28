//
//  ViewController.swift
//  Camera
//
//  Created by 高田将弘 on 2020/05/20.
//  Copyright © 2020 高田将弘. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let fileOutput = AVCaptureMovieFileOutput() // 動画撮影用
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

    // 写真撮影終了時（写真撮影が終了すると自動的に呼び出されるメソッド）
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imageView.image = image // 写真を画面に表示する
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil) // 写真を保存する
        self.dismiss(animated: true)
    }
    
    // 動画撮影開始
    func setUpPreview() {
        let videoDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio)

        do {
            if videoDevice == nil || audioDevice == nil {
                throw NSError(domain: "device error", code: -1, userInfo: nil)
            }

            let captureSession = AVCaptureSession()
            // video inputを capture sessionに追加
            let videoInput = try AVCaptureDeviceInput(device: videoDevice!)
            captureSession.addInput(videoInput)

            // audio inputを capture sessionに追加
            let audioInput = try AVCaptureDeviceInput(device: audioDevice!)
            captureSession.addInput(audioInput)
            
            // max 30sec
            self.fileOutput.maxRecordedDuration = CMTimeMake(value: 30, timescale: 1)
            captureSession.addOutput(fileOutput)

            // プレビュー
            let videoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoLayer.frame = self.view.bounds
            videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.view.layer.addSublayer(videoLayer)

            captureSession.startRunning()

        } catch {
            // エラー処理
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // setUpPreview()
    }
}

