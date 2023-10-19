//
//  GSButton.swift
//  GSDesignSystem
//
//  Created by 원태영 on 10/5/23.
//

import SwiftUI
import GSUtilities

public struct GSButton<Label: View>: View {
    public enum Style {
        case primary(ableState: AbleState)
        case secondary(ableState: AbleState)
        case tag(tagState: TagState)
        case plain(destructiveState: DestructiveState)
        case tab
        
        public enum AbleState {
            case enabled	
            case disabled
        }
        
        public enum TagState {
            case idle
            case editing(activityState: ActivityState)
            case selected
            
            public enum ActivityState {
                case active
                case inactive
            }
        }
        
        public enum DestructiveState {
            case idle
            case destructive
        }
    }
    
    let style: Style
    let action: () -> Void
    let label: Label
    
    public init(
        style: Style,
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.style = style
        self.action = action
        self.label = label()
    }
    
    public var body: some View {
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

extension GSButton {
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

// MARK: -Preview
struct GSButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
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
