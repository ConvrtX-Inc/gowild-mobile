//
//  ChatHeaderView.swift
//  GoWild
//
//  Created by SA - Haider Ali on 27/12/2022.
//  Copyright © 2022 Go_Wild. All rights reserved.
//

import Foundation
import SnapKit

class ChatHeaderView: UIView {
    
    var vStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 5.0
        return view
    }()
    
    var userImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = view.frame.height * 0.5
        view.image = nil
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var subscribedImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = view.frame.height * 0.5
        view.image = UIImage(named: "subscribed")
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.isHidden = true
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.getForegenRoughOneFontOf(size: 26)
        label.text = "Title label"
        label.textAlignment = .left
        label.textColor = R.color.appWhiteColor()
        return label
    }()
    
    private var onlineImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "onlineStatus")
        view.isHidden = true
        return view
    }()
    
    private var subTitleLAbel: UILabel = {
        let label = UILabel()
        label.font = Fonts.getSourceSansProRegularOf(size: 14)
        label.text = "subTitle label"
        label.textAlignment = .left
        label.isHidden = true
        label.textColor = R.color.textDarkGrayColor()
        return label
    }()
    
    private var namePrefixLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.getSourceSansProBoldOf(size: 12)
        label.textAlignment = .center
        label.textColor = R.color.appBgBlack()
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureViews()
        setupConstrints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        addSubview(vStackView)
        addSubview(userImageView)
        addSubview(onlineImageView)
        addSubview(subscribedImageView)
        userImageView.addSubview(namePrefixLabel)
        vStackView.addArrangedSubview(titleLabel)
        vStackView.addArrangedSubview(subTitleLAbel)
    }

    func configureViews() {
        self.backgroundColor = .clear
        userImageView.layer.cornerRadius = 19
        userImageView.backgroundColor = UIColor.appYellowColor
        userImageView.bringSubviewToFront(onlineImageView)
    }
    func setupConstrints() {
        
        userImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(38)
            make.bottom.equalToSuperview()
            make.leading.top.equalToSuperview()
        }
        onlineImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(12)
            make.trailing.equalTo(userImageView.snp.trailing)
            make.bottom.equalTo(userImageView.snp.bottom)
        }
        
         namePrefixLabel.snp.makeConstraints { make in
             make.edges.equalTo(userImageView)
         }
        
        vStackView.snp.makeConstraints { (make) in
            make.leading.equalTo(userImageView.snp.trailing).offset(12)
            make.trailing.top.bottom.equalToSuperview()
        }
        subscribedImageView.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.leading.equalTo(vStackView.snp.trailing).offset(8)
            make.top.equalTo(titleLabel.snp.top)
        }
    }
}
