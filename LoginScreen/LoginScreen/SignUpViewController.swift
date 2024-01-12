//
//  SignUpViewController.swift
//  LoginScreen
//
//  Created by Vadym Sorokolit on 17.12.2023.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var signUpInfoLabel: UILabel!
    @IBOutlet weak var signUpInformationLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpInfoLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextFieldTopConstraint: NSLayoutConstraint!
    
    // MARK Current and min Height of screenHeigh
    
    private let screenHeigh = UIScreen.main.bounds.height
    private let iPhone8PlusScreenHeigh = 736.0
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLabels()
        self.setupTextFields()
    }
    
    // MARK: Methods
    
    private func setupLabels() {
        self.signUpInformationLabel.isUserInteractionEnabled = true
        self.signUpInformationLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
        if self.screenHeigh < self.iPhone8PlusScreenHeigh {
            self.signUpInfoLabelTopConstraint.constant /= 2
           self.emailTextFieldTopConstraint.constant /= 2
        }
    }
    
    private func setupTextFields() {
        emailTF.addPaddingToTextField()
        passwordTF.addPaddingToTextField()
    }
    
    private func goToSignIn() {
        if let SignInVC = self.navigationController?.viewControllers.first(where: { $0 is LogInViewController }) {
            self.navigationController?.setViewControllers([SignInVC], animated: true)
        }  else {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            if let SignInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? LogInViewController {
                SignInVC.title = "Log In Screen"
                self.navigationController?.setViewControllers([SignInVC], animated: true)
            }
        }
    }
    
    private func goHomePage() {
        if let HomePageVC = self.navigationController?.viewControllers.first(where: { $0 is HomePageViewController }) {
            self.navigationController?.setViewControllers([HomePageVC], animated: true)
        }  else {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            if let loggedVC = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
                loggedVC.title = "Home Page Screen"
                self.navigationController?.setViewControllers([loggedVC], animated: true)
            }
        }
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
    }
    
    // MARK: IBActions
    
    @IBAction func onSignUpButtonDidTap(_ sender: UIButton) {
        self.goHomePage()
    }
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (self.signUpInformationLabel.text! as NSString).range(of: "Log in")
        
        if gesture.didTapAttributedTextInLabel(label: self.signUpInformationLabel, inRange: termsRange) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}




