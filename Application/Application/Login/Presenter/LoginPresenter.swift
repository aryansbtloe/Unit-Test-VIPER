//
//  LoginPresenter.swift
//  Application
//
//  Created by Alok Singh on 01/31/2019.
//  Copyright © 2019 Sample. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol, LoginInteractorOutputProtocol {

    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?

    init() {}
}


// MARK: - LoginPresenterProtocol
extension LoginPresenter {
    func loginButtonTapped(username: String, password: String) {
        interactor?.login(username: username, password: password)
    }
}

// MARK: - LoginInteractorOutputProtocol
extension LoginPresenter {
    func loginSucceded() {
        view?.showLoginSuccessMessage()
    }
    func loginFailed(error: Error?) {
        view?.showLoginFailedMessage()
    }
}
