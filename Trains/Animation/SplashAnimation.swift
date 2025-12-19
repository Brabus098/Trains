//  SplashAnimation.swift

import Foundation
import SwiftUI

enum SplashAnimation {
    case start, mid, end
    
    var opacity: Double {
        switch self {
        case .start: 0.1
        case .mid: 0.8
        case .end: 1.0
        }
    }
    
    var offset: CGFloat {
        switch self {
        case .start: 0
        case .mid: -350
        case .end: -400
        }
    }
    
    var animationType: Animation {
        switch self {
        case .start: .easeIn(duration: 1)
        case .mid: .linear(duration: 1)
        case .end: .easeOut(duration: 3)
        }
    }
}
