//
//  ChatDetailView.swift
//  GSChatFeature
//
//  Created by Celan on 12/28/23.
//

import GSDesignSystem
import SwiftUI

struct ChatDetailView: View {
  private func isUsersMessage(_ int: Int) -> Bool {
    int % 2 == 0
  }
  
  var body: some View {
    VStack {
      // MARK: Profile Header Section
      VStack(spacing: 14) {
        Image(systemName: "person.circle.fill")
          .resizable()
          .frame(width: 100, height: 100)
        
        VStack(spacing: 4) {
          GSText(style: .title3, string: "RandomBrazilGuy")
          GSText(style: .caption1, string: "@RandomBrazilGuy")
        }
        
        VStack(spacing: 4) {
          GSText(style: .title3, string: "Starred: ")
          GSText(style: .caption1, string: "Owner Of: ")
        }
      }
      
      Divider()
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
      
      // MARK: LOFI Chat ScrollView
      ScrollViewReader { proxy in
        ScrollView {
          GSText(style: .caption1, string: "22/10/12 14:00 KST")
            .padding(.bottom, 8)
          
          Section {
            GSText(style: .description, string: "Hi! This is Gildong from South Korea who’s currently studying Web programming. Would you mind giving me some time and advising me on my future career path? Thank you so much for your help!")
              .padding(.horizontal, 25)
              .padding(.vertical, 20)
              .background {
                RoundedRectangle(cornerRadius: 20)
                  .foregroundStyle(Color.white)
                  .shadow(
                    color: Color.gray.opacity(0.3),
                    radius: 5,
                    y: 2
                  )
              }
              .padding(.bottom, 12)
            
          } header: {
            GSText(
              style: .body2,
              string: "Knock Message"
            )
            .frame(
              maxWidth: .infinity,
              alignment: .leading
            )
          }
          .padding(.horizontal, 20)
          
          // MARK: Each Chat Bubble
          ForEach(0..<10) { int in
            HStack(
              alignment: .bottom,
              spacing: 8
            ) {
              if isUsersMessage(int) {
                Text(.now, style: .time)
                  .font(.footnote)
                  .foregroundStyle(Color.gsGray1)
              }
              
              if !isUsersMessage(int) {
                Image(systemName: "person.circle.fill")
                  .resizable()
                  .frame(width: 25, height: 25)
                  .padding(.leading, 20)
              }
              
              GSText(
                style: .body1,
                string: "Lorem Ipsum is simply dummy text of the printin Lorem Ipsum Lorem"
              )
              .frame(maxWidth: 250)
              .padding(.horizontal, 12)
              .padding(.vertical, 18)
              .background {
                BubbleBackground(isUsersMessage: isUsersMessage(int))
                  .foregroundStyle(Color.yellow)
              }
              .padding(
                isUsersMessage(int) ? .trailing : .leading,
                isUsersMessage(int) ? 20 : 0
              )
              .frame(
                alignment: isUsersMessage(int) ? .trailing : .leading
              )
              
              if !isUsersMessage(int) {
                Text(.now, style: .time)
                  .font(.footnote)
                  .foregroundStyle(Color.gsGray1)
              }
            }
            .frame(
              maxWidth: .infinity,
              alignment: isUsersMessage(int) ? .trailing : .leading
            )
            .padding(.bottom, 12)
            .id(int)
          }
          .onAppear {
            #warning("Replace into Chat Documents count")
            proxy.scrollTo(9)
          }
        }
      }
    }
    .frame(
      maxWidth: .infinity,
      maxHeight: .infinity,
      alignment: .top
    )
    .padding(.top, 20)
    .navigationBarBackButtonHidden()
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          
        } label: {
          Image(systemName: "ellipsis")
            .foregroundStyle(Color.gsGray2)
        }
      }
      
      ToolbarItem(placement: .principal) {
        HStack {
          Image(systemName: "person.circle.fill")
            .resizable()
            .frame(width: 25, height: 25)
          
          Text("RandomBrazilGuy")
        }
      }
    }
  }
}

#Preview {
  NavigationStack {
    ChatListView()
//    ChatDetailView()
  }
}

struct BubbleBackground: Shape {
  let isUsersMessage: Bool
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners:
        isUsersMessage
      ? [.topLeft, .bottomLeft, .bottomRight]
      : [.topRight, .bottomRight, .bottomLeft],
      cornerRadii: CGSize(
        width: 20,
        height: 20
      )
    )
    
    return Path(path.cgPath)
  }
}
