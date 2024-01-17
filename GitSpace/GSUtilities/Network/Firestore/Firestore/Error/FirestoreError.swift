import FirebaseFirestore

enum FirestoreError: GSError {
  case encodeError(from: String)
  case decodeError(from: String)
  case noDocument(from: String, document: DocumentSnapshot)
  case emptyCollection(from: String)
  case emptyQuery(from: String)
  case unknown(from: String)
}

extension FirestoreError {
  var errorDescription: String {
    switch self {
      case .encodeError(let from):
        return from + "인코딩에 실패했습니다."
        
      case .decodeError(let from):
        return from + "디코딩에 실패했습니다."
        
      case .noDocument(let from, let document):
        return from + "\(document.documentID) 문서를 찾을 수 없습니다."
        
      case .emptyCollection(let from):
        return from + "빈 컬렉션입니다."
        
      case .emptyQuery(let from):
        return from + "쿼리에 해당하는 문서를 찾을 수 없습니다."
        
      case .unknown(let from):
        return from + "정의되지 않은 오류입니다."
    }
  }
}
