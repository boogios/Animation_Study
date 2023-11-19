//
//  SecondFightingViewController.swift
//  Animation
//
//  Created by 변상우 on 11/19/23.
//

import UIKit
import Then
import SnapKit

class SecondFightingViewController: UIViewController {
    var score: Int = 0
    var timer: Timer? = nil
    var isPause: Bool = true
    
    private lazy var turtle = UIImageView(image: UIImage(named: "turtle"))
    private let topStone = UIImageView(image: UIImage(named: "stone"))
    private let bottomStone = UIImageView(image: UIImage(named: "stone"))
    private let leadingStone = UIImageView(image: UIImage(named: "stone"))
    private let trailingStone = UIImageView(image: UIImage(named: "stone"))
    private let scoreLabel = UILabel().then {
        $0.textAlignment = .center
        $0.text = "더블클릭을 해서 돌피하기 게임을 시작해보세요!"
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .brown
        $0.numberOfLines = 2
    }
    
    //저는 viewDidLoad startTimer 를 바로 시작하지 않고 longPress 제스처를 추가했어요
    //꾹 눌렀다가 땠을 때 startTimer 가 시작될 수 있게 .ended 에다가 startTimer()를 시작했답니다!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setLayout()
        setStone()
//        startTimer()
        target()
    }
    
    private func target() {
        //LongPress 제스처 추가
        let press = UILongPressGestureRecognizer(target: self, action: #selector(viewPress))
        press.minimumPressDuration = 3.0
        turtle.addGestureRecognizer(press)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(viewTap))
        doubleTap.numberOfTapsRequired = 2
        turtle.addGestureRecognizer(doubleTap)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(viewPan(_:)))
        turtle.addGestureRecognizer(gesture)
        turtle.isUserInteractionEnabled = true
    }
    
    //Pan 제스처 함수
    @objc
    private func viewPan(_ sender: UIPanGestureRecognizer) {
        let transition = sender.translation(in: turtle)
        let changedX = turtle.center.x + transition.x
        let changedY = turtle.center.y + transition.y
        
        self.turtle.center = .init(x: changedX,
                                    y: changedY)
        sender.setTranslation(.zero, in: self.turtle)
    }
    
    //longPress 제스처 함수
    @objc
    private func viewPress(gesture : UILongPressGestureRecognizer) {
        if gesture.state == .ended {
            startTimer()
        }
    }
    
    @objc
    private func viewTap(gesture : UILongPressGestureRecognizer) {
        startTimer()
    }
    
    //시간 측정
    private func startTimer() {
        self.score = 0
        self.scoreLabel.text = "거북이가 돌에 맞지않도록 해주세요!"
        guard timer == nil else { return }
        self.timer = Timer.scheduledTimer(timeInterval: 0.2,
                                          target: self,
                                          selector: #selector(self.moveToast),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func setLayout() {
        self.view.addSubview(turtle)
        self.view.addSubview(scoreLabel)
        turtle.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(80)
        }
        scoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(50)
        }
    }
    
    private func setStone() {
        self.view.addSubview(topStone)
        self.view.addSubview(bottomStone)
        self.view.addSubview(leadingStone)
        self.view.addSubview(trailingStone)
        
        topStone.snp.makeConstraints {
            $0.top.centerX.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.height.equalTo(50)
        }
        leadingStone.snp.makeConstraints {
            $0.leading.centerY.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.height.equalTo(50)
        }
        trailingStone.snp.makeConstraints {
            $0.trailing.centerY.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.height.equalTo(50)
        }
        bottomStone.snp.makeConstraints {
            $0.bottom.centerX.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.height.equalTo(50)
        }
    }
    
    //startTimer 가 시작되면 실행되는 함수(토스트가 움직이는 함수)
    @objc
    private func moveToast() {
        var topStoneY = self.topStone.frame.origin.y
        topStoneY += 10
        self.topStone.frame = .init(origin: .init(x: self.topStone.frame.origin.x,
                                                  y: topStoneY),
                                    size: self.topStone.frame.size)
        
        var bottomStoneY = self.bottomStone.frame.origin.y
        bottomStoneY -= 10
        self.bottomStone.frame = .init(origin: .init(x: self.bottomStone.frame.origin.x,
                                                     y: bottomStoneY),
                                       size: self.bottomStone.frame.size)
        
        var leftToastX = self.leadingStone.frame.origin.x
        leftToastX += 10
        self.leadingStone.frame = .init(origin: .init(x: leftToastX,
                                                      y: self.leadingStone.frame.origin.y),
                                        size: self.leadingStone.frame.size)
        
        var rightToastX = self.trailingStone.frame.origin.x
        rightToastX -= 10
        self.trailingStone.frame = .init(origin: .init(x: rightToastX,
                                                       y: self.trailingStone.frame.origin.y),
                                         size: self.trailingStone.frame.size)
        self.calculatePositionReached()
    }
    
    //토스트랑 쿠로미랑 만났는지 측정해서 게임 점수와 시작,끝 정해주는 함수
    private func calculatePositionReached() {
        if self.turtle.frame.minX <= self.topStone.frame.minX &&
            self.turtle.frame.maxX >= self.topStone.frame.maxX &&
            self.turtle.frame.minY <= self.topStone.frame.minY &&
            self.turtle.frame.maxY >= self.topStone.frame.maxY
        {
            self.scoreLabel.text = "거북이가 돌에 맞았어요ㅠㅠ\n점수:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
        
        if self.turtle.frame.minX <= self.leadingStone.frame.minX &&
            self.turtle.frame.maxX >= self.leadingStone.frame.maxX &&
            self.turtle.frame.minY <= self.leadingStone.frame.minY &&
            self.turtle.frame.maxY >= self.leadingStone.frame.maxY
        {
            self.scoreLabel.text = "거북이가 돌에 맞았어요ㅠㅠ\n점수:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
        
        if self.turtle.frame.minX <= self.trailingStone.frame.minX &&
            self.turtle.frame.maxX >= self.trailingStone.frame.maxX &&
            self.turtle.frame.minY <= self.trailingStone.frame.minY &&
            self.turtle.frame.maxY >= self.trailingStone.frame.maxY
        {
            self.scoreLabel.text = "거북이가 돌에 맞았어요ㅠㅠ\n점수:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
        
        if self.turtle.frame.minX <= self.bottomStone.frame.minX &&
            self.turtle.frame.maxX >= self.bottomStone.frame.maxX &&
            self.turtle.frame.minY <= self.bottomStone.frame.minY &&
            self.turtle.frame.maxY >= self.bottomStone.frame.maxY
        {
            self.scoreLabel.text = "거북이가 돌에 맞았어요ㅠㅠ\n점수:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
    }
}
