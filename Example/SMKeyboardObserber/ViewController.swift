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

        let textField: UITextField = {
            let tf = UITextField(frame: CGRect(x: 50, y: 400, width: view.frame.width - 100, height: 50))
            tf.backgroundColor = .cyan
            tf.delegate = self
            return tf
        }()
        view.addSubview(textField)

        keyboardObserver.onKeyboard(event: .willShow) { [weak self, weak textField] e, i in
            guard let self = self else { return }

            let offset = self.heightOffset(info: i)

            UIView.animate(withDuration: i.animationDuration,
                           delay: 0,
                           options: i.animationOptions) {
                textField?.transform = CGAffineTransform.init(translationX: 0, y: -offset)
            }
        }

        keyboardObserver.onKeyboard(event: .willHide) { [weak self, weak textField] e, i in
            guard let _ = self else { return }

            let animator = UIViewPropertyAnimator(duration: i.animationDuration,
                                                  curve: i.animationCurve ?? .easeIn) { 
                textField?.transform = .identity
            }
            animator.startAnimation()
        }
    }


    // MARK: Private

    private func heightOffset(info: SMKeyboardInfo) -> CGFloat {
        let diffY = max(info.beginFrame.origin.y, info.endFrame.origin.y) - min(info.beginFrame.origin.y, info.endFrame.origin.y)
        return diffY
    }
}


// MARK: UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

