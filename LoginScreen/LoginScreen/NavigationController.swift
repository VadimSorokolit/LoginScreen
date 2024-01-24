//
//  NavigationController.swift
//
//  Created by Vadym Sorokolit on 30.12.2023.
//

import Foundation
import UIKit
import FirebaseAuth
import ProgressHUD

class NavigationController: UINavigationController {
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Start auth_listener
        Auth.auth().addStateDidChangeListener( { (auth: Auth, user: User?) -> Void in
            if let user = user {
                if let userName = user.email {
                    GlobalConstants.userName = userName
                }
                self.progressHudWillShow()
                if let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.homePageViewControllerId) as? HomePageViewController {
                    self.setViewControllers([homePageVC], animated: false)
                }
            } else {
                self.progressHudWillShow()
                if let logInVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.loginViewControllerId) as? LogInViewController {
                    self.setViewControllers([logInVC], animated: false)
                }
            }
        })
    }
    
    // MARK: Methods
    
    private func progressHudWillShow() {
        ProgressHUD.succeed("Please wait...", delay: 1.5)
        ProgressHUD.mediaSize = 300
        ProgressHUD.marginSize = 300
        ProgressHUD.colorAnimation = .systemBlue
    }
}
