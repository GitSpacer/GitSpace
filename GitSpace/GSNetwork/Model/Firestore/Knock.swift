import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct Knock: GSModel, Hashable {
  
  public var id: String = UUID().uuidString
  public var knockedDate: Timestamp
  public var knockMessage: String
  public var knockStatus: String
  public var knockCategory: String
  public var declineMessage: String?
  public var receivedUserName: String
  public var sentUserName: String
  public var receivedUserID: String
  public var sentUserID: String
  public var chatID: String?
  public var acceptedDate: Timestamp?
  public var declinedDate: Timestamp?
}
