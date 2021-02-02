//
//  LoginPresenter.swift
//  OddoLog
//
//  Created by Petr on 31.01.2021.
//

import Foundation
import Apollo
import KeychainSwift

class LoginPresenter: LoginViewProtocol {

    
    
    var router: RouterInput
    var view: LoginViewController
    
     let loginTetx = "Plase check log"
    let paswordText = "Password"
    
    
    static let loginKeychainKey = "login"
    
    
    required init(router: RouterInput, view: LoginViewController) {
        self.router = router
        self.view = view
    }
    func loginIn() {
        Network.shared.apollo.fetch(query: LoginQuery(login: loginTetx, password: paswordText)) { [weak self] result in
                 defer {
                    self?.enableSubmitButton(true)
                 }

                 switch result {
                    case .success(let graphQLResult):
                        if let token = graphQLResult.data?.login {
                            let keychain = KeychainSwift()
                            keychain.set(token, forKey: LoginPresenter.loginKeychainKey)
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
            

private func enableSubmitButton(_ isEnabled: Bool) {
    self.view.logInButton.isEnabled = isEnabled
       if isEnabled {
        self.view.logInButton.setTitle("Submit", for: .normal)
       } else {
        self.view.logInButton.setTitle("Submitting...", for: .normal)
       }
   }
}
protocol LoginViewProtocol: class {
    
    var router: RouterInput { get }
    
    func loginIn()
        
    }
    

        
