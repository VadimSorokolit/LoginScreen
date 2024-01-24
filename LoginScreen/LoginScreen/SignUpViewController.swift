//
//  SignUpViewController.swift
//
//  Created by Vadym Sorokolit on 17.12.2023.
//

import Foundation
import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    // MARK: Objects
    
    private struct LocalConstants {
        static let logInKeyword = "Log in"
        static let errorMessage = "It's user is in Firebase, please try write other login and password"
    }
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var termsLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var errorLabelTopConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    private var isCorrectEmail: Bool = false
    private var isCorrectPassword: Bool = false
    private var isLoggedUser: Bool = false
    
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
            return GlobalConstants.errorMessageEmailDoesntMustContainSpaces
        }
        let reqularExpression = GlobalConstants.emailReqularExpression
        let predicate = NSPredicate(format: GlobalConstants.predicateFormat, reqularExpression)
        if !predicate.evaluate(with: value) {
            return GlobalConstants.errorMessageInvalidEmailAddress
        }
        return nil
    }
    
    private func checkValidPassword(_ value: String) -> String? {
        if value.isEmpty {
            return nil
        }
        if value.contains(" ") {
            return GlobalConstants.errorMessagePasswordDoesntMustContainSpaces
        }
        if value.count <= 8 {
            return GlobalConstants.errorMessagePasswordMustBeAtLeast8Characters
        }
        if self.containsDigit(value) {
            return GlobalConstants.errorMessagePasswordMustContainAtLeast1Digit
        }
        if self.containsLowerCase(value) {
            return GlobalConstants.errorMessagePasswordMustContainAtLeast1LowerCaseCharacter
        }
        if self.containsUpperCase(value) {
            return GlobalConstants.errorMessagePasswordMustContainAtLeast1UpperCaseCharacter
        }
        return nil
    }
    
    private func containsDigit(_ value: String) -> Bool {
        let reqularExpression = GlobalConstants.containsDigitReqularExpression
        let predicate = NSPredicate(format: GlobalConstants.predicateFormat, reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func containsLowerCase(_ value: String) -> Bool {
        let reqularExpression = GlobalConstants.containsLowerCaseReqularExpression
        let predicate = NSPredicate(format: GlobalConstants.predicateFormat, reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func containsUpperCase(_ value: String) -> Bool {
        let reqularExpression = GlobalConstants.containsUpperCaseReqularExpression
        let predicate = NSPredicate(format: GlobalConstants.predicateFormat, reqularExpression)
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
        if self.screenHeight < GlobalConstants.iPhone8PlusScreenHeight {
            self.titleLabelTopConstraint.constant /= 2
            self.errorLabelTopConstraint.constant /= 2
        }
        self.termsLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(self.onTermsLabelDidTap))
        self.termsLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupTextFields() {
        self.emailTextField.addPaddingToTextField()
        self.passwordTextField.addPaddingToTextField()
        self.emailTextField.keyboardType = .asciiCapable
        self.passwordTextField.keyboardType = .asciiCapable
    }
    
    private func goToHomePage() {
        if let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.homePageViewControllerId) as? HomePageViewController {
            self.navigationController?.setViewControllers([homePageVC], animated: true)
        }
    }
    
    // MARK: IBActions
    
    @IBAction private func emailEditingChanged(_ textField: UITextField) {
        self.makeCheckingEmail(textField)
    }
    
    @IBAction private func passwordEditingChanged(_ textField: UITextField) {
        self.makeCheckingPassword(textField)
    }
    
    @IBAction private func emailDidBegin(_ textField: UITextField) {
        self.makeCheckingEmail(textField)
    }
    
    @IBAction private func passwordDidBegin(_ textField: UITextField) {
        self.makeCheckingPassword(textField)
    }
    
    @IBAction private func emailPrimaryActionTriggered(_ textField: UITextField) {
        self.dismissKeyboard()
    }
    
    @IBAction private func passwordPrimaryActionTriggered(_ textField: UITextField) {
        self.dismissKeyboard()
    }
    
    @IBAction private func onSignUpButtonDidTap(_ sender: UIButton) {
        if let email = self.emailTextField.text,
           let password = self.passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: { ( authResult: AuthDataResult?, error: Error?) -> Void in
                if let error = error {
                    print(error)
                    return
                }
                if (authResult?.user) != nil {
                    self.goToHomePage()
                } else {
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = LocalConstants.errorMessage
                    return
                    
                }
            })
        }
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
        let termsRange = (self.termsLabel.text! as NSString).range(of: LocalConstants.logInKeyword)
        if gesture.didTapAttributedTextInLabel(label: self.termsLabel, inRange: termsRange) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}




