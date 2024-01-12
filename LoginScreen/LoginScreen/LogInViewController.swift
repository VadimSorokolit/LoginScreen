//
//  LogInViewController.swift
//
//  Created by Vadym Sorokolit on 06.12.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    private struct LocalConstans {
        static let signUpViewController = "SignUpViewController"
        static let signUp = "Sign up"
    }

    // MARK: IBOutlets
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var errorLabel: UILabel!
    @IBOutlet weak private var termsLabel: UILabel!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var logInButton: UIButton!
    @IBOutlet weak private var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak private var emailTextFieldTopConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    
    private let screenHeigh: CGFloat = UIScreen.main.bounds.height
    private var isCorrectEmail = false
    private var isCorrectPassword = false
   
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.setValue(false, forKey: GlobalConstans.isLoggedIn)
        
        self.registerForKeyboardNotifications()
        self.resetForm()
        self.setupLabels()
        self.setupTextFields()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: Methods
    
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
            self.logInButton.isEnabled = true
            self.logInButton.alpha = 1.0
        } else {
            self.logInButton.isEnabled = false
            self.logInButton.alpha = 0.5
        }
    }
    
    private func setupLabels() {
        if self.screenHeigh < GlobalConstans.iPhone8PlusScreenHeigh {
            self.titleLabelTopConstraint.constant /= 2
            self.emailTextFieldTopConstraint.constant /= 2
        }
        self.termsLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(self.onTermsLabelDidTap))
        self.termsLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupTextFields() {
        self.emailTextField.addPaddingToTextField()
        self.passwordTextField.addPaddingToTextField()
    }
    
    private func goToSignUp() {
        if let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: LocalConstans.signUpViewController) as? SignUpViewController {
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
    
    private func goToHomePage() {
        if let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstans.homePageViewController) as? HomePageViewController {
            self.navigationController?.setViewControllers([homePageVC], animated: true)
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        let keyboardHeigh = keyboardFrame.height
        if self.view.frame.origin.y == 0.0 {
            self.view.frame.origin.y -= (keyboardHeigh / 2)
        }
    }
    
    // MARK: Events
    
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
        let termsRange = (self.termsLabel.text! as NSString).range(of: LocalConstans.signUp)
        if gesture.didTapAttributedTextInLabel(label: self.termsLabel, inRange: termsRange) {
            self.goToSignUp()
        }
    }
    
    // MARK: IBActions
    
    // 'Return' button tap
    @IBAction private func emailPrimaryActionTriggered(_ textField: UITextField) {
        self.dismissKeyboard()
    }
    
    // 'Return' button tap
    @IBAction private func passwordPrimaryActionTriggered(_ textField: UITextField) {
        self.dismissKeyboard()
    }
    
    @IBAction private func emailEditingDidBegin(_ textField: UITextField) {
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
    
    @IBAction private func passwordEditingDidBegin(_ textField: UITextField) {
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
    
    @IBAction func emailEditingChanged(_ textField: UITextField) {
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
    
    @IBAction private func passwordEditingChanged(_ textField: UITextField) {
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
    
    @IBAction private func onLogInButtonDidTap(_ sender: UIButton) {
        self.goToHomePage()
    }
    
}

// MARK: - UITextfield

extension UITextField {
    func addPaddingToTextField() {
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 0.0))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

// MARK: - UITapGestureRecognizer

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
