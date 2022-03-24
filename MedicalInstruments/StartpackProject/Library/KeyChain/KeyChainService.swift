//
//  KeyChainService.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import Foundation
import KeychainSwift

final class Keychain {
    
    static let shared: KeychainSwift = {
        let shared = KeychainSwift()
        shared.synchronizable = true
        return shared
    }()
    
    private init() {}
}

extension KeychainSwift {
    //MARK: UserToken
    
    func getUserToken() -> String? {
        return Keychain.shared.get("userToken")
    }
    
    func setUserToken(_ token: String) {
        Keychain.shared.set(token, forKey: "userToken")
    }
    
    func deleteUserToken() {
        Keychain.shared.delete("userToken")
    }
    
    func getUserName() -> String? {
        return Keychain.shared.get("userName")
    }
    
    func setUserName(_ name: String) {
        Keychain.shared.set(name, forKey: "userName")
    }
    
    func deleteUserName() {
        Keychain.shared.delete("userName")
    }

}
