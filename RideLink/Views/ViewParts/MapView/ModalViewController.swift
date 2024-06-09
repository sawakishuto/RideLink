//
//  ModalViewController.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/06/09.
//

import Foundation
import UIKit
import SnapKit

final class ModalViewController: UIViewController {
    var buttonTapped: (() -> Void)?
    var destinationNameOnChanged: ((String) -> Void)?
    var touringCommentOnChanged: ((String) -> Void)?

    init(buttonTapped: @escaping () -> Void, destinationNameOnChanged: @escaping (String) -> Void, touringCommentOnChanged: @escaping (String) -> Void) {
        self.buttonTapped = buttonTapped
        self.destinationNameOnChanged = destinationNameOnChanged
        self.touringCommentOnChanged = touringCommentOnChanged
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        destinationField.delegate = self
        commentField.delegate = self
        setUp()

        destinationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }
        destinationLabel.contentHuggingPriority(for: .horizontal)

        destinationField.snp.makeConstraints {
            $0.top.equalTo(destinationLabel.snp.bottom).offset(20)
            $0.height.equalTo(60)
            $0.centerX.equalTo(destinationLabel.snp.centerX)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        destinationField.contentHuggingPriority(for: .horizontal)

        commentLabel.snp.makeConstraints {
            $0.top.equalTo(destinationField.snp.bottom).offset(40)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }
        commentLabel.contentHuggingPriority(for: .horizontal)

        commentField.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(20)
            $0.height.equalTo(140)
            $0.centerX.equalTo(commentLabel.snp.centerX)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        commentField.contentHuggingPriority(for: .horizontal)

        dicedeButton.snp.makeConstraints {
            $0.top.equalTo(commentField.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(60)
        }

    }

    let destinationLabel: UILabel = {
        let label = UILabel()
        label.text = "目的地"
        label.font = .systemFont(ofSize: 20, weight: .black)
        return label
    }()

    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "ツーリングコメント"
        label.font = .systemFont(ofSize: 20, weight: .black)
        return label
    }()

    let destinationField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.layer.cornerRadius = 20
        return textfield
    }()

    let commentField: UITextView = {
        let textfield = UITextView()
        textfield.backgroundColor = .white
        textfield.layer.cornerRadius = 20
        return textfield
    }()

    let dicedeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 14/255.0, green: 124/255.0, blue: 100/255.0, alpha: 1.0)
        button.layer.cornerRadius = 25
        button.setTitle("決定", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 20, weight: .black)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)

        return button
    }()

    private func setUp() {

        view.addSubview(destinationLabel)
        view.addSubview(destinationField)
        view.addSubview(commentLabel)
        view.addSubview(commentField)
        view.addSubview(dicedeButton)

    }
}

extension ModalViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            destinationNameOnChanged?(text)
        }
    }
}
extension ModalViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            touringCommentOnChanged?(text)
        }
    }
}
extension ModalViewController {
    @objc func tapButton() {
        buttonTapped!()
    }
}
