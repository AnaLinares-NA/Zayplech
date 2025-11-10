//
//  AidTexts.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 07/11/25.
//

import SwiftUI

import Foundation

struct AidStep: Identifiable {
    let id = UUID()
    let number: Int
    let icon: String
    let description: String
}

struct AidContent: Identifiable {
    let id = UUID()
    let title: String
    let steps: [AidStep]
}

// Contenido de ejemplo
let faintingContent = AidContent(
    title: "Desmayos",
    steps: [
        AidStep(number: 1, icon: "figure.stand", description: "Mantén la calma y verifica si la persona responde."),
        AidStep(number: 2, icon: "bed.double", description: "Acuéstala boca arriba en el suelo."),
        AidStep(number: 3, icon: "arrow.up", description: "Eleva sus piernas unos 30 cm."),
        AidStep(number: 4, icon: "tshirt", description: "Afloja la ropa ajustada."),
        AidStep(number: 5, icon: "wind", description: "Asegura aire fresco."),
        AidStep(number: 6, icon: "drop", description: "No le des nada de comer o beber."),
        AidStep(number: 7, icon: "phone.fill", description: "Si no despierta o no respira, llama al 911."),
        AidStep(number: 8, icon: "figure.walk", description: "Mantén recostada unos minutos antes de incorporarse.")
    ]
)

let heatstrokeContent = AidContent(
    title: "Insolación",
    steps: [
        AidStep(number: 1, icon: "sun.max.fill", description: "Lleva a la persona a un lugar fresco."),
        AidStep(number: 2, icon: "tshirt", description: "Afloja ropa y aplica paños húmedos."),
        AidStep(number: 3, icon: "drop", description: "Ofrécele pequeños sorbos de agua."),
        AidStep(number: 4, icon: "no.drink", description: "No bebidas alcohólicas, cafeína ni muy frías."),
        AidStep(number: 5, icon: "phone.fill", description: "Si confusión o pierde el conocimiento, llama al 911.")
    ]
)

let cutContent = AidContent(
    title: "Cortaduras",
    steps: [
        AidStep(number: 1, icon: "hand.raised.fill", description: "Lava tus manos antes de tocar la herida."),
        AidStep(number: 2, icon: "bandage.fill", description: "Aplica presión para detener el sangrado."),
        AidStep(number: 3, icon: "drop", description: "Limpia la herida con agua y jabón."),
        AidStep(number: 4, icon: "bandage.fill", description: "Cubre con venda o apósito estéril."),
        AidStep(number: 5, icon: "phone.fill", description: "Si la herida es profunda o sigue sangrando, busca atención médica.")
    ]
)

let firstAidContents = [faintingContent, heatstrokeContent, cutContent]
