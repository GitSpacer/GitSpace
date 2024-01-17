import Foundation

// MARK: - Temporary Tag Struct
struct Tag: GSModel, Hashable {
  var id: String = UUID().uuidString
  var tagName: String
  var repositories: [String]  // “${username}/${repoName}”
  var isSelected: Bool = false
}
