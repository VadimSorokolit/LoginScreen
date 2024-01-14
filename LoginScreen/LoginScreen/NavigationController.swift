//
//  NavigationController.swift
//
//  Created by Vadym Sorokolit on 30.12.2023.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: GlobalConstants.isLoggedInKey)
        
        if isLoggedIn {
            if let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.homePageViewControllerId) as? HomePageViewController {
                self.setViewControllers([homePageVC], animated: true)
            }
        }
        if let logInVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.loginViewControllerId) as? LogInViewController {
                self.setViewControllers([logInVC], animated: true)
        }
    }
}
