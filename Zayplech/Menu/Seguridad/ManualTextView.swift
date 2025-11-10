//
//  ManualTextView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI

struct ManualStep: Identifiable {
    let id = UUID()
    let number: Int
    let icon: String
    let description: String
}

struct ManualContent: Identifiable {
    let id = UUID()
    let title: String
    let steps: [ManualStep]
}

// MARK: - Contenido de los manuales

let assaultContent = ManualContent(
    title: "¿Qué hacer en caso de un asalto?",
    steps: [
        ManualStep(number: 1, icon: "heart.gauge.open", description: "Tu vida es lo más valioso. No opongas resistencia y entrega tus objetos de valor."),
        ManualStep(number: 2, icon: "eye.fill", description: "Mantén la calma y memoriza rasgos del agresor."),
        ManualStep(number: 3, icon: "phone.fill", description: "Reporta a las autoridades: 089 o 911.")
    ]
)

let reportContent = ManualContent(
    title: "Cómo poner una denuncia",
    steps: [
        ManualStep(number: 1, icon: "doc.text.fill", description: "Reúne toda la información: fechas, lugares, nombres y descripción de hechos."),
        ManualStep(number: 2, icon: "person.fill.questionmark", description: "Acude al Ministerio Público o usa plataformas digitales oficiales."),
        ManualStep(number: 3, icon: "checkmark.seal.fill", description: "Obtén comprobante de tu denuncia y sigue las indicaciones de las autoridades.")
    ]
)

let extortionContent = ManualContent(
    title: "Guía ante extorsión",
    steps: [
        ManualStep(number: 1, icon: "exclamationmark.triangle.fill", description: "Mantén la calma y no realices pagos inmediatos."),
        ManualStep(number: 2, icon: "phone.fill", description: "Contacta de inmediato a las autoridades (911) y a tus contactos de confianza."),
        ManualStep(number: 3, icon: "lock.fill", description: "No compartas información personal ni contraseñas con desconocidos."),
        ManualStep(number: 4, icon: "doc.text.fill", description: "Registra toda comunicación como evidencia para presentar a las autoridades.")
    ]
)

let earthquakeContent = ManualContent(
    title: "Protocolos sismos",
    steps: [
        ManualStep(number: 1, icon: "figure.walk.motion", description: "Si estás en la calle, aléjate de edificios, postes y cables. Busca un lugar abierto."),
        ManualStep(number: 2, icon: "building.2.fill", description: "Si estás en un edificio, no uses el elevador. Repliégate en zona de seguridad y cubre tu cabeza."),
        ManualStep(number: 3, icon: "hand.raised.fill", description: "No salgas hasta que el movimiento termine.")
    ]
)

let fireContent = ManualContent(
    title: "Protocolos incendios",
    steps: [
        ManualStep(number: 1, icon: "flame.fill", description: "Agáchate para evitar el humo, ya que tiende a subir."),
        ManualStep(number: 2, icon: "door.left.hand.open", description: "Si una puerta está caliente, no la abras."),
        ManualStep(number: 3, icon: "figure.walk", description: "Busca la salida de emergencia más cercana y evacúa con calma."),
        ManualStep(number: 4, icon: "phone.fill", description: "Llama al 911 en cuanto estés a salvo.")
    ]
)

let publicTransportContent = ManualContent(
    title: "Seguridad en transporte público",
    steps: [
        ManualStep(number: 1, icon: "car.fill", description: "Utiliza taxis de sitio autorizados o apps de transporte reconocidas (Uber, Didi)."),
        ManualStep(number: 2, icon: "location.fill", description: "Evita tomar taxis en la calle, especialmente de noche."),
        ManualStep(number: 3, icon: "person.2.fill", description: "Comparte tu viaje en tiempo real con un contacto de confianza."),
        ManualStep(number: 4, icon: "creditcard.fill", description: "Mantén tu bolso o mochila al frente y no pierdas de vista tus objetos.")
    ]
)

