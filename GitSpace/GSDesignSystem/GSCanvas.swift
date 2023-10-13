//
//  GSCanvas.swift
//  GSDesignSystem
//
//  Created by Da Hae Lee on 10/11/23.
//

import SwiftUI
import GSUtilities

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
        
        var backgroundColorByColorScheme: Color {
            switch colorScheme {
            case .light:
                Color.white
            case.dark:
                Color.gsGray2
            default:
                Color.white
            }
        }
        
        public func body(content: Content) -> some View {
            switch style {
            case .primary:
                content
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 17, style: .continuous)
                            .fill(backgroundColorByColorScheme)
                            .frame(maxWidth: .infinity)
                            .frame(minWidth: 50)
                            .shadow(color: Color.gsGray2.opacity(0.3), radius: 6, x:0, y:2)
                    )
            }
        }
        
        init(style: GSCanvasStyle) {
            self.style = style
        }
    }
}

#Preview {
    VStack {
        GSCanvas(style: .primary) {
            Text("This is primary GSCanvas.")
        }
        
        GSCanvas(style: .primary) {
            HStack {
                Image(systemName: "star.fill")
                VStack(alignment: .leading){
                    Text("**Star**")
                        .font(.title3)
                    Text("Star repositories you want to see again.")
                        .font(.caption)
                }
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        
        GSCanvas(style: .primary) {
            HStack {
                Image(systemName: "star.fill")
                VStack(alignment: .leading){
                    Text("**Star**")
                        .font(.title3)
                    Text("Star repositories you want to see again.")
                        .font(.caption)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
        
        GSCanvas(style: .primary) {
            HStack {
                Image(systemName: "tag.fill")
                VStack(alignment: .leading){
                    Text("**Tag**")
                        .font(.title3)
                    Text("Organize your starred repositories using tags.")
                        .font(.caption)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
        
        GSCanvas(style: .primary) {
            HStack {
                Text("**How to see a list of blocked users?**")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
        
        GSCanvas(style: .primary) {
            ZStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("GitSpacer")
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                                Text("**GitSpace**")
                                    .font(.title2)
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                        }
                        .padding(.bottom, 5)
                        Text("🚀 GitSpace")
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                    }
                    Image(systemName: "ellipsis")
                        .frame(width: 40, height: 40)
                        .offset(x: 10, y: -15)
                }
            }
        }
        .padding(.horizontal)
    }
}
