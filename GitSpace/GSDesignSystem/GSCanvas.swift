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
        
        var backgroundColorByColorScheme: Color {
            switch colorScheme {
            case .light:
                Color.white
            case.dark:
                Color.init(hex: "#27292E")
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
                            .fill(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(minWidth: 50)
                        // !!!: Merge 이후 프로젝트 컬러(.gsGray2)로 바꿀 것
                            .shadow(color: Color.init(hex: "#27292E").opacity(0.3), radius: 6, x:0, y:2)
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
    }
}

// !!!: Hexa Color (Merge 후 같은 파일로 통일할 것)
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
