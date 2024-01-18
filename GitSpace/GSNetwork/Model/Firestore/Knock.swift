import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct Knock: GSModel, Hashable {
  public var id: String = UUID().uuidString
  var knockedDate: Timestamp
  var knockMessage: String
  var knockStatus: String
  var knockCategory: String
  var declineMessage: String?
  var receivedUserName: String
  var sentUserName: String
  var receivedUserID: String
  var sentUserID: String
  var chatID: String?
  var acceptedDate: Timestamp?
  var declinedDate: Timestamp?
}
