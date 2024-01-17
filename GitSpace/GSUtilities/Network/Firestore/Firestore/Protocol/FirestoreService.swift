import FirebaseFirestore

protocol FirestoreService {
  func create<T: GSModel>(
    col collection: FirestoreCollection,
    model: T
  ) throws
  
  func fetch<T: GSModel>(
    col collection: FirestoreCollection,
    docID documentID: String
  ) async throws -> T
  
  func fetch<T: GSModel>(
    col collection: FirestoreCollection
  ) async throws -> [T]
  
  func fetch<T: GSModel, U: FirestoreFieldProtocol>(
    col collection: FirestoreCollection,
    field firestoreField: U,
    operation: FirestoreQueryOperation
  ) async throws -> [T]
  
  func update<T: GSModel, U: FirestoreFieldProtocol>(
    col collection: FirestoreCollection,
    model: T,
    updateFields: [U]
  ) throws
  
  func delete(
    col colledtion: FirestoreCollection,
    docID documentID: String
  )
}

