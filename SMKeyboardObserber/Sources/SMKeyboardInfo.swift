//
//  SMKeyboardInfo.swift
//  SMKeyboardObserber
//
//  Created by Максим Шаптала on 21.03.2022.
//

import Foundation

public struct SMKeyboardInfo {
    public let beginFrame: CGRect
    public let endFrame: CGRect
    public let animationDuration: TimeInterval
    public let rawCurve: Int
    public let isLocal: Bool
}


// MARK: UIViewAnimationCurve
public extension SMKeyboardInfo {
    var animationCurve: UIView.AnimationCurve? {
        return UIView.AnimationCurve(rawValue: rawCurve)
    }
}


// MARK: UIViewAnimationOptions
public extension SMKeyboardInfo {
    var animationOptions: UIView.AnimationOptions {
        return UIView.AnimationOptions(rawValue: UInt(rawCurve))
    }
}
