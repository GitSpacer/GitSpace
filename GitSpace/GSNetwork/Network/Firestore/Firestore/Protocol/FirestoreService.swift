import FirebaseFirestore

public protocol FirestoreService {
  func create<T: GSModel>(
    in collection: FirestoreCollection,
    with model: T
  ) throws
  
  func fetch<T: GSModel>(
    from collection: FirestoreCollection,
    at documentID: String
  ) async throws -> T
  
  func fetch<T: GSModel>(
    from collection: FirestoreCollection
  ) async throws -> [T]
  
  func fetch<T: GSModel, U: FirestoreFieldProtocol>(
    from collection: FirestoreCollection,
    where firestoreField: U,
    satisfies operation: FirestoreQueryOperation
  ) async throws -> [T]
  
  func update<T: GSModel, U: FirestoreFieldProtocol>(
    in collection: FirestoreCollection,
    with model: T,
    updating updateFields: [U]
  ) throws
  
  func delete(
    in collection: FirestoreCollection,
    at documentID: String
  )
}
