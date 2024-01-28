//
//  LogInViewController.swift
//
//  Created by Vadym Sorokolit on 06.12.2023.
//

import UIKit
import FirebaseAuth
import ProgressHUD

class LogInViewController: UIViewController {
    
    // MARK: Objects
    
    private struct LocalConstants {
        static let message = "Please wait..."
        static let signUpViewControllerId = "SignUpViewController"
        static let signUpKeyword = "Sign up"
    }
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var termsLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var errorLabelTopConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    
    private let alertsManager = AlertsManager()
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    private var isCorrectEmail: Bool = false
    private var isCorrectPassword: Bool = false
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupActivityIndicator()
        self.setupLabels()
        self.setupTextFields()
        self.resetForm()
        self.registerForKeyboardNotifications()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: Methods
    
    // API for activity indicator

    private func setupActivityIndicator() {
        ProgressHUD.colorAnimation = .systemBlue
    }
    
    private func showActivityIndicator() {
        ProgressHUD.animate(LocalConstants.message, .squareCircuitSnake, interaction: false)
    }
    
    private func hideActivityIndicator() {
        ProgressHUD.dismiss()
    }
    
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
            return GlobalConstants.errorMessageEmailDoesntMustContainSpaces
        }
        let reqularExpression = GlobalConstants.emailRegularExpression
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
        let reqularExpression = GlobalConstants.containsDigitRegularExpression
        let predicate = NSPredicate(format: GlobalConstants.predicateFormat, reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func containsLowerCase(_ value: String) -> Bool {
        let reqularExpression = GlobalConstants.containsLowerCaseRegularExpression
        let predicate = NSPredicate(format: GlobalConstants.predicateFormat, reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func containsUpperCase(_ value: String) -> Bool {
        let reqularExpression = GlobalConstants.containsUpperCaseRegularExpression
        let predicate = NSPredicate(format: GlobalConstants.predicateFormat, reqularExpression)
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
    
    private func goToSignUp() {
        if let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: LocalConstants.signUpViewControllerId) as? SignUpViewController {
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
    
    private func goToHomePage(withUserName userName: String) {
        if let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstants.homePageViewControllerId) as? HomePageViewController {
            homePageVC.userName = userName
            self.navigationController?.setViewControllers([homePageVC], animated: true)
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
        let termsRange = (self.termsLabel.text! as NSString).range(of: LocalConstants.signUpKeyword)
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
    
    @IBAction private func emailEditingChanged(_ textField: UITextField) {
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
        if let email = self.emailTextField.text,
           let password = self.passwordTextField.text {
            self.showActivityIndicator()
            Auth.auth().signIn(withEmail: email, password: password, completion: { (authResult: AuthDataResult?, error: Error?) -> Void in
                self.hideActivityIndicator()
                if let error {
                    self.alertsManager.showErrorAlert(message: error.localizedDescription, in: self)
                    return
                }
                if let user = authResult?.user {
                    if let userName = user.email {
                        self.goToHomePage(withUserName: userName)
                    }
                }
            })
        }
    }
    
}

// MARK: - UITextfield

extension UITextField {
    func addPaddingToTextField() {
        let frame = CGRect(x: 0.0, y: 0.0, width: 15.0, height: 0.0)
        let paddingView: UIView = UIView.init(frame: frame)
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
