//
//  TusInteresesView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI

struct TusInteresesView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {
                    
                    // MARK: - Cabecera con título y descripción
                    VStack(alignment: .center, spacing: 8) {
                        Text("Tus intereses")
                            .font(.largeTitle.bold())
                            .foregroundColor(.naranjaMelocoton)
                        
                        Text("Personaliza tu experiencia seleccionando tus equipos favoritos y los partidos que no puedes perderte. ¡Prepárate para disfrutar cada momento!")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    // MARK: - Tarjeta: Tus equipos favoritos
                    NavigationLink(destination: EquiposFavoritosView()) {
                        InterestOverlayCard(
                            title: "Tus equipos favoritos",
                            imageName: "equipos",
                            color: .orange
                        )
                    }
                    
                    // MARK: - Tarjeta: Partidos que no quieres perderte
                    NavigationLink(destination: FavoriteMatchesView()) {
                        InterestOverlayCard(
                            title: "Partidos que no quieres perderte",
                            imageName: "jugador",
                            color: .orange
                        )
                    }
                    
                    Spacer(minLength: 40)
                }
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - Tarjeta con imagen de fondo y título superior
struct InterestOverlayCard: View {
    let title: String
    let imageName: String
    let color: Color
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 160, alignment: .top)
                .offset(y: imageName == "jugador" ? -25 : 0)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.naranjaMelocoton.opacity(0.55), .clear]),
                        startPoint: .top,
                        endPoint: .center
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                )
                .clipped()
            
            Text(title)
                .font(.headline.bold())
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
                .padding(.top, 12)
                .frame(maxWidth: .infinity)
        }
        .frame(height: 160)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .gray.opacity(0.25), radius: 6, x: 0, y: 4)
    }
}

// MARK: - Vista: Partidos que no quieres perderte
struct FavoriteMatchesView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Elige tus partidos favoritos")
                    .font(.headline)
                    .foregroundColor(.naranjaMelocoton)
                
                Text("Pronto podrás seleccionar tus encuentros y activar recordatorios para no perderte ningún momento de la acción.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("""
                Tan pronto se confirme el calendario oficial de la FIFA, podrás seleccionar y activar alertas para todos los encuentros que no quieras perderte.
                """)
                .font(.footnote)
                .foregroundColor(.blue)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blue, lineWidth: 1)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.blue.opacity(0.05)))
                )
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Partidos Imperdibles")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
#Preview {
    TusInteresesView()
}
