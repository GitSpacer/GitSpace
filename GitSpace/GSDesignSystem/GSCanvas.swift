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

#Preview {
    GSCanvas(style: .primary) {
        Text("Hello")
    }
}
