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
    
    func showAlert(error: String, in viewContoller: UIViewController, completion: ((UIAlertAction) -> (Void))? = nil) {
        let alert = UIAlertController(title: LocalConstants.errorTitle, message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: LocalConstants.okActionTitle, style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        viewContoller.present(alert, animated: true, completion: nil)
    }
    
}
