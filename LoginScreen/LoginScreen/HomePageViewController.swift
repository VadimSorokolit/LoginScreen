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
    
    // MARK: Events
    
    @objc func showAlertButtonTapped(withError error: String) {
        
        // create the alert
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: IBActions
    
    @IBAction private func onLogOutButtonDidTap(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            self.goToLogIn()
        } catch let signOutError as NSError {
            self.showAlertButtonTapped(withError: signOutError.localizedDescription)
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


    


