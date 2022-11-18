//
//  APIFailure.swift
//  Velotio test
//
//  Created by Rahul Patil on 18/11/22.
//

import Foundation
enum APIFailure: Error, CustomStringConvertible {
  case invalidRequestURL(URL)
  case decodingError(DecodingError)
  case noInternet(URLError.Code)
  case emptyData
  
  var description: String {
    switch self {
    case let .decodingError(error):
      return "Json decoding Error: \(error.localizedDescription)"
      
    case .emptyData:
        return "Empty response from the server"
      
    case let .invalidRequestURL(urlError):
      return "Invalid URL Error: \(urlError.description)"
      
    case let .noInternet(error):
      return "Internet not available: \(error)"
    }
  }
}
