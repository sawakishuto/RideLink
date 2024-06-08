//
//  TouringButton.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/06/05.
//

import Foundation
import UIKit

final class TouringButton: UIButton {

    var handler: ((Bool) -> Void)?
    var buttonColor: UIColor = UIColor(red: 252.0/255.0, green: 136.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    var shadowColor: CGColor = CGColor(red: 252.0/255.0, green: 136.0/255.0, blue: 100.0/255.0, alpha: 1.0)

    var isStartTouring: Bool = false {
        didSet {
            if isStartTouring {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    self.customView.backgroundColor = UIColor(red: 214.0/255.0, green: 53.0/255.0, blue: 42.0/255.0, alpha: 1.0)
                    self.shadowColor = CGColor(red: 252.0/255.0, green: 136.0/255.0, blue: 100.0/255.0, alpha: 1.0)
                    self.customLabel.text = "ツーリングを終了する！"
                    self.customImageView.image = UIImage(named: "home")
                    self.customView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }, completion: { _ in
                    UIView.animate(withDuration: 0.3, animations: {
                        self.customView.transform = CGAffineTransform.identity
                    })
                })
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    self.customView.backgroundColor = UIColor(red: 252.0/255.0, green: 136.0/255.0, blue: 100.0/255.0, alpha: 1.0)
                    self.shadowColor = CGColor(red: 252.0/255.0, green: 136.0/255.0, blue: 100.0/255.0, alpha: 1.0)
                    self.customLabel.text = "ツーリングを始める！"
                    self.customImageView.image = UIImage(named: "mainBike")
                    self.customView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }, completion: { _ in
                    UIView.animate(withDuration: 0.3, animations: {
                        self.customView.transform = CGAffineTransform.identity
                    })
                })
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setUpButton()
    }

    private func setUpButton() {
        self.addSubview(customView)
        customView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(70)
            $0.width.equalTo(240)
        }
        customView.backgroundColor = buttonColor
        customView.layer.shadowColor = CGColor(gray: 1, alpha: 1)
        customView.layer.shadowOffset = CGSize(width: 2, height: 4)

        customView.addSubview(customImageView)
        customImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
            $0.width.equalTo(50)
            $0.height.equalTo(30)
        }

        customView.addSubview(customLabel)
        customLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(customImageView.snp.bottom).offset(8)
        }
    }

    private lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mainBike")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var customLabel: UILabel = {
        let label = UILabel()
        label.text = isStartTouring ? "ツーリングを終了する！": "ツーリングを始める！"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()

    private let customView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.isUserInteractionEnabled = false

        return view
    }()
}
