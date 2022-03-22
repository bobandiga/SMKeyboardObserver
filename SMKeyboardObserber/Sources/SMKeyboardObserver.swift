//
//  SMKeyboardObserver.swift
//  
//
//  Created by Максим Шаптала on 21.03.2022.
//

import UIKit

public typealias SMKeyboardHandler = (SMKeyboardEvent, SMKeyboardInfo) -> Void


public protocol SMKeyboardObserverProtocol {
    var isEnabled: Bool { get set }
    func onKeyboard(events: SMKeyboardEvent..., handler: @escaping SMKeyboardHandler)
    func onKeyboard(event: SMKeyboardEvent, handler: @escaping SMKeyboardHandler)

    func forceRemoveObserver(event: SMKeyboardEvent)
    func forceRemoveObservers(events: SMKeyboardEvent...)
    func forceRemoveAllObservers()
}


public final class SMKeyboardObserver: SMKeyboardObserverProtocol {


    // MARK: Public

    public var isEnabled: Bool


    // MARK: Private

    private let nc: NotificationCenter
    private var handlers: [SMKeyboardEvent: SMKeyboardHandler] = [:]
    private var observers: [SMKeyboardEvent: Any] = [:]




    // MARK: Lifecycle

    public init(notificationCenter: NotificationCenter = .default,
                isEnabled: Bool = true) {
        self.nc = notificationCenter
        self.isEnabled = isEnabled
    }

    deinit {
        unsubscribeAllObservers()
    }


    // MARK: Public


    public func onKeyboard(events: SMKeyboardEvent..., handler: @escaping SMKeyboardHandler) {
        events.forEach { event in
            onKeyboard(event: event, handler: handler)
        }
    }

    public func onKeyboard(event: SMKeyboardEvent,
                           handler: @escaping SMKeyboardHandler) {

        /// Clear all data assotiated with event
        unsubscribeObserverIfNeeded(event: event)

        /// Set handler for event
        handlers[event] = handler

        /// Subscribe observer
        subscribeObserver(event: event)
    }

    public func forceRemoveObserver(event: SMKeyboardEvent) {
        unsubscribeObserverIfNeeded(event: event)
    }

    public func forceRemoveObservers(events: SMKeyboardEvent...) {
        events.forEach(unsubscribeObserverIfNeeded(event:))
    }

    public func forceRemoveAllObservers() {
        unsubscribeAllObservers()
    }

    
    // MARK: Private

    private func subscribeObserver(event: SMKeyboardEvent) {

        let observer = nc.addObserver(forName: event
                                        .notificationName,
                                      object: nil,
                                      queue: .main) { [weak self] notification in

            guard let self = self else {
                return
            }

            guard self.isEnabled else {
                return
            }

            guard
                let info = self.info(notification),
                let handler = self.handlers[event]
            else {
                return
            }
            
            handler(event, info)
        }

        observers[event] = observer
    }

    private func unsubscribeObserverIfNeeded(event: SMKeyboardEvent) {
        if let observer = observers[event] {
            nc.removeObserver(observer)
        }

        handlers[event] = nil
        observers[event] = nil
    }

    private func unsubscribeAllObservers() {
        observers.values.forEach(nc.removeObserver(_:))
        observers.removeAll()
        handlers.removeAll()
    }

    private func info(_ notification: Notification) -> SMKeyboardInfo? {
        guard let info = notification.userInfo else { return nil }

        guard
            let beginFrame = info[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect,
            let endFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let animationDuration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let rawCurve = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
            let isLocal = info[UIResponder.keyboardIsLocalUserInfoKey] as? Bool
        else {
            return nil
        }

        return SMKeyboardInfo(beginFrame: beginFrame,
                              endFrame: endFrame,
                              animationDuration: animationDuration,
                              rawCurve: rawCurve,
                              isLocal: isLocal)

    }
}


