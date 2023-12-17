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
        
        if self.screenHeigh < self.iPhone8PlusScreenHeigh {
            self.infoLabelTopConstraint.constant /= 2
            self.infoLabelBottomConstraint.constant /= 2
        }
    }
    
    // MARK: - Methods
    
    private func setupLabels() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        self.informationLabel.isUserInteractionEnabled = true
        self.informationLabel.addGestureRecognizer(tap)
    }
    
    // MARK: - IBActions
    
    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
        print("Task is done")
    }
    
}

