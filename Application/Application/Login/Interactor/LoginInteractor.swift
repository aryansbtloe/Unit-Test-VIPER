//
//  LoginInteractor.swift
//  Application
//
//  Created by Alok Singh on 01/31/2019.
//  Copyright © 2019 Sample. All rights reserved.
//

import Foundation

class LoginInteractor: LoginInteractorInputProtocol {

    weak var presenter: LoginInteractorOutputProtocol?
    var apiDataManager: APIDataManagerInputProtocol?

    init() {
    }
}

extension LoginInteractor {
    func login(username: String, password: String) {
        let user : User = User(username: username, password: password)
        apiDataManager?.login(user: user, response: { (success, error) -> (Void) in
            if success {
                self.presenter?.loginSucceded()
            }else{
                self.presenter?.loginFailed(error: error)
            }
        })
    }
}
