//
//  ViewController.swift
//  SMKeyboardObserber
//
//  Created by bobandiga on 03/20/2022.
//  Copyright (c) 2022 bobandiga. All rights reserved.
//

import UIKit
import SMKeyboardObserber

class ViewController: UIViewController {
    
    
    // MARK: Private
    
    private let keyboardObserver: SMKeyboardObserverProtocol
    
    private let textField: UITextField = UITextField(frame: CGRect(x: 50, y: 400, width: 300, height: 50))
    
    
    // MARK: Lifecycle
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init() {
        self.keyboardObserver = SMKeyboardObserver()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        textField.delegate = self
        textField.backgroundColor = .cyan
        view.addSubview(textField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        keyboardObserver.onKeyboard(event: .willShow) { [weak self] e, i in
            guard let self = self else { return }
            guard let offset = self.heightOffset(info: i) else { return }
            DispatchQueue.main.async {
                UIView.animate(withDuration: i.animationDuration,
                               delay: 0,
                               options: i.animationOptions) { [weak self] in
                    self?.textField.transform = CGAffineTransform.init(translationX: 0, y: -offset)
                }
            }
        }
        
        keyboardObserver.onKeyboard(event: .willHide) { [weak self] e, i in
            guard let self = self else { return }
            let animator = UIViewPropertyAnimator(duration: i.animationDuration,
                                                  curve: i.animationCurve ?? .easeIn) { [weak self] in
                self?.textField.transform = .identity
            }
            animator.startAnimation()
        }
    }
    
    
    // MARK: Private
    
    private func heightOffset(info: SMKeyboardInfo) -> CGFloat? {
        let diffY = max(info.beginFrame.origin.y, info.endFrame.origin.y) - min(info.beginFrame.origin.y, info.endFrame.origin.y)
        return diffY == 0 ? nil : diffY
    }
}


// MARK: UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

