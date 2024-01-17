enum GSModelError: GSError {
  case castIDFailed(from: String)
}

extension GSModelError {
  var errorDescription: String {
    switch self {
      case .castIDFailed(let from):
        return from + "Identifiable에 정의된 ID 변환에 실패했습니다."
    }
  }
}
