//
//  ForumView.swift
//  F1Predictions
//
//  Created by Pascal Sibondagara on 14/08/2024.
//

import SwiftUI

struct ForumView: View {
    var body: some View {
      GeometryReader { geometry in
                  ZStack {
                      // Red Rectangle
                      Rectangle()
                          .fill(Color.red)
                          .frame(width: geometry.size.width, height: 100)
                      
                     
                      VStack {
                          Image("f1logo")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                              .frame(height: 30)
                              .offset(x: -5)
                              .padding()
                        
                        
                      }
                      .padding(.bottom, -45)
                  }
                  .position(x: geometry.size.width / 2, y: 50)
              }
              .edgesIgnoringSafeArea(.top)
    }
}


#Preview {
    ForumView()
}
