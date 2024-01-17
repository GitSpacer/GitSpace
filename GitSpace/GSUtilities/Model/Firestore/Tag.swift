import Foundation

// MARK: - Temporary Tag Struct
public struct Tag: GSModel, Hashable {
  public var id: String = UUID().uuidString
  var tagName: String
  var repositories: [String]  // “${username}/${repoName}”
  var isSelected: Bool = false
}
