//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Matvey Garbuzov on 01.06.2023.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
  
  private let stack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .center
    stack.distribution = .fillEqually
    stack.spacing = 5
    
    return stack
  }()
  private let loginField = CustomTextField()
  private let passwordField = CustomTextField()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupKeyboard()
    setupViews()
    setupConstraints()
  }
  
  private func setupKeyboard() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
  @objc private func handleKeyboardWillShow(notification: Notification) {
    guard let keyboardFrame = getKeyboardFrame(from: notification.userInfo) else { return }
    let offset = keyboardFrame.height
    stack.snp.updateConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(offset)
    }
    UIView.animate(withDuration: 0.3, animations: {
      self.view.layoutIfNeeded()
    })
  }
  
  @objc private func handleKeyboardWillHide(notification: Notification) {
    stack.snp.updateConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide)
    }
    
    UIView.animate(withDuration: 0.3, animations: {
      self.view.layoutIfNeeded()
    })
  }
  
  private func getKeyboardFrame(from userInfo: [AnyHashable : Any]?) -> CGRect? {
    guard let userInfo = userInfo else { return nil }
    guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return nil }
    return self.view.convert(keyboardFrame, from: nil)
  }
  
  private func setupViews() {
    view.backgroundColor = .darkGray
  
    loginField.placeholder = "Login:"
    passwordField.placeholder = "Password:"
  }
  
  private func setupConstraints() {
    stack.addArrangedSubview(loginField)
    stack.addArrangedSubview(passwordField)
    
    view.addSubview(stack)
    
    stack.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(120)
      make.width.equalToSuperview().multipliedBy(0.9)
    }
    
    stack.subviews.forEach({ view in
      view.snp.makeConstraints { make in
        make.width.equalToSuperview()
      }
    })
  }
}
