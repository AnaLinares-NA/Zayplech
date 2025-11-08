import SwiftUI
import CoreLocation
import Combine

// MARK: - WeatherCard Animado
struct WeatherCardAnimado: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var weatherManager = WeatherManager()
    
    @State private var animateSun = false
    @State private var animateCloud = false
    @State private var animateRain = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("¡No dejes que el clima te arruine la emoción!")
                .font(.subheadline.bold())
                .foregroundColor(.white.opacity(0.9))
            
            ZStack {
                // Fondo dinámico
                LinearGradient(
                    gradient: Gradient(colors: gradientForCondition(weatherManager.iconName)),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                // Elementos animados
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(weatherManager.temperature)°C")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(weatherManager.condition)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    ZStack {
                        if weatherManager.iconName.contains("sun") {
                            Image(systemName: "sun.max.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.yellow)
                                .rotationEffect(.degrees(animateSun ? 360 : 0))
                                .animation(.linear(duration: 20).repeatForever(autoreverses: false), value: animateSun)
                        }
                        
                        if weatherManager.iconName.contains("cloud") {
                            Image(systemName: "cloud.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .offset(x: animateCloud ? 10 : -10)
                                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animateCloud)
                        }
                        
                        if weatherManager.iconName.contains("rain") {
                            RainView()
                                .frame(width: 50, height: 50)
                                .opacity(animateRain ? 1 : 0)
                                .animation(.easeInOut(duration: 0.5).repeatForever(), value: animateRain)
                        }
                    }
                }
                .padding()
            }
            .frame(height: 120)
        }
        .padding(.horizontal)
        .onAppear {
            animateSun = true
            animateCloud = true
            animateRain = true
        }
        .onReceive(locationManager.$location.compactMap { $0 }) { loc in
            weatherManager.fetchWeather(lat: loc.latitude, lon: loc.longitude)
        }
    }
    
    private func gradientForCondition(_ icon: String) -> [Color] {
        switch icon {
        case "sun.max.fill":
            return [Color.yellow.opacity(0.8), Color.orange.opacity(0.6)]
        case "cloud.fill", "cloud.sun.fill":
            return [Color.gray.opacity(0.7), Color.blue.opacity(0.5)]
        case "cloud.rain.fill", "cloud.bolt.rain.fill":
            return [Color.blue.opacity(0.7), Color.gray.opacity(0.6)]
        case "snow":
            return [Color.white.opacity(0.8), Color.blue.opacity(0.3)]
        default:
            return [Color.blue.opacity(0.6), Color.purple.opacity(0.5)]
        }
    }
}

// MARK: - Vista simple de lluvia animada
struct RainView: View {
    @State private var offsetY: CGFloat = -10
    
    var body: some View {
        Rectangle()
            .fill(Color.blue.opacity(0.6))
            .frame(width: 2, height: 10)
            .offset(y: offsetY)
            .onAppear {
                withAnimation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false)) {
                    offsetY = 10
                }
            }
    }
}
