//
//  Endpoint.swift
//  GSNetwork
//
//  Created by 박제균 on 2/14/24.
//

import Foundation

protocol Endpoint {
  var scheme: String { get }
  var host: String { get }
  var path: String { get }
  var method: HTTPRequestMethod { get }
  var header: [String: String]? { get }
  var body: [String: String]? { get }
  var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
  var scheme: String {
    return "https"
  }
  var host: String {
    return "api.github.com"
  }
}
