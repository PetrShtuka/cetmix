//
//  AlertRouter.swift
//  OddoLog
//
//  Created by Petr on 01.02.2021.
//

import UIKit

protocol RouterInput {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

extension RouterInput {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
}
