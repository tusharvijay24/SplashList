//
//  Alerts.swift
//  SplashList
//
//  Created by Tushar on 13/04/24.
//

import Foundation
import UIKit

func showAlert(on viewController: UIViewController, title: String?, message: String?, cancel: String, confirm: String, action: @escaping () -> Void) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: cancel, style: .cancel, handler: nil)
    let confirmAction = UIAlertAction(title: confirm, style: .default) { (_) in
        action()
    }
    alertController.addAction(cancelAction)
    alertController.addAction(confirmAction)
    viewController.present(alertController, animated: true, completion: nil)
}

func showAlertWithOutCancel(on viewController: UIViewController, title: String, message: String, buttonTitle: String, completion: (() -> Void)?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let action = UIAlertAction(title: buttonTitle, style: .default) { (_) in
        completion?()
    }
    alertController.addAction(action)
    viewController.present(alertController, animated: true, completion: nil)
}

func showAlertWithBothAction(
    on viewController: UIViewController, title: String?, message: String?, cancel: String, cancelAction: @escaping () -> Void, confirm: String, confirmAction: @escaping () -> Void
) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: cancel, style: .default) { (_) in
        cancelAction()
    }
    let confirmAction = UIAlertAction(title: confirm, style: .default) { (_) in
        confirmAction()
    }
    alertController.addAction(cancelAction)
    alertController.addAction(confirmAction)
    viewController.present(alertController, animated: true, completion: nil)
}
