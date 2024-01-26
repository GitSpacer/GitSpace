import Foundation

// MARK: - Temporary Tag Struct
public struct Tag: GSModel, Hashable {
  
  public var id: String = UUID().uuidString
  public var tagName: String
  public var repositories: [String]  // “${username}/${repoName}”
  public var isSelected: Bool = false
}
