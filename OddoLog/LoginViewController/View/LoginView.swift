//
//  LoginView.swift
//  OddoLog
//
//  Created by Petr on 03.02.2021.
//

protocol LoginView: class {

    func showAlert(with title: String?, message: String?)
    func enableSubmitButton(_ isEnabled: Bool)
    func didLogin(error: Error?)
}
