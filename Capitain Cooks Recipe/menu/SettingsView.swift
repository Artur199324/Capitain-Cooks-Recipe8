import SwiftUI
import StoreKit
import WebKit
struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State var notifications = false
    @State private var showTermsWebView = false
    @State private var showPrivacyWebView = false
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

                    Text("Settings")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)

                    Spacer()

                   
                    Spacer().frame(width: 44)
                }
                .padding(.top, 20)
                .padding(.bottom, 10)

               
                VStack(spacing: 0) {
                    settingsRow(title: "Notifications") {
                        notifications.toggle()
                    }
                  
                    Divider().overlay(Color("pink"))
                    settingsRow(title: "Terms of Service") {
                        showTermsWebView = true
                    }.sheet(isPresented: $showTermsWebView) {
                        WebView(url: URL(string: "https://sites.google.com/view/captain-kitchen-of-flavo-trms/")!)
                    }
                    Divider().overlay(Color("pink"))
                    settingsRow(title: "Privacy Policy") {
                        showPrivacyWebView = true
                    }.sheet(isPresented: $showPrivacyWebView) {
                        WebView(url: URL(string: "https://sites.google.com/view/captain-kitchen-of-flavor-priv/")!)
                    }
                    Divider().overlay(Color("pink"))
                  
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("darkPurple"))
                )
                .padding(.horizontal)

                Spacer()
            }
        }  .fullScreenCover(isPresented: $notifications) {
            NotificationsView()
        }
    }

   
    func settingsRow(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }
            .padding(.vertical, 15)
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
#Preview {
    SettingsView()
}
