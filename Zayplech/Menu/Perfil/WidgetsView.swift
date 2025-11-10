//
//  WidgetsView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 07/11/25.
//

import SwiftUI

struct WidgetCard: View {
    let title: String
    let description: String?
    let iconName: String
    let color: Color
    let sizeText: String // Ej: 2x2, 4x2

    var body: some View {
        VStack() {
            
            VStack() {
                HStack {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(color)
                        .cornerRadius(8)
                    
                    VStack() {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        if let description = description {
                            Text(description)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                        }
                    }
                }
                
                // Texto de tamaño (simulando un tamaño de celda)
                Text(sizeText)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .padding(.top, 5)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
        }
    }
}

// Vista de la pantalla de Widgets
struct WidgetsView: View {
    
    var body: some View {
        ScrollView {
            
            // MARK: - Cabecera
            VStack(alignment: .center, spacing: 5) {
                Text("Widgets")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.moradoMedio)
                
                Text("Aquí puedes agregar widgets a tu pantalla de inicio.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 20) {
        
                // MARK: - Widget 1: IA Chat (simulado con el diseño de la imagen)
                VStack(alignment: .leading, spacing: 5) {
                    Text("IA 2x2")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    HStack{
                        AIPromptMascotWidget()
                        AIPromptQuestionWidget()
                    }
            
                }
                
                // MARK: - Widget 2: Salud / Datos de Emergencia Médica
                VStack(alignment: .leading, spacing: 5) {
                    Text("Salud 4x2")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)

                    HealthEmergencyWidget()
  
                }
                
                // MARK: - Widget 3: Seguridad / Botón de Pánico
                VStack(alignment: .leading, spacing: 5) {
                    Text("Seguridad 4x2")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    PanicButtonWidget()

                }
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Perfil")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Sección de Widgets IA (Scroll Horizontal)
struct AIWidgetsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Asistente IA")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    AIPromptMascotWidget()
                    AIPromptQuestionWidget()
                }
                .padding(.horizontal)
            }
        }
        .padding(.bottom, 10)
    }
}

// MARK: Widget de Chat con IA
struct AIPromptMascotWidget: View {
    var body: some View {
        VStack(spacing: 6) {
            Image("Zayplech_Mascota1")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.lilaSuave, lineWidth: 2))
            
            Text("Zayplech")
                .font(.headline)
                .foregroundColor(.moradoMedio)
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray6))
                .overlay(
                    HStack {
                        Text("Escribe aquí...")
                            .foregroundColor(.gray)
                            .font(.caption)
                            .padding(.leading, 8)
                        Spacer()
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.moradoMedio)
                            .font(.caption)
                            .padding(.trailing, 6)
                    }
                )
                .frame(height: 30)
        }
        .padding(10)
        .frame(width: 170, height: 170)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 3)
    }
}

// MARK: 2.
struct AIPromptQuestionWidget: View {
    var body: some View {
        VStack() {
            
            Text("¿En qué te puedo ayudar?")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .background(
                        LinearGradient(colors: [Color.lilaSuave, Color.moradoMedio],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    )
                    .cornerRadius(10)
                    .padding(.vertical, 40)
            
            // Campo de texto simulado
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray6))
                .overlay(
                    HStack {
                        Text("Escribe aquí...")
                            .foregroundColor(.gray)
                            .font(.caption)
                            .padding(.leading, 8)
                        Spacer()
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.moradoMedio)
                            .font(.caption)
                            .padding(.trailing, 6)
                    }
                )
                .frame(height: 30)
        }
        .padding(10)
        .frame(width: 170, height: 170)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 3)
    }
}


// MARK: - Widget de Datos de Emergencia Médica (Salud)
struct HealthEmergencyWidget: View {
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .foregroundColor(.white)
                .padding()
                .background(
                    LinearGradient(colors: [Color.red, Color.rosaChicle],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                )
                .cornerRadius(20)
                .shadow(color: Color.red.opacity(0.3), radius: 8, x: 0, y: 5)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Datos Médicos")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.moradoMedio)
                
                VStack(alignment: .leading, spacing: 6) {
                    infoLine("Edad", icon: "person.fill")
                    infoLine("Tipo de sangre", icon: "drop.fill")
                    infoLine("Alergias", icon: "exclamationmark.triangle.fill")
                    infoLine("Medicamentos", icon: "pills.fill")
                }
            }
            
            Spacer()
        }
        .padding()
        .frame(width: 335, height: 130)
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 5)
    }
}

// MARK: - Línea de información
@ViewBuilder
private func infoLine(_ text: String, icon: String) -> some View {
    HStack(spacing: 6) {
        Image(systemName: icon)
            .font(.caption)
            .foregroundColor(.rosaChicle)
        
        Text(text)
            .font(.footnote)
            .foregroundColor(.gray)
    }
}


// MARK: 3. Widget de Botón de Pánico (Seguridad)
struct PanicButtonWidget: View {
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "iphone.radiowaves.left.and.right.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .foregroundColor(.white)
                .padding()
                .background(
                    LinearGradient(colors: [Color.azulCielo, Color.naranjaMelocoton], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(20)
                .shadow(color: Color.red.opacity(0.3), radius: 8, x: 0, y: 5)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Botón de Pánico")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.moradoMedio)
                
                Text("Mantén presionado para enviar alerta de emergencia y tu ubicación a tus contactos.")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .frame(width: 340, height: 170)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 5)
    }
}

struct WidgetsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WidgetsView()
        }
    }
}
