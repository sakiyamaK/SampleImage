//
//  CameraPresentation.swift
//  SampleImage
//
//  Created by  on 2021/6/10.
//

import Foundation

protocol CameraPresentation: AnyObject {
    func viewDidLoad()
    func snapShot(image: Data)
}

final class CameraPresenter {
    private weak var view: CameraView?
    private let router: CameraWireframe
    private let interactor: CameraUsecase

    init(
        view: CameraView,
        interactor: CameraUsecase,
        router: CameraWireframe
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension CameraPresenter: CameraPresentation {
    func viewDidLoad() {
    }

    func snapShot(image: Data) {
        router.showCroppedImage(image: image)
    }
}
