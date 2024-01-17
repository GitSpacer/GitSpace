//
//  ApiTransferable.swift
//  GSUtilities
//
//  Created by Celan on 12/24/23.
//

import Foundation
import SwiftUI

private protocol GSApiTransferable<T> {
  associatedtype T: Codable
  var create: () async throws -> T? { get set }
  var read: () async throws -> T? { get set }
  var delete: () async throws -> T? { get set }
  var update: () async throws -> T? { get set }
}

public struct GSFirebaseClient<T: Codable>: GSApiTransferable {
  public var create: () async throws -> T?
  public var read: () async throws -> T?
  public var delete: () async throws -> T?
  public var update: () async throws -> T?
  
  public init(
    create: @escaping () -> T? = { return nil },
    read: @escaping () -> T? = { return nil },
    delete: @escaping () -> T? = { return nil },
    update: @escaping () -> T? = { return nil }
  ) {
    self.create = create
    self.read = read
    self.delete = delete
    self.update = update
  }
}

// MARK: Additional Helpers
extension GSFirebaseClient {
  public func fetchAll() -> [T] {
    return []
  }
}

public struct GSGitHubClient<T: Codable>: GSApiTransferable {
  public var create: () async throws -> T?
  public var read: () async throws -> T?
  public var delete: () async throws -> T?
  public var update: () async throws -> T?
  
  public init(
    create: @escaping () -> T? = { return nil },
    read: @escaping () -> T? = { return nil },
    delete: @escaping () -> T? = { return nil },
    update: @escaping () -> T? = { return nil }
  ) {
    self.create = create
    self.read = read
    self.delete = delete
    self.update = update
  }
}

struct ModelSample: Codable { }
struct GitHubModel: Codable { }
struct FirebaseModel: Codable { }

private struct MyView: View {
  let firebaseClient: some GSApiTransferable = GSFirebaseClient(
    create: { return ModelSample() },
    read: { return ModelSample() }
  )
  
  let githubClient: some GSApiTransferable = GSGitHubClient<GitHubModel>()
  
  var body: some View {
    VStack { }
  }
}
