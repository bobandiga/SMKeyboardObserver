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
                return UIResponder.keyboardWillShowNotification
            case .didShow:
                return UIResponder.keyboardDidShowNotification
            case .willHide:
                return UIResponder.keyboardWillHideNotification
            case .didHide:
                return UIResponder.keyboardDidHideNotification
            case .willChangeFrame:
                return UIResponder.keyboardWillChangeFrameNotification
            case .didChangeFrame:
                return UIResponder.keyboardDidChangeFrameNotification
        }
    }
}
