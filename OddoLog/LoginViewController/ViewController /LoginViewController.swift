//
//  LoginViewController.swift
//  OddoLog
//
//  Created by Petr on 31.01.2021.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    var presenter: LoginPresenter = LoginViewPresenter()

    @IBOutlet var emailTextFiled: UIView!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var logInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
    }

    @IBAction func loginIn(_ sender: Any) {
    }
}

extension LoginViewController: LoginView {
    // ???
    func didLogin(error: Error?) {
        if error == nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.showAlert(with: nil, message: error?.localizedDescription ?? "Something was wrong")
        }
    }
    func showAlert(with title: String?, message: String?) {
        self.presentAlert(withTitle: title, message: message)
    }

    func enableSubmitButton(_ isEnabled: Bool) {
      self.logInButton.isEnabled = isEnabled
      if isEnabled {
        self.logInButton.setTitle("Submit", for: .normal)
      } else {
        self.logInButton.setTitle("Submitting...", for: .normal)
      }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        if textField == emailTextFiled {
            presenter.setUserName(username: textField.text)
        }

        if textField == passwordTextFiled {
            presenter.setPassword(password: textField.text)
        }

        presenter.loginIn()

        return true
    }
}
