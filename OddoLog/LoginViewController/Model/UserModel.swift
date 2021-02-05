//
//  userModel.swift
//  OddoLog
//
//  Created by Petr on 03.02.2021.
//

import Foundation

class UserModel {

    var login: String?
    var password: String?
    var token: String

    init(token: String) {
        self.token = token
    }

}
