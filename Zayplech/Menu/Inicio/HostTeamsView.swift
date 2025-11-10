//
//  HostTeamsView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI

// MARK: - Vista de países anfitriones
struct HostTeamsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedCountries: Set<String> = []
    
    let countries: [(flag: String, name: String)] = [
        ("🇲🇽", "México"),
        ("🇺🇸", "Estados Unidos"),
        ("🇨🇦", "Canadá")
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            
            // MARK: Encabezado
            VStack(alignment: .leading, spacing: 6) {
                Text("Anfitriones")
                    .font(.largeTitle.bold())
                    .foregroundColor(.naranjaMelocoton)
                
                Text("Selecciona los países anfitriones que quieras seguir.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // MARK: Scroll de países
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    ForEach(countries, id: \.name) { country in
                        CountryRow(
                            flag: country.flag,
                            name: country.name,
                            color: .naranjaMelocoton,
                            isSelected: selectedCountries.contains(country.name)
                        ) {
                            toggleSelection(country.name)
                        }
                    }
                }
                .padding()
            }
            
            // MARK: Botón Guardar selección
            Button(action: saveSelection) {
                Text("Guardar selección")
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedCountries.isEmpty ? Color.gray : Color.naranjaMelocoton)
                    .cornerRadius(12)
                    .shadow(radius: 2)
            }
            .padding(.horizontal)
            .disabled(selectedCountries.isEmpty)
        }
        .background(Color(.systemGroupedBackground))
        .onAppear(perform: loadSelection)
        .navigationTitle("Países Anfitriones")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Lógica selección múltiple
    private func toggleSelection(_ country: String) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            if selectedCountries.contains(country) {
                selectedCountries.remove(country)
            } else {
                selectedCountries.insert(country)
            }
        }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    // MARK: Guardar selección
    private func saveSelection() {
        let array = Array(selectedCountries)
        UserDefaults.standard.set(array, forKey: "HostCountriesSelected")
        print("Países guardados:", array)
    }
    
    // MARK: Cargar selección previa
    private func loadSelection() {
        guard let saved = UserDefaults.standard.array(forKey: "HostCountriesSelected") as? [String] else { return }
        selectedCountries = Set(saved)
    }
}

// MARK: - Fila de país reutilizable
struct CountryRow: View {
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
                    .shadow(radius: 1)
                
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
                    .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        HostTeamsView()
            .preferredColorScheme(.light)
    }
}
