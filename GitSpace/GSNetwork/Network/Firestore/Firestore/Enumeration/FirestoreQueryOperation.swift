public enum FirestoreQueryOperation {
  public enum SortType {
    case ascending
    case descending
  }
  
  /// 지정된 값보다 작은 값을 가진 문서를 반환합니다.
  case lessThan(value: Any)

  /// 지정된 값보다 작거나 같은 값을 가진 문서를 반환합니다.
  case lessThanOrEqualTo(value: Any)

  /// 지정된 값과 동일한 값을 가진 문서를 반환합니다.
  case equalTo(value: Any)

  /// 지정된 값보다 큰 값을 가진 문서를 반환합니다.
  case greaterThan(value: Any)

  /// 지정된 값보다 크거나 같은 값을 가진 문서를 반환합니다.
  case greaterThanOrEqualTo(value: Any)

  /// 배열 필드에 지정된 값을 포함하는 문서를 반환합니다.
  case arrayContains(value: Any)

  /// 지정된 값들 중 하나와 일치하는 필드 값을 가진 문서를 반환합니다.
  case `in`(values: [Any])

  /// 배열 필드에 지정된 값들 중 하나 이상을 포함하는 문서를 반환합니다.
  case arrayContainsAny(values: [Any])

  /// 지정된 필드를 기준으로 문서를 정렬합니다. `SortType`은 오름차순 또는 내림차순 정렬을 지정합니다.
  case orderBy(type: SortType)
}
