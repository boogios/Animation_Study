//
//  FirstFightingViewController.swift
//  Animation
//
//  Created by 변상우 on 11/12/23.
//

import UIKit

class FirstFightingViewController: UIViewController {
    
    private let animationLabel1: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.text = "애니메이션 스터디"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private let animationLabel2: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.text = "화이팅~~!"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private let shakeButton : UIButton = {
        let button = UIButton()
        button.setTitle("~흔들리는~버튼~", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.textColor = .brown
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(shakeButtonTap), for: .touchUpInside)
        button.shakeButton()
        return button
    }()
    
    private let showTaostButton : UIButton = {
        let button = UIButton()
        button.setTitle("토스트 메시지 나와라!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.textColor = .brown
        button.layer.backgroundColor = UIColor.systemGreen.cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showToastButtonTap), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        animateLabel()
    }
    
    private func setLayout() {
        [animationLabel1, animationLabel2, shakeButton, showTaostButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            animationLabel1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            animationLabel1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            animationLabel2.topAnchor.constraint(equalTo: animationLabel1.bottomAnchor, constant: 5),
            animationLabel2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            shakeButton.topAnchor.constraint(equalTo: animationLabel2.bottomAnchor, constant: 50),
            shakeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            shakeButton.widthAnchor.constraint(equalToConstant: 300),
            shakeButton.heightAnchor.constraint(equalToConstant: 50),
            
            showTaostButton.topAnchor.constraint(equalTo: shakeButton.bottomAnchor, constant: 30),
            showTaostButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            showTaostButton.widthAnchor.constraint(equalToConstant: 300),
            showTaostButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func shakeButtonTap() {
        shakeButton.shakeButton()
    }
    
    @objc private func showToastButtonTap() {
        let label = UILabel()
        label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center;
        label.text = "토스트 메시지입니다!"
        label.alpha = 1.0
        label.layer.cornerRadius = 10;
        label.clipsToBounds  =  true
        
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseInOut, animations: {
            label.alpha = 0.0
        }, completion: {(isCompleted) in
            label.removeFromSuperview()
        })
    }
    
    func animateLabel() {
        // 첫 번째 줄 나타내기
        UIView.animate(withDuration: 0.5, animations: {
            self.animationLabel1.alpha = 1.0
        }) { _ in
            // 1초 대기 후 두 번째 줄 나타내기
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIView.animate(withDuration: 0.5) {
                    self.animationLabel2.alpha = 1.0
                }
            }
        }
    }
}
