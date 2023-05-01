//
//  UIView+Extensions.swift
//  UIBottomSheet
//
//  Created by Bruno Vieira on 01/05/23.
//

import UIKit

extension UIView {
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
      let mask = CAShapeLayer()
      let path = UIBezierPath(
        roundedRect: bounds,
        byRoundingCorners: corners,
        cornerRadii: CGSize(width: radius, height: radius)
      )
      
      mask.path = path.cgPath
      layer.mask = mask
  }
}
