//
//  CropImagePresentation.swift
//  SampleImage
//
//  Created by  on 2021/6/10.
//

import Foundation

protocol CropImagePresentation: AnyObject {
    func viewDidLoad()
    func tapCropButton(image: Data)
}

final class CropImagePresenter {
    private weak var view: CropImageView?
    private let router: CropImageWireframe
    private let interactor: CropImageUsecase

    init(
        view: CropImageView,
        interactor: CropImageUsecase,
        router: CropImageWireframe
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension CropImagePresenter: CropImagePresentation {
    func viewDidLoad() {
    }

    func tapCropButton(image: Data) {
        router.showCroppedImage(image: image)
    }
}
