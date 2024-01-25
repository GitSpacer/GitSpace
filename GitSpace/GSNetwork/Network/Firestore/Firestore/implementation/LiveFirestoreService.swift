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
  ///   - collection: 모델을 생성할 컬렉션입니다.
  ///   - model: 저장할 모델의 인스턴스입니다.
  /// - Author: 원태영
  public func create<T: GSModel>(
    in collection: FirestoreCollection,
    with model: T
  ) throws {
    
    guard let id = model.id as? String else {
      throw GSModelError.castIDFailed(from: #function)
    }
    
    let docPath: DocumentReference = getDocumentPath(
      col: collection,
      docID: id
    )
    
    try addDocument(
      docPath: docPath,
      model: model
    )
  }
  
  /// 지정된 컬렉션과 문서 ID를 사용하여 모델을 조회합니다.
  /// - Parameters:
  ///   - collection: 조회할 컬렉션입니다.
  ///   - documentID: 조회할 문서의 ID입니다.
  /// - Returns: 지정된 타입의 모델을 반환합니다.
  /// - Author: 원태영
  public func fetch<T: GSModel>(
    from collection: FirestoreCollection,
    at documentID: String
  ) async throws -> T {
    
    let path: DocumentReference = getDocumentPath(
      col: collection,
      docID: documentID
    )
    
    let document: DocumentSnapshot = try await getDocument(docPath: path)
    
    let model: T = try document.data(as: T.self)
    
    return model
  }
  
  /// 지정된 컬렉션의 모든 문서를 조회합니다.
  /// - Parameters:
  ///   - collection: 조회할 컬렉션입니다.
  /// - Returns: 해당 컬렉션의 모든 모델을 포함하는 배열을 반환합니다.
  /// - Author: 원태영
  public func fetch<T: GSModel>(
    from collection: FirestoreCollection
  ) async throws -> [T] {
    
    let path: CollectionReference = getCollectionPath(col: collection)
    
    let documents: [QueryDocumentSnapshot] = try await getDocuments(colPath: path)
    
    let modelArray: [T] = try documents.map { document in
      try document.data(as: T.self)
    }
    
    return modelArray
  }
  
  /// 지정된 컬렉션에서 특정 조건을 만족하는 모든 문서를 조회합니다.
  /// - Parameters:
  ///   - collection: 조회할 컬렉션입니다.
  ///   - firestoreField: 조건을 검사할 필드입니다.
  ///   - operation: 조건으로 사용되는 연산자 케이스입니다.
  /// - Returns: 조건을 만족하는 모든 모델을 포함하는 배열을 반환합니다.
  /// - Author: 원태영
  public func fetch<T: GSModel, U: FirestoreFieldProtocol>(
    from collection: FirestoreCollection,
    where firestoreField: U,
    satisfies operation: FirestoreQueryOperation
  ) async throws -> [T] {
    
    let path: CollectionReference = getCollectionPath(col: collection)
    
    let documents: [QueryDocumentSnapshot] = try await getDocuments(
      colPath: path,
      field: firestoreField,
      operation: operation
    )
    
    let modelArray: [T] = try documents.map { document in
      try document.data(as: T.self)
    }
    
    return modelArray
  }
  
  /// 지정된 컬렉션의 모델을 업데이트합니다. model의 ID를 사용해서 문서를 조회합니다.
  /// - Parameters:
  ///   - collection: 업데이트할 컬렉션입니다.
  ///   - model: 업데이트할 모델의 인스턴스입니다.
  ///   - updateFields: 업데이트할 필드의 배열입니다.
  /// - Author: 원태영
  public func update<T: GSModel, U: FirestoreFieldProtocol>(
    in collection: FirestoreCollection,
    with model: T,
    updating updateFields: [U]
  ) throws {
    
    guard let id = model.id as? String else {
      throw GSModelError.castIDFailed(from: #function)
    }
    
    let path: DocumentReference = getDocumentPath(
      col: collection,
      docID: id
    )
    
    let fields: [String: Any] = makeFields(
      updateFields: updateFields,
      model: model
    )
    
    updateDocument(
      docPath: path,
      fields: fields
    )
  }
  
  /// 지정된 컬렉션의 문서를 찾아서 삭제합니다.
  /// - Parameters:
  ///   - collection: 삭제할 컬렉션입니다.
  ///   - documentID: 삭제할 문서의 ID입니다.
  /// - Author: 원태영
  public func delete(
    in collection: FirestoreCollection,
    at documentID: String
  ) {
    
    let path: DocumentReference = getDocumentPath(
      col: collection,
      docID: documentID
    )
    
    deleteDocument(docPath: path)
  }
}


// MARK: - Private

// MARK: - Get Path
extension LiveFirestoreService {
  
  /// 지정한 컬렉션의 경로를 반환합니다.
  /// - Parameter collection: 경로를 검색할 Firestore 컬렉션입니다.
  /// - Returns: 지정된 컬렉션에 대한 CollectionReference를 반환합니다.
  /// - Author: 원태영
  private func getCollectionPath(col collection: FirestoreCollection) -> CollectionReference {
    
    return firestore
      .collection(collection.name)
  }
  
  /// 지정한 컬렉션에서 단일 문서 경로를 반환합니다.
  /// - Parameters:
  ///   - collection: 문서 경로를 검색할 컬렉션입니다.
  ///   - documentID: 검색할 문서의 ID입니다.
  /// - Returns: 지정된 문서에 대한 DocumentReference를 반환합니다.
  /// - Author: 원태영
  private func getDocumentPath(
    col collection: FirestoreCollection,
    docID documentID: String
  ) -> DocumentReference {
    
    return firestore
      .collection(collection.name)
      .document(documentID)
  }
  
  /// 지정한 컬렉션의 하위 컬렉션 경로를 반환합니다.
  /// - Parameters:
  ///   - superCollection: 상위 컬렉션입니다.
  ///   - superDocumentID: 상위 문서의 ID입니다.
  ///   - subCollection: 하위 컬렉션입니다.
  /// - Returns: 하위 컬렉션에 대한 CollectionReference를 반환합니다.
  /// - Author: 원태영
  private func getCollectionPath(
    supCol superCollection: FirestoreCollection,
    supDocID superDocumentID: String,
    subCol subCollection: FirestoreCollection
  ) -> CollectionReference {
    
    return firestore
      .collection(superCollection.name)
      .document(superDocumentID)
      .collection(subCollection.name)
  }
  
  /// 지정한 컬렉션의 하위 컬렉션에서 단일 문서 경로를 반환합니다.
  /// - Parameters:
  ///   - superCollection: 상위 컬렉션입니다.
  ///   - superDocumentID: 상위 문서의 ID입니다.
  ///   - subCollection: 하위 컬렉션입니다.
  ///   - subDocumentID: 하위 문서의 ID입니다.
  /// - Returns: 하위 문서에 대한 DocumentReference를 반환합니다.
  /// - Author: 원태영
  private func getDocumentPath(
    supCol superCollection: FirestoreCollection,
    supDocID superDocumentID: String,
    subCol subCollection: FirestoreCollection,
    subDocID subDocumentID: String
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
  ///   - documentPath: 생성할 문서의 경로입니다.
  ///   - model: Firestore에 저장할 모델입니다.
  /// - Throws: 문서 생성 중 발생하는 오류를 방출합니다.
  /// - Author: 원태영
  private func addDocument<T: GSModel>(
    docPath documentPath: DocumentReference,
    model: T
  ) throws {
    
    try documentPath.setData(from: model)
  }
}

// MARK: - Read_Query
extension LiveFirestoreService {
  
  /// 지정한 컬렉션에 쿼리를 적용한 경로를 반환합니다.
  /// - Parameters:
  ///   - collectionPath: 쿼리를 생성할 컬렉션의 경로입니다.
  ///   - field: 조건을 검사할 필드입니다.
  ///   - operation: 조건으로 적용할 쿼리 연산자입니다.
  /// - Returns: 생성된 Query 객체를 반환합니다.
  /// - Author: 원태영
  private func makeQuery(
    _ collectionPath: CollectionReference,
    field: any FirestoreFieldProtocol,
    operation: FirestoreQueryOperation
  ) -> Query {
    
    switch operation {
      case .lessThan(let value):
        return collectionPath.whereField(field.name, isLessThan: value)
        
      case .lessThanOrEqualTo(let value):
        return collectionPath.whereField(field.name, isLessThanOrEqualTo: value)
        
      case .equalTo(let value):
        return collectionPath.whereField(field.name, isEqualTo: value)
        
      case .greaterThan(let value):
        return collectionPath.whereField(field.name, isGreaterThan: value)
        
      case .greaterThanOrEqualTo(let value):
        return collectionPath.whereField(field.name, isGreaterThanOrEqualTo: value)
        
      case .arrayContains(let value):
        return collectionPath.whereField(field.name, arrayContains: value)
        
      case .in(let values):
        return collectionPath.whereField(field.name, in: values)
        
      case .arrayContainsAny(let values):
        return collectionPath.whereField(field.name, arrayContainsAny: values)
        
      case .orderBy(let type):
        return collectionPath.order(by: field.name, descending: type == .descending)
    }
  }
}

// MARK: - Read_Fetch
extension LiveFirestoreService {
  
  /// 지정한 경로의 단일 문서를 조회합니다.
  /// - Parameter documentPath: 조회할 문서의 경로입니다.
  /// - Returns: 조회된 DocumentSnapshot을 반환합니다.
  /// - Throws: 문서가 존재하지 않을 때 오류를 방출합니다.
  /// - Author: 원태영
  private func getDocument(docPath documentPath: DocumentReference) async throws -> DocumentSnapshot {
    let document: DocumentSnapshot = try await documentPath.getDocument()
    
    guard document.exists else {
      throw FirestoreError.noDocument(from: #function, document: document)
    }
    
    return document
  }
  
  /// 지정한 경로의 모든 문서를 조회합니다.
  /// - Parameter collectionPath: 조회할 컬렉션의 경로입니다.
  /// - Returns: 조회된 문서들의 배열을 반환합니다.
  /// - Throws: 컬렉션이 비어있을 때 오류를 방출합니다.
  /// - Author: 원태영
  private func getDocuments(colPath collectionPath: CollectionReference) async throws -> [QueryDocumentSnapshot] {
    
    let snapshot: QuerySnapshot = try await collectionPath.getDocuments()
    
    guard snapshot.isEmpty == false else {
      throw FirestoreError.emptyCollection(from: #function)
    }
    
    return snapshot.documents
  }
  
  /// 지정한 경로에서 조건을 만족하는 모든 문서를 조회합니다.
  /// - Parameters:
  ///   - collectionPath: 조회할 컬렉션의 경로입니다.
  ///   - field: 조건을 검사할 필드입니다.
  ///   - operation: 조건으로 적용할 쿼리 연산자입니다.
  /// - Returns: 조건을 만족하는 문서들의 배열을 반환합니다.
  /// - Throws: 쿼리 결과가 비어있을 때 오류를 방출합니다.
  /// - Author: 원태영
  private func getDocuments(
    colPath collectionPath: CollectionReference,
    field: any FirestoreFieldProtocol,
    operation: FirestoreQueryOperation
  ) async throws -> [QueryDocumentSnapshot] {
    
    let query: Query = makeQuery(
      collectionPath,
      field: field,
      operation: operation
    )
    
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
  ///   - updateFields: 업데이트할 필드들입니다.
  ///   - model: 업데이트할 모델입니다.
  /// - Returns: 업데이트할 필드들의 딕셔너리를 반환합니다.
  /// - Author: 원태영
  private func makeFields<T: GSModel>(
    updateFields: [any FirestoreFieldProtocol],
    model: T
  ) -> [String: Any] {
    
    let fieldDictionary = model.asDictionary
    var fields: [String: Any] = [:]
    
    updateFields.forEach { field in
      guard let value = fieldDictionary[field.name] else { return }
      
      fields.updateValue(value, forKey: field.name)
    }
    
    return fields
  }
  
  /// 지정한 경로의 단일 문서의 지정된 필드들을 업데이트합니다.
  /// - Parameters:
  ///   - docPath: 업데이트할 문서의 경로입니다.
  ///   - fields: 업데이트할 필드들입니다.
  /// - Author: 원태영
  private func updateDocument(
    docPath: DocumentReference,
    fields: [String: Any]
  ) {
    
    docPath.updateData(fields)
  }
}


// MARK: - Delete
extension LiveFirestoreService {
  
  /// 지정한 경로의 단일 문서를 삭제합니다.
  /// - Parameter docPath: 삭제할 문서의 경로입니다.
  /// - Author: 원태영
  private func deleteDocument(docPath: DocumentReference) {
    
    docPath.delete()
  }
}

