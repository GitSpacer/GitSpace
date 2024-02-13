//
//  GitHubError.swift
//  GSNetwork
//
//  Created by 박제균 on 2/13/24.
//

import GSUtilities

public enum GitHubError: GSError {
  case invalidURL(from: String)
  case invalidResponse(from: String)
  case failToDecoding(from: String)
  case failToEncoding(from: String)
  case failToLoadREADME(from: String)
  case unauthorized(from: String)
  case unexpectedStatusCode(from: String)
  case notModified(from: String)
  case requireAuthentication(from: String)
  case forbidden(from: String)
  case notFound(from: String)
  case failToRequest(from: String)
  case unknown(from: String)
}

public extension GitHubError {

  var errorDescription: String {
    switch self {
    case .invalidURL(let from):
      return from + "URL was invalid, Please try again."

    case .invalidResponse(let from):
      return from + "Invalid response from the server. Please try again."

    case .failToDecoding(let from):
      return from + "Fail to decode data. Please try again"

    case .failToEncoding(let from):
      return from + "Fail to encode data. Please try again"

    case .unauthorized(let from):
      return from + "Authorization Failed. Please try again"

    case .unexpectedStatusCode(let from):
      return from + "Unexpected Error occured. Please try again"

    case .notModified(let from):
      return from + "No data modification has been made. Please try again"

    case .requireAuthentication(let from):
      return from + "Authentication is required. Please try again"

    case .forbidden(let from):
      return from + "This is an invalid permission. Please Try Again"

    case .notFound(let from):
      return from + "Resources are not found. Please Try Again"

    case .failToLoadREADME(let from):
      return from + "Fail to load README.md from Server. Please Try Again"

    case .failToRequest(let from):
      return from + "Fail to Request Network. Please Try Again"

    case .unknown(from: let from):
      return from + "Unknown Error. Please try Again"
    }
  }

}
