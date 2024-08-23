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
        HomeView().tabItem
          {
            Label("Home", systemImage: "house")
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
