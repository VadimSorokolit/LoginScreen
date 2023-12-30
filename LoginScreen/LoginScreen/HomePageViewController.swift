//
//  HomePageViewController.swift
//  LoginScreen
//
//  Created by Vadim on 17.12.2023.
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
    @IBOutlet weak var firstLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonTopConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLabels()
        self.defineCurrentScreen()
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
          //self.firstLabelTopConstraint.constant /= 3
            self.buttonTopConstraint.constant /= 8

        }
    }
    

    
}

class VerticalAlignedLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        var newRect = rect
        switch contentMode {
        case .top:
            newRect.size.height = sizeThatFits(rect.size).height
        case .bottom:
            let height = sizeThatFits(rect.size).height
            newRect.origin.y += rect.size.height - height
            newRect.size.height = height
        default:
            ()
        }
        
        super.drawText(in: newRect)
    }
}


    


