//
//  NavigationController.swift
//
//  Created by Vadym Sorokolit on 30.12.2023.
//

import Foundation
import UIKit
import FirebaseAuth

class NavigationController: UINavigationController {
    
    // MARK: Objects
    
    private struct LocalConstants {
        static let isLoggedIn = "isLoggedIn"
        static let userName = "userName"
    }
    
    // MARK: Properties
    
    private let isLoggedIn = UserDefaults.standard.bool(forKey: LocalConstants.isLoggedIn)
    private let userName = UserDefaults.standard.string(forKey: LocalConstants.userName)
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLoggedIn {
            if let userName {
                if let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.homePageViewControllerId) as? HomePageViewController {
                    homePageVC.userName = userName
                    self.setViewControllers([homePageVC], animated: false)
                }
            }
        } else {
            if let logInVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.loginViewControllerId) as? LogInViewController {
                self.setViewControllers([logInVC],animated: false)
            }
        }
        
        // Auth_listener
        Auth.auth().addStateDidChangeListener({ (auth: Auth, user: User?) -> Void in
            if let user, let userName = user.email {
                UserDefaults.standard.setValue(true, forKey: LocalConstants.isLoggedIn)
                UserDefaults.standard.setValue(userName, forKey: LocalConstants.userName)
            } else {
                UserDefaults.standard.setValue(false, forKey: LocalConstants.isLoggedIn)
                UserDefaults.standard.setValue(nil, forKey: LocalConstants.userName)
            }
        })
    }
    
}
