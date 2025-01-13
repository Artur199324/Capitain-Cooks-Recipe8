

import SwiftUI

struct AccountView: View {
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var isLoginMode: Bool = false
    @State private var errorMessage: String = ""
    @State private var isAvatarSelectionPresented: Bool = false
    @State private var isGuest: Bool = false
    @State private var login: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
         
            Text(isLoginMode ? "Log in to your account" : "Let's create an account")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 10)
            

            Text(isLoginMode ? "Enter your credentials to log in" : "Create your profile to receive notifications and reports from the app. Fill in the fields below")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
       
            
        
            TextField("", text: $name)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("inputBackground"))
                )
                .overlay(
                    Text("Enter Your Name")
                        .foregroundColor(.gray)
                        .opacity(name.isEmpty ? 1 : 0)
                        .padding(.leading, 15),
                    alignment: .leading
                )
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.top,40)

            SecureField("", text: $password)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("inputBackground"))
                )
                .overlay(
                    Text("Enter Your Password")
                        .foregroundColor(.gray)
                        .opacity(password.isEmpty ? 1 : 0)
                        .padding(.leading, 15),
                    alignment: .leading
                )
                .foregroundColor(.white)
                .padding(.horizontal, 20)
           
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, 5)
            }
            
           
            Button(action: {
                if isLoginMode {
                    handleLogin()
                } else {
                    handleSignUp()
                }
            }) {
                Text(isLoginMode ? "Log In" : "Create Account")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("pink"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
            .padding(.top, 10)
            
           
            Button(action: {
                withAnimation {
                    isLoginMode.toggle()
                    errorMessage = ""
                }
            }) {
                Text(isLoginMode ? "Don't have an account? " : "Already have an account? ")
                       .foregroundColor(.white) +
                   Text(isLoginMode ? "Sign up" : "Log in")
                       .foregroundColor(Color("pink"))
            }
            
            Spacer()
            
           
            Button(action: {
                guest()
            }) {
                Text("Stay as Guest")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }.padding(.bottom,50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backg").scaledToFill())
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $isAvatarSelectionPresented) {
            AvatarSelectionView()
        }
        .fullScreenCover(isPresented: $isGuest) {
            WelcomeView()
        }
        .fullScreenCover(isPresented: $login) {
            MenuView()
        }
    }
    
   
    func handleSignUp() {
        guard !name.isEmpty, !password.isEmpty else {
            errorMessage = "Name and password cannot be empty"
            return
        }
        
       
        UserDefaults.standard.set(name, forKey: "userName")
        UserDefaults.standard.set(password, forKey: "userPassword")
        UserDefaults.standard.set(true, forKey: "log")
     
        
       
        isAvatarSelectionPresented = true
    }
    func guest() {
        UserDefaults.standard.set("Guest", forKey: "userName")
        
        UserDefaults.standard.set("avatar9", forKey: "userAvatar")
        isGuest = true
    }

    func handleLogin() {
      
        if UserDefaults.standard.string(forKey: "userName") == nil {
            UserDefaults.standard.set("TestUser", forKey: "userName")
            UserDefaults.standard.set("test123123", forKey: "userPassword")
            UserDefaults.standard.set(false, forKey: "log")
        }
        
       
        let savedName = UserDefaults.standard.string(forKey: "userName") ?? ""
        let savedPassword = UserDefaults.standard.string(forKey: "userPassword") ?? ""
        
     
        guard !name.isEmpty, !password.isEmpty else {
            errorMessage = "Name and password cannot be empty"
            return
        }
        
     
        if name == savedName && password == savedPassword {
            print("Login Successful")
            errorMessage = ""
            UserDefaults.standard.set(true, forKey: "log")
            login.toggle()
        } else {
            errorMessage = "Invalid name or password"
        }
    }
}

#Preview {
    AccountView()
}
