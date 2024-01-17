import Foundation

struct UserInfo : GSModel, Equatable {
  // MARK: -Firestore Properties
  let id: String                  // 유저 ID (Firebase Auth UID)
  let createdDate: Date           // 유저 생성일시
  var deviceToken: String         // 유저 기기 토큰
  var blockedUserIDs: [String]    // 차단한 유저 ID 리스트
  var blockedByUserIDs: [String]  // 유저를 차단한 상대 유저 ID 리스트
  var isKnockPushAvailable: Bool? // Knock 푸시알람 승인여부
  var isChatPushAvailable: Bool?  // chat 푸시알람 승인여부
  
  // MARK: -Github Properties
  let githubID: Int               // 유저 깃허브 ID값, 받을 때 정수형으로 와서 타입 통일
  let githubLogin: String         // 유저 깃허브 login (Repository 경로에 쓰는 이름)
  let githubName: String?         // 유저 깃허브 이름
  let githubEmail: String?        // 유저 이메일
  let avatar_url: String          // profile image
  let bio: String?                // bio, intro message
  let company: String?            // company
  let location: String?           // location
  let blog: String?               // blog url
  let public_repos: Int           // public repos
  let followers: Int              // followers
  let following: Int              // following
}
