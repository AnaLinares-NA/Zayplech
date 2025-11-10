//
//  WeatherManager.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import Foundation
import Combine
import SwiftUI

class WeatherManager: ObservableObject {
    @Published var temperature: Int = 22
    @Published var condition: String = ""
    @Published var iconName: String = "cloud.sun.fill"
    
    private var conditionKey: String = "weather_partially_cloudy"
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Suscribirse al idioma actual
        LocalizationManager.shared.$currentLanguage
            .sink { [weak self] _ in
                self?.updateLocalizedCondition()
            }
            .store(in: &cancellables)
        
        // Inicializar condición
        updateLocalizedCondition()
    }
    
    func fetchWeather(lat: Double, lon: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let sampleWeathers = [
                (temp: 25, condKey: "weather_sunny", icon: "sun.max.fill"),
                (temp: 18, condKey: "weather_thunderstorms", icon: "cloud.bolt.rain.fill"),
                (temp: 20, condKey: "weather_cloudy", icon: "cloud.fill")
            ]
            
            let random = sampleWeathers.randomElement()!
            self.temperature = random.temp
            self.iconName = random.icon
            self.conditionKey = random.condKey
            self.updateLocalizedCondition()
        }
    }
    
    private func updateLocalizedCondition() {
        // Usamos NSLocalizedString directamente
        self.condition = NSLocalizedString(conditionKey, comment: "Estado del clima")
    }
}
