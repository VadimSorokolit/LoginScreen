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
    @IBOutlet weak private var userAccountTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var logInButton: UIButton!
    @IBOutlet weak private var informationLabel: UILabel!
    @IBOutlet weak var infoLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoLabelBottomConstraint: NSLayoutConstraint!
    
    // MARK - Current and min Height of screenHeigh
    
    private let screenHeigh = UIScreen.main.bounds.height
    private let iPhone8PlusScreenHeigh = 736.0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
        
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
    
    private func setupLabels() {
        self.informationLabel.isUserInteractionEnabled = true
        self.informationLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        
        if self.screenHeigh < self.iPhone8PlusScreenHeigh {
            self.infoLabelTopConstraint.constant /= 2
            self.infoLabelBottomConstraint.constant /= 2
        }
    }
    
    private func setupTextFields() {
        userAccountTextField.addPaddingToTextField()
        passwordTextField.addPaddingToTextField()
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
    
    @IBAction func onLogInButtonDidTap(_ sender: UIButton) {
        self.goToHomePage()
    }
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
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


