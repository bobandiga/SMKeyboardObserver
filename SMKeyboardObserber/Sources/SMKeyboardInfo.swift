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
    var animationCurve: UIViewAnimationCurve? {
        return UIViewAnimationCurve(rawValue: rawCurve)
    }
}


// MARK: UIViewAnimationOptions
public extension SMKeyboardInfo {
    var animationOptions: UIViewAnimationOptions {
        return UIViewAnimationOptions(rawValue: UInt(rawCurve))
    }
}
