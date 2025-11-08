//
//  ZayplechBrain.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 07/11/25.
//

import Foundation
import Combine

final class ZayplechBrain: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    private(set) var learnedPairs: [String: String] = [
        "hola": "¡Hola! 🌸 Soy Zayplech, tu compañera virtual de seguridad y apoyo durante el Mundial. ¿Cómo te sientes hoy?",
        "quien eres?": "Soy Zayplech, tu guía segura y amiga para todo lo relacionado con el Mundial Femenino 🪷",
        "adios": "Hasta pronto 🌿 ¡Cuídate y recuerda revisar nuestros tips de seguridad!"
    ]
    
    // MARK: - Función principal de respuesta
    func generateResponse(to input: String) -> String {
        let lower = input.lowercased()
        
        if containsAny(of: ["peligro", "ayuda", "emergencia", "socorro", "auxilio"]) {
            return "⚠️ Si estás en peligro, llama inmediatamente al 911 (o el número local) y dirígete al lugar seguro más cercano. ¿Quieres que te muestre la ubicación de los lugares seguros cercanos?"
        }
        
        if containsAny(of: ["sola", "segura", "no sé si ir"]) {
            return "🌸 Mantente siempre en lugares concurridos, lleva tu teléfono cargado y revisa los manuales de seguridad femenina dentro de la app. ¿Quieres que te muestre consejos rápidos?"
        }
        
        if containsAny(of: ["miedo", "nerviosa", "estresada", "ansiosa", "no me siento bien"]) {
            return "💛 Respira profundo. No estás sola. Recuerda que puedes revisar tips de seguridad, lugares seguros y contactos de emergencia dentro de la app."
        }
        
        if containsAny(of: ["dato", "estadisticas", "mundial", "partido"]) {
            return getRandomFact()
        }
        
        if containsAny(of: ["gracias", "muchas gracias", "agradezco", "mil gracias", "thank you"]) {
            let thankResponses = [
                "🌸 ¡De nada! Siempre estoy aquí para ayudarte 💛",
                "💛 Me alegra poder ayudarte. Cuídate mucho 🌿",
                "😊 ¡Para eso estoy! Recuerda revisar los lugares seguros y tips de la app.",
                "🌷 ¡Encantada de ayudarte! Mantente segura y disfruta el Mundial."
            ]
            return thankResponses.randomElement() ?? "💛 ¡Siempre aquí para ti!"
        }
        
        if containsAny(of: ["hola", "buenos días", "buenas tardes", "adiós", "chao", "bye"]) {
            return handleGreetings(lower)
        }
        
        if let response = findBestMatch(for: lower) {
            return response
        }
        
        if containsAny(of: ["tip", "recordatorio", "consejo"]) {
            return getQuickTip()
        }
        
        return "🤔 No estoy segura de qué responder 😅. ¿Quieres enseñarme qué debería decir en esta situación?"
        
        // Helper para containsAny
        func containsAny(of keywords: [String]) -> Bool {
            for key in keywords {
                if lower.contains(key) { return true }
            }
            return false
        }
    }
    
    // MARK: - Buscar coincidencias aprendidas
    private func findBestMatch(for input: String) -> String? {
        for (key, value) in learnedPairs {
            if input.contains(key) { return value }
        }
        return nil
    }
    
    // MARK: - Aprender nuevas respuestas de manera segura
    func learnResponse(for input: String, response: String) {
        // Validación básica: solo palabras seguras
        let forbiddenWords = ["violencia", "arma", "droga"] // puedes ampliar
        for word in forbiddenWords {
            if response.lowercased().contains(word) { return }
        }
        
        learnedPairs[input.lowercased()] = response
        objectWillChange.send()
    }
    
    // MARK: - Datos curiosos del Mundial
    private func getRandomFact() -> String {
        let facts = [
            "⚽ La Copa del Mundo Femenina 2026 se jugará en Norteamérica. ¡Prepárate para apoyar a tu equipo favorito!",
            "🌎 Más de 30 países competirán en la próxima edición del Mundial Femenino.",
            "🎯 La seguridad de las fanáticas es prioridad: siempre busca puntos de información y lugares seguros.",
            "🏟️ Los estadios contarán con zonas de asistencia y apoyo exclusivo para mujeres.",
            "🥅 ¿Sabías que la final será transmitida a nivel mundial? ¡No te la pierdas!"
        ]
        return facts.randomElement() ?? "⚽ ¡Disfruta el Mundial y mantente segura!"
    }
    
    // MARK: - Saludos y despedidas
    private func handleGreetings(_ lower: String) -> String {
        if lower.contains("hola") || lower.contains("buenos días") || lower.contains("buenas tardes") {
            return "🌸 ¡Hola! ¿Cómo estás hoy? 💛"
        } else if lower.contains("adiós") || lower.contains("chao") {
            return "🌿 ¡Hasta pronto! Mantente segura y disfruta del Mundial."
        }
        return "😊 ¡Hola!"
    }
    
    // MARK: - Tips rápidos / recordatorios
    private func getQuickTip() -> String {
        let tips = [
            "💡 Tip: Mantén tu teléfono cargado y comparte tu ubicación con amigas.",
            "🌸 Tip de seguridad: Siempre usa transporte confiable y evita zonas solitarias.",
            "🦋 Recordatorio: Revisa nuestros manuales de seguridad femenina en la app.",
            "⚠️ Tip rápido: Ante cualquier emergencia, llama al número local de ayuda."
        ]
        return tips.randomElement() ?? "💡 ¡Recuerda mantenerte segura!"
    }
}
