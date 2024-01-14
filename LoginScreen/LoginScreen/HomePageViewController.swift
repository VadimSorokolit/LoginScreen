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
    }
    
    // MARK: - Methods
    
    private func setupLabels() {
        self.homePageFirstLabel.contentMode = .bottom
        self.homePageSecondLabel.contentMode = .top
    }
    
    private func goToLogIn() {
        if let logInVC = self.navigationController?.viewControllers.first(where: { $0 is LogInViewController }) {
            self.navigationController?.setViewControllers([logInVC], animated: true)
        }
        if let logInVC = self.storyboard?.instantiateViewController(withIdentifier: GlobalConstans.loginViewControllerId) as? LogInViewController {
            self.navigationController?.setViewControllers([logInVC], animated: true)
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


    


