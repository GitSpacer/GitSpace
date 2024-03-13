import FirebaseFirestore

public protocol FirestoreService {
  
  /// 지정한 컬렉션의 경로를 반환합니다.
  /// - Parameter from collection: 경로를 검색할 Firestore 컬렉션입니다.
  /// - Returns: 지정된 컬렉션에 대한 CollectionReference를 반환합니다.
  /// - Author: 원태영
  func getCollectionPath(
    from collection: FirestoreCollection
  ) -> CollectionReference
  
  
  /// 지정한 컬렉션의 하위 컬렉션 경로를 반환합니다.
  /// - Parameters:
  ///   - superCol superCollection: 상위 컬렉션입니다.
  ///   - superDoc superDocumentID: 상위 문서의 ID입니다.
  ///   - from subCollection: 하위 컬렉션입니다.
  /// - Returns: 하위 컬렉션에 대한 CollectionReference를 반환합니다.
  /// - Author: 원태영
  func getCollectionPath(
    superCol superCollection: FirestoreCollection,
    superDoc superDocumentID: String,
    from subCollection: FirestoreCollection
  ) -> CollectionReference
  
  
  /// 지정된 컬렉션에 모델을 생성합니다.
  /// - Parameters:
  ///   - in collection: 모델을 생성할 컬렉션입니다.
  ///   - with model: 저장할 모델의 인스턴스입니다.
  /// - Author: 원태영
  func create<T: GSModel>(
    in collection: FirestoreCollection,
    with model: T
  ) throws
  
  /// 지정된 컬렉션에 모델을 생성합니다.
  /// - Parameters:
  ///   - superCol superCollection: 상위 컬렉션입니다.
  ///   - superDoc superDocumentID: 상위 문서의 ID입니다.
  ///   - in collection: 모델을 생성할 컬렉션입니다.
  ///   - with model: 저장할 모델의 인스턴스입니다.
  /// - Author: 원태영
  func create<T: GSModel>(
    superCol superCollection: FirestoreCollection,
    superDoc superDocumentID: String,
    in collection: FirestoreCollection,
    with model: T
  ) throws
  
  
  /// 지정된 컬렉션의 모든 문서를 조회합니다.
  /// - Parameters:
  ///   - from collection: 조회할 컬렉션입니다.
  /// - Returns: 해당 컬렉션의 모든 모델을 포함하는 배열을 반환합니다.
  /// - Author: 원태영
  func fetch<T: GSModel>(
    from collection: FirestoreCollection
  ) async throws -> [T]
  
  
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
  ///   - superCol superCollection: 상위 컬렉션입니다.
  ///   - superDoc superDocumentID: 상위 문서의 ID입니다.
  ///   - from collection: 조회할 컬렉션입니다.
  /// - Returns: 해당 컬렉션의 모든 모델을 포함하는 배열을 반환합니다.
  /// - Author: 원태영
  func fetch<T: GSModel>(
    superCol superCollection: FirestoreCollection,
    superDoc superDocumentID: String,
    from collection: FirestoreCollection
  ) async throws -> [T]
  
  
  /// 지정된 컬렉션과 문서 ID를 사용하여 모델을 조회합니다.
  /// - Parameters:
  ///   - superCol superCollection: 상위 컬렉션입니다.
  ///   - superDoc superDocumentID: 상위 문서의 ID입니다.
  ///   - from collection: 조회할 컬렉션입니다.
  ///   - at documentID: 조회할 문서의 ID입니다.
  /// - Returns: 지정된 타입의 모델을 반환합니다.
  /// - Author: 원태영
  func fetch<T: GSModel>(
    superCol superCollection: FirestoreCollection,
    superDoc superDocumentID: String,
    from collection: FirestoreCollection,
    at documentID: String
  ) async throws -> T
  
  
  /// 지정된 컬렉션에서 특정 조건을 만족하는 모든 문서를 조회합니다.
  /// - 단일 쿼리일 때 사용합니다. 복합 쿼리를 사용하시려면 getCollectionPath로 컬렉션 경로를 설정하고, .query 체이닝으로 원하는 조건을 설정한 뒤 .fetch를 호출해주세요.
  /// - Parameters:
  ///   - from colRef: 조회할 컬렉션입니다.
  ///   - where field: 조건을 적용할 필드입니다.
  ///   - by query: 조건으로 적용할 쿼리 연산자입니다.
  /// - Returns: 조건을 만족하는 모든 모델을 포함하는 배열을 반환합니다.
  /// - Author: 원태영
  func fetch<T: GSModel>(
    from collection: FirestoreCollection,
    where field: any FirestoreFieldProtocol,
    by query: FirestoreQueryOperation
  ) async throws -> [T]
  
  
  /// 지정된 컬렉션에서 특정 조건을 만족하는 모든 문서를 조회합니다.
  /// - 단일 쿼리일 때 사용합니다. 복합 쿼리를 사용하시려면 getCollectionPath로 컬렉션 경로를 설정하고, .query 체이닝으로 원하는 조건을 설정한 뒤 .fetch를 호출해주세요.
  /// - Parameters:
  ///   - superCol superCollection: 상위 컬렉션입니다.
  ///   - superDoc superDocumentID: 상위 문서의 ID입니다.
  ///   - from colRef: 조회할 컬렉션입니다.
  ///   - where field: 조건을 적용할 필드입니다.
  ///   - by query: 조건으로 적용할 쿼리 연산자입니다.
  /// - Returns: 조건을 만족하는 모든 모델을 포함하는 배열을 반환합니다.
  /// - Author: 원태영
  func fetch<T: GSModel>(
    superCol superCollection: FirestoreCollection,
    superDoc superDocumentID: String,
    from collection: FirestoreCollection,
    where field: any FirestoreFieldProtocol,
    by query: FirestoreQueryOperation
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
  
  
  /// 지정된 컬렉션의 모델을 업데이트합니다. 모델의 ID를 사용해서 문서를 조회합니다.
  /// - Parameters:
  ///   - superCol superCollection: 상위 컬렉션입니다.
  ///   - superDoc superDocumentID: 상위 문서의 ID입니다.
  ///   - in collection: 업데이트 모델이 위치한 컬렉션입니다.
  ///   - at model: 업데이트할 모델입니다.
  ///   - updating fields: 업데이트할 필드 리스트입니다.
  /// - Author: 원태영
  func update<T: GSModel, U: FirestoreFieldProtocol>(
    superCol superCollection: FirestoreCollection,
    superDoc superDocumentID: String,
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
  
  
  /// 지정된 컬렉션의 문서를 찾아서 삭제합니다.
  /// - Parameters:
  ///   - superCol superCollection: 상위 컬렉션입니다.
  ///   - superDoc superDocumentID: 상위 문서의 ID입니다.
  ///   - in collection: 삭제할 컬렉션입니다.
  ///   - at documentID: 삭제할 문서의 ID입니다.
  /// - Author: 원태영
  func delete(
    superCol superCollection: FirestoreCollection,
    superDoc superDocumentID: String,
    in collection: FirestoreCollection,
    at documentID: String
  )
}
