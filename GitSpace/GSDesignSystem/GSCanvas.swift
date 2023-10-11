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
            .modifier(GSCanvasModifier(style: style))
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
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 17, style: .continuous)
                                .fill(Color.white)
                                .frame(maxWidth: .infinity)
                                .frame(minWidth: 50)
                                .shadow(color: .gray.opacity(0.3), radius: 6, x:0, y:2)
                            )
                }
            case .dark:
                switch style {
                case .primary:
                    content
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 17, style: .continuous)
                                .fill(Color.gray)
                                .frame(maxWidth: .infinity)
                                .frame(minWidth: 50)
                                .shadow(color: .gray.opacity(0.0), radius: 6, x:0, y:2)
                            )
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
