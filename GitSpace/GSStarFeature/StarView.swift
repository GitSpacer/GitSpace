//
//  StarView.swift
//  GSStarFeature
//
//  Created by Da Hae Lee on 1/28/24.
//

import SwiftUI
import GSDesignSystem

struct StarView: View {
    @State private var starredTapStatus: GSTab = .starred
    @State private var activityTapStatus: GSTab = .activity
    
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
                            selectedTab: $starredTapStatus)
                    ) {
                        starredTapStatus = .starred
                        activityTapStatus = .activity
                    } label: {
                        Text("Starred")
                    }
                    
                    Divider()
                        .frame(height: 10)
                        .padding(.horizontal, 5)
                    
                    GSButton(
                        style: .tab(
                            tabName: .starred,
                            selectedTab: $activityTapStatus)
                    ) {
                        starredTapStatus = .activity
                        activityTapStatus = .starred
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
            switch starredTapStatus {
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
