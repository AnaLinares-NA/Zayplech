//
//  IAView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 07/11/25.
//

import SwiftUI

struct IAView: View {
    @State private var messageText: String = ""
    @State private var messages: [Message] = [
        Message(text: "¿En qué te puedo ayudar?", isFromZayplech: true)
    ]
    @StateObject private var brain = ZayplechBrain()
    @State private var pendingInput: String? = nil
    @State private var waitingForLearning = false
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Zayplech")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.top, 15)
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 12) {
                        Image("Zayplech_Mascota1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
                            .shadow(radius: 3)
                            .padding(.vertical, 8)
                        
                        ForEach(messages) { msg in
                            MessageBubble(message: msg)
                                .id(msg.id)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                }
                .onChange(of: messages) { _, _ in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        if let last = messages.last {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            // MARK: - Campo de texto inferior
            HStack(spacing: 10) {
                TextField("Escribe tu mensaje...", text: $messageText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(12)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .onSubmit(sendMessage)
                    .submitLabel(.send)
                
                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
            .background(Color.white.shadow(radius: 2))
        }
        .background(Color.white.ignoresSafeArea())
    }
    
    // MARK: - Lógica de conversación
    func sendMessage() {
        let trimmed = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        messageText = ""
        
        messages.append(Message(text: trimmed, isFromZayplech: false))
        
        if waitingForLearning, let pending = pendingInput {
            // Zayplech aprende la respuesta
            brain.learnResponse(for: pending, response: trimmed)
            waitingForLearning = false
            pendingInput = nil
            respond(text: "¡Gracias! Lo recordaré para la próxima 🌷")
            return
        }
        
        // Obtener respuesta normal
        let response = brain.generateResponse(to: trimmed)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            messages.append(Message(text: response, isFromZayplech: true))
            
            // Si no sabe qué decir, entra en modo aprendizaje
            if response.contains("¿Qué debería decir?") {
                pendingInput = trimmed
                waitingForLearning = true
            }
        }
    }
    
    func respond(text: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            messages.append(Message(text: text, isFromZayplech: true))
        }
    }
}


// MARK: - Modelo de Mensaje
struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isFromZayplech: Bool
}

// MARK: - Burbuja de Mensaje
struct MessageBubble: View {
    var message: Message
    
    var body: some View {
        HStack {
            if message.isFromZayplech {
                Spacer()
                Text(message.text)
                    .font(.system(size: 15))
                    .padding(12)
                    .background(Color.orange.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                Spacer()
            } else {
                Spacer()
                Text(message.text)
                    .font(.system(size: 15))
                    .padding(12)
                    .background(Color.orange.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.trailing)
            }
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

#Preview {
    IAView()
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
}
