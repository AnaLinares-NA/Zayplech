//
//  AsiaTeamsView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI

// MARK: - Modelo de equipo
struct Team: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let flag: String
}

// MARK: - Vista principal de equipos asiáticos
struct AsiaTeamsView: View {
    @State private var selectedTeams: Set<String> = []

    let asiaTeams: [Team] = [
        Team(name: "Japón", flag: "🇯🇵"),
        Team(name: "Irán", flag: "🇮🇷"),
        Team(name: "Corea del Sur", flag: "🇰🇷"),
        Team(name: "Uzbekistán", flag: "🇺🇿"),
        Team(name: "Jordania", flag: "🇯🇴"),
        Team(name: "Australia", flag: "🇦🇺")
    ]

    var body: some View {
        VStack(spacing: 16) {
            
            // MARK: - Scroll de equipos
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    ForEach(asiaTeams) { team in
                        TeamRow(
                            flag: team.flag,
                            name: team.name,
                            color: .yellow,
                            isSelected: selectedTeams.contains(team.name)
                        ) {
                            toggleSelection(team.name)
                        }
                    }
                }
                .padding()
            }

            // MARK: - Botón Guardar
            Button(action: saveSelection) {
                Text("Guardar selección")
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedTeams.isEmpty ? Color.gray : Color.yellow)
                    .cornerRadius(12)
                    .shadow(radius: 2)
            }
            .padding(.horizontal)
            .disabled(selectedTeams.isEmpty)
        }
        .navigationTitle("Equipos Asiáticos")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
        .onAppear(perform: loadSelection)
    }
    
    // MARK: - Funciones de selección
    private func toggleSelection(_ team: String) {
        withAnimation(.spring()) {
            if selectedTeams.contains(team) {
                selectedTeams.remove(team)
            } else {
                selectedTeams.insert(team)
            }
        }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    // MARK: - Guardar selección
    private func saveSelection() {
        let array = Array(selectedTeams)
        UserDefaults.standard.set(array, forKey: "AsiaTeamsSelected")
        print("Equipos guardados:", array)
    }
    
    // MARK: - Cargar selección previa
    private func loadSelection() {
        guard let saved = UserDefaults.standard.array(forKey: "AsiaTeamsSelected") as? [String] else { return }
        selectedTeams = Set(saved)
    }
}

// MARK: - Fila de equipo
struct TeamRow: View {
    let flag: String
    let name: String
    let color: Color
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                Text(flag)
                    .font(.system(size: 36))
                
                Text(name)
                    .font(.body.bold())
                    .foregroundColor(.primary)
                
                Spacer()
                
                ZStack {
                    Circle()
                        .strokeBorder(isSelected ? color : .gray.opacity(0.3), lineWidth: 2)
                        .frame(width: 28, height: 28)
                        .background(Circle().fill(isSelected ? color.opacity(0.15) : Color.clear))
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(color)
                            .font(.system(size: 26))
                            .transition(.scale)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white)
                    .shadow(color: .gray.opacity(0.08), radius: 4, x: 0, y: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        AsiaTeamsView()
            .preferredColorScheme(.light)
    }
}
