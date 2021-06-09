//
//  CroppedImageView.swift
//  SampleImage
//
//  Created by  on 2021/6/10.
//

import UIKit

protocol CroppedImageView: AnyObject {
}

final class CroppedImageViewController: UIViewController {

    @IBOutlet private var imageView: UIImageView!

    private var croppedImage: UIImage!
    private var presenter: CroppedImagePresentation!
    func inject(presenter: CroppedImagePresentation, croppedImage: UIImage) {
        self.presenter = presenter
        self.croppedImage = croppedImage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: false)

        imageView.image = croppedImage
    }
}

extension CroppedImageViewController: CroppedImageView {
}
