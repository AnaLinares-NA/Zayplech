//
//  HomeView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 21/10/25.
//

import SwiftUI
import Combine
import MapKit
import CoreLocation

struct HomeView: View {
    @StateObject private var weatherManager = WeatherManager()
    @EnvironmentObject var localizationManager: LocalizationManager

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: - Encabezado de imagen con contador
                    ZStack(alignment: .bottom) {
                        Image("copa")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [.black.opacity(0.4), .clear]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            )
                        
                        CountdownOverlayView()
                            .padding(.bottom, 12)
                    }
                    .padding(.horizontal)

                    // MARK: - Sección: No te pierdas ningún gol
                    VStack(alignment: .leading, spacing: 12) {
                        Text(t("home_no_te_pierdas_gol"))
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.horizontal)

                        HStack(spacing: 16) {
                            TusInteresesWidget()
                            MapaBusquedaWidget()
                        }
                        .padding(.horizontal)
                    }

                    // MARK: - Noticias y más
                    NoticiasCarruselView()

                    // MARK: - Clima Animado
                    VStack(alignment: .leading) {
                        Text(t("home_clima_emocion"))
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                        
                        WeatherCardAnimado()
                    }

                    // MARK: - Sección de Accesibilidad
                    VStack(alignment: .leading, spacing: 12) {
                        Text(t("home_estadio"))
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                AccessibilityWidget(
                                    imageName: "mantente_segura_inicio",
                                    title: t("home_necesitas_ayuda"),
                                    description: t("home_identificar_seguridad"),
                                    color: .rosaChicle,
                                    destination: MantenteSeguraView()
                                )
                                
                                AccessibilityWidget(
                                    imageName: "zona_de_accesibilidad",
                                    title: t("home_zonas_accesibilidad"),
                                    description: t("home_identifica_zonas_discapacidad"),
                                    color: .azulCielo,
                                    destination: ZonaAccesibilidadView()
                                )
                                
                                AccessibilityWidget(
                                    imageName: "lupa",
                                    title: t("home_perdiste_algo"),
                                    description: t("home_protocolos_robo_extravio"),
                                    color: .rappi,
                                    destination: ManualesMujeresView()
                                )
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // MARK: - Más allá del estadio
                    VStack(alignment: .leading, spacing: 12) {
                        Text(t("home_mas_allá_estadio"))
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                        
                        NavigationLink(destination: TuEquipoView()) {
                            HStack(spacing: 12) {
                                Image("alineaciones")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 160)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                                    )
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(t("home_alineaciones_jugadores"))
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .lineLimit(2)
                                    
                                    Text(t("home_conoce_alineaciones"))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .lineLimit(4)
                                }
                                .frame(height: 160, alignment: .topLeading)
                            }
                            .padding(10)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(color: .gray.opacity(0.15), radius: 5, x: 0, y: 3)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}


// MARK: - Componentes reutilizables

struct CountdownOverlayView: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    let targetDate: Date = {
        var components = DateComponents()
        components.year = 2026
        components.month = 6
        components.day = 15
        components.hour = 18
        components.minute = 0
        components.second = 0
        components.timeZone = TimeZone.current
        return Calendar.current.date(from: components)!
    }()

    @State private var now = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
   

    var timeRemaining: DateComponents {
        Calendar.current.dateComponents([.day, .hour, .minute, .second], from: now, to: targetDate)
    }

    var body: some View {
        VStack(spacing: 4) {
            Text(t("home_cuenta_regresiva"))
                .font(.footnote.bold())
                .foregroundColor(.white)
            
            HStack(spacing: 8) {
                TimeBox(value: timeRemaining.day ?? 0, label: t("dias"))
                TimeBox(value: timeRemaining.hour ?? 0, label: t("horas"))
                TimeBox(value: timeRemaining.minute ?? 0, label: t("minutos"))
                TimeBox(value: timeRemaining.second ?? 0, label: t("segundos"))
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.black.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onReceive(timer) { now = $0 }
    }
}

struct TimeBox: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    let value: Int
    let label: String
    var body: some View {
        VStack(spacing: 2) {
            Text("\(value)")
                .font(.headline.bold())
                .foregroundColor(.white)
            Text(label)
                .font(.caption2)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(minWidth: 45)
    }
}

// MARK: - Widget: TusInteresesWidget
struct TusInteresesWidget: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    var body: some View {
        NavigationLink(destination: TusInteresesView()) {
            ZStack(alignment: .topLeading) {
                Image("seleccionPaises")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.5), .clear]),
                            startPoint: .top,
                            endPoint: .center
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    )

                Text(t("register_interest_teams_matches"))
                    .font(.subheadline.bold())
                    .foregroundColor(.white)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 160)
            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 3)
        }
    }
}

// MARK: - Widget: MapaBusquedaWidget
struct MapaBusquedaWidget: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 19.4333, longitude: -99.1333),
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
            ))
            .frame(height: 160)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .allowsHitTesting(false)

            NavigationLink(destination: MapView()) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray6))
                    .overlay(
                        HStack {
                            Text(t("search_stadium_city"))
                                .foregroundColor(.gray)
                                .font(.caption)
                                .padding(.leading, 8)
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.blue)
                                .font(.caption)
                                .padding(.trailing, 6)
                        }
                    )
                    .frame(height: 30)
                    .padding([.leading, .trailing, .bottom], 8)
            }
        }
        .frame(height: 160)
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 3)
    }
}

// MARK: - NoticiasCarruselView
struct NoticiasCarruselView: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(t("news_and_more"))
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    NoticiaCard(
                        imageName: "noticia1",
                        title: t("pre_sale_phase_worldcup"),
                        subtitle: t("pre_sale_phase_description"),
                        url: "https://www.elfinanciero.com.mx/deportes/2025/09/08/quieres-ir-al-mundial-de-2026-esto-debes-saber-sobre-la-preventa-de-boletos-fechas-registros-y-mas/"
                    )
                    
                    NoticiaCard(
                        imageName: "noticia2",
                        title: t("qualified_teams_title"),
                        subtitle: t("qualified_teams_description"),
                        url: "https://www.fifa.com/es/tournaments/mens/worldcup/canadamexicousa2026/articles/copa-mundial-2026-selecciones-clasificadas"
                    )
                }
                .padding(.horizontal)
            }
        }
    }
}


// MARK: - NoticiaCard
struct NoticiaCard: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    let imageName: String
    let title: String
    let subtitle: String
    let url: String
    
    var body: some View {
        NavigationLink(destination: URLView(url: url)) {
            HStack(spacing: 12) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }
                .frame(width: 170, height: 160, alignment: .leading)
            }
            .padding(10)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: .gray.opacity(0.15), radius: 5, x: 0, y: 3)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Widgets de Accesibilidad
struct AccessibilityWidget<Destination: View>: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    let imageName: String
    let title: String
    let description: String
    let color: Color
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                    
                    Text(title)
                        .font(.headline.bold())
                        .foregroundColor(.white)
                        .lineLimit(2)
                }
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .lineLimit(3)
            }
            .padding()
            .frame(width: 190, height: 160, alignment: .topLeading)
            .background(color.opacity(0.75)) 
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: color.opacity(0.3), radius: 5, x: 0, y: 3)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Preview
#Preview {
    HomeView()
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
}
