public enum FirestoreCollection: String, FirestoreSchema {
  case chat
  case message
  case knock
  case report
  case userInfo
  case tag
  
  /// GitSpace Firestore의 컬렉션 이름과 일치시키기 위해 첫 글자를 대문자로 변환합니다.
  /// - Author: 원태영
  public var name: String {
    var temp: String = self.rawValue
    let firstChar: String = String(temp.removeFirst())
    
    return firstChar.uppercased() + temp
  }
  
  public var collectionFieldType: any FirestoreFieldProtocol.Type {
    switch self {
      case .chat:
        return FirestoreField.Chat.self
        
      case .knock:
        return FirestoreField.Knock.self
        
      case .message:
        return FirestoreField.Message.self
        
      case .report:
        return FirestoreField.Report.self
        
      case .userInfo:
        return FirestoreField.UserInfo.self
        
      case .tag:
        return FirestoreField.Tag.self
    }
  }
}
