//
//  HomePageViewController.swift
//
//  Created by Vadym Sorokolit on 17.12.2023.
//

import Foundation
import UIKit

class HomePageViewController: UIViewController {
    
  
    // MARK: IBOutlets
    
    @IBOutlet weak private var homePageImageView: UIImageView!
    @IBOutlet weak private var homePageFirstLabel: UILabel!
    @IBOutlet weak private var homePageSecondLabel: UILabel!
    @IBOutlet weak private var homePageThirdLabel: UILabel!
    @IBOutlet weak private var homePageButton: UIButton!

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.setValue(true, forKey: GlobalConstans.isLoggedInKey)
        
        self.setupLabels()
//      self.defineCurrentScreen()
//      self.getSafeAreaHeightsTopAndBottom()
    }
    
    // MARK: - Methods
    
    private func setupLabels() {
        self.homePageFirstLabel.contentMode = .bottom
        self.homePageSecondLabel.contentMode = .top
        
    }
    
    private func defineCurrentScreen() {
        let screenHeigh = UIScreen.main.bounds.height
        let iPhone8PlusScreenHeigh = 736.0
        
        if screenHeigh < iPhone8PlusScreenHeigh {
        // for example: self.firstLabelTopConstraint.constant /= 3
        // for example: self.buttonButtomConstraint.constant /= 8
        }
    }
    
    private func getSafeAreaHeightsTopAndBottom() {
        if #available(iOS 13.0, *), let window = UIApplication.shared.windows.first {
            let topPadding = window.safeAreaInsets.top
            let bottomPadding = window.safeAreaInsets.bottom
            print(topPadding, bottomPadding)
        }
    }
    
    private func goToLogIn() {
        if let logInVC = self.navigationController?.viewControllers.first(where: { $0 is LogInViewController }) {
            self.navigationController?.setViewControllers([logInVC], animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            if let logInVC = storyboard.instantiateViewController(withIdentifier: GlobalConstans.loginViewControllerId) as? LogInViewController {
                self.navigationController?.setViewControllers([logInVC], animated: true)
            }
        }
        UserDefaults.standard.setValue(false, forKey: GlobalConstans.isLoggedInKey)
    }
    
    @IBAction func onLogOutButtonDidTap(_ sender: UIButton) {
        self.goToLogIn()
    }
}


class VerticalAlignedLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        var newRect = rect
        let height = sizeThatFits(rect.size).height
        switch contentMode {
            case .top:
                newRect.size.height = height
            case .bottom:
                newRect.origin.y += (rect.size.height - height)
                newRect.size.height = height
            default:
                break
        }
        super.drawText(in: newRect)
    }
}


    


