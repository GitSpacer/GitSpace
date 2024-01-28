//
//  StarView.swift
//  GSStarFeature
//
//  Created by Da Hae Lee on 1/28/24.
//

import SwiftUI
import GSDesignSystem

struct StarView: View {
    @State var selectedTab: GSTab = .starred
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    GSText(
                        style: .title1,
                        string: "GitSpace")
                    Spacer()
                }
                HStack {
                    GSButton(
                        style: .tab(
                            tabName: .starred,
                            selectedTab: $selectedTab)
                    ) {
                        selectedTab = .starred
                    } label: {
                        Text("Starred")
                    }
                    
                    Divider()
                        .frame(height: 10)
                        .padding(.horizontal, 5)
                    
                    GSButton(
                        style: .tab(
                            tabName: .activity,
                            selectedTab: $selectedTab)
                    ) {
                        selectedTab = .activity
                    } label: {
                        Text("Activity")
                    }
                    Spacer()
                }
                .overlay(alignment: .bottom) {
                    Divider()
                        .frame(minHeight: 3)
                        .offset(y: 8)
                }
            }
            .padding(.horizontal)
            
            /** starred, activity tab */
            switch selectedTab {
            case .starred:
                StarRepositoryView()
            case .activity:
                // TODO: ActivityView 만들어서 연결
                ScrollView {
                    Text("ActivityView")
                }
            }
        }
    }
}

#Preview {
    StarView()
}
