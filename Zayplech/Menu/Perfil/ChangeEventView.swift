import SwiftUI

struct ChangeEventView: View {
    // Puedes usar un @State para el evento actual seleccionado
    @State private var selectedEvent: String = "Mundial"

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: - Cabecera con título
                HStack {
                    Image(systemName: "circle.fill") // Pequeño círculo naranja
                        .font(.caption)
                        .foregroundColor(.orange)
                    Text("Cambiar de evento")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)

                // MARK: - Evento Actual
                VStack(alignment: .leading, spacing: 10) {
                    Text("Evento actual: \(selectedEvent)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal) // Alinea con el borde de la tarjeta

                    // Tarjeta para el evento actual (Mundial)
                    Image("worldcup_event_card") // Asegúrate de tener esta imagen en tus Assets
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 100) // Altura fija para la tarjeta
                        .cornerRadius(10)
                        .clipped() // Para cortar la imagen si se sale de la esquina
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                        .padding(.horizontal, 10) // Padding dentro de la tarjeta contenedora
                }
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                .padding(.horizontal)

                // MARK: - Registrar un evento nuevo
                VStack(alignment: .leading, spacing: 10) {
                    Text("Registrar un evento nuevo")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal)

                    Button(action: {
                        // Acción para registrar un nuevo evento
                        print("Abrir pantalla para registrar nuevo evento")
                    }) {
                        HStack {
                            Text("Añadir nuevo evento") // Puedes cambiar el texto
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "plus.circle.fill") // Icono para añadir
                                .foregroundColor(.accentColor)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 3)
                    }
                    .padding(.horizontal, 10) // Padding dentro de la tarjeta contenedora
                }
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                .padding(.horizontal)


                // MARK: - Opciones de Eventos Registrados
                VStack(alignment: .leading, spacing: 10) {
                    // Botón para Concierto
                    EventOptionCard(eventName: "Concierto", backgroundImageName: "concert_event_card") {
                        selectedEvent = "Concierto"
                    }

                    // Botón para Feria
                    EventOptionCard(eventName: "Feria", backgroundImageName: "fair_event_card") {
                        selectedEvent = "Feria"
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Perfil")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Componentes Auxiliares para ChangeEventView

// Tarjeta de opción de evento
struct EventOptionCard: View {
    let eventName: String
    let backgroundImageName: String // Nombre de la imagen de fondo en tus Assets
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .overlay(
                    Text(eventName)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.7), radius: 3, x: 0, y: 2)
                )
                .cornerRadius(10)
                .clipped()
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
        }
    }
}

struct ChangeEventView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChangeEventView()
        }
    }
}