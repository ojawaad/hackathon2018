//
//  ConnectToAPI.swift
//  Hackathon2018
//
//  Created by John Christopher Briones on 10/14/18.
//  Copyright © 2018 Jc Briones. All rights reserved.
//

import Foundation
import Alamofire

final class ConnectToAPI {
    
    let API_URL = "https://jcbriones.com/mlh2018"
    
    func userLogin(username: String, password: String, completion: @escaping (User?, String?) -> Void) {
        Alamofire.request(
            URL(string: "\(API_URL)/login")!,
            method: .post,
            parameters: [
                "username": username,
                "password": password
            ])
            .validate()
            .responseJSON { response in
                
                switch (response.result) {
                case .success:
                    if let data = response.data {
                        do {
                            let userData = try JSONDecoder().decode(User.self, from: data)
                            completion(userData, nil)
                        } catch let err {
                            do {
                                let errorData = try JSONDecoder().decode(JSError.self, from: data)
                                completion(nil, errorData.errorMessage)
                            }
                            catch {
                                completion(nil,err.localizedDescription)
                            }
                        }
                    }
                    break
                case .failure(let error):
                    completion(nil, "\(error.localizedDescription)")
                    break
                }
        }
    }
    
    func inviteUser(email: String, completion: @escaping (String?) -> Void) {
        Alamofire.request(
            URL(string: "\(API_URL)/invite_user")!,
            method: .post,
            parameters: [
                "email": email
            ])
            .validate()
            .responseJSON { response in
                
                switch (response.result) {
                case .success:
                    if let data = response.data {
                        do {
                            let errorData = try JSONDecoder().decode(JSError.self, from: data)
                            completion(errorData.errorMessage)
                        }
                        catch {
                            completion("Failed to invite")
                        }
                    }
                    break
                case .failure(let error):
                    completion(error.localizedDescription)
                    break
                }
        }
    }
    
}
