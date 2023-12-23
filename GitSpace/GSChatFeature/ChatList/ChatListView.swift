//
//  ChatListView.swift
//  GSChatFeature
//
//  Created by Celan on 12/23/23.
//

import ComposableArchitecture
import GSDesignSystem
import GSUtilities
import SwiftUI

struct ChatListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Section {
                ScrollView(
                    .horizontal,
                    showsIndicators: false
                ) {
                    HStack {
                        ForEach(0..<10) { int in
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 64, height: 64    )
                                
                                VStack(alignment: .leading) {
                                    GSText(
                                        style: .title3,
                                        string: "@RandomBrazilGuy"
                                    )
                                    .fontWeight(.semibold)
                                    
                                    HStack {
                                        GSText(style: .body1, string: "1.9k followers")
                                        
                                        GSText(style: .body1, string: "1.9k Repos")
                                    }
                                    
                                    GSButton(
                                        style: .secondary(
                                            ableState: .enabled
                                        )
                                    ) {
                                        print()
                                    } label: {
                                        Text("Knock!")
                                    }
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .trailing
                                    )
                                }
                            }
                            .padding(.vertical, 14)
                            .padding(.horizontal, 20)
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .foregroundStyle(Color.white)
                                    .shadow(
                                        color: Color.gsGray1,
                                        radius: 8,
                                        x: 0,
                                        y: 2
                                    )
                            }
                        }
                        .padding(.vertical, 15)
                        .padding(.horizontal, 10)
                    }
                }
            } header: {
                GSText(
                    style: .body2,
                    string: "Recommended “pals” for you 👋"
                )
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.horizontal, 20)
            }
            
            Divider()
            
            Section {
                ScrollView(
                    .vertical,
                    showsIndicators: false
                ) {
                    ForEach(0..<10) { int in
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 52, height: 52)
                                
                                VStack {
                                    GSText(
                                        style: .title3,
                                        string: "Random Brazil Girl"
                                    )
                                    .fontWeight(.semibold)
                                    
                                    
                                    GSText(
                                        style: .body2,
                                        string: "@randombrazilgirl"
                                    )
                                    .fontWeight(.semibold)
                                }
                            }
                            
                            Divider()
                        }
                    }
                }
            } header: {
                GSText(
                    style: .body2,
                    string: "My Penpals"
                )
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("GITSPACE")
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print()
                } label: {
                    Image(systemName: "archivebox.fill")
                }
            }
             
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print()
                } label: {
                    Image(systemName: "plus.bubble.fill")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChatListView()
    }
}
