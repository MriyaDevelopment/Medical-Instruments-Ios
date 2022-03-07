//
//  ConfigurationProtocol.swift
//  MedicalInstruments
//
//  Created by Nikita Ezhov on 07.03.2022.
//

import Foundation

protocol ConfigurationProtocol {
    var scheme: String { get }
    var host: String { get }
}

extension ConfigurationProtocol {
    var baseUrl: String {
        return "\(scheme)://\(host)"
    }
    
    func buildUrl(for path: String) -> String {
        guard !path.isEmpty else {
            return path
        }
        return baseUrl + path
    }
}

#warning("change scheme")
struct Configuration: ConfigurationProtocol {
    static let shared: ConfigurationProtocol = ConfigurationTest()
    
    let scheme: String = Configuration.shared.scheme
    let host: String = Configuration.shared.host
}

struct ConfigurationTest: ConfigurationProtocol {
    let scheme: String = "https"
    let host = "unizoo-studiofact.t-dir.com"
}
