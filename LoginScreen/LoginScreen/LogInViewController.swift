//
//  LogInViewController.swift
//  LoginScreen
//
//  Created by Vadim on 06.12.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var errorLabel: UILabel!
    @IBOutlet weak private var termsLabel: UILabel!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var logInButton: UIButton!
    @IBOutlet weak private var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak private var titleLabelBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    private let screenHeigh: CGFloat = UIScreen.main.bounds.height
    private let iPhone8PlusScreenHeigh: CGFloat = 736.0
    private var isCorrectEmail = false
    private var isCorrectPassword = false
    private var keyboardDismissTapGesture: UITapGestureRecognizer?
  
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
        
        self.registerForKeyboardNotifications()
        self.resetForm()
        self.setupLabels()
        self.setupTextFields()
        self.view.addGestureRecognizer(tap)
        
        /*
         
         userAccountTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: userAccountTextField.frame.height))
         userAccountTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: userAccountTextField.frame.height))
         userAccountTextField.leftViewMode = .always
         userAccountTextField.rightViewMode = .always
         
         */
    }
    
    // MARK: - Methods
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func resetForm() {
        self.logInButton.isEnabled = false
        self.logInButton.alpha = 0.5
        self.errorLabel.text = ""
    }
    
    private func checkValidEmail(_ value: String) -> String? {
        if value.isEmpty {
            return nil
        }
        if value.contains(" ") {
            return "Email dosn't must contain spaces"
        }
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value) {
            return "Invalid email address"
        }
        return nil
    }

    private func checkValidPassword(_ value: String) -> String? {
        if value.isEmpty {
            return nil
        }
        if value.contains(" ") {
            return "Password dosn't must contain spaces"
        }
        if value.count > 0, value.count <= 8  {
            return "Password must be at least 8 characters"
        }
        if containsDigit(value) {
            return "Password must contain at least 1 digit"
        }
        if containsLowerCase(value) {
            return "Password must contain at least 1 lowerCase character"
        }
        if containsUpperCase(value) {
            return "Password must contain at least 1 upperCase character"
        }
        return nil
    }

    private func containsDigit(_ value: String) -> Bool {
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func containsLowerCase(_ value: String) -> Bool {
        let reqularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func containsUpperCase(_ value: String) -> Bool {
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func checkValidForm() {
        if self.emailTextField.hasText, self.isCorrectEmail, self.passwordTextField.hasText, self.isCorrectPassword {
            self.logInButton.isEnabled = true
            self.logInButton.alpha = 1
        } else {
            self.logInButton.isEnabled = false
            self.logInButton.alpha = 0.5
        }
    }
    
    private func setupLabels() {
        self.termsLabel.isUserInteractionEnabled = true
        self.termsLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(self.tapLabel(gesture:))))
        
        if self.screenHeigh < self.iPhone8PlusScreenHeigh {
            self.titleLabelTopConstraint.constant /= 2
            self.titleLabelBottomConstraint.constant /= 2
        }
    }
    
    private func setupTextFields() {
        self.emailTextField.addPaddingToTextField()
        self.passwordTextField.addPaddingToTextField()
//   UITextFieldDelegate   self.emailTextField.delegate = self
//                         self.passwordTextField.delegate = self
        
    }
    
    private func goToSignUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            signUpVC.title = "Sign Up Screen"
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
    
    private func goToHomePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let homePageVC = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
            homePageVC.title = "Home Page Screen"
            self.navigationController?.setViewControllers([homePageVC], animated: true)
        }
    }
    
//  UITextFieldDelegate   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//                              textField.resignFirstResponder()
//                              self.errorLabel.isHidden = true
//                              return true
//                        }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        let keyboardHeigh = keyboardFrame.height
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= (keyboardHeigh / 2)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
        self.errorLabel.isHidden = true
    }

    
    @objc private func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (self.termsLabel.text! as NSString).range(of: "Sign up")
        if gesture.didTapAttributedTextInLabel(label: self.termsLabel, inRange: termsRange) {
            self.goToSignUp()
        }
    }
    
    // MARK: - IBActions
    
    @IBAction private func emailPrimaryActionTriggered(_ textField: UITextField) {
        self.dismissKeyboard()
    }
    
    @IBAction private func passwordPrimaryActionTriggered(_ textField: UITextField) {
        self.dismissKeyboard()
    }
    
    @IBAction private func emailEditingDidBegin(_ textField: UITextField) {
        if let email = textField.text {
            if let errorMessage = self.checkValidEmail(email) {
                self.errorLabel.text = errorMessage
                self.errorLabel.isHidden = false
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.red.cgColor
                self.isCorrectEmail = false
            } else {
                self.isCorrectEmail = true
                self.errorLabel.isHidden = true
                textField.layer.borderWidth = 0
                textField.layer.borderColor = UIColor.clear.cgColor
            }
        }
        self.checkValidForm()
    }
    
    @IBAction private func passwordEditingDidBegin(_ textField: UITextField) {
        if let password = textField.text {
            if let errorMessage = self.checkValidPassword(password) {
                self.errorLabel.text = errorMessage
                self.errorLabel.isHidden = false
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.red.cgColor
                self.isCorrectPassword = false
            } else {
                self.isCorrectPassword = true
                self.errorLabel.isHidden = true
                textField.layer.borderWidth = 0
                textField.layer.borderColor = UIColor.clear.cgColor
            }
        }
        self.checkValidForm()
    }
    
    @IBAction func emailEditingChanged(_ textField: UITextField) {
        if let email = textField.text {
            if let errorMessage = self.checkValidEmail(email) {
                self.errorLabel.text = errorMessage
                self.errorLabel.isHidden = false
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.red.cgColor
                self.isCorrectEmail = false
            } else {
                self.isCorrectEmail = true
                self.errorLabel.isHidden = true
                textField.layer.borderWidth = 0
                textField.layer.borderColor = UIColor.clear.cgColor
            }
        }
        self.checkValidForm()
    }
    
    @IBAction private func passwordEditingChanged(_ textField: UITextField) {
        if let password = textField.text {
            if let errorMessage = self.checkValidPassword(password) {
                self.errorLabel.text = errorMessage
                self.errorLabel.isHidden = false
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.red.cgColor
                self.isCorrectPassword = false
            } else {
                self.isCorrectPassword = true
                self.errorLabel.isHidden = true
                textField.layer.borderWidth = 0
                textField.layer.borderColor = UIColor.clear.cgColor
            }
        }
        self.checkValidForm()
    }
    
    @IBAction private func onLogInButtonDidTap(_ sender: UIButton) {
        self.goToHomePage()
    }
    
}

// Add padding to UITextField

extension UITextField {
    
    func addPaddingToTextField() {
        let borderWidth  = 15
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: borderWidth, height: 0))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}


