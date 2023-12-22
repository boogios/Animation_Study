//
//  LastFightingSubView.swift
//  Animation
//
//  Created by 변상우 on 12/22/23.
//

import UIKit

import SnapKit

class LastFightingSubView: UIView {
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    let confirmButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setLayout()
    }
    
    private func setupView() {
        backgroundColor = UIColor.darkGray
        layer.cornerRadius = 30
        clipsToBounds = true
        
        titleLabel.text = "100,000원"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.textAlignment = .center
        
        subTitleLabel.text = "받았어요."
        subTitleLabel.textColor = .systemGray2
        subTitleLabel.font = UIFont.systemFont(ofSize: 15)
        subTitleLabel.textAlignment = .center
        
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.backgroundColor = .yellow
        confirmButton.layer.cornerRadius = 25
        
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(confirmButton)
        
        // 초기에는 보이지 않도록 설정
        isHidden = true
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(30)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        confirmButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(30)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(60)
        }
    }
    
    func show() {
        isHidden = false
    }
    
    @objc
    func hide() {
        isHidden = true
    }
}
