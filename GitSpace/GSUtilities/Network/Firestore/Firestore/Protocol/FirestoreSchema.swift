//
//  FirestoreSchema.swift
//  GSUtilities
//
//  Created by 원태영 on 1/17/24.
//

protocol FirestoreSchema {
  var name: String { get }
}

extension FirestoreSchema where Self: RawRepresentable, Self.RawValue == String {
  /// String 원시값을 채택한 열거형 타입에서만 사용 가능합니다.
  /// - Author: 원태영
  var name: String {
    return self.rawValue
  }
}

