//
//  NavigationController.swift
//
//  Created by Vadim on 30.12.2023.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: GlobalConstans.mainStoryboardNameKey, bundle: .main)
        let isLoggedIn = UserDefaults.standard.bool(forKey: GlobalConstans.isLoggedInKey)
        
        if isLoggedIn {
            if let homePageVC = storyboard.instantiateViewController(withIdentifier: GlobalConstans.homePageViewControllerId) as? HomePageViewController {
                self.setViewControllers([homePageVC], animated: true)
            }
        } else {
            if let logInVC = storyboard.instantiateViewController(withIdentifier: GlobalConstans.loginViewControllerId) as? LogInViewController {
                self.setViewControllers([logInVC], animated: true)
            }
        }
    }
}
