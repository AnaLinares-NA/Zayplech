//
//  EquiposFavoritosView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI

struct EquiposFavoritosView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 25) {
                    
                    // MARK: - Encabezado
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tus equipos favoritos")
                            .font(.title2.bold())
                            .foregroundColor(.naranjaMelocoton)
                        
                        Text("Selecciona las confederaciones o regiones para descubrir los equipos disponibles.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                    
                    // MARK: - Nota informativa
                    VStack(alignment: .leading, spacing: 8) {
                        Text("""
                        Si no encuentras tu equipo favorito, es posible que el listado oficial de la FIFA esté pendiente de actualización. Una vez disponible, podrás seleccionarlo aquí automáticamente.
                        """)
                        .font(.footnote)
                        .foregroundColor(.blue)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.azulCielo, lineWidth: 1)
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color.azulCielo.opacity(0.08)))
                        )
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Lista de Confederaciones
                    VStack(spacing: 16) {
                        ConfederationRow(name: "Anfitriones", color: .naranjaMelocoton, destination: HostTeamsView())
                        ConfederationRow(name: "Confederación Asiática de Fútbol", color: .yellow, destination: AsiaTeamsView())
                        ConfederationRow(name: "Confederación Africana de Fútbol", color: .azulCielo, destination: PlaceholderView(title: "África"))
                        ConfederationRow(name: "Confederación Sudamericana de Fútbol", color: .rosaMagenta, destination: PlaceholderView(title: "Sudamérica"))
                        ConfederationRow(name: "Confederación de Fútbol de Oceanía", color: .lilaSuave, destination: PlaceholderView(title: "Oceanía"))
                        ConfederationRow(name: "Unión de la Asociación Europea de Fútbol", color: .moradoMedio, destination: PlaceholderView(title: "Europa"))
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 40)
                }
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

// MARK: - Subvista: Fila de confederación con NavigationLink
struct ConfederationRow<Destination: View>: View {
    let name: String
    let color: Color
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(name)
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Text("Seleccionar")
                    .font(.caption.bold())
                    .padding(.vertical, 6)
                    .padding(.horizontal, 14)
                    .background(color.opacity(0.15))
                    .foregroundColor(color)
                    .clipShape(Capsule())
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white)
                    .shadow(color: .gray.opacity(0.08), radius: 4, x: 0, y: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Vista temporal (para las otras confederaciones)
struct PlaceholderView: View {
    let title: String
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "soccerball")
                .font(.system(size: 48))
                .foregroundColor(.gray.opacity(0.5))
            Text("Pronto podrás seleccionar equipos de \(title).")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
        }
        .navigationTitle(title)
    }
}

#Preview {
    EquiposFavoritosView()
}
