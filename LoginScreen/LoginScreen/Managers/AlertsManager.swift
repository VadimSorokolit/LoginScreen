//
//  AlertsManager.swift
//
//  Created by Vadym Sorokolit on 27.01.2024.
//

import Foundation
import UIKit

class AlertsManager {
    
    // MARK: Objects
    
    private struct LocalConstants {
        static let errorTitle = "Error"
        static let okActionTitle = "Ok"
    }
    
    // MARK: Methods
    
    func showAlert(title: String, message: String, in viewContoller: UIViewController, okCompletion: ((UIAlertAction) -> (Void))?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: LocalConstants.okActionTitle, style: UIAlertAction.Style.default, handler: okCompletion)
        alert.addAction(okAction)
        viewContoller.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(message: String, in viewController: UIViewController) {
        self.showAlert(title: LocalConstants.errorTitle, message: message, in: viewController, okCompletion: nil)
    }
    
}
