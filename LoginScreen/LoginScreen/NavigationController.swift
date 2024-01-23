//
//  NavigationController.swift
//
//  Created by Vadym Sorokolit on 30.12.2023.
//

import Foundation
import UIKit
import FirebaseAuth

class NavigationController: UINavigationController {
    
    // MARK: Properties
    
    private var handle: AuthStateDidChangeListenerHandle?
    private let isLoggedIn = UserDefaults.standard.bool(forKey: GlobalConstants.isLoggedInKey)
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Start auth_listener
        self.handle = Auth.auth().addStateDidChangeListener( { (auth: Auth, user: User?) -> Void in
            if user == nil {
                UserDefaults.standard.setValue(false, forKey: GlobalConstants.isLoggedInKey)
                if let logInVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.loginViewControllerId) as? LogInViewController {
                    self.setViewControllers([logInVC], animated: false)
                }
            } else {
                UserDefaults.standard.setValue(true, forKey: GlobalConstants.isLoggedInKey)
                if let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.homePageViewControllerId) as? HomePageViewController {
                    self.setViewControllers([homePageVC], animated: false)
                }
            }
        })
    }
}
