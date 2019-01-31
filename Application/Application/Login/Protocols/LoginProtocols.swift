//
//  LoginProtocols.swift
//  Application
//
//  Created by Alok Singh on 01/31/2019.
//  Copyright © 2019 Sample. All rights reserved.
//

import Foundation


///VIEW : PRESENTER -> VIEW
protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }
    func showLoginSuccessMessage()
    func showLoginFailedMessage()
}

///PRESENTER : VIEW -> PRESENTER
protocol LoginPresenterProtocol: class {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    func loginButtonTapped(username:String,password:String)
}

///PRESENTER : INTERACTOR -> PRESENTER
protocol LoginInteractorOutputProtocol: class {
    func loginSucceded()
    func loginFailed(error:Error?)
}

///INTERACTOR : PRESENTER -> INTERACTOR
protocol LoginInteractorInputProtocol: class {
    var presenter: LoginInteractorOutputProtocol? { get set }
    var apiDataManager: APIDataManagerInputProtocol? { get set }
    func login(username:String,password:String)
}

///APIDATAMANAGER : INTERACTOR -> APIDataManager
protocol APIDataManagerInputProtocol: class{
    func login(user:User, response:@escaping (_ success:Bool, _ error:Error?) -> (Void))
}
