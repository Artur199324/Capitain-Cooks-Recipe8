import SwiftUI
import PhotosUI

struct SupportView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var isPickerPresented = false
    @State private var isCameraPicker = false
    @State private var showAlert = false
    @State private var email = ""
    @State private var messageText = ""
    @State private var showActionSheet = false
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
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title2)
                    }

                    Spacer()

                    Text("Support")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)

                    Spacer()

                    Spacer().frame(width: 44)
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                .padding(.horizontal)

                Text("We will respond to your appeal at the earliest opportunity. Thank you!")
                    .foregroundColor(.gray)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

          
                VStack {
                    HStack {
                        Spacer()
                        Text("Image / File")
                            .font(.headline)
                            .foregroundColor(Color("pink"))
                            .padding(.leading)

                        Spacer()

                        Button(action: {
                            showActionSheet = true
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("pink"))
                                    .frame(width: 50, height: 50)
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                        }
                        .padding(.trailing)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("pink"), style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("backg")))
                    )
                    .padding()

                  
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding()
                    }
                }

                
                TextField("", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .overlay(
                        HStack {
                            if email.isEmpty {
                                Text("Email")
                                    .foregroundColor(.white.opacity(0.6))
                                    .padding(.leading, 30)
                            }
                            Spacer()
                        }
                    )

              
                TextField("", text: $messageText)
                    .frame(height: 150)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .overlay(
                        
                        HStack {
                            if messageText.isEmpty {
                                Text("Message Text")
                                    .foregroundColor(.white.opacity(0.6))
                                    .padding(.leading, 30)
                            }
                            Spacer()
                        }
                    )

               
                Button(action: {
                    showAlert = true
                }) {
                    Text("Send Message")
                        .foregroundColor(.white)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("pink"))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Success"), message: Text("File uploaded successfully!"), dismissButton: .default(Text("OK")))
                }

                Spacer()
            }
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("Choose an option"),
                buttons: [
                    .default(Text("Open Camera")) {
                        isCameraPicker = true
                        isPickerPresented = true
                    },
                    .default(Text("Open Gallery")) {
                        isCameraPicker = false
                        isPickerPresented = true
                    },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $isPickerPresented) {
            if isCameraPicker {
                ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
            } else {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
            }
        }
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

#Preview {
    SupportView()
}
