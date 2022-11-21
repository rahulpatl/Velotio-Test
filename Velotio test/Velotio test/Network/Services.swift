//
//  Services.swift
//  Velotio test
//
//  Created by Rahul Patil on 18/11/22.
//

import Foundation
enum APIServices {
    case getCharacter(startsWith: String, hashKey: String, ts: String)
    case characterDetails(id: Int, hashKey: String, timeStamp: String)
}

//MARK: NetworkAPI Constants
enum APIConstants {
    static let marvelBaseURL = "https://gateway.marvel.com"
    static let APIKey = "2b332f8162515d107d333135ddfb6b306cc566f9"
    static let PublicKey = "2c23c86a20aafe7b7102f599f25c220e"
}

enum HTTPMethod: String {
    case get = "GET"
}

extension APIServices {
  var parameters: [String : Any] {
      switch self {
      case let .getCharacter(startsWith, hashKey, ts):
          return [
            "nameStartsWith": startsWith,
            "apikey": APIConstants.PublicKey,
            "hash": hashKey,
            "ts": ts
          ]
          
      case let .characterDetails(_, hashKey, timeStamp):
          return [
            "apikey": APIConstants.PublicKey,
            "hash": hashKey,
            "ts": timeStamp
          ]
      }
  }
  
  var baseURL: URL {
    return URL(string: APIConstants.marvelBaseURL)!
  }
  
  var path: String {
    switch self {
    case .getCharacter:
      return "/v1/public/characters"
    case .characterDetails(let id, _, _):
        return "/v1/public/characters/\(id)"
    }
  }
  
  var method: HTTPMethod {
    return HTTPMethod.get
  }
  
  var headers: [String: String]? {
      return [
          "Connection": "keep-alive"
      ]
  }
}
