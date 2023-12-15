//
//  ViewController.swift
//  LoginScreen
//
//  Created by Vadim on 06.12.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var infoLabel: UILabel!
    @IBOutlet weak private var userAccountTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var logInButton: UIButton!
    @IBOutlet weak private var informationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
        self.informationLabel.isUserInteractionEnabled = true
        self.informationLabel.addGestureRecognizer(tap)
    }
    
    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
        print("Task is done")
    }
}

