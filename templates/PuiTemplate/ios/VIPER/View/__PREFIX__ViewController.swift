//
//  __PREFIX__View.swift
//  __TARGET__
//
//  Created by __USERNAME__ on __YEAR__/__MONTH__/__DAY__.
//

import UIKit

protocol __PREFIX__View: AnyObject {
}

final class __PREFIX__ViewController: UIViewController {

  private var presenter: __PREFIX__Presentation!
  func inject(presenter: __PREFIX__Presentation) {
    self.presenter = presenter
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

extension __PREFIX__ViewController: __PREFIX__View {
}