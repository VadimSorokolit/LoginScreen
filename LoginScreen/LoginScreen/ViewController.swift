//
//  ViewController.swift
//  LoginScreen
//
//  Created by Vadim on 06.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var infoLabel: UILabel!
    @IBOutlet weak private var userAccountTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var logInButton: UIButton!
    @IBOutlet weak private var informationLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLabels()
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

