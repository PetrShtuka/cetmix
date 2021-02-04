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
    
    func setUserName(username: String?) {
        self.username = username
    }
    
    func setPassword(password: String?) {
        self.password = password
    }
    
    static let loginKeychainKey = "login"
    
    func attachView(_ view: LoginView?) {
        self.view = view
    }
    
    
    func loginIn() {
        
        guard let login = username else { return }
        guard let password = password else { return }
        
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
            }
        }
    }
    
}
