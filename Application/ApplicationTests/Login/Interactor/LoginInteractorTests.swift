//
//  LoginInteractorTests.swift
//  Application
//
//  Created by Alok Singh on 01/31/2019.
//  Copyright © 2019 Sample. All rights reserved.
//

import XCTest
@testable import Application

class LoginInteractorTests: XCTestCase {

    /// Target object to test
    var interactor : LoginInteractor!
    var mockedPresenter : MockPresenter!
    var mockedApiDataManager : MockAPIDataManager!

    override func setUp() {
        super.setUp()

        /// Target to test
        interactor = LoginInteractor()

        /// Dependencies
        mockedPresenter = MockPresenter()
        mockedApiDataManager = MockAPIDataManager()

        interactor.presenter = mockedPresenter
        interactor.apiDataManager = mockedApiDataManager
    }

    func testLogin_Success_Response() {
        /// Setup
        mockedApiDataManager.mockSuccess = true

        /// Expectation
        let expectation = self.keyValueObservingExpectation(for: mockedPresenter, keyPath: "loginSuccededCalled") { (object, info) -> Bool in
            return (object as? MockPresenter)?.loginSuccededCalled ?? false
        }

        /// Test
        interactor?.login(username: "username", password: "password")

        /// Waiter
        let expectationStatus = XCTWaiter().wait(for: [expectation], timeout: 5)

        /// Validation of test case
        XCTAssertEqual(expectationStatus, .completed)
    }

    func testLogin_Failure_Response() {
        /// Setup
        mockedApiDataManager.mockSuccess = false

        /// Expectation
        let expectation = self.keyValueObservingExpectation(for: mockedPresenter, keyPath: "loginFailedCalled") { (object, info) -> Bool in
            return (object as? MockPresenter)?.loginFailedCalled ?? false
        }

        /// Test
        interactor?.login(username: "username", password: "password")

        /// Waiter
        let expectationStatus = XCTWaiter().wait(for: [expectation], timeout: 5)

        /// Validation of test case
        XCTAssertEqual(expectationStatus, .completed)
    }


    class MockPresenter: NSObject,LoginInteractorOutputProtocol {

        /// To hold the function call status
        @objc dynamic var loginSuccededCalled : Bool = false
        @objc dynamic var loginFailedCalled : Bool = false

        func loginSucceded() {
            loginSuccededCalled = true
        }

        func loginFailed(error: Error?) {
            loginFailedCalled = true
        }
    }
    
    class MockAPIDataManager: APIDataManagerInputProtocol {

        /// To mock SUCCESS/FAILURE
        var mockSuccess : Bool = true

        func login(user: User, response: @escaping (Bool, Error?) -> (Void)) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 , execute: {
                if self.mockSuccess {
                    response(true,nil)
                }else{
                    let error = NSError(domain: "no such user found", code: 508, userInfo: nil) as? Error
                    response(false,error)
                }
            })
        }

    }

}
