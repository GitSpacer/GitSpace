import Foundation

struct Repository: GSModel, Equatable {
  static func == (lhs: Repository, rhs: Repository) -> Bool {
    return lhs.id == rhs.id
  }
  
  var id: Int
  var name: String
  var fullName: String
  var owner: Owner
  var description: String?
  var isPrivate: Bool
  var stargazersCount: Int
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case fullName = "full_name"
    case owner = "owner"
    case description = "description"
    case isPrivate = "private"
    case stargazersCount = "stargazers_count"
  }
}
