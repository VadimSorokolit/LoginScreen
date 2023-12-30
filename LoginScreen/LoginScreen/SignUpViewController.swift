//
//  SignUpViewController.swift
//  LoginScreen
//
//  Created by Vadim on 17.12.2023.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var signUpInfoLabel: UILabel!
    @IBOutlet weak var signUpUserAccountTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpInformationLabel: UILabel!
    @IBOutlet weak var signUpInfoLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpInfoLabelBottomConstraint: NSLayoutConstraint!
    
    // MARK - find the current and min Height of screenHeigh
    
    private let screenHeigh = UIScreen.main.bounds.height
    private let iPhone8PlusScreenHeigh = 736.0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLabels()
        self.setupTextFields()
        
        if self.screenHeigh < self.iPhone8PlusScreenHeigh {
            self.signUpInfoLabelTopConstraint.constant /= 2
            self.signUpInfoLabelBottomConstraint.constant /= 2
        }
    }
    
    // MARK: - Methods
    
    private func setupLabels() {
        if let text = signUpInformationLabel.text {
            let underlineAttriString = NSMutableAttributedString(string: text)
            let range1 = (text as NSString).range(of: "Log in")
            self.signUpInformationLabel.isUserInteractionEnabled = true
            self.signUpInformationLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        }
    }
    
    private func setupTextFields() {
        signUpUserAccountTextField.addPaddingToTextField()
        signUpPasswordTextField.addPaddingToTextField()
    }
    
    private func goToSignIn() {
        if let loginVC = self.navigationController?.viewControllers.first(where: { $0 is SignInViewController }) {
            self.navigationController?.setViewControllers([loginVC], animated: true)
        }  else {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController {
                loginVC.title = "Log In Screen"
                self.navigationController?.setViewControllers([loginVC], animated: true)
            }
        }
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
    }
    
    private func goToLogIn() {
        if let loginVC = self.navigationController?.viewControllers.first(where: { $0 is SignInViewController }) {
            self.navigationController?.setViewControllers([loginVC], animated: true)
        }  else {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController {
                loginVC.title = "Log In Screen"
                self.navigationController?.setViewControllers([loginVC], animated: true)
            }
        }
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
    }
    
    // MARK: - IBActions
    
    
    
    @IBAction func onSignUpButtonDidTap(_ sender: UIButton) {
        self.goToLogIn()
    }
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (self.signUpInformationLabel.text! as NSString).range(of: "Log in")
        
        if gesture.didTapAttributedTextInLabel(label: self.signUpInformationLabel, inRange: termsRange) {
            self.goToSignIn()
        }
    }
    
}




