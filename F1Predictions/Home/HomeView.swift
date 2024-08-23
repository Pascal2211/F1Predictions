//
//  HomeView.swift
//  F1Predictions
//
//  Created by Pascal Sibondagara on 14/08/2024.
//

import SwiftUI

struct HomeView: View {
  
  @State private var showSettings = false
  @State private var userFullName: String = UserDefaults.standard.string(forKey: "userFullName") ?? "Guest"
  
    var body: some View {
      GeometryReader { geometry in
                  ZStack {
                      // Red Rectangle
                      Rectangle()
                          .fill(Color.red)
                          .frame(width: geometry.size.width, height: 100)
            
                  
                      VStack {
                        ZStack{
                          Image("f1logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                            .offset(x: -5)
                            .padding()
                          
                          Button
                          {
                            showSettings.toggle()
                          }
                        label:
                          {
                            Label("", systemImage: "person")
                              .foregroundStyle(.white)
                              .font(.system(size: 25))
                              .offset(x: 15)
                              .padding(.bottom, -5)
                            
                          }
                          .fullScreenCover(isPresented: $showSettings, content : LogInView.init)
                          .offset(x: 140)
                        }
                        
                        
                      }
                      .padding(.bottom, -45)
                    
                  
                  }
                  .position(x: geometry.size.width / 2, y: 50)
       
        
              }
              .edgesIgnoringSafeArea(.top)
      
              Text("Welcome, \(userFullName)")
                              
            }
          }

#Preview {
    HomeView()
}
