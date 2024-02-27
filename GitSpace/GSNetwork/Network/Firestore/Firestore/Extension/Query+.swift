import FirebaseFirestore

public extension Query {
  
  typealias FirestoreField = any FirestoreFieldProtocol
  
  func query(
    field: FirestoreField,
    operation: FirestoreQueryOperation
  ) -> Query {
    switch operation {
      case .lessThan(let value):
        return self.whereField(field.name, isLessThan: value)
        
      case .lessThanOrEqualTo(let value):
        return self.whereField(field.name, isLessThanOrEqualTo: value)
        
      case .equalTo(let value):
        return self.whereField(field.name, isEqualTo: value)
        
      case .greaterThan(let value):
        return self.whereField(field.name, isGreaterThan: value)
        
      case .greaterThanOrEqualTo(let value):
        return self.whereField(field.name, isGreaterThanOrEqualTo: value)
        
      case .arrayContains(let value):
        return self.whereField(field.name, arrayContains: value)
        
      case .in(let values):
        return self.whereField(field.name, in: values)
        
      case .arrayContainsAny(let values):
        return self.whereField(field.name, arrayContainsAny: values)
        
      case .orderBy(let type):
        return self.order(by: field.name, descending: type == .descending)
    }
  }
  
  func fetch<T: GSModel>() async throws -> [T] {
    
    let documents = try await self.getDocuments().documents
    
    let modelArray: [T] = try documents.map { try $0.data(as: T.self) }
    
    return modelArray
  }
}
