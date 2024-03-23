//
//  HTTPClient.swift
//  GSNetwork
//
//  Created by 박제균 on 2/14/24.
//

import Foundation

protocol HTTPClient {

  /// HTTP request를 보내고, 성공시 지정한 model을 돌려받을 수 있다. 실패시 error를 받는다.
  func sendRequest<T: Decodable>(endpoint: Endpoint) async -> Result<T, GitHubError>

  ///response로 status code와 함께 string을 받는 경우(Markdown)
  func sendRequest(endpoint: Endpoint) async -> Result<String, GitHubError>

  /// response로 status code만 받는 경우 (star, unstar, follow, unfollow)
  /// status code만 받기 때문에, 204를 만나면 break, 나머지 코드를 받으면 error를 throw한다.
  func sendRequest(endpoint: Endpoint) async throws
}

extension HTTPClient {

  func sendRequest<T: Decodable>(endpoint: Endpoint) async -> Result<T, GitHubError> {

    var components = URLComponents()
    components.scheme = endpoint.scheme
    components.host = endpoint.host
    components.path = endpoint.path
    components.queryItems = endpoint.queryItems

    guard let url = components.url else {
      return .failure(.invalidURL(from: #function))
    }

    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue
    request.allHTTPHeaderFields = endpoint.header

    if let body = endpoint.body {
      request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
    }

    do {
      let (data, response) = try await URLSession.shared.data(for: request)

      guard let response = response as? HTTPURLResponse else {
        return .failure(.invalidResponse(from: #function))
      }

      switch response.statusCode {
      case 200...299:
        guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
          return .failure(.failToDecoding(from: #function))
        }
        return .success(decodedResponse)
      default:
        return .failure(.unexpectedStatusCode(from: #function))
      }

    } catch {
      return .failure(.unknown(from: #function))
    }
  }

  func sendRequest(endpoint: Endpoint) async -> Result<String, GitHubError> {
    var components = URLComponents()
    components.scheme = endpoint.scheme
    components.host = endpoint.host
    components.path = endpoint.path
    components.queryItems = endpoint.queryItems

    guard let url = components.url else {
      return .failure(.invalidURL(from: #function))
    }

    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue
    request.allHTTPHeaderFields = endpoint.header

    if let body = endpoint.body {
      request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
    }

    do {
      let (data, response) = try await URLSession.shared.data(for: request)

      guard let response = response as? HTTPURLResponse else {
        return .failure(.invalidResponse(from: #function))
      }

      switch response.statusCode {

      case 200:
        guard let resultString = String(data: data, encoding: .utf8) else {
          return .failure(.failToEncoding(from: #function))
        }
        return .success(resultString)
      case 204:
        return .success("request succeed")
      case 304:
        return .failure(.notModified(from: #function))
      case 401:
        return .failure(.requireAuthentication(from: #function))
      case 403:
        return .failure(.forbidden(from: #function))
      case 404:
        return .failure(.notFound(from: #function))
      default:
        return .failure(.unexpectedStatusCode(from: #function))
      }
    } catch {
      return .failure(.unknown(from: #function))
    }
  }

  func sendRequest(endpoint: Endpoint) async throws {
    var components = URLComponents()
    components.scheme = endpoint.scheme
    components.host = endpoint.host
    components.path = endpoint.path
    components.queryItems = endpoint.queryItems

    guard let url = components.url else {
      throw GitHubError.invalidURL(from: #function)
    }

    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue
    request.allHTTPHeaderFields = endpoint.header

    if let body = endpoint.body {
      request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
    }

    do {
      let ( _, response) = try await URLSession.shared.data(for: request)

      guard let response = response as? HTTPURLResponse else {
        throw GitHubError.invalidResponse(from: #function)
      }

      switch response.statusCode {
        // 204를 만나면 에러 없이 종료
      case 204:
        break
      case 304:
        throw GitHubError.notModified(from: #function)
      case 401:
        throw GitHubError.requireAuthentication(from: #function)
      case 403:
        throw GitHubError.forbidden(from: #function)
      case 404:
        throw GitHubError.notFound(from: #function)
      default:
        throw GitHubError.unexpectedStatusCode(from: #function)
      }

    } catch {
      throw GitHubError.unknown(from: #function)
    }
  }

}


