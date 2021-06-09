//
//  CroppedImagePresentation.swift
//  SampleImage
//
//  Created by  on 2021/6/10.
//

import Foundation

protocol CroppedImagePresentation: AnyObject {
  func viewDidLoad()
}

final class CroppedImagePresenter {
  private weak var view: CroppedImageView?
  private let router: CroppedImageWireframe
  private let interactor: CroppedImageUsecase

  init(
    view: CroppedImageView,
    interactor: CroppedImageUsecase,
    router: CroppedImageWireframe
  ) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
}

extension CroppedImagePresenter: CroppedImagePresentation {
  func viewDidLoad() {
  }
}