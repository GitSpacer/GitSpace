//
//  GSButton.swift
//  GSDesignSystem
//
//  Created by 원태영 on 10/5/23.
//

import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

extension Color {
    static let gsGreenPrimary: Color = .init(hex: "#BDFF01")
    static let gsGreenSecondary: Color = .init(hex: "#E0FF66")
    static let gsYellow: Color = .init(hex: "#FAFF10")
    static let gsGray1: Color = .init(hex: "#8D8F97")
    static let gsRed: Color = .init(hex: "#FF6C2E")
}

struct GSButton<Label: View>: View {
    enum Style {
        case primary(state: AbleState)
        case secondary(state: AbleState)
        case tag(state: TagState)
        case plain
        case tab
        
        enum AbleState {
            case enabled
            case disabled
        }
        
        enum TagState {
            case idle
            case editing(activityState: ActivityState)
            case selected
            
            enum ActivityState {
                case active
                case inactive
            }
        }
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
}

// MARK: -Modifier Extension
private extension GSButton {
    struct GSButtonLabelModifier: ViewModifier {
        let style: Style
        
        init(_ style: Style) {
            self.style = style
        }
        
        func body(content: Content) -> some View {
            switch style {
            case let .primary(ableState):
                content
                    .font(
                        .system(size: 14, weight: .semibold)
                    )
                    .foregroundColor(.black)
                    .padding(.horizontal, 34)
                    .padding(.vertical, 18)
                    .frame(minWidth: 150)
                    .background(Color.gsGreenPrimary)
                    .cornerRadius(30)
                    .overlay {
                        if ableState == .disabled { Color.clear }
                    }
                
            case let .secondary(ableState):
                content
                    .font(
                        .system(size: 14, weight: .semibold)
                    )
//                    .foregroundColor(state == .enabled ? .white : .black)
                    .padding(.horizontal, 23)
                    .padding(.vertical, 13)
                    .frame(minWidth: 80)
//                    .background(isDisabled ? Color.gsGray1 : Color.gsGreenPrimary)
                    .cornerRadius(20)
                    .overlay {
                        if ableState == .disabled { Color.clear }
                    }
                
            case .tag:
                content
                
            case .plain:
                content
                
            case .tab:
                content
                
            }
        }
    }
    
    struct GSButtonLabelForegroundColorModifier: ViewModifier {
        let style: Style
        @Environment(\.colorScheme) var colorScheme
        
        init(style: Style) {
            self.style = style
        }
        
        func body(content: Content) -> some View {
            switch style {
            case .primary:
                content
                    .foregroundColor(.black)
                
            case let .secondary(ableState):
                switch ableState {
                case .enabled:
                    content
                        .foregroundColor(.black)
                    
                case .disabled:
                    content
                        .foregroundColor(.white)
                }
                
            case let .tag(tagState):
                switch tagState {
                case .idle:
                    content
                        .foregroundColor(.white)
                    
                case let .editing(activityState):
                    switch (colorScheme, activityState) {
                    case (.light, .active):
                        content
                            .foregroundColor(.white)
                        
                    case (.light, .inactive):
                        content
                            .foregroundStyle(.black)
                        
                    case (.dark, _):
                        content
                            .foregroundColor(.primary)
                        
                    @unknown default:
                        content
                    }
                    
                case .selected:
                    content.foregroundColor(.black)
                }
                
            case .plain:
                content
                
            case .tab:
                content
                
            }
        }
    }
}

// MARK: -Preview
struct GSButton_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
