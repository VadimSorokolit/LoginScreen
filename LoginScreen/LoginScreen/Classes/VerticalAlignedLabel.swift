//
//  VerticalAligment.swift
//
//  Created by Vadym Sorokolit on 27.01.2024.
//

import Foundation
import UIKit

class VerticalAlignedLabel: UILabel {
    
    // MARK: Methods
    
    override func drawText(in rect: CGRect) {
        var newRect = rect
        let height = self.sizeThatFits(rect.size).height
        switch self.contentMode {
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
