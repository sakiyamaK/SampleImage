//
//  CropImageRouter.swift
//  SampleImage
//
//  Created by  on 2021/6/10.
//

import UIKit

protocol CropImageWireframe: AnyObject {
    func showCroppedImage(image: Data)
}

final class CropImageRouter {
  private unowned let viewController: UIViewController

  private init(viewController: UIViewController) {
    self.viewController = viewController
  }

  static func assembleModules() -> UIViewController {
    let view = UIStoryboard.loadCropImage()
    let interactor = CropImageInteractor()
    let router = CropImageRouter(viewController: view)
    let presenter = CropImagePresenter(
      view: view,
      interactor: interactor,
      router: router
    )
    view.inject(presenter: presenter)
    return view
  }
}

extension CropImageRouter: CropImageWireframe {
    func showCroppedImage(image: Data) {
        guard let image = UIImage(data: image) else { return }
        let vc = CroppedImageRouter.assembleModules(croppedImage: image)
        self.viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIStoryboard {
  static func loadCropImage() -> CropImageViewController {
    UIStoryboard(name: "CropImage", bundle: nil).instantiateInitialViewController() as! CropImageViewController 
  }
}
