//
//  Comics.swift
//  Velotio test
//
//  Created by Rahul Patil on 20/11/22.
//

import Foundation
struct Comics : Codable {
    let items : [Items]?

    enum CodingKeys: String, CodingKey {
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
    }
}

struct Items : Codable {
    let resourceURI : String?
    let name : String?

    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
