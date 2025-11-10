//
//  AboutYouView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 07/11/25.
//


import SwiftUI

struct AboutYouView: View {
    
    @State private var profileImage: Image? = nil
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    @State private var userName: String = "Nombre de Usuario"
    @State private var email: String = "correo@ejemplo.com"

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: - Cabecera con título
                VStack(alignment: .center, spacing: 5) {
                    Text("Sobre ti")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                    
                    Text("Aquí puedes ver la información principal de tu cuenta, asi como gestionar la misma.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 10)

                // MARK: - Sección de Imagen y Nombre de Usuario
                VStack {
                    Button(action: {
                        showingImagePicker = true
                        
                    }) {
                        if let profileImage = profileImage {
                            profileImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                        } else {
                           
                            Image(systemName: "camera.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .foregroundColor(Color(.systemGray4))
                                .background(Color(.systemGray6))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.bottom, 10)

                    Text(userName)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                .padding(.horizontal)

                // MARK: - Opciones de Edición
                VStack(spacing: 15) {
                    EditableProfileRow(title: "Correo electrónico", value: $email, icon: "arrow.forward.circle.fill") {
                        
                        print("Guardar correo: \(email)")
                    }
                    
                    ProfileActionRow(title: "Agrgar número telefónico", icon: "arrow.forward.circle.fill") {
                        
                        print("Ir a cambiar contraseña")
                    }
                    
                    ProfileActionRow(title: "Cambiar contraseña", icon: "arrow.forward.circle.fill") {
                        
                        print("Ir a cambiar contraseña")
                    }
                    
                    ProfileActionRow(title: "Eliminar cuenta", icon: "arrow.forward.circle.fill") {
                        
                        print("Mostrar confirmación para eliminar cuenta")
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Perfil")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { newImage in
            loadImage()
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
}

// MARK: - Componentes Auxiliares para AboutYouView

struct EditableProfileRow: View {
    let title: String
    @Binding var value: String
    let icon: String
    let action: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
            Spacer()
            TextField("", text: $value)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.gray)
                .disabled(false)
            Button(action: action) {
                Image(systemName: icon)
                    .foregroundColor(.yellow)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
    }
}

struct ProfileActionRow: View {
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: icon)
                    .foregroundColor(.yellow)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


struct AboutYouView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { 
            AboutYouView()
        }
    }
}
