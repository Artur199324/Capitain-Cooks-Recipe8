import SwiftUI

struct WelcomeView: View {
    @State private var avatar: String = "avatar9" 
    @State private var username: String = "Guest"
    @State private var home = false
    
    var body: some View {
        VStack {
            Spacer()
            
           
            Text("Welcome")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 10)
            
            
            Text(username == "Guest" ?
                 "Glad to see you on our app. We hope you will find the information you need here and enjoy it" :
                 "You have successfully created your account and can now fully utilize all the features of the app")
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            
          
            Image(avatar)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("pink"), lineWidth: 5))
                .padding(.bottom, 20)
            
            
            HStack {
                if username != "Guest" {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                Text(username)
                    .fontWeight(.bold)
                    .foregroundColor(username == "Guest" ? .orange : .white)
                if username != "Guest" {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(username == "Guest" ? Color.orange : Color("pink"), lineWidth: 2)
            )
            .background(Color.clear)
            .padding(.horizontal, 60)
            .padding(.bottom, 20)
            
           
            if username != "Guest" {
                Text("We hope you can find the recipes you need and enjoy using our app")
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
            }
            
     
            Button(action: {
                home.toggle()
            }) {
                Text("Get Started")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("pink"))
                    .foregroundColor(.white)
                    .cornerRadius(40)
                    .padding(.horizontal, 20)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backg").scaledToFill())
        .ignoresSafeArea()
        .onAppear {
            loadUserData()
        }
        .fullScreenCover(isPresented: $home) {
            MenuView()
        }
    }
    
   
    private func loadUserData() {
        avatar = UserDefaults.standard.string(forKey: "userAvatar") ?? "avatar9"
        username = UserDefaults.standard.string(forKey: "userName") ?? "Guest"
    }
}

#Preview {
    WelcomeView()
}
