//
//  SMKeyboardEvent.swift
//  SMKeyboardObserber
//
//  Created by Максим Шаптала on 21.03.2022.
//

import Foundation
import UIKit

public enum SMKeyboardEvent {
    case willShow
    case didShow
    case willHide
    case didHide
    case willChangeFrame
    case didChangeFrame
}

extension SMKeyboardEvent {
    var notificationName: Notification.Name {
        switch self {
            case .willShow:
                return .UIKeyboardWillShow
            case .didShow:
                return .UIKeyboardDidShow
            case .willHide:
                return .UIKeyboardWillHide
            case .didHide:
                return .UIKeyboardDidHide
            case .willChangeFrame:
                return .UIKeyboardWillChangeFrame
            case .didChangeFrame:
                return .UIKeyboardDidChangeFrame
        }
    }
}
