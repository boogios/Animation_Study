//
//  ViewController.swift
//  Animation
//
//  Created by 변상우 on 11/6/23.
//

import UIKit

class ViewController: UIViewController {

    let testView : UIView = {
        let view = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view.backgroundColor = .systemPink
        return view
    }()
    
    let testButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 150, y: 400, width: 200, height: 50))
        button.setTitle("짠!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.textColor = .brown
        button.layer.backgroundColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
        return button
    }()
    
    let firstFightingButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 130, y: 500, width: 200, height: 50))
        button.setTitle("1주차 화이팅!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.titleLabel?.textColor = .brown
        button.layer.backgroundColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(goToFirstFightingView), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        didMoveTap()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(testView)
        view.addSubview(testButton)
        view.addSubview(firstFightingButton)
    }
    
    private func didMoveTap() {
        // 이건 3개가 동시에 돌아가요!
//        UIView.animate(withDuration: 2.0) { [self] in
//            testView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
//        }
//        
//        UIView.animate(withDuration: 2.0) { [self] in
//            testView.transform = CGAffineTransform(rotationAngle: .pi)
//        }
//        
//        UIView.animate(withDuration: 2.0) { [self] in
//            testView.transform = CGAffineTransform(translationX: 200, y: 200)
//        }
        
        // 이건 너무 코드가 더러워요!
//        UIView.animate(withDuration: 2.0) { [self] in
//                    testView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
//                } completion: { _ in
//                    UIView.animate(withDuration: 2.0) { [self] in
//                        testView.transform = CGAffineTransform(rotationAngle: .pi)
//                    } completion: { _ in
//                        UIView.animate(withDuration: 2.0) { [self] in
//                            testView.transform = CGAffineTransform(translationX: 200, y: 200)
//                        }
//                    }
//                }
        
        UIView.animateKeyframes(withDuration: 3.0, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3) { [self] in
                testView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            }
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) { [self] in
                testView.transform = CGAffineTransform(rotationAngle: .pi)
            }
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) { [self] in
                testView.transform = CGAffineTransform(translationX: 200, y: 200)
            }
        }
    }
    
    @objc private func didButtonTap() {
        // 포스트잇 효과, transition 내장 옵션들 활용
//        UIView.transition(with: testView, duration: 1.0, options: .transitionCurlUp, animations: nil)
        
        // 왕복 하는 횟수, 할지 말지 결정하는 것
//        UIView.animate(withDuration: 1.0) { [self] in
//            UIView.modifyAnimations(withRepeatCount: 3.0, autoreverses: true) {
//                testView.frame.origin.x += 100
//            }
//        }
        
        // 바닥까지 갔다가 바운스 되는 기능들
        UIView.animate (springDuration: 2.0, bounce: 0.6) {
            testView.center.y += 100
        }
    }
    
    @objc private func goToFirstFightingView() {
        self.navigationController?.pushViewController(FirstFightingViewController(), animated: true)
    }
}
