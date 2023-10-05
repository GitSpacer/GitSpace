//
//  GSButton.swift
//  GSDesignSystem
//
//  Created by 원태영 on 10/5/23.
//

import SwiftUI

struct GSButton<Label: View>: View {
    
    enum Style {
        case primary(isDisabled: Bool)
        case secondary(isDisabled: Bool)
        case tag
        case plain
        case tab
    }
    
    let style: Style
    let action: () -> Void
    let label: Label
    
    init(
        style: Style,
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.style = style
        self.action = action
        self.label = label()
    }
    
    var body: some View {
        Button(action: action) {
            label
                .modifier(
                    GSButtonLabelModifier(style)
                )
        }
    }
private extension GSButton {
    struct GSButtonLabelModifier: ViewModifier {
        // MARK: -Property
        let style: Style
        
        // MARK: -Initializer
        init(_ style: Style) {
            self.style = style
        }
    }
}
}
