//
//  NotificationsView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 07/11/25.
//

import SwiftUI

struct NotificationOptionRow: View {
    let title: String
    @Binding var isEnabled: Bool

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
            Spacer()
            Toggle("", isOn: $isEnabled)
                .labelsHidden()
                .tint(.moradoMedio)
        }
        .padding()
        .background(Color.white)
    }
}

struct NotificationsView: View {
    
    @State private var matchNewsEnabled = true
    @State private var healthRemindersEnabled = true
    @State private var securityNewsEnabled = false

    var body: some View {
        ScrollView {
            
            // MARK: - Cabecera
            VStack(alignment: .center, spacing: 5) {
                Text("Notificaciones")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.moradoMedio)
                
                Text("Aquí puedes otorgar o revocar los permisos de notificaciones a la aplicación.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 20) {

                // MARK: - Opciones de Notificación
                VStack(spacing: 0) {
                    NotificationOptionRow(title: "Noticias sobre partidos", isEnabled: $matchNewsEnabled)
                    Divider().padding(.leading)
                    NotificationOptionRow(title: "Recordatorios de salud", isEnabled: $healthRemindersEnabled)
                    Divider().padding(.leading)
                    NotificationOptionRow(title: "Noticias de seguridad", isEnabled: $securityNewsEnabled)
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
    NotificationsView()
}
