//
//  HapticService.swift
//  GSUtilities
//
//  Created by 최한호 on 2024/01/17.
//

import Foundation
import SwiftUI

/**
 햅틱 피드백(진동)을 줄 때 사용합니다. 햅틱 종류를 선택하고 `.run()`을 통해 실행합니다.
 ```
 // 사용법
 HapticService.impact(.light).run()
 HapticService.notification(.success).run()
 HapticService.selection.run()
 ```
 - Parameters:
    - impact: 사용자와 상호작용 할 때 사용
        - light: 작은 사이즈의 버튼 탭과 같은 가벼운 UI
        - medium: 중간 사이즈의 switch 이동 같은 UI
        - heavy: 큰 사이즈의 UI
        - rigid: 유연하거나 거친 UI
        - soft: 부드러운 UI
    - notification: 작업의 성공이나 실패를 알릴 때 사용
        - success: 점점 강렬해지는 반응
        - warning: 점점 약해지는 반응
        - error: 여러 번 울리는 반응
    - selection: 사용자가 특정 UI를 탭한 경우, 데이터 값이 변경되고 있음을 알릴 때 사용
        - 종류는 한 개 뿐이며, 굉장히 짧은 지속시간과 약한 반응을 의미
 */
enum HapticService {
    case impact(UIImpactFeedbackGenerator.FeedbackStyle)
    case notification(UINotificationFeedbackGenerator.FeedbackType)
    case selection
    
    func run() {
        switch self {
        case let .impact(style):
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.prepare()
            generator.impactOccurred()
        case let .notification(type):
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
}
