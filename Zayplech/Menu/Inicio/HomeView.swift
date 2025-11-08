//
//  HomeView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 21/10/25.
//

import SwiftUI
import Combine
import MapKit


struct HomeView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                
                // MARK: - Título principal
                Text(t("noticia_y_mas"))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .padding(.top, 10)

                NoticiasScrollView()

                CountdownTimerView()

                // MARK: - Boleto y Mapa
                HStack(spacing: 16) {
                    TicketCard() // ya con t() aplicado en textos
                    MapCard()
                }
                .padding(.horizontal)

                // MARK: - Clima
                WeatherWidget()

                RappiWidget()
                
                MapAndUberWidgets()

                AdidasWidget()
            }
        }
        .background()
    }
}

// MARK: - NewsCard
struct NewsCard: View {
    let title: String
    let teaser: String
    let fullText: String
    
    @State private var showSheet = false
    
    var body: some View {
        Button(action: {
            showSheet.toggle()
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Text(teaser)
                        .font(.subheadline)
                        .foregroundColor(.black)
                    
                    Text(t("pulsa_ver_mas"))
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                
                Image(systemName: "figure.soccer")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.moradoMedio)
                    .padding(.leading, 10)
            }
            .padding()
            .frame(width: 320, height: 140)
            .background()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.azulCielo, lineWidth: 2)
            )
            .cornerRadius(16)
            .shadow(radius: 2)
            .padding(.vertical)
        }
        .sheet(isPresented: $showSheet) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(fullText)
                        .font(.body)
                }
            }
        }
    }
}

// MARK: - NoticiasScrollView
struct NoticiasScrollView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                NewsCard(
                    title: t("noticia_argentina_titulo"),
                    teaser: t("noticia_argentina_teaser"),
                    fullText: t("noticia_argentina_fulltext")
                )
                
                NewsCard(
                    title: t("noticia_francia_titulo"),
                    teaser: t("noticia_francia_teaser"),
                    fullText: t("noticia_francia_fulltext")
                )
                
                NewsCard(
                    title: t("noticia_mexico_titulo"),
                    teaser: t("noticia_mexico_teaser"),
                    fullText: t("noticia_mexico_fulltext")
                )
                
                NewsCard(
                    title: t("noticia_eeuu_titulo"),
                    teaser: t("noticia_eeuu_teaser"),
                    fullText: t("noticia_eeuu_fulltext")
                )
                
                NewsCard(
                    title: t("noticia_alemania_titulo"),
                    teaser: t("noticia_alemania_teaser"),
                    fullText: t("noticia_alemania_fulltext")
                )
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - CountdownTimerView
struct CountdownTimerView: View {
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
        VStack(alignment: .center, spacing: 10) {
            Text(t("countdown_title"))
                .font(.headline)
            
            Text(
                String(
                    format: t("countdown_text"),
                    timeRemaining.day ?? 0,
                    timeRemaining.hour ?? 0,
                    timeRemaining.minute ?? 0,
                    timeRemaining.second ?? 0
                )
            )
            .font(.subheadline)
            .multilineTextAlignment(.center)
        }
        .padding()
        .background()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.naranjaMelocoton, lineWidth: 2)
        )
        .cornerRadius(16)
        .frame(maxWidth: .infinity, minHeight: 140)
        .shadow(radius: 2)
        .padding(.horizontal)
        .onReceive(timer) { input in
            now = input
        }
    }
}

// MARK: - TicketCard
struct TicketCard: View {
    @State private var showDetails = false

    var body: some View {
        Button {
            showDetails.toggle()
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Text(t("ticket_title"))
                    .font(.headline)
                    .foregroundColor(.black)
                Text(t("ticket_subtitle"))
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text(t("ticket_teaser"))
                    .font(.footnote)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            .frame(width: 170, height: 170)
            .background()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.lilaSuave, lineWidth: 2)
            )
            .cornerRadius(16)
            .shadow(radius: 2)
        }
        .sheet(isPresented: $showDetails) {
            VStack(alignment: .leading, spacing: 12) {
                Text(t("ticket_details_title"))
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(t("ticket_details_line1"))
                    .font(.body)
                
                Text(t("ticket_details_line2"))
                Text(t("ticket_details_line3"))
                Text(t("ticket_details_line4"))
                Text(t("ticket_details_line5"))
                Text(t("ticket_details_line6"))
                
                Text(t("ticket_details_line7"))
                    .font(.body)
                    .padding(.top)
                
                Spacer()
            }
            .padding()
        }
    }
}

