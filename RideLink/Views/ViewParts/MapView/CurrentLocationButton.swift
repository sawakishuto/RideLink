//
//  CurrentLocationButton.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/06/06.
//

import Foundation
import UIKit

final class CurrentLocationButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpButton() {
        self.addSubview(customView)
        customView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(70)
            $0.width.equalTo(70)
        }
        customView.backgroundColor = .white
        customView.layer.shadowColor = CGColor(gray: 1, alpha: 1)
        customView.layer.shadowOffset = CGSize(width: 2, height: 4)

        customView.addSubview(customImageView)
        customImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }

        customView.addSubview(customLabel)
        customLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(customImageView.snp.bottom).offset(8)
        }
    }

    private lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mappin.and.ellipse")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var customLabel: UILabel = {
        let label = UILabel()
        label.text = "現在地に戻る"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 6)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let customView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.isUserInteractionEnabled = false

        return view
    }()
}