let crowdsContent = ManualContent(
    title: "Precauciones en eventos masivos",
    steps: [
        ManualStep(number: 1, icon: "person.3.fill", description: "Define un punto de encuentro con tu grupo por si se separan."),
        ManualStep(number: 2, icon: "arrow.up.right.circle.fill", description: "Ubica las salidas de emergencia al llegar al lugar."),
        ManualStep(number: 3, icon: "figure.stand", description: "Si hay estampida, muévete con la multitud, no en contra, e intenta mantenerte de pie."),
        ManualStep(number: 4, icon: "shield.lefthalf.filled", description: "Protege tu pecho con los brazos y mantén a los niños cerca si los hay.")
    ]
)

// MARK: - Contenido adicional

let alertEnvironmentContent = ManualContent(
    title: "Mantente alerta a tu entorno",
    steps: [
        ManualStep(number: 1, icon: "eye.fill", description: "Evita caminar sola en calles oscuras o poco transitadas."),
        ManualStep(number: 2, icon: "figure.walk", description: "Confía en tu intuición; si algo se siente mal, busca un lugar seguro, como un negocio abierto o un módulo de policía."),
        ManualStep(number: 3, icon: "headphones", description: "Procura no llevar audífonos con volumen alto para poder escuchar lo que sucede a tu alrededor.")
    ]
)

let harassmentProtocolContent = ManualContent(
    title: "Protocolo en caso de acoso (callejero o digital)",
    steps: [
        ManualStep(number: 1, icon: "shield.fill", description: "Si te sientes en riesgo, prioriza tu seguridad. No confrontes si no es seguro."),
        ManualStep(number: 2, icon: "phone.fill", description: "Busca ayuda de inmediato llamando al 911."),
        ManualStep(number: 3, icon: "building.2.fill", description: "Si es acoso callejero, entra a un lugar concurrido."),
        ManualStep(number: 4, icon: "lock.fill", description: "Si es acoso digital, bloquea, reporta y guarda evidencia (capturas de pantalla)."),
        ManualStep(number: 5, icon: "person.crop.circle.badge.xmark", description: "No compartas información personal con desconocidos.")
    ]
)

let redFlagsContent = ManualContent(
    title: "Identificando 'Banderas Rojas' (Señales de alerta)",
    steps: [
        ManualStep(number: 1, icon: "exclamationmark.triangle.fill", description: "Aprende a identificar comportamientos de control: qué ropa usar, con quién hablar."),
        ManualStep(number: 2, icon: "heart.slash.fill", description: "Celos excesivos o aislamiento de amigos/familia."),
        ManualStep(number: 3, icon: "hand.raised.fill", description: "Manipulación emocional: hacerte sentir culpable por sus acciones.")
    ]
)

let transportDatingTipsContent = ManualContent(
    title: "Tips de seguridad en transporte y apps de citas",
    steps: [
        ManualStep(number: 1, icon: "car.fill", description: "Verifica siempre la placa y el conductor antes de subir a un auto de app."),
        ManualStep(number: 2, icon: "location.fill", description: "Comparte tu viaje en tiempo real con alguien de confianza."),
        ManualStep(number: 3, icon: "person.2.fill", description: "En apps de citas, reúnete las primeras veces en lugares públicos y avisa a alguien dónde estarás.")
    ]
)

let supportNetworkContent = ManualContent(
    title: "Cómo crear tu red de apoyo",
    steps: [
        ManualStep(number: 1, icon: "person.3.fill", description: "Define 'Contactos de confianza'."),
        ManualStep(number: 2, icon: "message.fill", description: "Ten un código de emergencia (una palabra clave) con familia o amigos para alertar que estás en problemas."),
        ManualStep(number: 3, icon: "map.fill", description: "Infórmales sobre tus rutas habituales o si saldrás de la rutina.")
    ]
)

// Array con todos los manuales extra
let additionalManualContents = [
    alertEnvironmentContent,
    harassmentProtocolContent,
    redFlagsContent,
    transportDatingTipsContent,
    supportNetworkContent
]

// Array con todos los manuales
let allManualContents = [
    assaultContent,
    reportContent,
    extortionContent,
    earthquakeContent,
    fireContent,
    publicTransportContent,
    crowdsContent
]
