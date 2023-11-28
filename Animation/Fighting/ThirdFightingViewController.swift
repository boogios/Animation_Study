//
//  ThirdFightingViewController.swift
//  Animation
//
//  Created by 변상우 on 11/28/23.
//

import UIKit

import SnapKit

class ThirdFightingViewController: UIViewController {
    
    private let loadingImageView = UIImageView(image: UIImage(named: "loading"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(loadingImageView)
        loadingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingImageView.heightAnchor.constraint(equalToConstant: 40),
            loadingImageView.widthAnchor.constraint(equalToConstant: 40),
            loadingImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        animate()
    }

    private func animate() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
         rotationAnimation.fromValue = 0
         rotationAnimation.toValue = CGFloat.pi * 2
         rotationAnimation.duration = 1.0
         rotationAnimation.repeatCount = Float.infinity
        
        loadingImageView.layer.add(rotationAnimation, forKey: "rotation_animation")
    }
}
