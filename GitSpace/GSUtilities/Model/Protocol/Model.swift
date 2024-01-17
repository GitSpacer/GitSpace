//
//  Model.swift
//  GSUtilities
//
//  Created by 원태영 on 1/12/24.
//

protocol GSModel: Codable, Identifiable {
  typealias Fields = [String: Any]
  
  var asDictionary: Fields { get }
}

extension GSModel {
  /**
   모델 구조체의 모든 프로퍼티를 key-value 딕셔너리로 변환해서 반환합니다.
   */
  var asDictionary: Fields {
    let mirror = Mirror(reflecting: self)
    var dictionary: Fields = [:]
    
    mirror.children.forEach { property in
      guard let key = property.label else { return }
      
      dictionary.updateValue(property.value, forKey: key)
    }
    
    return dictionary
  }
}
