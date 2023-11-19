//
//  SecondStudyViewController.swift
//  Animation
//
//  Created by 변상우 on 11/13/23.
//

import UIKit

class SecondStudyViewController: UIViewController {
    
    var testView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.frame = CGRect(x: 100, y: 300, width: 200, height: 200)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.view.addSubview(testView)
        
        target()
    }
    
    private func target() {
        // UITapGestureRecognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTap))
        tapGesture.numberOfTapsRequired = 3
        testView.addGestureRecognizer(tapGesture)
        
        // UIPinchGestureRecognizer
        var pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(viewPinch))
        testView.addGestureRecognizer(pinchGesture)
        
        // UIRotationGestureRecognizer
        var rotaionGesture = UIRotationGestureRecognizer(target: self, action: #selector(viewRotaion))
        testView.addGestureRecognizer(rotaionGesture)
        
        // UISwipeGestureRecognizer
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipe))
        swipeRightGesture.direction = .right
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipe))
        swipeRightGesture.direction = .left
        self.view.addGestureRecognizer(swipeRightGesture)
        self.view.addGestureRecognizer(swipeLeftGesture)
        
        //UILongPressGestureRecognizer
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(viewPress))
//        longPressGesture.minimumPressDuration = 5.0
//        longPressGesture.numberOfTouchesRequired = 2
        self.testView.addGestureRecognizer(longPressGesture)
        
        //UIPanGestureRecognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPan))
        self.testView.addGestureRecognizer(panGesture)
    }
    
    @objc
    private func viewTap(gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 1.0, animations: { [self] in
            testView.frame.origin.x += 50
        }, completion: { _ in
            UIView.animate(withDuration: 1.0, animations: { [self] in
                testView.frame.origin.x -= 50
            })
        })
    }
    
    @objc
    private func viewPinch(gesture: UIPinchGestureRecognizer) {
        guard let view = gesture.view else { return }
        view.transform = view.transform.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1
    }

    @objc
    private func viewRotaion(gesture: UIRotationGestureRecognizer) {
        guard let view = gesture.view else { return }
        view.transform = view.transform.rotated(by: gesture.rotation)
        gesture.rotation = 0
    }
   
    @objc
    private func viewSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            self.view.backgroundColor = .brown
        } else if gesture.direction == .left {
            self.view.backgroundColor = .white
        }
    }

    @objc
    private func viewPress(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            print("Start\n")
        case .changed:
            print("Change\n")
        case .ended:
            print("End\n")
        case .possible:
            print("Possibe")
        case .cancelled:
            print("Cancel")
        case .failed:
            print("Fail")
        @unknown default:
            print("어쩔")
        }
    }
    
    @objc 
    private func viewPan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        if let viewToMove = gesture.view {
            viewToMove.center = CGPoint(x: viewToMove.center.x + translation.x, y: viewToMove.center.y + translation.y)
        }
        
        gesture.setTranslation(.zero, in: view)
    }
    
}
