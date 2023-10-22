//
//  GSTextField.swift
//  GSDesignSystem
//
//  Created by Celan on 10/21/23.
//

import GSUtilities
import SwiftUI

// TODO: - content-less TextField, Multi content Textfield Impl
struct GSTextField<GSContent: View>: View {
    enum GSTextFieldStyle {
        case search
        case tag
        case chat
    }
    
    @Environment(\.colorScheme) private var colorScheme
    @Binding internal var text: String
    private let style: GSTextFieldStyle
    private let content: GSContent
    
    // MARK: Body
    var body: some View {
        switch style {
        case .search:
            HStack(
                alignment: .center,
                spacing: 8
            ) {
                content
                    .padding(.leading, 14)
                    
                TextField(
                    "Search",
                    text: $text,
                    prompt: Text("Search")
                )
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(.vertical, 8)
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
            )
            .padding(.horizontal)
            
        case .tag:
            HStack(
                alignment: .center,
                spacing: 20
            ) {
                TextField(
                    "Search",
                    text: $text,
                    prompt: Text("Tag Name")
                )
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(
                            Color.gsGray2,
                            style: StrokeStyle(lineWidth: 1.5)
                        )
                )
                .padding(.leading)
                
                content
                    .padding(.trailing)
            }
            
        case .chat:
            HStack(
                alignment: .top,
                spacing: 16
            ) {
                TextField(
                    "Search",
                    text: $text,
                    prompt: Text("Enter Message..."),
                    axis: .vertical
                )
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .multilineTextAlignment(.center)
                .lineLimit(1...5)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(
                            Color.gsGray1,
                            style: StrokeStyle(lineWidth: 0.5)
                        )
                )
                .padding(.leading)
                
                content
                    .padding(
                        [.top, .trailing]
                     )
            }
        }
    }
    
    // MARK: INIT
    /// GitSpace의 디자인 시스템 레이아웃을 갖는 GSTextField를 생성합니다.
    /// - Parameters:
    ///   - text: Binding<String>
    ///   - style: GitSpace TextField의 스타일을 지정하여 TextField를 구성합니다.
    ///   - actionButton: 각 스타일의 Layout에 해당하는 View를 전달합니다.
    init(
        text: Binding<String>,
        style: GSTextFieldStyle,
        content: @escaping () -> GSContent
    ) {
        self._text = text
        self.style = style
        self.content = content()
    }
}

#Preview {
    VStack {
        GSTextField(
            text: .constant("Search Field"),
            style: .search
        ) {
            Image(systemName: "magnifyingglass")
        }
        
        GSTextField(
            text: .constant("Tag Field"),
            style: .tag
        ) {
            Button {
                
            } label: {
                Image(systemName: "plus")
            }
            .tint(.primary)
        }
        
        GSTextField(
            text: .constant("일이삼사오육칠팔구일이삼사오육칠팔구일이삼사오육칠팔구일이삼사오육칠팔구일이삼사오육칠팔구일이삼사오육칠팔구일이삼사오육칠팔구일이삼사오육칠팔구일이삼사오육칠팔구일이삼사오육칠팔구일이삼사오육칠팔구"),
            style: .chat
        ) {
            Button {
                
            } label: {
                Image(systemName: "paperplane.fill")
            }
            .tint(.primary)
        }
    }
}
