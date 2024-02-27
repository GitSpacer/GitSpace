import FirebaseFirestore

public final class LiveFirestoreService: FirestoreService {
  
  // MARK: - Property
  private let firestore: Firestore
  
  // MARK: - Initializer
  public init(firestore: Firestore = .firestore()) {
    self.firestore = firestore
  }
}


// MARK: - Interface Method
extension LiveFirestoreService {
  
  /// 지정된 컬렉션에 모델을 생성합니다.
  /// - Parameters:
  ///   - in collection: 모델을 생성할 컬렉션입니다.
  ///   - with model: 저장할 모델의 인스턴스입니다.
  /// - Author: 원태영
  public func create<T: GSModel>(
    in collection: FirestoreCollection,
    with model: T
  ) throws {
    
    guard let docID = model.id as? String else {
      throw GSModelError.castIDFailed(from: #function)
    }
    
    let docRef: DocumentReference = getDocumentPath(from: collection, at: docID)
    
    try addDocument(at: docRef, with: model)
  }
  
  
  /// 지정된 컬렉션과 문서 ID를 사용하여 모델을 조회합니다.
  /// - Parameters:
  ///   - from collection: 조회할 컬렉션입니다.
  ///   - at documentID: 조회할 문서의 ID입니다.
  /// - Returns: 지정된 타입의 모델을 반환합니다.
  /// - Author: 원태영
  public func fetch<T: GSModel>(
    from collection: FirestoreCollection,
    at documentID: String
  ) async throws -> T {
    
    let docRef: DocumentReference = getDocumentPath(from: collection, at: documentID)
    
    let document: DocumentSnapshot = try await getDocument(at: docRef)
    
    let model: T = try document.data(as: T.self)
    
    return model
  }
  
  
  /// 지정된 컬렉션의 모든 문서를 조회합니다.
  /// - Parameters:
  ///   - from collection: 조회할 컬렉션입니다.
  /// - Returns: 해당 컬렉션의 모든 모델을 포함하는 배열을 반환합니다.
  /// - Author: 원태영
  public func fetch<T: GSModel>(
    from collection: FirestoreCollection
  ) async throws -> [T] {
    
    let colRef: CollectionReference = getCollectionPath(from: collection)
    
    let documents: [QueryDocumentSnapshot] = try await getDocuments(from: colRef)
    
    let modelArray: [T] = try documents.map { try $0.data(as: T.self) }
    
    return modelArray
  }
  
  
  /// 지정된 컬렉션에서 특정 조건을 만족하는 모든 문서를 조회합니다.
  /// - Parameters:
  ///   - from colRef: 조회할 컬렉션입니다.
  ///   - where query: 검사할 필드와 조건 오퍼레이션이 포함된 튜플 배열입니다.
  /// - Returns: 조건을 만족하는 모든 모델을 포함하는 배열을 반환합니다.
  /// - Author: 원태영
  public func fetch<T: GSModel>(
    from collection: FirestoreCollection,
    where query: WhereField
  ) async throws -> [T] {
    
    let colRef: CollectionReference = getCollectionPath(from: collection)
    
    let documents: [QueryDocumentSnapshot] = try await getDocuments(from: colRef, where: query)
    
    let modelArray: [T] = try documents.map { try $0.data(as: T.self) }
    
    return modelArray
  }
  
  
  /// 지정된 컬렉션의 모델을 업데이트합니다. 모델의 ID를 사용해서 문서를 조회합니다.
  /// - Parameters:
  ///   - in collection: 업데이트 모델이 위치한 컬렉션입니다.
  ///   - at model: 업데이트할 모델입니다.
  ///   - updating fields: 업데이트할 필드 리스트입니다.
  /// - Author: 원태영
  public func update<T: GSModel, U: FirestoreFieldProtocol>(
    in collection: FirestoreCollection,
    at model: T,
    updating fields: [U]
  ) throws {
    
    guard let docID = model.id as? String else {
      throw GSModelError.castIDFailed(from: #function)
    }
    
    let docRef: DocumentReference = getDocumentPath(from: collection, at: docID)
    
    let updatingFields: [String: Any] = makeFields(with: fields, to: model)
    
    updateDocument(at: docRef, with: updatingFields)
  }
  
  
  /// 지정된 컬렉션의 문서를 찾아서 삭제합니다.
  /// - Parameters:
  ///   - in collection: 삭제할 컬렉션입니다.
  ///   - at documentID: 삭제할 문서의 ID입니다.
  /// - Author: 원태영
  public func delete(
    in collection: FirestoreCollection,
    at documentID: String
  ) {
    
    let docRef: DocumentReference = getDocumentPath(from: collection, at: documentID)
    
    deleteDocument(at: docRef)
  }
}


// MARK: - Private

// MARK: - Get Path
extension LiveFirestoreService {
  
  /// 지정한 컬렉션의 경로를 반환합니다.
  /// - Parameter from collection: 경로를 검색할 Firestore 컬렉션입니다.
  /// - Returns: 지정된 컬렉션에 대한 CollectionReference를 반환합니다.
  /// - Author: 원태영
  public func getCollectionPath(from collection: FirestoreCollection) -> CollectionReference {
    
    return firestore
      .collection(collection.name)
  }
  
  
  /// 지정한 컬렉션에서 단일 문서 경로를 반환합니다.
  /// - Parameters:
  ///   - from collection: 문서 경로를 검색할 컬렉션입니다.
  ///   - at documentID: 검색할 문서의 ID입니다.
  /// - Returns: 지정된 문서에 대한 DocumentReference를 반환합니다.
  /// - Author: 원태영
  private func getDocumentPath(
    from collection: FirestoreCollection,
    at documentID: String
  ) -> DocumentReference {
    
    return firestore
      .collection(collection.name)
      .document(documentID)
  }
  
  
  /// 지정한 컬렉션의 하위 컬렉션 경로를 반환합니다.
  /// - Parameters:
  ///   - superCol superCollection: 상위 컬렉션입니다.
  ///   - superDoc superDocumentID: 상위 문서의 ID입니다.
  ///   - from subCollection: 하위 컬렉션입니다.
  /// - Returns: 하위 컬렉션에 대한 CollectionReference를 반환합니다.
  /// - Author: 원태영
  public func getCollectionPath(
    superCol superCollection: FirestoreCollection,
    superDoc superDocumentID: String,
    from subCollection: FirestoreCollection
  ) -> CollectionReference {
    
    return firestore
      .collection(superCollection.name)
      .document(superDocumentID)
      .collection(subCollection.name)
  }
  
  
  /// 지정한 컬렉션의 하위 컬렉션에서 단일 문서 경로를 반환합니다.
  /// - Parameters:
  ///   - superCol superCollection: 상위 컬렉션입니다.
  ///   - superDoc superDocumentID: 상위 문서의 ID입니다.
  ///   - from subCollection: 하위 컬렉션입니다.
  ///   - at subDocumentID: 하위 문서의 ID입니다.
  /// - Returns: 하위 문서에 대한 DocumentReference를 반환합니다.
  /// - Author: 원태영
  private func getDocumentPath(
    superCol superCollection: FirestoreCollection,
    superDoc superDocumentID: String,
    from subCollection: FirestoreCollection,
    at subDocumentID: String
  ) -> DocumentReference {
    
    return firestore
      .collection(superCollection.name)
      .document(superDocumentID)
      .collection(subCollection.name)
      .document(subDocumentID)
  }
}


// MARK: - Create
extension LiveFirestoreService {
  
  /// 지정한 경로에 새로운 단일 문서를 생성합니다.
  /// - Parameters:
  ///   - at docRef: 생성할 문서의 경로입니다.
  ///   - with model: 문서로 생성할 모델입니다.
  /// - Throws: 문서 생성 중 발생하는 오류를 방출합니다.
  /// - Author: 원태영
  private func addDocument<T: GSModel>(
    at docRef: DocumentReference,
    with model: T
  ) throws {
    
    try docRef.setData(from: model)
  }
}


// MARK: - Read_Query
extension LiveFirestoreService {
  
  /// 지정한 컬렉션에 쿼리를 적용한 경로를 반환합니다.
  /// - Parameters:
  ///   - from colRef: 쿼리를 생성할 컬렉션의 경로입니다.
  ///   - where field: 조건을 검사할 필드입니다.
  ///   - operation: 조건으로 적용할 쿼리 연산자입니다.
  /// - Returns: 생성된 Query 객체를 반환합니다.
  /// - Author: 원태영
  private func makeQuery(
    from colRef: CollectionReference,
    where field: any FirestoreFieldProtocol,
    operation: FirestoreQueryOperation
  ) -> Query {
    
    switch operation {
      case .lessThan(let value):
        return colRef.whereField(field.name, isLessThan: value)
        
      case .lessThanOrEqualTo(let value):
        return colRef.whereField(field.name, isLessThanOrEqualTo: value)
        
      case .equalTo(let value):
        return colRef.whereField(field.name, isEqualTo: value)
        
      case .greaterThan(let value):
        return colRef.whereField(field.name, isGreaterThan: value)
        
      case .greaterThanOrEqualTo(let value):
        return colRef.whereField(field.name, isGreaterThanOrEqualTo: value)
        
      case .arrayContains(let value):
        return colRef.whereField(field.name, arrayContains: value)
        
      case .in(let values):
        return colRef.whereField(field.name, in: values)
        
      case .arrayContainsAny(let values):
        return colRef.whereField(field.name, arrayContainsAny: values)
        
      case .orderBy(let type):
        return colRef.order(by: field.name, descending: type == .descending)
    }
  }
}


// MARK: - Read_Fetch
extension LiveFirestoreService {
  
  /// 지정한 경로의 단일 문서를 조회합니다.
  /// - Parameter at docRef: 조회할 문서의 경로입니다.
  /// - Returns: 조회된 DocumentSnapshot을 반환합니다.
  /// - Throws: 문서가 존재하지 않을 때 오류를 방출합니다.
  /// - Author: 원태영
  private func getDocument(at docRef: DocumentReference) async throws -> DocumentSnapshot {
    let document: DocumentSnapshot = try await docRef.getDocument()
    
    guard document.exists else {
      throw FirestoreError.noDocument(from: #function, document: document)
    }
    
    return document
  }
  
  
  /// 지정한 경로의 모든 문서를 조회합니다.
  /// - Parameter from colRef: 조회할 컬렉션의 경로입니다.
  /// - Returns: 조회된 문서들의 배열을 반환합니다.
  /// - Throws: 컬렉션이 비어있을 때 오류를 방출합니다.
  /// - Author: 원태영
  private func getDocuments(from colRef: CollectionReference) async throws -> [QueryDocumentSnapshot] {
    
    let snapshot: QuerySnapshot = try await colRef.getDocuments()
    
    guard snapshot.isEmpty == false else {
      throw FirestoreError.emptyCollection(from: #function)
    }
    
    return snapshot.documents
  }
  
  
  /// 지정한 경로에서 조건을 만족하는 모든 문서를 조회합니다.
  /// - Parameters:
  ///   - from colRef: 조회할 컬렉션의 경로입니다.
  ///   - where query: 검사할 필드와 조건 쿼리가 합쳐진 튜플입니다.
  /// - Returns: 조건을 만족하는 문서들의 배열을 반환합니다.
  /// - Throws: 쿼리 결과가 비어있을 때 오류를 방출합니다.
  /// - Author: 원태영
  private func getDocuments(
    from colRef: CollectionReference,
    where query: WhereField
  ) async throws -> [QueryDocumentSnapshot] {
    
    let query = makeQuery(from: colRef, where: query.field, operation: query.operation)
    
    let snapshot: QuerySnapshot = try await query.getDocuments()
    
    guard snapshot.isEmpty == false else {
      throw FirestoreError.emptyQuery(from: #function)
    }
    
    return snapshot.documents
  }
}


// MARK: - Update
extension LiveFirestoreService {
  
  /// 모델에서 업데이트 할 필드 딕셔너리를 추출해서 반환합니다.
  /// - Parameters:
  ///   - with fields: 업데이트할 필드들입니다.
  ///   - to model: 업데이트할 모델입니다.
  /// - Returns: 업데이트할 필드들의 딕셔너리를 반환합니다.
  /// - Author: 원태영
  private func makeFields<T: GSModel>(
    with fields: [any FirestoreFieldProtocol],
    to model: T
  ) -> [String: Any] {
    
    let fieldDictionary = model.asDictionary
    var updatingFields: [String: Any] = [:]
    
    fields.forEach { field in
      guard let value = fieldDictionary[field.name] else { return }
      
      updatingFields.updateValue(value, forKey: field.name)
    }
    
    return updatingFields
  }
  
  
  /// 지정한 경로의 단일 문서의 지정된 필드들을 업데이트합니다.
  /// - Parameters:
  ///   - at docRef: 업데이트할 문서의 경로입니다.
  ///   - with fields: 업데이트할 필드 딕셔너리입니다.
  /// - Author: 원태영
  private func updateDocument(
    at docRef: DocumentReference,
    with fields: [String: Any]
  ) {
    
    docRef.updateData(fields)
  }
}


// MARK: - Delete
extension LiveFirestoreService {
  
  /// 지정한 경로의 단일 문서를 삭제합니다.
  /// - Parameter at docRef: 삭제할 문서의 경로입니다.
  /// - Author: 원태영
  private func deleteDocument(at docRef: DocumentReference) {
    
    docRef.delete()
  }
}

