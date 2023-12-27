//
//  SignUpViewController.swift
//  LoginScreen
//
//  Created by Vadim on 17.12.2023.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpInfoLabel: UILabel!
    @IBOutlet weak var signUpUserAccountTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpInformationLabel: UILabel!
    @IBOutlet weak var signUpInfoLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpInfoLabelBottomConstraint: NSLayoutConstraint!
    
    // MARK: - IBOutlets
    
    
    
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
        signUpUserAccountTextField.AddPaddingToTextField()
        signUpPasswordTextField.AddPaddingToTextField()
    }
    
    // MARK: - IBActions
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (self.signUpInformationLabel.text! as NSString).range(of: "Log in")
       
        if gesture.didTapAttributedTextInLabel(label: self.signUpInformationLabel, inRange: termsRange) {
            print("Good")
        }
    }
    
    @IBAction func pop(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}




