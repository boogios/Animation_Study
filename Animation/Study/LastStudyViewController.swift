//
//  LastStudyViewController.swift
//  Animation
//
//  Created by 변상우 on 12/6/23.
//

import UIKit

class LastStudyViewController: UIViewController {

    private let emitterLayer = CAEmitterLayer()
        
        override func viewDidLoad() {
            super.viewDidLoad()
//            self.view.layer.addSublayer(emitterLayer)
            
            self.view.backgroundColor = .white
            setUpEmitterLayer()
            setUpTapGestureRecognizer()
        }
        
        private func setUpEmitterLayer() {
            emitterLayer.emitterCells = [setUpEmiterCell]
        }
        
        private var setUpEmiterCell: CAEmitterCell {
            let cell = CAEmitterCell()
            cell.contents = UIImage(named: "turtle")?.cgImage
            cell.lifetime = 3
            cell.birthRate = 30
            
            cell.scale = 0.15 //크기
            cell.scaleRange = 0.05 //크기범위
            
            cell.spin = 5 //스핀 횟수
            cell.spinRange = 10 //스핀 범위
            
            cell.emissionRange = CGFloat.pi * 2 //방출 각도, 360도
            
            cell.velocity = 700
            cell.velocityRange = 50 //velocity범위
            cell.yAcceleration = 1200 //gravity 효과 //양수면 중력, 음수면 중력적용 X
            
            return cell
        }
        
        private func setUpTapGestureRecognizer() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            self.view.addGestureRecognizer(tap)
            self.view.isUserInteractionEnabled = true
        }
        
        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            let x = sender.location(in: view).x
            let y = sender.location(in: view).y

            emitterLayer.emitterPosition = CGPoint(x: x, y: y)
            emitterLayer.birthRate = 1

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
                self?.emitterLayer.birthRate = 0
            }
            
            view.layer.addSublayer(emitterLayer)
        }
}
