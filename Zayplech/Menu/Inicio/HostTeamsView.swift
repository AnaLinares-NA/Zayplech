//
//  HostTeamsView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI

struct HostTeamsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedCountries: Set<String> = []
    
    let countries: [(flag: String, name: String)] = [
        ("🇲🇽", "México"),
        ("🇺🇸", "Estados Unidos"),
        ("🇨🇦", "Canadá")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Encabezado
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Anfitriones")
                            .font(.largeTitle.bold())
                            .foregroundColor(.naranjaMelocoton)
                        
                        Text("Selecciona los países anfitriones que quieras seguir.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    ForEach(countries, id: \.name) { country in
                        HostCountryRow(
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
                .padding(.top, 8)
            }
        }
        .navigationBarHidden(true)
        .background(Color(.systemGroupedBackground))
    }
    
    // MARK: - Lógica de selección múltiple
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
}

// MARK: - Subvista: Tarjeta de país moderna
struct HostCountryRow: View {
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
                    .shadow(color: .gray.opacity(0.08), radius: 4, x: 0, y: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        HostTeamsView()
            .preferredColorScheme(.light)
    }
}
