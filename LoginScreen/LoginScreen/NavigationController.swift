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
                if let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.homePageViewControllerId) as? HomePageViewController {
                    self.progressHudWillShow()
                    self.setViewControllers([homePageVC], animated: false)
                }
            } else {
                if let logInVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.loginViewControllerId) as? LogInViewController {
                    self.progressHudWillShow()
                    self.setViewControllers([logInVC],animated: false)
                }
            }
        })
    }
    
    // MARK: Methods
    
    private func progressHudWillShow() {
        ProgressHUD.succeed("Please wait...", delay: 3)
        ProgressHUD.mediaSize = 400
        ProgressHUD.marginSize = 400
        ProgressHUD.colorAnimation = .systemBlue
    }
}
