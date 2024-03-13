import Foundation

public struct Message: GSModel {
  
  public var id: String            // 메세지 ID
  public var senderID: String      // 메세지 작성자 유저 ID
  public var textContent: String   // 메세지 내용
  public var imageContent: String? // 메세지에 첨부한 이미지
  public var sentDate: Date        // 메세지 작성 날짜
  public var isRead: Bool          // 수신 유저의 메세지 확인 여부
  
  public static var dummy: Message {
    return Message(
      id: UUID().uuidString,
      senderID: "",
      textContent: "메세지 내용입니다.",
      sentDate: .now,
      isRead: false
    )
  }
}
