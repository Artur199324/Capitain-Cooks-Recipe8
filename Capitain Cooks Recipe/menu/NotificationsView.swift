import SwiftUI

struct NotificationsView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
           
            Color("backg")
                .edgesIgnoringSafeArea(.all)

            VStack {
               
                HStack {
                    Button(action: {
                        self.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    }

                    Spacer()

                    Text("Notifications")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)

                    Spacer()

                    Spacer().frame(width: 44)
                }
                .padding(.top, 20)
                .padding(.bottom, 10)

            

                Text("This will show all reminders, notifications and updates in the app")
                    .foregroundColor(Color.gray)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()
            }
        }
    }
}

#Preview {
    NotificationsView()
}
