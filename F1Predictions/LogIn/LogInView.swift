//
//  LogInView.swift
//  F1Predictions
//
//  Created by Pascal Sibondagara on 20/08/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LogInView: View {
  
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var isSignUpActive = false
  @State private var isCreatedUserActive = false
  @State private var isLoggedIn: Bool = false
  @State private var userFullName: String = ""

  
  //RegexFunction that makes the rules for a password
  private func isPasswordValid(_password: String) -> Bool{
    let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
    
    return passwordRegex.evaluate(with: password)
  }
  
  
    var body: some View {
      NavigationStack{
        VStack{
          HStack{
            Spacer()
            Image(systemName: "person")
              .resizable()
              .frame(width: 40, height: 40)
            Spacer()
          }
          .padding()
          .padding()
          .padding(.top)
          Spacer()
          
          Text("Log inn to your formula1 prediction apps")
            .font(.title3)
          
          VStack{
            HStack{
              Image(systemName: "mail")
              TextField("Email", text: $email)
              Spacer()
              
              if(email.count != 0) {
                
                Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                  .fontWeight(.bold)
                  .foregroundColor(email.isValidEmail() ? .green : .red)
                
              }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10)
              .stroke(Color.gray, lineWidth: 1))
            .padding(.horizontal)
            
            HStack{
              Image(systemName: "lock")
              SecureField("Password", text: $password)
              Spacer()
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10)
              .stroke(Color.gray, lineWidth: 1)
              .foregroundColor(.black))
            .padding(.horizontal)
            
            
            Button {
              Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                      if let error = error {
                          // Handle the error, e.g., show an alert
                          print("Failed to log in: \(error.localizedDescription)")
                          return
                      }

                      // If login is successful, fetch the user's data from Firestore
                      guard let userId = Auth.auth().currentUser?.uid else { return }
                      let db = Firestore.firestore()
                      let userRef = db.collection("users").document(userId)
                      
                      userRef.getDocument { document, error in
                          if let document = document, document.exists {
                              let data = document.data()
                              let firstName = data?["firstName"] as? String ?? "User"
                              let lastName = data?["lastName"] as? String ?? ""
                              let fullName = "\(firstName) \(lastName)"
                              
                              // Store the user's full name and navigate to the HomeView
                              // You may use a navigation or state change here
                              isLoggedIn = true
                              UserDefaults.standard.set(fullName, forKey: "userFullName")
                              
                              // Navigate to HomeView or perform the necessary action
                          } else {
                              print("User data does not exist")
                          }
                      }
                  }
              
            } label: {
              Text("Sign in")
                .foregroundColor(.white)
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                  LinearGradient(
                    gradient: Gradient(colors: [Color.gray, Color.gray]),
                    startPoint: .top,
                    endPoint: .bottom
                  )
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
              }
            
            HStack{
              Text("Dont have a user ?")
                .padding()
              NavigationLink(destination: SignUpView()) {
                Text("Create a user")
                  .foregroundColor(.blue)
              }
            }
            
            VStack{
              Button{
                
              } label: {
                HStack{
                  Spacer()
                  Image(systemName: "apple.logo")
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 20, height: 20)
                  Text("Log inn with Apple")
                    .foregroundColor(.black)
                  Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
              }
              
              
              Button{
                
              } label: {
                HStack{
                  Spacer()
                  Image(systemName: "g.circle")
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 20, height: 20)
                  Text("Log inn with Google")
                    .foregroundColor(.black)
                  Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
              }
              
            }
            .padding()
            Spacer()
          }
          .padding()
          .padding(.bottom)
          .padding(.top)
          
        NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                   EmptyView()
                 }
        }
        .padding(.top)
        .padding(.top)
      }
    }
  
}

#Preview {
    LogInView()
}
