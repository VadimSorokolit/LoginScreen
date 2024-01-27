//
//  HomePageViewController.swift
//
//  Created by Vadym Sorokolit on 17.12.2023.
//

import Foundation
import UIKit
import FirebaseAuth

class HomePageViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak private var loggedInLabel: UILabel!
    @IBOutlet weak private var userNameLabel: UILabel!
    
    // MARK: Properties
    
    private let alertsManager = AlertsManager()
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
        self.userNameLabel.text = self.userName
    }
    
    private func goToLogIn() {
        if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.loginViewControllerId) as? LogInViewController {
            self.navigationController?.setViewControllers([loginVC], animated: false)
        }
    }
    
    // MARK: IBActions
    
    @IBAction private func onLogOutButtonDidTap(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            self.goToLogIn()
        } catch let signOutError {
            self.alertsManager.showAlert(error: signOutError.localizedDescription, in: self, completion: nil)
        }
    }
}




    


