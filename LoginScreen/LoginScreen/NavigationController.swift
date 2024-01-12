//
//  NavigationController.swift
//  LoginScreen
//
//  Created by Vadim on 30.12.2023.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        if isLoggedIn {
            if let homePageVC = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
                self.setViewControllers([homePageVC], animated: true)
            }
        } else {
            if let SignInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? LogInViewController {
                self.setViewControllers([SignInVC], animated: true)
            }
        }
    }
}
