//
//  Extensions.swift
//  CountryApp
//
//  Created by Matvey Garbuzov on 01.06.2023.
//

import UIKit

extension UIView {
  func animateInsidePress() {
    UIView.animate(withDuration: 0.15, animations: {
      self.transform = self.transform.scaledBy(x: 0.95, y: 0.95)
    }) { _ in
      UIView.animate(withDuration: 0.15, animations: {
        self.transform = CGAffineTransform.identity
      })
    }
  }
  
  func shake() {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.1
    animation.repeatCount = 1
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
    self.layer.add(animation, forKey: "position")
  }
}
