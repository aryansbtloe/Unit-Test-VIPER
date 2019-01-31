//
//  APIDataManager.swift
//  Application
//
//  Created by Alok Singh on 01/31/2019.
//  Copyright © 2019 Sample. All rights reserved.
//

import Foundation

class APIDataManager {
    init() {
        
    }
}

extension APIDataManager : APIDataManagerInputProtocol {
    func login(user: User, response: (Bool, Error?) -> (Void)) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: ["username":user.username,"password":user.password], options: JSONSerialization.WritingOptions.prettyPrinted)
            let request = self.requestWithBody(path: "login", method: "POST", body: jsonData as NSData)
        } catch {
            response(false, NSError(domain: "invalid Json", code: 1, userInfo: ["user": user]))
        }
    }
}


extension APIDataManager {
    private func requestWithBody(path: String, method: String, body: NSData) -> NSMutableURLRequest {
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: "http://localhost:9955/AuthService/" + path)
        request.httpMethod = method
        if method == "POST" {
            request.httpBody = body as Data
        }
        return request
    }
}
