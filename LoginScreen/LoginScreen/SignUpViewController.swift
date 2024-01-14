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
    @IBOutlet weak private var errorLabelTopConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    
    private let screenHeigh = UIScreen.main.bounds.height
    private var isCorrectEmail = false
    private var isCorrectPassword = false
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resetForm()
        self.setupLabels()
        self.setupTextFields()
        self.registerForKeyboardNotifications()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: Methods
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func resetForm() {
        self.signUpButton.isEnabled = false
        self.signUpButton.alpha = 0.5
        self.errorLabel.text = ""
    }
    
    private func checkValidEmail(_ value: String) -> String? {
        if value.isEmpty {
            return nil
        }
        if value.contains(" ") {
            return GlobalConstans.errorMessageEmailDoesntMustContainSpaces
        }
        let reqularExpression = GlobalConstans.emailReqularExpression
        let predicate = NSPredicate(format: GlobalConstans.predicateFormat, reqularExpression)
        if !predicate.evaluate(with: value) {
            return GlobalConstans.errorMessageInvalidEmailAddress
        }
        return nil
    }
    
    private func checkValidPassword(_ value: String) -> String? {
        if value.isEmpty {
            return nil
        }
        if value.contains(" ") {
            return GlobalConstans.errorMessagePasswordDoesntMustContainSpaces
        }
        if value.count <= 8 {
            return GlobalConstans.errorMessagePasswordMustBeAtLeast8Characters
        }
        if self.containsDigit(value) {
            return GlobalConstans.errorMessagePasswordMustContainAtLeast1Digit
        }
        if self.containsLowerCase(value) {
            return GlobalConstans.errorMessagePasswordMustContainAtLeast1LowerCaseCharacter
        }
        if self.containsUpperCase(value) {
            return GlobalConstans.errorMessagePasswordMustContainAtLeast1UpperCaseCharacter
        }
        return nil
    }
    
    private func containsDigit(_ value: String) -> Bool {
        let reqularExpression = GlobalConstans.containsDigitReqularExpression
        let predicate = NSPredicate(format: GlobalConstans.predicateFormat, reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func containsLowerCase(_ value: String) -> Bool {
        let reqularExpression = GlobalConstans.containsLowerCaseReqularExpression
        let predicate = NSPredicate(format: GlobalConstans.predicateFormat, reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func containsUpperCase(_ value: String) -> Bool {
        let reqularExpression = GlobalConstans.containsUpperCaseReqularExpression
        let predicate = NSPredicate(format: GlobalConstans.predicateFormat, reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func checkValidForm() {
        if self.emailTextField.hasText, self.isCorrectEmail, self.passwordTextField.hasText, self.isCorrectPassword {
            self.signUpButton.isEnabled = true
            self.signUpButton.alpha = 1.0
        } else {
            self.signUpButton.isEnabled = false
            self.signUpButton.alpha = 0.5
        }
    }
    
    private func makeCheckingEmail(_ textField: UITextField) {
        if let email = textField.text {
            if let errorMessage = self.checkValidEmail(email) {
                self.errorLabel.text = errorMessage
                self.errorLabel.isHidden = false
                textField.layer.borderWidth = 1.0
                textField.layer.borderColor = UIColor.red.cgColor
                self.isCorrectEmail = false
            } else {
                self.isCorrectEmail = true
                self.errorLabel.isHidden = true
                textField.layer.borderWidth = 0.0
                textField.layer.borderColor = UIColor.clear.cgColor
            }
        }
        self.checkValidForm()
    }
    
    private func makeCheckingPassword(_ textField: UITextField) {
        if let password = textField.text {
            if let errorMessage = self.checkValidPassword(password) {
                self.errorLabel.text = errorMessage
                self.errorLabel.isHidden = false
                textField.layer.borderWidth = 1.0
                textField.layer.borderColor = UIColor.red.cgColor
                self.isCorrectPassword = false
            } else {
                self.isCorrectPassword = true
                self.errorLabel.isHidden = true
                textField.layer.borderWidth = 0.0
                textField.layer.borderColor = UIColor.clear.cgColor
            }
        }
        self.checkValidForm()
    }
    
    private func setupLabels() {
        if self.screenHeigh < GlobalConstans.iPhone8PlusScreenHeigh {
            self.titleLabelTopConstraint.constant /= 2
            self.errorLabelTopConstraint.constant /= 2
        }
        self.termsLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(onTermsLabelDidTap))
        self.termsLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupTextFields() {
        self.emailTextField.addPaddingToTextField()
        self.passwordTextField.addPaddingToTextField()
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
    
    @IBAction func emailEditingChanged(_ textField: UITextField) {
        self.makeCheckingEmail(textField)
    }
    
    @IBAction func passwordEditingChanged(_ textField: UITextField) {
        self.makeCheckingPassword(textField)
    }
    
    @IBAction func emailDidBegin(_ textField: UITextField) {
        self.makeCheckingEmail(textField)
    }
    
    @IBAction func passwordDidBegin(_ textField: UITextField) {
        self.makeCheckingPassword(textField)
    }
    
    @IBAction func emailPrimaryActionTriggered(_ textField: UITextField) {
        self.dismissKeyboard()
    }
    
    @IBAction func passwordPrimaryActionTriggered(_ textField: UITextField) {
        self.dismissKeyboard()
    }
    
    @IBAction private func onSignUpButtonDidTap(_ sender: UIButton) {
        self.goHomePage()
    }
    
    // MARK: Events
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        let keyboardHeigh = keyboardFrame.height
        if self.view.frame.origin.y == 0.0 {
            self.view.frame.origin.y -= (keyboardHeigh / 2)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0.0 {
            self.view.frame.origin.y = 0.0
        }
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
        self.errorLabel.isHidden = true
    }
    
    @objc private func onTermsLabelDidTap(gesture: UITapGestureRecognizer) {
        let termsRange = (self.termsLabel.text! as NSString).range(of: LocalConstans.logInKeyword)
        if gesture.didTapAttributedTextInLabel(label: self.termsLabel, inRange: termsRange) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}




