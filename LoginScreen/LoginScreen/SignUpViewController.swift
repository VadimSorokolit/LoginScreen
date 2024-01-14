//
//  SignUpViewController.swift
//
//  Created by Vadym Sorokolit on 17.12.2023.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: Objects
    
    private struct LocalConstans {
        static let logInKeyword = "Log in"
    }
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var errorLabel: UILabel!
    @IBOutlet weak private var termsLabel: UILabel!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var signUpButton: UIButton!
    @IBOutlet weak private var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var errorLabelTopConstraint: NSLayoutConstraint!
    // MARK: Properties
    
    private let screenHeigh = UIScreen.main.bounds.height
    private var isCorrectEmail = false
    private var isCorrectPassword = false
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLabels()
        self.setupTextFields()
    }
    
    // MARK: Methods
    
    private func setupLabels() {
        self.termsLabel.isUserInteractionEnabled = true
        self.termsLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
        if self.screenHeigh < GlobalConstans.iPhone8PlusScreenHeigh {
            self.titleLabelTopConstraint.constant /= 2
//           self.errorLabelTopConstraint.constant /= 2
        }
    }
    
    private func setupTextFields() {
        emailTextField.addPaddingToTextField()
        passwordTextField.addPaddingToTextField()
    }
    
    private func goToSignIn() {
        if let logInVC = self.navigationController?.viewControllers.first(where: { $0 is LogInViewController }) {
            self.navigationController?.setViewControllers([logInVC], animated: true)
        }
        if let logInVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstans.loginViewControllerId) as? LogInViewController {
            self.navigationController?.setViewControllers([logInVC], animated: true)
        }
    }
    
    private func goHomePage() {
        if let homePageVC = self.navigationController?.viewControllers.first(where: { $0 is HomePageViewController }) {
            self.navigationController?.setViewControllers([homePageVC], animated: true)
        }
        if let loggedVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstans.homePageViewControllerId) as? HomePageViewController {
                self.navigationController?.setViewControllers([loggedVC], animated: true)
            }
        UserDefaults.standard.setValue(true, forKey: GlobalConstans.isLoggedInKey)
    }
    
    // MARK: IBActions
    
    @IBAction private func onSignUpButtonDidTap(_ sender: UIButton) {
        self.goHomePage()
    }

    @IBAction private func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (self.termsLabel.text! as NSString).range(of: LocalConstans.logInKeyword)
        
        if gesture.didTapAttributedTextInLabel(label: self.termsLabel, inRange: termsRange) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}




