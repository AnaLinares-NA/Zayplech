//
//  ChangeEventView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 07/11/25.
//

import SwiftUI

struct ChangeEventView: View {
    
    @State private var selectedEvent: String = "Mundial"

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: - Cabecera
                VStack(alignment: .center, spacing: 5) {
                    Text("Cambiar evento")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                    
                    Text("Aquí puedes ver tu evento actual así como cambiar a otro evento el cual hayas registrado.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                .padding(.top, 10)

                // MARK: - Evento Actual
                VStack(alignment: .leading, spacing: 10) {
                    Text("Evento actual: \(selectedEvent)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal)

                    Image("cm")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .cornerRadius(10)
                        .clipped()
                        .padding(.horizontal, 10)
                }
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(15)
                .padding(.horizontal)

                // MARK: - Registrar un evento nuevo
                VStack(alignment: .leading, spacing: 10) {
                    Text("Registrar un evento nuevo")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal)

                    Button(action: {
                        
                        print("Abrir pantalla para registrar nuevo evento")
                    }) {
                        HStack {
                            Text("Añadir nuevo evento")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.yellow)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 3)
                    }
                    .padding(.horizontal, 10)
                    
                }
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                .padding(.horizontal)

                // MARK: - Opciones de Eventos Registrados
                VStack(alignment: .leading, spacing: 25) {
                    
                    EventOptionCard(eventName: "Concierto", backgroundImageName: "concierto") { selectedEvent = "Concierto" }
                    
                    EventOptionCard(eventName: "Desfile", backgroundImageName: "desfile") { selectedEvent = "Desfile" }

                    EventOptionCard(eventName: "Feria", backgroundImageName: "feria") { selectedEvent = "Feria" }
                    
                    EventOptionCard(eventName: "Congreso", backgroundImageName: "congreso") { selectedEvent = "Congreso" }
                    
                    EventOptionCard(eventName: "Meet & Greet", backgroundImageName: "mg") { selectedEvent = "Meet & Greet" }
                    
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Perfil")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Componentes Auxiliares para ChangeEventView

struct EventOptionCard: View {
    let eventName: String
    let backgroundImageName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .overlay(
                    Text(eventName)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.7), radius: 3, x: 0, y: 2)
                )
                .cornerRadius(10)
                .clipped()
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
        }
    }
}

#Preview {
    ChangeEventView()
}
