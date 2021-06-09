//
//  OverlayView.swift
//  SampleImage
//
//  Created by sakiyamaK on 2021/06/10.
//

import UIKit

final class OverlayView: UIView {

    struct CropParameter {
        var region: CGRect = .zero
        var cornerRadius: CGFloat = 5.0
        var arroundColor: UIColor = .black
    }

    private func createBackgroundLayer(parameter: CropParameter) -> CALayer {
        let backgroundLayer = CALayer()
        backgroundLayer.bounds = self.bounds
        backgroundLayer.position = self.center
        backgroundLayer.backgroundColor = parameter.arroundColor.cgColor

        let maskLayer = CAShapeLayer()
        maskLayer.bounds = backgroundLayer.bounds
        let path =  UIBezierPath(roundedRect: parameter.region, cornerRadius: parameter.cornerRadius)
        path.append(UIBezierPath(rect: maskLayer.bounds))

        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.path = path.cgPath
        maskLayer.position = self.center
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        backgroundLayer.mask = maskLayer

        return backgroundLayer
    }

    func setup(parameter: CropParameter) {
        self.layer.addSublayer(createBackgroundLayer(parameter: parameter))
    }


}
