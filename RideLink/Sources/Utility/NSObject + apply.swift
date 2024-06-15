//
//  NSObject + apply.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/06/06.
//

import Foundation


extension NSObject {

    func apply(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}
