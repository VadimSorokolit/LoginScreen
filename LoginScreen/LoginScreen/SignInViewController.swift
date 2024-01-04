//
//  SignInViewController.swift
//  LoginScreen
//
//  Created by Vadim on 06.12.2023.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var infoLabel: UILabel!
    @IBOutlet weak private var foundError: UILabel!
    @IBOutlet weak private var emailTF: UITextField!
    @IBOutlet weak private var passwordTF: UITextField!
    @IBOutlet weak private var logInButton: UIButton!
    @IBOutlet weak private var informationLabel: UILabel!
    @IBOutlet weak private var infoLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak private var infoLabelBottomConstraint: NSLayoutConstraint!
    
    // MARK - Current and min Height of screenHeigh
    
    private let screenHeigh = UIScreen.main.bounds.height
    private let iPhone8PlusScreenHeigh = 736.0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
        
        self.resetForm()
        self.setupLabels()
        self.setupTextFields()
        
        /*
         
         userAccountTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: userAccountTextField.frame.height))
         userAccountTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: userAccountTextField.frame.height))
         userAccountTextField.leftViewMode = .always
         userAccountTextField.rightViewMode = .always
         
         */
    }
    
    // MARK: - Methods
    
    private func resetForm() {
        self.logInButton.isEnabled = false
        
        self.foundError.isHidden = false
        
        self.foundError.text = "Required"
        self.foundError.text = ""
    }
    
    private func invalidEmail(_ value: String) -> String? {
        let reqularExpression = "[A-Z0-9a-z._%+_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2.64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if  !predicate.evaluate(with: value) {
            return "Invalid email address"
        }
        return nil
        
    }
    
    private func invalidPassword(_ value: String) -> String? {
        if value.count < 8 {
            return "Password must be at least 8 characters"
        }
        return nil
    }
    
    private func checkForValidForm() {
        if self.foundError.isHidden {
            self.logInButton.isEnabled = true
        } else {
            self.logInButton.isEnabled = false
        }
    }
    
    private func setupLabels() {
        self.informationLabel.isUserInteractionEnabled = true
        self.informationLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
        if self.screenHeigh < self.iPhone8PlusScreenHeigh {
            self.infoLabelTopConstraint.constant /= 2
            self.infoLabelBottomConstraint.constant /= 2
        }
    }
    
    private func setupTextFields() {
        self.emailTF.addPaddingToTextField()
        self.passwordTF.addPaddingToTextField()
    }
    
    private func goToSignUp() {
        if let signUpVC = self.navigationController?.viewControllers.first(where: { $0 is SignUpViewController }) {
            self.navigationController?.setViewControllers([signUpVC], animated: true)
        }  else {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            if let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
                signUpVC.title = "Sign Up Screen"
                self.navigationController?.pushViewController(signUpVC, animated: true)
            }
        }
    }
    
    private func goToHomePage() {
        if let HomePageVC = self.navigationController?.viewControllers.first(where: { $0 is HomePageViewController }) {
            self.navigationController?.setViewControllers([HomePageVC], animated: true)
        }  else {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            if let HomePageVC = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
                HomePageVC.title = "Home Page Screen"
                self.navigationController?.setViewControllers([HomePageVC], animated: true)
            }
        }
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
    }

    // MARK: - IBActions
    
    @IBAction func emailChanged(_ sender: Any) {
        if let email = self.emailTF.text {
            if let errorMessage = invalidEmail(email) {
                self.foundError.text = errorMessage
                self.foundError.isHidden = false
            } else {
                self.foundError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    
    @IBAction func passwordChanged(_ sender: Any) {
        if let password = passwordTF.text {
            if let errorMessage = invalidPassword(password) {
                foundError.text = errorMessage
                foundError.isHidden = false
            } else {
                foundError.isHidden = true
            }
        }
        checkForValidForm()
    }
    
    @IBAction private func onLogInButtonDidTap(_ sender: UIButton) {
        resetForm()
        self.goToHomePage()
    }
    
    @IBAction private func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (informationLabel.text! as NSString).range(of: "Sign up")
        
        if gesture.didTapAttributedTextInLabel(label: informationLabel, inRange: termsRange) {
            self.goToSignUp()
        }
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


