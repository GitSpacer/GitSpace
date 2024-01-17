import FirebaseFirestore

public final class LiveFirestoreService: FirestoreService {
  // MARK: - Property
  private let firestore: Firestore
  
  // MARK: - Initializer
  init(firestore: Firestore = .firestore()) {
    self.firestore = firestore
  }
}

// MARK: - Interface Method
extension LiveFirestoreService {
  /**
   지정된 모델을 컬렉션 경로에 새로운 문서로 추가합니다.
   - Author: 원태영
   - parameter col: 문서를 추가할 컬렉션입니다.
   - parameter model: 문서의 내용이 되는 모델입니다.
   - Returns:
   */
  public func create<T: GSModel>(
    col collection: FirestoreCollection,
    model: T
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
  
  /**
   지정된 컬렉션 경로와 문서 ID를 사용하여 모델을 조회합니다.
   - Author: 원태영
   - parameter col: 조회할 컬렉션입니다.
   - parameter docID: 조회할 문서의 ID입니다.
   - Returns: 지정된 타입의 모델을 반환합니다.
   */
  public func fetch<T: GSModel>(
    col collection: FirestoreCollection,
    docID documentID: String
  ) async throws -> T {
    let path: DocumentReference = getDocumentPath(
      col: collection,
      docID: documentID
    )
    
    let document: DocumentSnapshot = try await getDocument(docPath: path)
    
    let model: T = try document.data(as: T.self)
    
    return model
  }
  
  /**
   지정된 컬렉션에 있는 모든 문서를 조회하여 모델의 배열로 반환합니다.
   - Author: 원태영
   - parameter col: 조회할 컬렉션입니다.
   - Returns: 지정된 타입의 모델 배열을 반환합니다.
   */
  public func fetch<T: GSModel>(
    col collection: FirestoreCollection
  ) async throws -> [T] {
    let path: CollectionReference = getCollectionPath(col: collection)
    
    let documents: [QueryDocumentSnapshot] = try await getDocuments(colPath: path)
    
    let modelArray: [T] = try documents.map { document in
      try document.data(as: T.self)
    }
    
    return modelArray
  }
  
  public func fetch<T: GSModel, U: FirestoreFieldProtocol>(
    col collection: FirestoreCollection,
    field firestoreField: U,
    operation: FirestoreQueryOperation
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
  
  public func update<T: GSModel, U: FirestoreFieldProtocol>(
    col collection: FirestoreCollection,
    model: T,
    updateFields: [U]
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
  
  public func delete(
    col colledtion: FirestoreCollection,
    docID documentID: String
  ) {
    let path: DocumentReference = getDocumentPath(
      col: colledtion,
      docID: documentID
    )
    
    deleteDocument(docPath: path)
  }
}


// MARK: - Private
extension LiveFirestoreService {
  // MARK: - Path
  private func getCollectionPath(col collection: FirestoreCollection) -> CollectionReference {
    return firestore
      .collection(collection.name)
  }
  
  private func getDocumentPath(
    col collection: FirestoreCollection,
    docID documentID: String
  ) -> DocumentReference {
    return firestore
      .collection(collection.name)
      .document(documentID)
  }
  
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
  
  // MARK: - Create
  private func addDocument<T: GSModel>(
    docPath documentPath: DocumentReference,
    model: T
  ) throws {
    try documentPath.setData(from: model)
  }
  
  // MARK: - Read
  private func makeQuery(
    _ collectionPath: CollectionReference,
    field: any FirestoreFieldProtocol,
    operation: FirestoreQueryOperation
  ) -> Query {
    switch operation {
      case .lessThan(let value):
        return collectionPath.whereField(
          field.name,
          isLessThan: value
        )
        
      case .lessThanOrEqualTo(let value):
        return collectionPath.whereField(
          field.name,
          isLessThanOrEqualTo: value
        )
        
      case .equalTo(let value):
        return collectionPath.whereField(
          field.name,
          isEqualTo: value
        )
        
      case .greaterThan(let value):
        return collectionPath.whereField(
          field.name,
          isGreaterThan: value
        )
        
      case .greaterThanOrEqualTo(let value):
        return collectionPath.whereField(
          field.name,
          isGreaterThanOrEqualTo: value
        )
        
      case .arrayContains(let value):
        return collectionPath.whereField(
          field.name,
          arrayContains: value
        )
        
      case .in(let values):
        return collectionPath.whereField(
          field.name,
          in: values
        )
        
      case .arrayContainsAny(let values):
        return collectionPath.whereField(
          field.name,
          arrayContainsAny: values
        )
        
      case .orderBy(let type):
        return collectionPath.order(
          by: field.name,
          descending: type == .descending ? true : false
        )
    }
  }
  
  private func getDocument(docPath documentPath: DocumentReference) async throws -> DocumentSnapshot {
    let document: DocumentSnapshot = try await documentPath.getDocument()
    
    guard document.exists else {
      throw FirestoreError.noDocument(from: #function, document: document)
    }
    
    return document
  }
  
  private func getDocuments(colPath collectionPath: CollectionReference) async throws -> [QueryDocumentSnapshot] {
    let snapshot: QuerySnapshot = try await collectionPath.getDocuments()
    
    guard snapshot.isEmpty == false else {
      throw FirestoreError.emptyCollection(from: #function)
    }
    
    return snapshot.documents
  }
  
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
  
  // MARK: - Update
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
  
  private func updateDocument(
    docPath: DocumentReference,
    fields: [String: Any]
  ) {
    docPath.updateData(fields)
  }

  // MARK: - Delete
  private func deleteDocument(docPath: DocumentReference) {
    docPath.delete()
  }
}

