import Foundation

public struct UserInfo: GSModel, Equatable {
  
  // MARK: -Firestore Properties
  public var id: String           // 유저 ID (Firebase Auth UID)
  public var createdDate: Date           // 유저 생성일시
  public var deviceToken: String         // 유저 기기 토큰
  public var blockedUserIDs: [String]    // 차단한 유저 ID 리스트
  public var blockedByUserIDs: [String]  // 유저를 차단한 상대 유저 ID 리스트
  public var isKnockPushAvailable: Bool? // Knock 푸시알람 승인여부
  public var isChatPushAvailable: Bool?  // chat 푸시알람 승인여부
  
  // MARK: -Github Properties
  public let githubID: Int               // 유저 깃허브 ID값, 받을 때 정수형으로 와서 타입 통일
  public let githubLogin: String         // 유저 깃허브 login (Repository 경로에 쓰는 이름)
  public let githubName: String?         // 유저 깃허브 이름
  public let githubEmail: String?        // 유저 이메일
  public let avatar_url: String          // profile image
  public let bio: String?                // bio, intro message
  public let company: String?            // company
  public let location: String?           // location
  public let blog: String?               // blog url
  public let public_repos: Int           // public repos
  public let followers: Int              // followers
  public let following: Int              // following
}
