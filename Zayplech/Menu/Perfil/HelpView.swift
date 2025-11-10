//
//  HelpView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 07/11/25.
//

import SwiftUI

struct HelpOptionRow: View {
    let title: String
    let destination: EmptyDestinationView
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(title)
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
        }
    }
}

struct EmptyDestinationView: View {
    let title: String
    var body: some View {
        VStack {
            Text("Preguntas frecuentes sobre \(title)")
                .font(.title3)
            Text("Contenido de ayuda no disponible todavía.")
                .foregroundColor(.gray)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HelpView: View {

    var body: some View {
        ScrollView {
            
            // MARK: - Cabecera
            VStack(alignment: .center, spacing: 5) {
                Text("Centro de ayuda")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text("¿Cómo podríamos ayudarte?")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                // MARK: - Opciones de Ayuda
                VStack(spacing: 0) {
                    HelpOptionRow(title: "Cuenta", destination: EmptyDestinationView(title: "Cuenta"))
                    Divider().padding(.leading)
                    HelpOptionRow(title: "Suscripción y pagos", destination: EmptyDestinationView(title: "Suscripción y pagos"))
                    Divider().padding(.leading)
                    HelpOptionRow(title: "Widgets", destination: EmptyDestinationView(title: "Widgets"))
                    Divider().padding(.leading)
                    HelpOptionRow(title: "Características", destination: EmptyDestinationView(title: "Características"))
                    Divider().padding(.leading)
                    HelpOptionRow(title: "Otra cosa", destination: EmptyDestinationView(title: "Otra cosa"))
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
    HelpView()
}
