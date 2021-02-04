//
//  Alert+UiViewController.swift
//  OddoLog
//
//  Created by Petr on 01.02.2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentAlert(withTitle title:String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}
