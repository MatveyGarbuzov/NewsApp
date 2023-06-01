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
  
  private let button: UIButton = {
    let button = UIButton()
    button.backgroundColor = .gray
    button.setTitle("Login", for: .normal)
    button.layer.cornerRadius = 10
    button.isEnabled = false
    
    
    return button
  }()
  
  private let errorLabel = ErrorLabel()
  private let loginField = CustomTextField()
  private let passwordField = CustomTextField()
  private let viewModel = LoginViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupKeyboard()
    setupViews()
    setupConstraints()
  }
  
  private func getKeyboardFrame(from userInfo: [AnyHashable : Any]?) -> CGRect? {
    guard let userInfo = userInfo else { return nil }
    guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return nil }
    return self.view.convert(keyboardFrame, from: nil)
  }
  
  private func setupViews() {
    view.backgroundColor = .darkGray
    
    loginField.placeholder = "Login:"
    loginField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    
    passwordField.placeholder = "Password:"
    passwordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    
    button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
  }
  
  private func setupConstraints() {
    stack.addArrangedSubview(loginField)
    stack.addArrangedSubview(passwordField)
    stack.addArrangedSubview(button)
    
    view.addSubview(errorLabel)
    view.addSubview(stack)
    
    errorLabel.snp.makeConstraints { make in
      make.height.equalTo(30)
      make.width.equalTo(errorLabel.intrinsicContentSize.width * 1.2)

      make.bottom.equalTo(stack.snp.top).inset(-10)
      make.centerX.equalToSuperview()
    }
    
    stack.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(180)
      make.width.equalToSuperview().multipliedBy(0.9)
    }
    
    stack.subviews.forEach({ view in
      view.snp.makeConstraints { make in
        make.width.equalToSuperview()
      }
    })
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
  
  @objc private func loginButtonPressed(_ sender: UIButton) {
    sender.animateInsidePress()
    viewModel.login = loginField.text
    viewModel.password = passwordField.text
    
    if viewModel.isValid {
      errorLabel.hide()
    } else {
      errorLabel.show()
    }
  }
  
  @objc func textFieldDidChange(_ textField: UITextField) {
    if let login = loginField.text, !login.isEmpty, let password = passwordField.text, !password.isEmpty {
      UIView.animate(withDuration: 0.4) { [self] in
        button.isEnabled = true
        button.backgroundColor = UIColor.blue
      }
      
    } else {
      UIView.animate(withDuration: 0.4) { [self] in
        button.isEnabled = false
        button.backgroundColor = UIColor.gray
      }
    }
  }
}
