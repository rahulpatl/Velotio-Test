//
//  StringX.swift
//  Velotio test
//
//  Created by Rahul Patil on 20/11/22.
//

import Foundation
import CryptoKit

extension String {
    var hashString: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}

extension Date {
    var timeStamp: Int {
        return Int(self.timeIntervalSince1970 * 1000)
    }
}
