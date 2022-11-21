//
//  CharactersData.swift
//  Velotio test
//
//  Created by Rahul Patil on 20/11/22.
//

import Foundation
struct CharactersData : Codable {
    let offset : Int?
    let limit : Int?
    let total : Int?
    let count : Int?
    let results : [CharacterDetails]?

    enum CodingKeys: String, CodingKey {
        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        results = try values.decodeIfPresent([CharacterDetails].self, forKey: .results)
    }

}
