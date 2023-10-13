//
//  GSText.swift
//  GSDesignSystem
//
//  Created by 박제균 on 10/12/23.
//

import SwiftUI
import GSUtilities

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
                .font(.system(size: Constant.GSTextConstants.title1Size))
                .fontWeight(Constant.GSTextConstants.title1FontWeight)
                .foregroundStyle(Constant.GSTextConstants.title1Color)
        case .title2:
            Text(.init(string))
                .font(.system(size: Constant.GSTextConstants.title2Size))
                .fontWeight(Constant.GSTextConstants.title2FontWeight)
                .foregroundStyle(Constant.GSTextConstants.title2Color)
        case .title3:
            Text(.init(string))
                .font(.system(size: Constant.GSTextConstants.title3Size))
                .fontWeight(Constant.GSTextConstants.title3FontWeight)
                .foregroundStyle(Constant.GSTextConstants.title3Color)
        case .sectionTitle:
            Text(.init(string))
                .font(.system(size: Constant.GSTextConstants.sectionTitleSize))
                .fontWeight(Constant.GSTextConstants.sectionTitleFontWeight)
                .foregroundStyle(Constant.GSTextConstants.sectionTitleColor)
        case .body1:
            Text(.init(string))
                .font(.system(size: Constant.GSTextConstants.body1Size))
                .fontWeight(Constant.GSTextConstants.body1FontWeight)
                .foregroundStyle(Constant.GSTextConstants.body1Color)
        case .body2:
            Text(.init(string))
                .font(.system(size: Constant.GSTextConstants.body2Size))
                .fontWeight(Constant.GSTextConstants.body2FontWeight)
                .foregroundStyle(Constant.GSTextConstants.body2Color)
        case .caption1:
            Text(.init(string))
                .font(.system(size: Constant.GSTextConstants.caption1Size))
                .fontWeight(Constant.GSTextConstants.caption1FontWeight)
                .foregroundStyle(Constant.GSTextConstants.caption1Color)
        case .caption2:
            Text(.init(string))
                .font(.system(size: Constant.GSTextConstants.caption2Size))
                .fontWeight(Constant.GSTextConstants.caption2FontWeight)
                .foregroundStyle(Constant.GSTextConstants.caption2Color)
        case .description:
            Text(.init(string))
                .font(.system(size: Constant.GSTextConstants.descriptionSize))
                .fontWeight(Constant.GSTextConstants.descriptionFontWeight)
                .foregroundStyle(Constant.GSTextConstants.descriptionColor)
        }
    }
}

// !!!: AssetColor와 CodeBase Color 중 어떤 방식으로 할지 논의 필요!
extension Color {
    static let gsGray1 = Color("GSGray1")
    static let gsGray2 = Color("GSGray2")
    static let gsGray3 = Color("GSGray3")
}

#Preview {
    VStack {
        GSText(style: .title1, string: "Title1")
        GSText(style: .title2, string: "Title2")
        GSText(style: .title3, string: "Title3")
        GSText(style: .sectionTitle, string: "SectionTitle")
        GSText(style: .body1, string: "Body1")
        GSText(style: .body2, string: "Body2")
        GSText(style: .caption1, string: "Caption1")
        GSText(style: .caption2, string: "Caption2")
        GSText(style: .description, string: "Description")
    }
}
