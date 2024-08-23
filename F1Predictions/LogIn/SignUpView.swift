//
//  SignUpView.swift
//  F1Predictions
//
//  Created by Pascal Sibondagara on 20/08/2024.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth


struct SignUpView: View {
  
  @State private var firstName = ""
  @State private var lastName = ""
  @State private var userName = ""
  @State private var password = ""
  @State private var email = ""
  
  //Boolean variables
  @State private var isChecked = false
  @State private var isTermsAccepted = false
  @State private var isButtonActive = false
  
  @FocusState private var isPasswordFocused: Bool
  
  @State private var isPasswordValidMessageVisible = false
  
  private func isPasswordValid(_ password: String) -> Bool {
    // The password validation logic:
    // You need 6 letters, 1 special symbol, and a number
    let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-zA-Z])(?=.*[$@$#!%*?&])(?=.*[0-9]).{6,}$")
    return passwordRegex.evaluate(with: password)
  }
  
  //This is a boolean that checks if all the conditions are met for the button to activate
  private var isCreateButtonActive: Bool {
      return !firstName.isEmpty && !lastName.isEmpty && !userName.isEmpty &&
          !email.isEmpty && email.isValidEmail() && isPasswordValid(password) && isTermsAccepted
  }
    
    var body: some View {
      VStack{
        Spacer()
        Image(systemName: "book")
          .resizable()
          .frame(width: 100, height: 100)
        Spacer()
        
        Text("Create a formula 1 account")
        
        TextFieldWithIcon(systemName: "pencil", placeholder: "First Name", text: $firstName)
        TextFieldWithIcon(systemName: "pencil", placeholder: "Last Name", text: $lastName)
        TextFieldWithIcon(systemName: "person.circle", placeholder: "Username", text: $userName)
        
        HStack{
          Image(systemName: "lock")
          SecureField("Password", text: $password) //Use textfield
            .focused($isPasswordFocused) //It tracks the passord fields
          
          if password.count != 0 {
            Image(systemName: isPasswordValid(password) ? "checkmark" : "xmark")
              .fontWeight(.bold)
              .foregroundColor(isPasswordValid(password) ? .green : .red)
          }
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10)
          .stroke(Color.gray, lineWidth: 1)
          .foregroundColor(.black))
        .padding(.horizontal)
        
        if isPasswordFocused {
          Text("You need 6 letters, 1 special symbol, and a number")
            .font(.caption)
            .foregroundColor(.blue)
            .padding(.top, 4)
        }
        
        HStack{
          Image(systemName: "mail")
          TextField("Email", text: $email)
          Spacer()
          
          if email.count != 0 {
            Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
              .fontWeight(.bold)
              .foregroundColor(email.isValidEmail() ? .green : .red)
          }
          
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10)
          .stroke(Color.gray, lineWidth: 1))
        .padding(.horizontal)
        
        Spacer()
        
        Button(action: {
          isChecked.toggle()
          isTermsAccepted = isChecked
        }) {
          HStack{
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
              .resizable()
              .frame(width: 24, height: 24)
              .foregroundColor(isChecked ? .blue : .gray)
            
            Text("Agree to terms and agreements")
              .foregroundColor(.primary)
            
          }
        }
        
        Spacer()
        
        Button(action: {
            if isCreateButtonActive {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        // Handle the error, such as showing an alert to the user
                        print("Failed to create user: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let user = authResult?.user else { return }

                    // Save additional user information to Firestore
                    let db = Firestore.firestore()
                    db.collection("users").document(user.uid).setData([
                        "firstName": firstName,
                        "lastName": lastName,
                        "email": email,
                        "userName": userName
                    ]) { error in
                        if let error = error {
                            // Handle the error
                            print("Error saving user data: \(error.localizedDescription)")
                        } else {
                            // Data saved successfully
                            print("User data saved successfully")
                            // Optionally, navigate to another screen or perform another action
                        }
                    }
                }
            }
        }) {
            Text("Create an account")
                .foregroundColor(.white)
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(LinearGradient(
                    gradient:
                        Gradient(
                            colors: isCreateButtonActive ? [Color.blue, Color.blue] : [Color.gray, Color.gray]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
        }
        .disabled(!isCreateButtonActive)
        
        Spacer()
        
      }
    }
}

struct TextFieldWithIcon: View {
  let systemName: String
  let placeholder: String
  @Binding var text: String
  
  var body: some View{
    HStack{
      Image(systemName: systemName)
      TextField(placeholder, text: $text)
      Spacer()
    }
    .padding()
    .overlay(RoundedRectangle(cornerRadius: 10)
      .stroke(Color.gray, lineWidth: 1))
    .padding(.horizontal)
  }
  
}


extension String {
  func isValidEmail() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)

    return regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
  }
}

#Preview {
    SignUpView()
}