// MARK: - MapCard
struct MapCard: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 19.4333, longitude: -99.1333), // CDMX
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        NavigationLink(destination: MapView()) {
            VStack(alignment: .leading, spacing: 8) {
                Text(t("mapa_titulo"))
                    .font(.headline)
                Text(t("mapa_subtitulo"))
                    .font(.subheadline)

                Map(coordinateRegion: $region)
                    .frame(height: 100)
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding(.top, 4)
            }
            .padding()
            .frame(width: 170, height: 170)
            .background()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.lilaSuave, lineWidth: 2)
            )
            .cornerRadius(16)
            .shadow(radius: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - WeatherWidget
struct WeatherWidget: View {
    var body: some View {
        VStack(spacing: 16) {
            // Top section: current weather
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(t("weather_location"))
                        .font(.headline)
                    Text(t("weather_main_temp"))
                        .font(.system(size: 44, weight: .light))
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Image(systemName: "cloud.bolt.rain.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                    Text(t("weather_condition"))
                        .font(.subheadline)
                    Text(t("weather_max_min"))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }

            // Forecast section
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForecastDayView(day: t("weather_forecast_day10"), icon: "cloud.rain.fill", temp: t("weather_temp10"))
                    ForecastDayView(day: t("weather_forecast_day11"), icon: "cloud.sun.fill", temp: t("weather_temp11"))
                    ForecastDayView(day: t("weather_forecast_day12"), icon: "cloud.sun.fill", temp: t("weather_temp12"))
                    ForecastDayView(day: t("weather_forecast_day13"), icon: "sun.max.fill", temp: t("weather_temp13"))
                    ForecastDayView(day: t("weather_forecast_day14"), icon: "sun.max.fill", temp: t("weather_temp14"))
                    ForecastDayView(day: t("weather_forecast_day15"), icon: "sun.max.fill", temp: t("weather_temp15"))
                }
                .padding(.top, 4)
            }
        }
        .padding()
        .background()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.moradoMedio, lineWidth: 2)
        )
        .cornerRadius(16)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}

// MARK: - ForecastDayView
struct ForecastDayView: View {
    let day: String
    let icon: String
    let temp: String

    var body: some View {
        VStack(spacing: 4) {
            Text(day)
                .font(.footnote)
            Image(systemName: icon)
                .foregroundColor(.orange)
            Text(temp)
                .font(.footnote)
        }
    }
}

// MARK: - RappiWidget
struct RappiWidget: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(t("rappi_titulo"))
                    .font(.headline)
                Text(t("rappi_subtitulo"))
                    .font(.subheadline)
            }
            Spacer()
            Image("logo rappi")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
        }
        .padding()
        .background(Color.rappi)
        .cornerRadius(16)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

// MARK: - MapAndUberWidgets
struct MapAndUberWidgets: View {
    @Environment(\.openURL) var openURL

    var body: some View {
        HStack(spacing: 16) {
            
            // MAP Widget
            NavigationLink(destination: MapView2()) {
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 19.3044, longitude: -99.1505),
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )))
                .frame(width: 170, height: 170)
                .cornerRadius(16)
                .overlay(
                    VStack(alignment: .leading, spacing: 4) {
                        Text(t("mapa_titulo"))
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(t("mapa_subtitulo"))
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding()
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(12)
                    .padding(6),
                    alignment: .topLeading
                )
                .shadow(radius: 4)
            }

            Button {
                if let url = URL(string: "https://apps.apple.com/app/uber/id368677368") {
                    openURL(url)
                }
            } label: {
                VStack(alignment: .leading, spacing: 8) {
                    Spacer()
                    Text(t("uber_titulo"))
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(t("uber_subtitulo"))
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            Image("uberLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 50)
                        }
                    }
                }
                .padding()
                .frame(width: 170, height: 170)
                .background(Color.black)
                .cornerRadius(16)
                .shadow(radius: 4)
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - AdidasWidget
struct AdidasWidget: View {
    var body: some View {
        VStack(spacing: 8) {
            Text(t("adidas_titulo"))
                .font(.headline)
            Text(t("adidas_subtitulo"))
                .font(.subheadline)
                .multilineTextAlignment(.center)
            Image("adidasLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 50)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 2)
        .padding(.horizontal)
        .padding(.bottom, 30)
    }
}

#Preview {
    HomeView()
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
}
