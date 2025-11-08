//
//  WeatherManager.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//


import Foundation
import Combine

class WeatherManager: ObservableObject {
    @Published var temperature: Int = 22
    @Published var condition: String = "Parcialmente nublado"
    @Published var iconName: String = "cloud.sun.fill"
    
    func fetchWeather(lat: Double, lon: Double) {
        // Simulamos una llamada a la API con un pequeño retraso
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Aquí puedes cambiar el clima para probar animaciones
            let sampleWeathers = [
                (temp: 25, cond: "Soleado", icon: "sun.max.fill"),
                (temp: 18, cond: "Tormentas", icon: "cloud.bolt.rain.fill"),
                (temp: 20, cond: "Nublado", icon: "cloud.fill")
            ]
            let random = sampleWeathers.randomElement()!
            self.temperature = random.temp
            self.condition = random.cond
            self.iconName = random.icon
        }
    }
}
