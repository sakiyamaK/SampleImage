//
//  CropImageView.swift
//  SampleImage
//
//  Created by  on 2021/6/10.
//

import UIKit
import SnapKit

protocol CropImageView: AnyObject {
}

final class CropImageViewController: UIViewController {

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var croppedButton: UIButton! {
        didSet {
            croppedButton.addTarget(self, action: #selector(tapCropImage), for: .touchUpInside)
        }
    }

    private var presenter: CropImagePresentation!
    func inject(presenter: CropImagePresentation) {
        self.presenter = presenter
    }

    let cropRegionParameter: OverlayView.CropParameter = .init(
        region: CGRect(x: 100, y: 100, width: 200, height: 200),
        cornerRadius: 5,
        arroundColor: .brown.withAlphaComponent(0.8))

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = .blue

        let overlayView = OverlayView()
        self.view.addSubview(overlayView)
        overlayView.snp.makeConstraints { $0.edges.equalToSuperview() }
        self.view.layoutIfNeeded()
        overlayView.setup(parameter: cropRegionParameter)
        self.imageView.bringSubviewToFront(overlayView)
        self.view.bringSubviewToFront(croppedButton)
    }
}

@objc extension CropImageViewController {
    func tapCropImage() {

        guard
            let imageData = imageView.toImage()?.cropped(to: cropRegionParameter.region)?.pngData() else { return }
        presenter.tapCropButton(image: imageData)
    }
}

extension CropImageViewController: CropImageView {
}
