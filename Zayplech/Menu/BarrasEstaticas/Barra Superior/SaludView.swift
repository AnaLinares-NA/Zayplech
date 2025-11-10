//
//  SaludView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 07/11/25.
//

import SwiftUI
import MapKit

struct SaludView: View {
    @State private var isEditing = false
    
    @State private var name = "Ana Linares"
    @State private var age = ""
    @State private var bloodType = ""
    @State private var allergies = ""
    @State private var medications = ""
    @State private var conditions = ""
    @State private var showHealthAlerts = false
    @State private var showPreventiveTips = false
    @State private var showZones = false
    @State private var showTents = false
    @State private var showCenters = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 18) {
                    
                    infoCard(title: "Información personal", color: .red, icon: "person.crop.circle.fill") {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.gray)
                                Spacer()
                                Button(action: { withAnimation { isEditing.toggle() } }) {
                                    Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil.circle.fill")
                                        .resizable()
                                        .frame(width: 28, height: 28)
                                        .foregroundColor(isEditing ? .green : .red)
                                }
                            }
                            if isEditing {
                                Group {
                                    TextField("Nombre Apellido", text: $name)
                                    TextField("Edad", text: $age)
                                    TextField("Tipo de sangre", text: $bloodType)
                                    TextField("Alergias", text: $allergies)
                                    TextField("Medicamentos que usa", text: $medications)
                                    TextField("Condiciones preexistentes", text: $conditions)
                                }
                                .textFieldStyle(.roundedBorder)
                                .padding(.vertical, 4)

                            } else {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(name).font(.headline)
                                    if !age.isEmpty { Text("Edad: \(age)") }
                                    if !bloodType.isEmpty { Text("Tipo de sangre: \(bloodType)") }
                                    if !allergies.isEmpty { Text("Alergias: \(allergies)") }
                                    if !medications.isEmpty { Text("Medicamentos: \(medications)") }
                                    if !conditions.isEmpty { Text("Condiciones: \(conditions)") }
                                }
                                .font(.subheadline)
                            }
                        }
                    }
                    
                    infoCard(title: "Puntos de auxilio cerca de mí", color: .blue, icon: "staroflife.fill") {
                        VStack(alignment: .leading, spacing: 8) {
                            
                            DisclosureGroup(isExpanded: $showZones) {
                                ForEach([
                                    "Zona 1 - Este",
                                    "Zona 2 - Oeste",
                                    "Zona 3 - Norte",
                                    "Zona 4 - Sur"
                                ], id: \.self) { zone in
                                    Label(zone, systemImage: "mappin.and.ellipse")
                                        .font(.subheadline)
                                }
                                mapButton()
                            } label: {
                                Label("Zonas con paramédicos", systemImage: "cross.case.fill")
                                    .font(.subheadline)
                            }
                            
                            DisclosureGroup(isExpanded: $showTents) {
                                ForEach([
                                    "Carpa 1 - Norte",
                                    "Carpa 2 - Centro",
                                    "Carpa 3 - Sur"
                                ], id: \.self) { tent in
                                    Label(tent, systemImage: "tent.fill")
                                        .font(.subheadline)
                                }
                                mapButton()
                            } label: {
                                Label("Carpas médicas", systemImage: "bandage.fill")
                                    .font(.subheadline)
                            }
                            
                            DisclosureGroup(isExpanded: $showCenters) {
                                ForEach([
                                    "Centro 1 - Estadio",
                                    "Centro 2 - Fan Zone"
                                ], id: \.self) { center in
                                    Label(center, systemImage: "cross.circle.fill")
                                        .font(.subheadline)
                                }
                                mapButton()
                            } label: {
                                Label("Centros de atención rápida dentro del evento", systemImage: "stethoscope")
                                    .font(.subheadline)
                            }
                        }
                    }

                    infoCard(title: "Hospitales cerca de mí", color: .red, icon: "cross.case.fill") {
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach([
                                "Hospital General de México",
                                "Hospital Juárez de México",
                                "Hospital General “Dr. Manuel Gea González”",
                                "Hospital de la Mujer"
                            ], id: \.self) { hospital in
                                Label(hospital, systemImage: "building.2.crop.circle.fill")
                                    .font(.subheadline)
                            }

                            mapButton()
                        }
                    }
                    
                    infoCard(title: "Primeros Auxilios", color: .orange, icon: "pills.fill") {
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach(firstAidItems, id: \.id) { item in
                                NavigationLink(destination: AidDetailView(content: item.content)) {
                                    Label("Qué hacer en caso de \(item.content.title.lowercased())",
                                          systemImage: item.icon)
                                        .font(.subheadline)
                                        .foregroundColor(.naranjaMelocoton)
                                        .padding(.vertical, 4)
                                }
                            }
                        }
                    }

                    infoCard(title: "Farmacias cerca de mí", color: .blue, icon: "pill.fill") {
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach([
                                "Farmacias Similares",
                                "Farmacias del Ahorro",
                                "Farmacias Guadalajara",
                                "Farmacias Benavides",
                                "Farmacia San Pablo"
                            ], id: \.self) { pharmacy in
                                Label(pharmacy, systemImage: "cross.case.fill")
                                    .font(.subheadline)
                            }
                            mapButton()
                        }
                    }
                    
                    VStack(spacing: 10) {
                        Toggle("Alertas de salud en tiempo real", isOn: $showHealthAlerts)
                        Toggle("Consejos preventivos", isOn: $showPreventiveTips)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.4), lineWidth: 3))
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Salud")
        }
    }
    
    struct AidItem: Identifiable {
        let id = UUID()
        let content: AidContent
        var icon: String { content.steps.first?.icon ?? "cross.fill" }
    }

    let firstAidItems: [AidItem] = [
        AidItem(content: faintingContent),
        AidItem(content: heatstrokeContent),
        AidItem(content: cutContent)
    ]
    
    // MARK: - Componentes reutilizables
    func infoCard<Content: View>(title: String, color: Color, icon: String, content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label {
                    Text(title)
                        .font(.title3)
                        .bold()
                        .foregroundColor(color)
                } icon: {
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .font(.title2)
                }
                Spacer()
            }
            content()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
                .shadow(color: color.opacity(0.2), radius: 4, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(color.opacity(0.5), lineWidth: 3)
        )

        .padding(.horizontal)
    }
    
    func mapButton() -> some View {
        NavigationLink(destination: MapView()) {
            HStack {
                Image(systemName: "map.fill")
                Text("Ver en el mapa")
                    .bold()
            }
            .font(.subheadline)
            .foregroundColor(.moradoMedio)
            .padding(8)
            .background(Color.moradoMedio.opacity(0.1))
            .cornerRadius(10)
        }
    }
}

// MARK: - Preview
#Preview {
    SaludView()
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
}
