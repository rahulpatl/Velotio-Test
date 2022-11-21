//
//  BaseResponse.swift
//  Velotio test
//
//  Created by Rahul Patil on 20/11/22.
//

import Foundation
struct BaseResponse: Codable {
    let code : Int?
    let status : String?
    let etag : String?
    let data : CharactersData?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case status = "status"
        case etag = "etag"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        etag = try values.decodeIfPresent(String.self, forKey: .etag)
        data = try values.decodeIfPresent(CharactersData.self, forKey: .data)
    }
}
