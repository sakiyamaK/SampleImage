//
//  CameraRouter.swift
//  SampleImage
//
//  Created by  on 2021/6/10.
//

import UIKit

protocol CameraWireframe: AnyObject {
    func showCroppedImage(image: Data)
}

final class CameraRouter {
  private unowned let viewController: UIViewController

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  static func assembleModules() -> UIViewController {
    let view = CameraViewController()
    let interactor = CameraInteractor()
    let router = CameraRouter(viewController: view)
    let presenter = CameraPresenter(
      view: view,
      interactor: interactor,
      router: router
    )
    view.inject(presenter: presenter)
    return view
  }
}

extension CameraRouter: CameraWireframe {
    func showCroppedImage(image: Data) {
        guard let image = UIImage(data: image) else { return }
        let vc = CroppedImageRouter.assembleModules(croppedImage: image)
        self.viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
