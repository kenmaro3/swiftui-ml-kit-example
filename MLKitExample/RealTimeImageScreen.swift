import AVFoundation
import UIKit
import SwiftUI

// UIViewControllerの定義
class CameraUIViewController: UIViewController {
//    カメラセッションをclassプロパティとして定義
    let captureSession = AVCaptureSession()
    var reverseButton: UIButton = UIButton()
    
    var isFront: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAndSetUpCameraView()
        
    }
    
    func startAndSetUpCameraView(){
        captureSession.beginConfiguration()
        connectInputsToSession()
        connectOutputToSession()
        captureSession.commitConfiguration()
        let previewView = PreviewView()
        previewView.videoPreviewLayer.session = self.captureSession
        view.addSubview(previewView)
        
        previewView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            previewView.topAnchor.constraint(equalTo: view.topAnchor),
            previewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
        setupReverseButton()

    }
    
    func setupReverseButton() {
        // camera-reversing button
        self.reverseButton.frame = CGRect(x: 0, y: 0, width: 300, height: 70)
        self.reverseButton.center = self.view.center
        self.reverseButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.reverseButton.setTitle("Reverse Camera Position", for: .normal)
        self.reverseButton.setTitleColor(UIColor.white, for: .normal)
        self.reverseButton.setTitleColor(UIColor.lightGray, for: .disabled)
        self.reverseButton.addTarget(self, action: #selector(self.onTapReverseButton(sender:)), for: .touchUpInside)
        self.view.addSubview(self.reverseButton)
    }
    
    @objc func onTapReverseButton(sender: UIButton) {
        isFront.toggle()
        self.stopAndRemoveCamera()
        self.startAndSetUpCameraView()
    }
    
    func stopAndRemoveCamera() {
        self.captureSession.stopRunning()
        self.captureSession.inputs.forEach { input in
            self.captureSession.removeInput(input)
        }
        self.captureSession.outputs.forEach { output in
            self.captureSession.removeOutput(output)
        }
    }
//    Input設定
    private func connectInputsToSession() {
        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: isFront ? .front : .back)
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), captureSession.canAddInput(videoDeviceInput)
        else {
            print("error")
            return
            
        }
        captureSession.addInput(videoDeviceInput)
    }
//    Output設定
    private func connectOutputToSession() {
        let photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput)
        else {
            print("error")
            return
            
        }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
    }
    

//    preview用画面UIView
    class PreviewView: UIView {
        override class var layerClass: AnyClass {
            return AVCaptureVideoPreviewLayer.self
        }
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
}
// CameraUIViewControllerをSwiftUIのViewに変換
struct CameraUIViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = CameraUIViewController
    func makeUIViewController(context: Context) ->  UIViewControllerType {
        return CameraUIViewController()
    }
    func updateUIViewController(_ uiViewController:  UIViewControllerType, context: Context) {
        
    }
}
// Canvasでプレビュー(カメラが接続できないのでクラッシュする)
struct CameraUIViewControllerRepresentablePreview: PreviewProvider {
    static var previews: some View {
        CameraUIViewControllerRepresentable()
    }
}
