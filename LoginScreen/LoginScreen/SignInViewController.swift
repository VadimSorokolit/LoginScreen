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
    @IBOutlet weak var infoLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoLabelTopConstraint: NSLayoutConstraint!
    
    // MARK - find the current and min Height of screenHeigh
    
    private let screenHeigh = UIScreen.main.bounds.height
    private let iPhone8PlusScreenHeigh = 736.0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLabels()
        self.setupTextFields()
        
        if self.screenHeigh < self.iPhone8PlusScreenHeigh {
            self.infoLabelTopConstraint.constant /= 2
            self.infoLabelBottomConstraint.constant /= 2
        }
        
    /*
        
        userAccountTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: userAccountTextField.frame.height))
        userAccountTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: userAccountTextField.frame.height))
        userAccountTextField.leftViewMode = .always
        userAccountTextField.rightViewMode = .always
         
    */
         
       
    }
    
    // MARK: - Methods
    
    private func setupLabels() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        self.informationLabel.isUserInteractionEnabled = true
        self.informationLabel.addGestureRecognizer(tap)
    }
    
    private func setupTextFields() {
        userAccountTextField.AddPaddingToTextField()
        passwordTextField.AddPaddingToTextField()
    }
    
    // MARK: - IBActions
    
    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
        print("Task is done")
    }
    
}

// Add padding to UITextField

extension UITextField {
    func AddPaddingToTextField() {
        let borderWidth  = 15
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: borderWidth, height: 0))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}


