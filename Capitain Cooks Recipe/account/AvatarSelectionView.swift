import SwiftUI

struct AvatarSelectionView: View {
    @State private var selectedAvatar: Int = 0
    @State private var welkome = false
    let avatars = ["avatar1", "avatar2", "avatar3", "avatar4", "avatar5", "avatar6", "avatar7", "avatar8"]
    
    var body: some View {
        VStack {
            Spacer()
            

            Text("Choose an avatar")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Select one of the suggested avatars to be displayed in the application")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            
         
            Image(avatars[selectedAvatar])
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("pink"), lineWidth: 5))
                .padding(.bottom, 20)
            
          
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())],
                spacing: 3
            ) {
                ForEach(avatars.indices, id: \.self) { index in
                    Image(avatars[index])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(index == selectedAvatar ? Color.pink : Color.clear, lineWidth: 3)
                        )
                        .onTapGesture {
                            withAnimation {
                                selectedAvatar = index
                            }
                        }
                }
            }
            .padding(.horizontal, 4)
            
            Spacer()
            
        
            Button(action: {
                saveAvatar()
                welkome.toggle()
            }) {
                Text("Continue")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("pink"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 50)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backg").scaledToFill())
        .ignoresSafeArea()
        .onAppear {
            loadAvatar()
        }
        .fullScreenCover(isPresented: $welkome) {
            WelcomeView()
        }
    }
    
 
    private func saveAvatar() {
        let avatarToSave = avatars[selectedAvatar]
        UserDefaults.standard.set(avatarToSave, forKey: "userAvatar")
    }
    

    private func loadAvatar() {
        if let savedAvatar = UserDefaults.standard.string(forKey: "userAvatar"),
           let index = avatars.firstIndex(of: savedAvatar) {
            selectedAvatar = index
        }
    }
}

#Preview {
    AvatarSelectionView()
}
