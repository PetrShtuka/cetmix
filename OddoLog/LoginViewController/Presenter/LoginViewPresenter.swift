//
//  LoginPresenter.swift
//  OddoLog
//
//  Created by Petr on 31.01.2021.
//
import Foundation
import Apollo
import KeychainSwift

class LoginViewPresenter: LoginPresenter {
    weak var view: LoginView?
    private var username: String?
    private var password: String?
    static let loginKeychainKey = "login"

    func setUserName(username: String?) {
        self.username = username
    }
    func setPassword(password: String?) {
        self.password = password
    }
    func attachView(_ view: LoginView?) {
        self.view = view
    }
    func login() {
        self.view?.didLogin(error: nil)
    }
    func validate(email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
    }
    func loginIn() {
        self.view?.enableSubmitButton(false)
        guard let login = username, !login.isEmpty else {
            self.view?.showAlert(with: "Error email", message: "Please enter an email address")
            self.view?.enableSubmitButton(true)
            return
            }
            guard validate(email: login) else {
            self.view?.showAlert(with: "Error", message: "Please ")
            self.view?.enableSubmitButton(true)
            return
            }
            guard let password = password, !password.isEmpty else {
            self.view?.showAlert(with: "Error", message: "Please enter an password")
            self.view?.enableSubmitButton(true)
            return
            }
        Network.shared.apollo.fetch(query: LoginQuery(login: login, password: password)) { [weak self] result in
            defer {
                self?.view?.enableSubmitButton(true)
            }
            switch result {
            case .success(let graphQLResult):
                if let token = graphQLResult.data?.login {
                    let keychain = KeychainSwift()
                    keychain.set(token, forKey: LoginViewPresenter.loginKeychainKey)
                    // self?.dismiss(animated: true)
                    // Segue loadHomeScreen()
                    print("Success")
                    print(token)
                }
                if let errors = graphQLResult.errors {
                    print("Errors from server: \(errors)")
                }
            case .failure(let error):
                print("Error: \(error)")
                self?.view?.showAlert(with: "Error", message: error.localizedDescription)
            }
        }
    }
}
