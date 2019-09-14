//
//  UIViewController+Extension.swift
//  Kodluyoruz-NoteAppRx
//
//  Created by XCODE on 14.09.2019.
//  Copyright © 2019 XCODE. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
