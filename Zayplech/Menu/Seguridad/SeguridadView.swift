//
//  SeguridadView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI

struct SeguridadView: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    
                    // MARK: - Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text(t("seguridad_title")) // "Seguridad"
                            .font(.largeTitle.bold())
                            .foregroundColor(.primary)
                        Text(t("seguridad_subtitle")) // "Recursos y asistencia en caso de emergencia"
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // MARK: - Botón de Pánico
                    SectionView(title: t("boton_panico_title")) { // "Botón de Pánico"
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                BotonPanico()
                            }
                            .padding(.horizontal)
                        }
                    }
                    // MARK: - Números de emergencia
                    SectionView(title: t("numeros_emergencia_title")) { // "Números de emergencia"
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                EmergencyCard911()
                                
                                CountryCard(
                                    country: t("pais_mexico"), // "México"
                                    color: .green,
                                    icon: "phone.fill",
                                    numbers: [
                                        ("089", t("denuncia_anonima")),
                                        ("078", t("auxilio_vial")),
                                        ("071", t("cfe")),
                                        ("800-911-25-11", t("linea_apoyo_mujeres"))
                                    ]
                                )
                                
                                CountryCard(
                                    country: t("pais_eeuu"), // "E.U."
                                    color: .blue,
                                    icon: "phone.fill",
                                    numbers: [
                                        ("311", t("policia_no_urgente")),
                                        ("1-888-373-7888", t("alto_trata")),
                                        ("1-888-283-8477", t("reporte_atf"))
                                    ]
                                )
                                
                                CountryCard(
                                    country: t("pais_canada"), // "Canadá"
                                    color: .red,
                                    icon: "phone.fill",
                                    numbers: [
                                        ("211", t("ayuda_comunitaria")),
                                        ("1-888-495-8501", t("reporte_fraudes")),
                                        ("1-800-222-8477", t("denuncia_anonima"))
                                    ]
                                )
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // MARK: - Manuales
                    SectionView(title: t("manuales_title")) { // "Manuales e instructivos"
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            NavigationLink(destination: ManualesMujeresView()) {
                                ManualCard(title: t("manuales_mujeres"), color: .pink, icon: "book.fill")
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            ManualCard(title: t("protocolos_via_publica"), color: .teal, icon: "map.fill")
                            ManualCard(title: t("guias_turisticas"), color: .orange, icon: "globe.europe.africa.fill")
                            ManualCard(title: t("protocolo_desastres"), color: .indigo, icon: "triangle.fill")
                        }
                        .padding(.horizontal)
                    }
                    
                    // MARK: - Novedades
                    SectionView(title: t("novedades_title")) { // "Novedades"
                        VStack(spacing: 12) {
                            SafetyNewsCard(title: t("noticias_mexico"), color: .green, url: "https://www.eluniversal.com.mx/")
                            SafetyNewsCard(title: t("noticias_eeuu"), color: .blue, url: "https://www.nytimes.com/")
                            SafetyNewsCard(title: t("noticias_canada"), color: .red, url: "https://www.theglobeandmail.com/")
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 50)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

// MARK: - Componentes de Cards

struct SectionView<Content: View>: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    let title: String
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            content
        }
    }
}

struct BotonPanico: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "sos.circle.fill")
                .font(.system(size: 120))
                .foregroundColor(.white)
        }
        .frame(width: 370, height: 220, alignment: .center) // Asegura el centrado
        .background(
            LinearGradient(colors: [.red, .rosaChicle],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
        )
        .cornerRadius(20)
        .shadow(color: .red.opacity(0.4), radius: 6, x: 0, y: 4)
    }
}

struct EmergencyCard911: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: "bell.fill")
                .font(.largeTitle)
                .foregroundColor(.white)
            Text(t("emergencia_911"))   // "911"
                .font(.largeTitle.bold())
                .foregroundColor(.white)
            Text(t("emergencia_text")) // "Emergencias"
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
        }
        .frame(width: 220, height: 140) // <- tamaño unificado
        .background(LinearGradient(colors: [.red, .rosaChicle], startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(20)
        .shadow(color: .red.opacity(0.4), radius: 6, x: 0, y: 4)
    }
}

struct CountryCard: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    let country: String
    let color: Color
    let icon: String
    let numbers: [(String, String)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(country)
                    .font(.headline)
                    .foregroundColor(color)
            }
            Divider()
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(numbers, id: \.0) { num, desc in
                    VStack(alignment: .leading, spacing: 2) {
                        Text(num)
                            .font(.body.bold())
                            .foregroundColor(.primary)
                        Text(desc)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .frame(width: 220, height: 140)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: color.opacity(0.25), radius: 4, x: 0, y: 3)

    }
}

struct ManualCard: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    let title: String
    let color: Color
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 50, height: 50)
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
            }
            
            Text(title)
                .font(.body.bold())
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .lineLimit(3)
                .minimumScaleFactor(0.6)
        }
        .padding()
        .frame(width: 150, height: 140)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: color.opacity(0.2), radius: 4, x: 0, y: 3)
    }
}

struct SafetyNewsCard: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    let title: String
    let color: Color
    let url: String
    
    var body: some View {
        NavigationLink(destination: URLView(url: url)
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.inline)) {
            HStack(spacing: 10) {
                Image(systemName: "megaphone.fill")
                    .foregroundColor(color)
                    .font(.title2)
                Text(title)
                    .font(.body.bold())
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
            }
            .padding()
            .frame(width: 370, height: 70)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 2)
        }
        .buttonStyle(PlainButtonStyle()) 
    }
}

#Preview {
    SeguridadView()
}
