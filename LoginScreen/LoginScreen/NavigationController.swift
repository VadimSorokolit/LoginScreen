//
//  NavigationController.swift
//
//  Created by Vadym Sorokolit on 30.12.2023.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth

class NavigationController: UINavigationController {
    
    // MARK: Properties
    
    var handle: AuthStateDidChangeListenerHandle?
    
    private let isLoggedIn = UserDefaults.standard.bool(forKey: GlobalConstants.isLoggedInKey)
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLoggedIn {
            if let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.homePageViewControllerId) as? HomePageViewController {
                self.setViewControllers([homePageVC], animated: true)
            }
        } else if let logInVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.loginViewControllerId) as? LogInViewController {
                self.setViewControllers([logInVC], animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle =  FirebaseAuth.Auth.auth().addStateDidChangeListener { (auth: Auth, user: User?) -> Void in
            if user != nil {
                print(user?.email)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
}
