import Foundation

public struct Chat: GSModel {
  public let id: String                   // 채팅방 ID
  let createdDate: Date                   // 생성 날짜
  let joinedMemberIDs: [String]           // 채팅방에 참여한 유저 ID 리스트
  var lastContent: String                 // 마지막 메세지 내용
  var lastContentDate: Date               // 마지막 메세지 날짜
  let knockContent: String                // 노크 메세지 내용
  let knockContentDate: Date              // 노크 메세지 날짜
  var unreadMessageCount: [String: Int]  // 읽지 않은 메시지 갯수 (userID : 읽지 않은 메시지 갯수)
  
  public init(
    id: String,
    createdDate: Date,
    joinedMemberIDs: [String],
    lastContent: String,
    lastContentDate: Date,
    knockContent: String,
    knockContentDate: Date,
    unreadMessageCount: [String : Int]
  ) {
    self.id = id
    self.createdDate = createdDate
    self.joinedMemberIDs = joinedMemberIDs
    self.lastContent = lastContent
    self.lastContentDate = lastContentDate
    self.knockContent = knockContent
    self.knockContentDate = knockContentDate
    self.unreadMessageCount = unreadMessageCount
  }
  
  public static var dummy: Chat {
    return Chat(
      id: UUID().uuidString,
      createdDate: .now,
      joinedMemberIDs: [],
      lastContent: "마지막 메세지",
      lastContentDate: .now,
      knockContent: "안녕하세요",
      knockContentDate: .now,
      unreadMessageCount: [:]
    )
  }
}
