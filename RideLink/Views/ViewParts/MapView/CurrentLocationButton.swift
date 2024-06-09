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
