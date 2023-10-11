//
//  GSCanvas.swift
//  GSDesignSystem
//
//  Created by Da Hae Lee on 10/11/23.
//

import SwiftUI

public struct GSCanvas<_Content: View>: View {
    public enum GSCanvasStyle {
        case primary
    }
    
    let style: GSCanvasStyle
    let content: _Content
    
    public var body: some View {
        content
    }
    
    public init(style: GSCanvasStyle, @ViewBuilder content: () -> _Content) {
        self.style = style
        self.content = content()
    }
}

extension GSCanvas {
    public struct GSCanvasModifier: ViewModifier {
        @Environment(\.colorScheme) var colorScheme
        let style: GSCanvasStyle
        
        public func body(content: Content) -> some View {
            switch colorScheme {
            case .light:
                switch style {
                case .primary:
                    content
                }
            case .dark:
                switch style {
                case .primary:
                    content
                }
            @unknown default:
                content
            }
        }
        
        init(style: GSCanvasStyle) {
            self.style = style
        }
    }
}

#Preview {
    GSCanvas(style: .primary) {
        Text("Hello")
    }
}
