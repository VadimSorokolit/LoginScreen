//
//  GlobalConstans.swift
//  LoginScreen
//
//  Created by Vadym Sorokolit on 12.01.2024.
//

import Foundation

struct GlobalConstants {
    static let iPhone8PlusScreenHeight: CGFloat = 736.0
    
    static let loginViewControllerId = "LogInViewController"
    static let homePageViewControllerId = "HomePageViewController"
    static let predicateFormat = "SELF MATCHES %@"
    static let emailReqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let containsDigitReqularExpression = ".*[0-9]+.*"
    static let containsLowerCaseReqularExpression = ".*[a-z]+.*"
    static let containsUpperCaseReqularExpression = ".*[A-Z]+.*"
    static let errorMessageEmailDoesntMustContainSpaces = "Email doesn't must contain spaces"
    static let errorMessageInvalidEmailAddress = "Invalid email address"
    static let errorMessagePasswordDoesntMustContainSpaces = "Password doesn't must contain spaces"
    static let errorMessagePasswordMustBeAtLeast8Characters = "Password must be at least 8 characters"
    static let errorMessagePasswordMustContainAtLeast1Digit = "Password must contain at least 1 digit"
    static let errorMessagePasswordMustContainAtLeast1LowerCaseCharacter = "Password must contain at least 1 lowerCase character"
    static let errorMessagePasswordMustContainAtLeast1UpperCaseCharacter = "Password must contain at least 1 upperCase character"
    static var userName = ""
}
