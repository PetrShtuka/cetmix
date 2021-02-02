//
//  ModuleOutputProtocol.swift
//  OddoLog
//
//  Created by Petr on 31.01.2021.
//

import Foundation


protocol Presa {
    
    init(view: LoginViewProtocol)
    var network: Network { get }
}
