//
//  StarRepositoryView.swift
//  GSStarFeature
//
//  Created by Da Hae Lee on 1/27/24.
//

import SwiftUI
import GSDesignSystem

struct StarRepositoryView: View {
    @State private var showingTaggingView = false
    
    var body: some View {
        VStack {
            HStack {
                GSText(style: .sectionTitle, string: "Selected Tags")
                Spacer()
                Button {
                    showingTaggingView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .padding()
            
            ScrollView {
                // TODO: ForEach 내부 Array 동적으로 할당하도록 수정
                ForEach([1,2,3], id: \.self) { _ in
                    NavigationLink {
                        Text("dd")
                    } label: {
                        GSCanvas(style: .primary) {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    HStack(alignment: .top) {
                                        VStack(alignment: .leading) {
                                            Text("Repository owner")
                                                .font(.body)
                                                .multilineTextAlignment(.leading)
                                            Text("**Repository title**")
                                                .font(.title2)
                                                .multilineTextAlignment(.leading)
                                        }
                                        Spacer()
                                    }
                                    .padding(.bottom, 5)
                                    // TODO: 만약 Repository description이 없으면 표시하지 않도록 구현
                                    if true {
                                        Text("🚀 Repository description")
                                            .font(.caption)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                                Menu {
                                    Button(action: {}, label: {
                                        Text("Button")
                                    })
                                } label: {
                                    Image(systemName: "ellipsis")
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .sheet(isPresented: $showingTaggingView, content: {
            TaggingView()
        })
    }
}

#Preview {
    NavigationStack {
        StarRepositoryView()
    }
}
