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
            if let HomePageVC = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
                HomePageVC.title = "Home Page Screen"
                self.setViewControllers([HomePageVC], animated: true)
            }
        } else {
            if let SignInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? LogInViewController {
                SignInVC.title = "Log In Screen"
                self.setViewControllers([SignInVC], animated: true)
            }
        }
    }
}
