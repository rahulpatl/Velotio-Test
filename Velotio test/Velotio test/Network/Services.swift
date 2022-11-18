//
//  Services.swift
//  Velotio test
//
//  Created by Rahul Patil on 18/11/22.
//

import Foundation
enum APIServices {
  case getCharacter(startsWith: String)
}

extension APIServices {
  var parameters: [String : Any] {
      switch self {
      case let .getCharacter(startsWith):
          return [
            "nameStartsWith": startsWith,
            "apikey": APIConstants.APIKey
          ]
      }
  }
  
  var baseURL: URL {
    return URL(string: APIConstants.marvelBaseURL)!
  }
  
  var path: String {
    switch self {
    case .getCharacter:
      return "443/v1/public/characters"
    }
  }
  
  var method: HTTPMethod {
    return HTTPMethod.get
  }
  
  var headers: [String: String]? {
      return [
          "Accept": "application/json",
          "Content-Type": "application/json"
      ]
  }
}

//MARK: NetworkAPI Constants
enum APIConstants {
    static let marvelBaseURL = "https://gateway.marvel.com"
    static let APIKey = "2c23c86a20aafe7b7102f599f25c220e"
}

enum HTTPMethod: String {
    case get = "GET"
}
