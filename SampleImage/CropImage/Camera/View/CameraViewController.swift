//
//  CameraView.swift
//  SampleImage
//
//  Created by  on 2021/6/10.
//

import UIKit
import AVFoundation

protocol CameraView: AnyObject {
}

final class CameraViewController: UIViewController {

    private var device: AVCaptureDevice!
    private var session: AVCaptureSession!
    private var output: AVCapturePhotoOutput!

    private var photo: UIImage?

    private var presenter: CameraPresentation!
    func inject(presenter: CameraPresentation) {
        self.presenter = presenter
    }

    private let cropRegionParameter: OverlayView.CropParameter = .init(
        region: CGRect(x: 100, y: 100, width: 200, height: 200),
        cornerRadius: 5,
        arroundColor: .black.withAlphaComponent(0.8))

    lazy private var shutterBtn: UIButton = {
        let shutterBtn = UIButton()
        shutterBtn.setTitle("shutter", for: .normal)
        shutterBtn.contentMode = .center
        shutterBtn.backgroundColor = .white
        shutterBtn.setTitleColor(UIColor.black, for: UIControl.State())
        shutterBtn.addTarget(self, action: #selector(snapShot), for: .touchDown)
        return shutterBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()

        let overlayView = OverlayView()
        self.view.addSubview(overlayView)
        overlayView.snp.makeConstraints { $0.edges.equalToSuperview() }
        self.view.layoutIfNeeded()
        overlayView.setup(parameter: self.cropRegionParameter)

        checkAuth {
            DispatchQueue.main.async {
                self.setupCameraSession()
                self.view.bringSubviewToFront(overlayView)
                self.view.addSubview(self.shutterBtn)
                self.shutterBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        if let session = session {
            session.startRunning()
        }
    }
}

private extension CameraViewController {
    func setupCameraSession() {
        session = AVCaptureSession()
        //背面カメラを選択
        device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        session.addInput(input)
        output = AVCapturePhotoOutput()
        session.addOutput(output)
        session.sessionPreset = .photo
        let pvLayer = AVCaptureVideoPreviewLayer(session: session)
        pvLayer.frame = view.bounds
        pvLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        pvLayer.connection?.videoOrientation = .portrait
        view.layer.addSublayer(pvLayer)
        // セッションを開始
        session.startRunning()
    }

    func checkAuth(_ completion: ( () -> Void)? = nil) {
        //ビデオ
        func checkAuthVideo(_ completion: ( () -> Void)? = nil ) {
            guard AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized else {
                completion?()
                return
            }
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (_) in
                completion?()
            })
        }
        checkAuthVideo(completion)
    }
}

extension CameraViewController: CameraView {
}

@objc extension CameraViewController {
    func snapShot() {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .off
        output.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        guard error == nil,
              let rawSizeImage = UIImage(data: photo.fileDataRepresentation()!)?.fixedOrientation() else {
            return
        }

        let previewSize = self.view.frame.size

        let pWR = previewSize.width / previewSize.height
        let rWR = rawSizeImage.size.width / rawSizeImage.size.height

        let x = (rWR - pWR) * rawSizeImage.size.height/2
        let w = pWR * rawSizeImage.size.height

        guard let previewImage = rawSizeImage.cropped(to: CGRect(x: x, y: 0, width: w, height: rawSizeImage.size.height)) else {
            return
        }

        let cWR = previewImage.size.width / self.view.frame.size.width
        let cHR = previewImage.size.height / self.view.frame.size.height

        let region = cropRegionParameter.region
        let photoCropRegion = CGRect(x: region.minX * cWR, y: region.minY * cHR, width: region.width * cWR, height: region.height * cHR)

        guard let cropImage = previewImage.cropped(to: photoCropRegion) else {
            return
        }

        session.stopRunning()

        presenter.snapShot(image: cropImage.pngData()!)
    }
}
