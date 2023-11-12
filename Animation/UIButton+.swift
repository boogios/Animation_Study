//
//  UIButton+.swift
//  Animation
//
//  Created by 변상우 on 11/12/23.
//

import UIKit

extension UIButton {
    func shakeButton() {
        self.transform = CGAffineTransform(translationX: 0, y: 20)
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 5,
                       options: [.curveEaseInOut]) {
            self.transform = .identity
        }
    }
}
