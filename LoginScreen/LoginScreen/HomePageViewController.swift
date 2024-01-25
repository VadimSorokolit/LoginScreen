//
//  HomePageViewController.swift
//
//  Created by Vadym Sorokolit on 17.12.2023.
//

import Foundation
import UIKit
import FirebaseAuth

class HomePageViewController: UIViewController {
    
    // MARK: Objects
    
    private struct LocalConstants {
        static let errorMessage = "Error signing out: "
    }
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var loggedInLabel: UILabel!
    @IBOutlet weak private var userNameLabel: UILabel!
    
    // MARK: Private. Properties
    
    var userName = ""
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLabels()
    }
    
    // MARK: Methods
    
    private func setupLabels() {
        self.loggedInLabel.contentMode = .bottom
        self.userNameLabel.contentMode = .top
        self.userNameLabel.text = userName
    }
    
    private func goToLogIn() {
        if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.loginViewControllerId) as? LogInViewController {
            self.navigationController?.setViewControllers([loginVC], animated: false)
        }
    }

    @IBAction private func onLogOutButtonDidTap(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.goToLogIn()
        } catch let signOutError as NSError {
            print(String(format: "%@", LocalConstants.errorMessage, signOutError))
        }
    }
}

class VerticalAlignedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        var newRect = rect
        let height = self.sizeThatFits(rect.size).height
        switch self.contentMode {
            case .top:
                newRect.size.height = height
            case .bottom:
                newRect.origin.y += (rect.size.height - height)
                newRect.size.height = height
            default:
                break
        }
        super.drawText(in: newRect)
    }
}


    


