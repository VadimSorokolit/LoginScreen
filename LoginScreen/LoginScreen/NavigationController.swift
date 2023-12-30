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

        if !isLoggedIn {
            if let loggedInVC = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
                loggedInVC.title = "Logged In Screen"
                self.setViewControllers([loggedInVC], animated: true)
            }
        } else {
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController {
                loginVC.title = "Log In Screen"
                self.setViewControllers([loginVC], animated: true)
            }
        }
    }
}
