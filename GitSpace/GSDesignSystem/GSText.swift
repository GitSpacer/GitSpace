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
        switch style {
        case .title1:
            Text(.init(string))
                .font(.system(size: GSTextConstants.title1Size))
                .fontWeight(GSTextConstants.title1FontWeight)
                .foregroundStyle(GSTextConstants.title1Color)
        case .title2:
            Text(.init(string))
                .font(.system(size: GSTextConstants.title2Size))
                .fontWeight(GSTextConstants.title2FontWeight)
                .foregroundStyle(GSTextConstants.title2Color)
        case .title3:
            Text(.init(string))
                .font(.system(size: GSTextConstants.title3Size))
                .fontWeight(GSTextConstants.title3FontWeight)
                .foregroundStyle(GSTextConstants.title3Color)
        case .sectionTitle:
            Text(.init(string))
                .font(.system(size: GSTextConstants.sectionTitleSize))
                .fontWeight(GSTextConstants.sectionTitleFontWeight)
                .foregroundStyle(GSTextConstants.sectionTitleColor)
        case .body1:
            Text(.init(string))
                .font(.system(size: GSTextConstants.body1Size))
                .fontWeight(GSTextConstants.body1FontWeight)
                .foregroundStyle(GSTextConstants.body1Color)
        case .body2:
            Text(.init(string))
                .font(.system(size: GSTextConstants.body2Size))
                .fontWeight(GSTextConstants.body2FontWeight)
                .foregroundStyle(GSTextConstants.body2Color)
        case .caption1:
            Text(.init(string))
                .font(.system(size: GSTextConstants.caption1Size))
                .fontWeight(GSTextConstants.caption1FontWeight)
                .foregroundStyle(GSTextConstants.caption1Color)
        case .caption2:
            Text(.init(string))
                .font(.system(size: GSTextConstants.caption2Size))
                .fontWeight(GSTextConstants.caption2FontWeight)
                .foregroundStyle(GSTextConstants.caption2Color)
        case .description:
            Text(.init(string))
                .font(.system(size: GSTextConstants.descriptionSize))
                .fontWeight(GSTextConstants.descriptionFontWeight)
                .foregroundStyle(GSTextConstants.descriptionColor)
        }
    }
}

enum GSTextConstants {
    static let title1Size: CGFloat = 28
    static let title1FontWeight: Font.Weight = .semibold
    static let title1Color: Color = Color.primary

    static let title2Size: CGFloat = 20
    static let title2FontWeight: Font.Weight = .semibold
    static let title2Color: Color = Color.primary

    static let title3Size: CGFloat = 16
    static let title3FontWeight: Font.Weight = .semibold
    static let title3Color: Color = Color.primary

    static let sectionTitleSize: CGFloat = 13
    static let sectionTitleFontWeight: Font.Weight = .regular
    static let sectionTitleColor: Color = Color.gsGray2

    static let body1Size: CGFloat = 16
    static let body1FontWeight: Font.Weight = .regular
    static let body1Color: Color = Color.primary

    static let body2Size: CGFloat = 12
    static let body2FontWeight: Font.Weight = .regular
    static let body2Color: Color = Color.gsGray1

    static let caption1Size: CGFloat = 13
    static let caption1FontWeight: Font.Weight = .medium
    static let caption1Color: Color = Color.gsGray2
    static let caption1PrimaryColor: Color = Color.primary

    static let caption2Size: CGFloat = 12
    static let caption2FontWeight: Font.Weight = .regular
    static let caption2Color: Color = Color.gsGray2
    static let caption2PrimaryColor: Color = Color.primary

    static let descriptionSize: CGFloat = 16
    static let descriptionFontWeight: Font.Weight = .medium
    static let descriptionColor: Color = Color.gsGray2
}

extension Color {
    static let gsGray1 = Color("GSGray1")
    static let gsGray2 = Color("GSGray2")
    static let gsGray3 = Color("GSGray3")
}

#Preview {
    VStack {
        GSText(style: .title1, string: "타이틀1")
        GSText(style: .title2, string: "타이틀2")
        GSText(style: .title3, string: "타이틀3")
        GSText(style: .sectionTitle, string: "섹션타이틀")
        GSText(style: .body1, string: "바디1")
        GSText(style: .body2, string: "바디2")
        GSText(style: .caption1, string: "캡션1")
        GSText(style: .caption2, string: "캡션2")
        GSText(style: .description, string: "디스크립션")
    }
}
