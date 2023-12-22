//
//  LastFightingViewController.swift
//  Animation
//
//  Created by 변상우 on 12/22/23.
//

import UIKit

import SnapKit

class LastFightingViewController: UIViewController {
    
    private let emitterLayer = CAEmitterLayer()
    private let confirmSubView = LastFightingSubView()
    private let grayView = UIView()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "myProfileImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "boogios"
        label.textColor = .systemGray
        return label
    }()
    
    private let receiveButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "receiveButtonImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setSytle()
        setHierarchy()
        setLayout()
        target()
        setUpEmitterLayer()
    }
    
    private func setNavigationBar() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: nil, action: nil)
        
        let rightSearchBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: nil, action: nil)
        
        let rightListBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.justify"), style: .plain, target: nil, action: nil)
        
        self.navigationItem.title = "iOS 애니메이션 스터디 짱"
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = rightSearchBarButtonItem
        self.navigationItem.rightBarButtonItem = rightListBarButtonItem
    }
    
    private func setSytle() {
        self.view.backgroundColor = .systemGray5
        grayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    private func setHierarchy() {
        self.view.addSubview(profileImageView)
        self.view.addSubview(profileLabel)
        self.view.addSubview(receiveButtonImageView)
        self.view.addSubview(confirmSubView)
    }
    
    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            $0.width.height.equalTo(40)
        }
        
        profileLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.top.equalTo(profileImageView.snp.top)
        }
        
        receiveButtonImageView.snp.makeConstraints {
            $0.top.equalTo(profileLabel.snp.bottom).offset(10)
            $0.leading.equalTo(profileLabel.snp.leading)
            $0.width.equalToSuperview().multipliedBy(0.7) // 이미지 뷰의 너비 설정 (예시로 80%의 너비)
            $0.height.equalTo(receiveButtonImageView.snp.width)
        }
        
        confirmSubView.snp.makeConstraints {
            $0.center.equalTo(self.view)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(230)
        }
    }
    
    private func setUpEmitterLayer() {
        emitterLayer.emitterCells = [setUpEmiterCell]
        emitterLayer.emitterShape = .line
    }
    
    private var setUpEmiterCell: CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "bells")?.cgImage
        cell.lifetime = 3
        cell.birthRate = 50
        
        cell.scale = 0.15 //크기
        cell.scaleRange = 0.05 //크기범위
        
        cell.spin = 2 //스핀 횟수
        cell.spinRange = 10 //스핀 범위
        
        cell.emissionLongitude = .pi / 2 // 파티클의 방향 (위쪽으로)
        cell.emissionRange = .pi / 8 // 파티클의 방향 범위
        
        cell.velocity = 100 // 파티클의 초기 속도
        cell.velocityRange = 1000 //velocity범위
        cell.yAcceleration = 1000 //gravity 효과 //양수면 중력, 음수면 중력적용 X
        
        return cell
    }
    
    private func target() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(receiveButtonTapped(_:)))
        receiveButtonImageView.addGestureRecognizer(tapGesture)
        
        confirmSubView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func receiveButtonTapped(_ sender: UITapGestureRecognizer) {
        self.view.addSubview(grayView)
        
        grayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        confirmSubView.show()
        self.view.bringSubviewToFront(confirmSubView)

        emitterLayer.emitterPosition = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)
        emitterLayer.birthRate = 1

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
            self?.emitterLayer.birthRate = 0
        }
        
        view.layer.addSublayer(emitterLayer)
    }
    
    @objc
    private func confirmButtonTapped() {
        grayView.removeFromSuperview()
        confirmSubView.hide()
    }
}
