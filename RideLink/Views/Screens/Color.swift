//
//  Color.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/05/05.
//

import Foundation
import SwiftUI

extension Color {
  /// create new object with hex string
  init?(hex: String, opacity: Double = 1.0) {
    // delete "#" prefix
    let hexNorm = hex.hasPrefix("#") ? String(hex.dropFirst(1)) : hex

    // scan each byte of RGB respectively
    let scanner = Scanner(string: hexNorm)
    var color: UInt64 = 0
    if scanner.scanHexInt64(&color) {
      let red = CGFloat((color & 0xFF0000) >> 16) / 255.0
      let green = CGFloat((color & 0x00FF00) >> 8) / 255.0
      let blue = CGFloat(color & 0x0000FF) / 255.0
      self.init(red: red, green: green, blue: blue, opacity: opacity)
    } else {
      // invalid format
      return nil
    }
  }
}

