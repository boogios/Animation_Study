//
//  ThirdStudyViewController.swift
//  Animation
//
//  Created by 변상우 on 11/27/23.
//

import UIKit

class ThirdStudyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewToTransform = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        viewToTransform.backgroundColor = .red
        self.view.addSubview(viewToTransform)
        
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 500
        transform = CATransform3DRotate(transform, CGFloat(45 * Double.pi / 180), 0, 1, 0)
        viewToTransform.layer.transform = transform
    }
}
