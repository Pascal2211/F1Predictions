//
//  MainView.swift
//  F1Predictions
//
//  Created by Pascal Sibondagara on 14/08/2024.
//

import SwiftUI

struct MainView: View {
  
  
    var body: some View 
    {
      
      TabView
      {
        HomeView()
          .tabItem
          {
            VStack
            {
              Image(systemName: "house")
                .renderingMode(.template)
                  .foregroundStyle(.yellow)
              Text("Home")
            }
          }
        
        PredictionsView().tabItem
        {
          Label("Predictions", systemImage: "trophy")
        }
        
        ChatView().tabItem
        {
          Label("Chat", systemImage: "tag")
        }
        
        ForumView().tabItem
        {
          Label("Forum", systemImage: "tray")
        }
        
        
      }
    }
}

#Preview {
    MainView()
}
