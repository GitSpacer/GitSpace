import FirebaseFirestore

public protocol FirestoreService {
  
  typealias WhereField = (field: any FirestoreFieldProtocol, operation: FirestoreQueryOperation)
  
  /// 지정된 컬렉션에 모델을 생성합니다.
  /// - Parameters:
  ///   - in collection: 모델을 생성할 컬렉션입니다.
  ///   - with model: 저장할 모델의 인스턴스입니다.
  /// - Author: 원태영
  func create<T: GSModel>(
    in collection: FirestoreCollection,
    with model: T
  ) throws
  
  
  /// 지정된 컬렉션과 문서 ID를 사용하여 모델을 조회합니다.
  /// - Parameters:
  ///   - from collection: 조회할 컬렉션입니다.
  ///   - at documentID: 조회할 문서의 ID입니다.
  /// - Returns: 지정된 타입의 모델을 반환합니다.
  /// - Author: 원태영
  func fetch<T: GSModel>(
    from collection: FirestoreCollection,
    at documentID: String
  ) async throws -> T
  
  
  /// 지정된 컬렉션의 모든 문서를 조회합니다.
  /// - Parameters:
  ///   - from collection: 조회할 컬렉션입니다.
  /// - Returns: 해당 컬렉션의 모든 모델을 포함하는 배열을 반환합니다.
  /// - Author: 원태영
  func fetch<T: GSModel>(
    from collection: FirestoreCollection
  ) async throws -> [T]
  
  
  /// 지정된 컬렉션에서 특정 조건을 만족하는 모든 문서를 조회합니다.
  /// - Parameters:
  ///   - from colRef: 조회할 컬렉션입니다.
  ///   - where query: 검사할 필드와 조건 쿼리가 합쳐진 가변 튜플입니다.
  /// - Returns: 조건을 만족하는 모든 모델을 포함하는 배열을 반환합니다.
  /// - Author: 원태영
  func fetch<T: GSModel>(
    from collection: FirestoreCollection,
    where query: WhereField...
  ) async throws -> [T]
  
  
  /// 지정된 컬렉션의 모델을 업데이트합니다. 모델의 ID를 사용해서 문서를 조회합니다.
  /// - Parameters:
  ///   - in collection: 업데이트 모델이 위치한 컬렉션입니다.
  ///   - at model: 업데이트할 모델입니다.
  ///   - updating fields: 업데이트할 필드 리스트입니다.
  /// - Author: 원태영
  func update<T: GSModel, U: FirestoreFieldProtocol>(
    in collection: FirestoreCollection,
    at model: T,
    updating fields: [U]
  ) throws
  
  
  /// 지정된 컬렉션의 문서를 찾아서 삭제합니다.
  /// - Parameters:
  ///   - in collection: 삭제할 컬렉션입니다.
  ///   - at documentID: 삭제할 문서의 ID입니다.
  /// - Author: 원태영
  func delete(
    in collection: FirestoreCollection,
    at documentID: String
  )
}
