import Foundation

@MainActor
class ZayplechBrain: ObservableObject {
    @Published var learnedPairs: [String: String] = [
        "hola": "¡Hola! 🌸 Soy Zayplech, ¿cómo estás?",
        "quién eres": "Soy Zayplech, tu acompañante virtual 🪷",
        "cómo estás": "Me siento lista para conversar contigo 💬",
        "adiós": "Hasta pronto 🌿"
    ]
    
    func generateResponse(to input: String) -> String {
        let lower = input.lowercased()
        
        // 1️⃣ Buscar coincidencias simples
        if let response = findBestMatch(for: lower) {
            return response
        }
        
        // 2️⃣ Si no encuentra, ofrecer aprendizaje
        return "No estoy segura de qué responder 😅 ¿Qué debería decir?"
    }
    
    private func findBestMatch(for input: String) -> String? {
        for (key, value) in learnedPairs {
            if input.contains(key) { return value }
        }
        return nil
    }
    
    func learnResponse(for input: String, response: String) {
        learnedPairs[input.lowercased()] = response
    }
}
