//
//  LoginPresenter.swift
//  OddoLog
//
//  Created by Petr on 03.02.2021.
//

protocol LoginPresenter: class {

   //  var router: RouterInput { get set }
    func loginIn()
    func attachView(_ view: LoginView?)
    func setUserName(username: String?)
    func setPassword(password: String?)
    func validate(email: String) -> Bool
}
