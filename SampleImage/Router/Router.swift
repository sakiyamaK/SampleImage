//
//  Router.swift
//  SampleImage
//
//  Created by sakiyamaK on 2021/01/16.
//

import UIKit

/**
 画面遷移を管理
 */
final class Router {
    static let shared: Router = .init()
    private init() { }

    var window: UIWindow?

    /**
     起動直後の画面を表示する
     - parameter window: UIWindow
     */
    func showRoot(window: UIWindow?) {
        let vc = CameraRouter.assembleModules()
//        let vc = CropImageRouter.assembleModules()
        let rootVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        self.window = window
    }
}
