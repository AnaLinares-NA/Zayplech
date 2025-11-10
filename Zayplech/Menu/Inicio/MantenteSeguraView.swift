//
//  MantenteSeguraView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI

struct MantenteSeguraView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showSeguridad: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                
                // Encabezado
                VStack(alignment: .leading, spacing: 6) {
                    Text("Mantente segura")
                        .font(.largeTitle.bold())
                        .foregroundColor(.pink)
                    
                    Text("Selecciona el estadio en el que te encuentras para localizar al personal de seguridad más cercano.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Estadio
                VStack(alignment: .leading, spacing: 10) {
                    Image("estadioBBVA")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .clipped()
                    
                    HStack {
                        Text("Estadio BBVA")
                            .font(.body.bold())
                            .foregroundColor(.primary)
                        Spacer()
                        
                        Button(action: {
                            showSeguridad.toggle() // Mostrar info de seguridad
                        }) {
                            Text("Seleccionar")
                                .font(.caption.bold())
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.pink.opacity(0.15))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.pink, lineWidth: 1)
                                )
                                .foregroundColor(.pink)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.pink.opacity(0.05))
                )
                .padding(.horizontal)
                
                // Líneas de auxilio
                NavigationLink(destination: SeguridadView()) {
                    HStack(spacing: 12) {
                        Image("mantente_segura_inicio")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                        Text("Líneas de Auxilio")
                            .font(.headline)
                            .foregroundColor(.pink)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.pink, lineWidth: 1)
                    )
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            // Mostrar la info de seguridad como sheet
            .sheet(isPresented: $showSeguridad) {
                SeguridadInfoSheet()
            }
        }
    }
}

// MARK: - Vista de seguridad mostrada al seleccionar el estadio
struct SeguridadInfoSheet: View {
    let primaryPink = Color(red: 0.88, green: 0.40, blue: 0.65)
    let secondaryPink = Color(red: 0.95, green: 0.85, blue: 0.90)
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                            .frame(width: 44, height: 44)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Text("Mantente segura")
                    .font(.custom("HelveticaNeue-Bold", size: 28))
                    .foregroundColor(primaryPink)
                    .padding(.bottom, 20)
                    .padding(.top, 10)
                
                Text("Selecciona el estadio en el que te encuentras para localizar al personal de seguridad más cercano.")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Podrás **Identificar al personal de seguridad** más cercano a ti en cuanto la organización del evento nos facilite su localización oficial.")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(20)
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(primaryPink, lineWidth: 2)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .opacity(0.9)
                        )
                        .shadow(color: primaryPink.opacity(0.2), radius: 5, x: 0, y: 5)
                )
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
}

// MARK: - Preview
#Preview {
    MantenteSeguraView()
}
