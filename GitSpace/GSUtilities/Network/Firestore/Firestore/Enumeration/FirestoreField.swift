enum FirestoreField {
  enum Chat: String, FirestoreFieldProtocol {
    case id
    case createdDate
    case joinedMemberIDs
    case lastContent
    case lastContentDate
    case knockContent
    case knockContentDate
    case unreadMessageCount
  }
  
  enum Knock: String, FirestoreFieldProtocol {
    case id
    case knockedDate
    case knockMessage
    case knockStatus
    case knockCategory
    case declineMessage
    case receivedUserName
    case sentUserName
    case receivedUserID
    case sentUserID
    case chatID
    case acceptedDate
    case declinedDate
  }
  
  enum Message: String, FirestoreFieldProtocol {
    case id
    case senderID
    case textContent
    case imageContent
    case sentDate
    case isRead
  }
  
  enum Report: String, FirestoreFieldProtocol {
    case id
    case reason
    case reporterID
    case targetUserID
    case date
    case content
    case type
  }
  
  enum Tag: String, FirestoreFieldProtocol {
    case id
    case tagName
    case repositories
    case isSelected
  }
  
  enum UserInfo: String, FirestoreFieldProtocol {
    case id
    case createdDate
    case deviceToken
    case blockedUserIDs
    case blockedByUserIDs
    case isKnockPushAvailable
    case isChatPushAvailable
    
    case githubID
    case githubLogin
    case githubName
    case githubEmail
    case avatar_url
    case bio
    case company
    case location
    case blog
    case public_repos
    case followers
    case following
  }
}
