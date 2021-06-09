//
//  CroppedImageRouter.swift
//  SampleImage
//
//  Created by  on 2021/6/10.
//

import UIKit

protocol CroppedImageWireframe: AnyObject {
}

final class CroppedImageRouter {
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules(croppedImage: UIImage) -> UIViewController {
        let view = UIStoryboard.loadCroppedImage()
        let interactor = CroppedImageInteractor()
        let router = CroppedImageRouter(viewController: view)
        let presenter = CroppedImagePresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        view.inject(presenter: presenter, croppedImage: croppedImage)
        return view
    }
}

extension CroppedImageRouter: CroppedImageWireframe {
}

extension UIStoryboard {
    static func loadCroppedImage() -> CroppedImageViewController {
        UIStoryboard(name: "CroppedImage", bundle: nil).instantiateInitialViewController() as! CroppedImageViewController
    }
}
