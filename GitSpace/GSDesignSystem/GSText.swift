//
//  GSText.swift
//  GSDesignSystem
//
//  Created by 박제균 on 10/12/23.
//

import SwiftUI

public struct GSText: View {

    let style: GSTextStyle
    let string: String

    public enum GSTextStyle {
        case title1, title2, title3, sectionTitle
        case body1, body2
        case caption1, caption2
        case description
    }

    init(style: GSTextStyle, string: String) {
        self.style = style
        self.string = string
    }

    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    GSText()
}
