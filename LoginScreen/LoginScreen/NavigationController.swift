//
//  NavigationController.swift
//
//  Created by Vadym Sorokolit on 30.12.2023.
//

import Foundation
import UIKit
import FirebaseAuth

class NavigationController: UINavigationController {
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Start auth_listener
        Auth.auth().addStateDidChangeListener({ (auth: Auth, user: User?) -> Void in
            if let user, let userName = user.email {
                if let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.homePageViewControllerId) as? HomePageViewController {
                    homePageVC.userName = userName
                    self.setViewControllers([homePageVC], animated: false)
                }
            } else {
                if let logInVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.loginViewControllerId) as? LogInViewController {
                    self.setViewControllers([logInVC],animated: false)
                }
            }
        })
    }
    
}
