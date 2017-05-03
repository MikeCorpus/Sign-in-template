//
//  AuthProvider.swift
//  Sign In Template
//
//  Created by Michael V. Corpus on 28/04/2017.
//  Copyright © 2017 Michael V. Corpus. All rights reserved.
//

import Foundation
import Firebase

typealias LoginHandler = (_ msg: String?) -> Void

struct LoginErrorCode {
    static let INVALID_EMAIL = "Invalid Email Address, Please Provide A Real Address"
    static let WRONG_PASSWORD = "Wrong Password, Please Enter The Correct Password"
    static let PROBLEM_CONNECTING = "Problem Connecting To Database"
    static let USER_NOT_FOUND = "User Not Found, Please Register"
    static let EMAIL_ALREADY_IN_USE = "Email Already In Use, Please Use Another Email"
    static let WEAK_PASSWORD = "Password Should Be At Least 6 Characters Long"
}

class AuthProvider {
    
    private static let _instance = AuthProvider()
    
    static var Instance: AuthProvider{
        return _instance
    }
    
    func login(withEmail: String, password: String, LoginHandler: LoginHandler?) {
        
        FIRAuth.auth()?.signIn(withEmail: withEmail, password: password, completion: {(user, error) in
            
            if error != nil {
                self.handleErrors(err: error! as NSError, LoginHandler: LoginHandler)
            } else {
                LoginHandler?(nil)
            }
            
        })
        
    }
    
    private func handleErrors(err: NSError, LoginHandler: LoginHandler?){
    
        if let errorCode = FIRAuthErrorCode(rawValue: err.code) {
            
            switch errorCode {
                
            case .errorCodeInvalidEmail:
                LoginHandler?(LoginErrorCode.INVALID_EMAIL)
                break
                
            case .errorCodeWrongPassword:
                LoginHandler?(LoginErrorCode.WRONG_PASSWORD)
                break
                
            case .errorCodeUserNotFound:
                LoginHandler?(LoginErrorCode.USER_NOT_FOUND)
                break
                
            case .errorCodeEmailAlreadyInUse:
                LoginHandler?(LoginErrorCode.EMAIL_ALREADY_IN_USE)
                break
                
            case .errorCodeWeakPassword:
                LoginHandler?(LoginErrorCode.WEAK_PASSWORD)
                break
                
            default:
                LoginHandler?(LoginErrorCode.PROBLEM_CONNECTING)
                break
                
            }
        
        
        
        }
    }
}













