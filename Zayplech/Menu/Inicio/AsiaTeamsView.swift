//
//  AsiaTeamsView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI

struct AsiaTeamsView: View {
    // Estado para manejar los equipos seleccionados
    @State private var selectedTeams: Set<String> = []

    // Equipos asiáticos de ejemplo
    let asiaTeams: [Team] = [
        Team(name: "Japón", flag: "🇯🇵"),
        Team(name: "Irán", flag: "🇮🇷"),
        Team(name: "Corea del Sur", flag: "🇰🇷"),
        Team(name: "Uzbekistán", flag: "🇺🇿"),
        Team(name: "Jordania", flag: "🇯🇴"),
        Team(name: "Australia", flag: "🇦🇺")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Encabezado
            VStack(alignment: .leading, spacing: 6) {
                Text("Confederación Asiática")
                    .font(.title2.bold())
                    .foregroundColor(.amarilloClaro)
                
                Text("Selecciona tus equipos favoritos de Asia que participarán en el Mundial.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // Lista de equipos
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(asiaTeams) { team in
                        TeamRow(team: team, isSelected: selectedTeams.contains(team.name)) {
                            if selectedTeams.contains(team.name) {
                                selectedTeams.remove(team.name)
                            } else {
                                selectedTeams.insert(team.name)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            
            Spacer()
        }
        .navigationTitle("Equipos Asiáticos")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Modelo de equipo
struct Team: Identifiable {
    let id = UUID()
    let name: String
    let flag: String
}

// MARK: - Fila de equipo
struct TeamRow: View {
    let team: Team
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            Text(team.flag)
                .font(.system(size: 32))
            
            Text(team.name)
                .font(.body.bold())
                .foregroundColor(.primary)
            
            Spacer()
            
            Button(action: action) {
                HStack(spacing: 6) {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    Text(isSelected ? "Seleccionado" : "Seleccionar")
                        .font(.caption.bold())
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .foregroundColor(isSelected ? .blanco : .amarilloClaro)
                .background(isSelected ? Color.amarilloClaro : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.amarilloClaro, lineWidth: 1)
                )
                .clipShape(Capsule())
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        AsiaTeamsView()
    }
    .previewDevice("iPhone 17 Pro")
}
