//
//  AccessPermissionsView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 07/11/25.
//

import SwiftUI

// Componente para una fila de permiso con Toggle
struct PermissionRow: View {
    let title: String
    @Binding var isEnabled: Bool

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
            Spacer()
            Toggle("", isOn: $isEnabled)
                .labelsHidden()
                .tint(.moradoMedio) // Usando el color que se ve en la imagen
        }
        .padding()
        .background(Color.white)
    }
}

// Vista de la pantalla de Permisos de Acceso
struct AccessPermissionsView: View {
    // Estados para gestionar los permisos de acceso (simulados)
    @State private var notificationsEnabled = true
    @State private var locationEnabled = false
    @State private var microphoneEnabled = true
    @State private var cameraGalleryEnabled = true

    var body: some View {
        ScrollView {
            
            // MARK: - Cabecera
            VStack(alignment: .center, spacing: 5) {
                Text("Permisos de acceso")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.moradoMedio)
                
                Text("Aquí puedes otorgar o revocar los permisos de acceso a la aplicación.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 20) {
                
                // MARK: - Lista de Permisos
                VStack(spacing: 0) {
                    
                    PermissionRow(title: "Notificaciones", isEnabled: $notificationsEnabled)
                    Divider().padding(.leading)
                    PermissionRow(title: "Ubicación", isEnabled: $locationEnabled)
                    Divider().padding(.leading)
                    PermissionRow(title: "Micrófono", isEnabled: $microphoneEnabled)
                    Divider().padding(.leading)
                    PermissionRow(title: "Cámara / Galería", isEnabled: $cameraGalleryEnabled)
                }
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                .padding(.horizontal)

                Spacer()
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Perfil")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    AccessPermissionsView()
}
