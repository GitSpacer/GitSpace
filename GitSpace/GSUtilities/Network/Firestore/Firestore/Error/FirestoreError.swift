import FirebaseFirestore

enum FirestoreError: Error {
  case encodeError
  case decodeError
  case noDocument(document: DocumentSnapshot)
  case emptyCollection
  case emptyQuery
  case unknown
}

extension FirestoreError {
  var errorDescription: String {
    switch self {
      case .encodeError:
        return "인코딩에 실패했습니다."
        
      case .decodeError:
        return "디코딩에 실패했습니다."
        
      case .noDocument(let document):
        return "\(document.documentID) 문서를 찾을 수 없습니다."
        
      case .emptyCollection:
        return "빈 컬렉션입니다."
        
      case .emptyQuery:
        return "쿼리에 해당하는 문서를 찾을 수 없습니다."
        
      case .unknown:
        return "정의되지 않은 오류입니다."
    }
  }
}

