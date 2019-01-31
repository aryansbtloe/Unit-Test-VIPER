//
//  LoginView.swift
//  Application
//
//  Created by Alok Singh on 01/31/2019.
//  Copyright © 2019 Sample. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var presenter: LoginPresenterProtocol?
}

extension LoginViewController: LoginViewProtocol {
    func showLoginSuccessMessage() {
        CommonFunctions.showLoginSuccessAlert()
    }
    func showLoginFailedMessage() {
        CommonFunctions.showLoginFailureAlert()
    }
}

extension LoginViewController {
    @IBAction func loginButtonTapped(){
        presenter?.loginButtonTapped(username: username.text ?? "", password: password.text ?? "")
    }
}
