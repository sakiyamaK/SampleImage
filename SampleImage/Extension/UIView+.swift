//
//  UIView+.swift
//  SampleImage
//
//  Created by sakiyamaK on 2021/06/10.
//

import UIKit

extension UIView {

    func toImage(opaque:Bool = false) -> UIImage? {
        let view = self
        UIGraphicsBeginImageContextWithOptions(view.frame.size, opaque, 0.0)
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: ctx)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }

    func toImageView() -> UIImageView {
        return UIImageView(image:self.toImage())
    }
}


