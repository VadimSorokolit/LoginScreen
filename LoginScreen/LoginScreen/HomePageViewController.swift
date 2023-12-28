//
//  HomePageViewController.swift
//  LoginScreen
//
//  Created by Vadim  on 17.12.2023.
//

import Foundation
import UIKit

class HomePageViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var homePageImageView: UIImageView!
    @IBOutlet weak private var homePageFirstLabel: UILabel!
    @IBOutlet weak private var homePageSecondLabel: UILabel!
    @IBOutlet weak private var homePageThirdLabel: UILabel!
    @IBOutlet weak private var homePageButton: UIButton!
    @IBOutlet weak private var homePageFirstLabelButtomConstraint: NSLayoutConstraint!
    @IBOutlet weak private var homePageSecondLabelButtomConstraint: NSLayoutConstraint!
    @IBOutlet weak private var homePageThirdLabelButtomConstraint: NSLayoutConstraint!
    
    // MARK - find the current and min Height of screenHeigh
    
    private let screenHeigh = UIScreen.main.bounds.height
    private let iPhone8PlusScreenHeigh = 736.0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.screenHeigh < self.iPhone8PlusScreenHeigh {
            self.homePageFirstLabelButtomConstraint.constant /= 4
            self.homePageSecondLabelButtomConstraint.constant /= 2
            self.homePageThirdLabelButtomConstraint.constant /= 2
        }
//        override func viewWillLayoutSubviews() {
//               sampleLabel.sizeToFit()
//           }
    }
}
