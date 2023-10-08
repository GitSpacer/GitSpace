//
//  GSButton.swift
//  GSDesignSystem
//
//  Created by 원태영 on 10/5/23.
//

import SwiftUI

struct GSButton<Label: View>: View {
    enum Style {
        case primary(ableState: AbleState)
        case secondary(ableState: AbleState)
        case tag(tagState: TagState)
        case plain(destructiveState: DestructiveState)
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
        
        enum DestructiveState {
            case idle
            case destructive
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
        .overlay {
            switch style {
            case .primary(ableState: .disabled), .secondary(ableState: .disabled):
                Capsule()
                    .fill(Color.white.opacity(0.1))
                
            case .tag(tagState: .editing(activityState: .inactive)):
                Capsule()
                    .stroke(Color.primary, lineWidth: 2)
            
            default:
                EmptyView()
            }
        }
    }
}

// MARK: - Label Modifier
private extension GSButton {
    struct GSButtonLabelModifier: ViewModifier {
        let style: Style
        
        init(_ style: Style) {
            self.style = style
        }
        
        func body(content: Content) -> some View {
            switch style {
            case .primary:
                content
                    .font(
                        .system(size: 14, weight: .semibold)
                    )
                    .padding(.horizontal, 34)
                    .padding(.vertical, 18)
                    .frame(minWidth: 150)
                    .modifier(GSButtonLabelColorModifier(style))
                    .cornerRadius(30)
                
            case .secondary:
                content
                    .font(
                        .system(size: 14, weight: .semibold)
                    )
                    .padding(.horizontal, 23)
                    .padding(.vertical, 13)
                    .frame(minWidth: 80)
                    .modifier(GSButtonLabelColorModifier(style))
                    .cornerRadius(20)
                
            case .tag:
                content
                    .font(
                        .system(size: 16, weight: .regular)
                    )
                    .padding(.horizontal, 12)
                    .padding(.vertical, 9)
                    .frame(minWidth: 62)
                    .modifier(GSButtonLabelColorModifier(style))
                    .cornerRadius(20)
                
            case .plain:
                content
                    .font(
                        .system(size: 16, weight: .medium)
                    )
                    .modifier(GSButtonLabelColorModifier(style))
                
            case .tab:
                content
                    .font(
                        .system(size: 20, weight: .medium)
                    )
                    .modifier(GSButtonLabelColorModifier(style))
            }
        }
    }
}

// MARK: - Foreground + Background Color Modifier
extension GSButton.GSButtonLabelModifier {
    struct GSButtonLabelColorModifier: ViewModifier {
        let style: GSButton.Style
        @Environment(\.colorScheme) var colorScheme
        
        init(_ style: GSButton.Style) {
            self.style = style
        }
        
        func body(content: Content) -> some View {
            switch colorScheme {
            case .light:
                switch style {
                case .primary:
                    content
                        .foregroundColor(.black)
                        .background(Color.gsGreenPrimary)
                    
                case let .secondary(ableState):
                    switch ableState {
                    case .enabled:
                        content
                            .foregroundColor(.black)
                            .background(Color.gsGreenPrimary)
                        
                    case .disabled:
                        content
                            .foregroundColor(.white)
                            .background(Color.gsGray1)
                    }
                    
                case let .tag(tagState):
                    switch tagState {
                    case .idle:
                        content
                            .foregroundColor(.white)
                            .background(Color.black)
                        
                    case let .editing(activityState):
                        switch activityState {
                        case .active:
                            content
                                .foregroundColor(.white)
                                .background(Color.black)
                            
                        case .inactive:
                            content
                                .foregroundColor(.black)
                                .background(Color.white)
                        }
                        
                    case .selected:
                        content
                            .foregroundColor(.black)
                            .background(Color.gsGreenPrimary)
                    }
                    
                case let .plain(destructiveState):
                    switch destructiveState {
                    case .idle:
                        content
                            .foregroundColor(.black)
                        
                    case .destructive:
                        content
                            .foregroundColor(.gsRed)
                    }
                    
                case .tab:
                    content
                        .foregroundColor(.black)
                }
                
            case .dark:
                switch style {
                case .primary:
                    content
                        .foregroundColor(.black)
                        .background(Color.gsYellow)
                    
                case let .secondary(ableState):
                    switch ableState {
                    case .enabled:
                        content
                            .foregroundColor(.black)
                            .background(Color.gsYellow)
                        
                    case .disabled:
                        content
                            .foregroundColor(.white)
                            .background(Color.gsGray1)
                    }
                    
                case let .tag(tagState):
                    switch tagState {
                    case .idle:
                        content
                            .foregroundColor(.white)
                            .background(Color.gsGray2)
                        
                    case let .editing(activityState):
                        switch activityState {
                        case .active:
                            content
                                .foregroundColor(.black)
                                .background(Color.white)
                            
                        case .inactive:
                            content
                                .foregroundColor(.white)
                                .background(Color.black)
                        }
                        
                    case .selected:
                        content
                            .foregroundColor(.black)
                            .background(Color.gsYellow)
                    }
                    
                    
                case let .plain(destructiveState):
                    switch destructiveState {
                    case .idle:
                        content
                            .foregroundColor(.white)
                        
                    case .destructive:
                        content
                            .foregroundColor(.gsRed)
                    }
                    
                case .tab:
                    content
                        .foregroundColor(.white)
                }
                
            @unknown default:
                content
                    .foregroundColor(.primary)
            }
        }
    }
}

// MARK: - Hexa Color
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

// MARK: - Custom Color Constant
extension Color {
    static let gsGreenPrimary: Color = .init(hex: "#BDFF01")
    static let gsGreenSecondary: Color = .init(hex: "#E0FF66")
    static let gsYellow: Color = .init(hex: "#FAFF10")
    static let gsGray1: Color = .init(hex: "#8D8F97")
    static let gsGray2: Color = .init(hex: "#27292E")
    static let gsRed: Color = .init(hex: "#FF6C2E")
}

// MARK: -Preview
struct GSButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GSButton(style: .primary(ableState: .enabled)) {

            } label: {
                Text("Primary Enabled")
            }
            GSButton(style: .primary(ableState: .disabled)) {

            } label: {
                Text("Primary Disabled")
            }
            GSButton(style: .secondary(ableState: .enabled)) {

            } label: {
                Text("Secondary Enabled")
            }
            GSButton(style: .secondary(ableState: .disabled)) {

            } label: {
                Text("Secondary Disabled")
            }
            GSButton(style: .tag(tagState: .idle)) {

            } label: {
                Text("Primary Idle")
            }
            GSButton(style: .tag(tagState: .editing(activityState: .active))) {

            } label: {
                Text("Tag Editing Active")
            }
            GSButton(style: .tag(tagState: .editing(activityState: .inactive))) {

            } label: {
                Text("Tag Editing Inactive")
            }
            GSButton(style: .tag(tagState: .selected)) {

            } label: {
                Text("Tag Selected")
            }
            GSButton(style: .plain(destructiveState: .idle)) {

            } label: {
                Text("Plain Idle")
            }
            GSButton(style: .plain(destructiveState: .destructive)) {

            } label: {
                Text("Plain Destructive")
            }
            GSButton(style: .tab) {

            } label: {
                Text("Tab")
            }
        }
    }
}
