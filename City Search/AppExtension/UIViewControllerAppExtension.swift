//
//  UIViewControllerAppExtension.swift
//  City Search
//
//  Created by Kaung Htet Win on 16/5/2566 BE.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default))
            self.present(alert, animated: true)
        }
    }
}
