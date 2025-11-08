import SwiftUI

struct YourMatchesView: View {
    @State private var newTicketInfo: String = "" // Para el campo de nuevo boleto
    @State private var showingTicketRegistration = false // Para mostrar la vista de registro de boleto

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: - Cabecera con título
                HStack {
                    Image(systemName: "circle.fill") // Pequeño círculo naranja
                        .font(.caption)
                        .foregroundColor(.orange)
                    Text("Sobre tus partidos")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)

                // MARK: - Registrar Nuevo Boleto
                VStack(alignment: .leading, spacing: 10) {
                    Text("Registrar un boleto nuevo")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Button(action: {
                        showingTicketRegistration = true // Activa la sheet para registrar boleto
                    }) {
                        HStack {
                            Text("Consultar boleto \"??? vs ???\"") // Placeholder para el botón de consulta
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "square.and.pencil") // Icono de edición
                                .foregroundColor(.accentColor)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 3)
                    }

                    // Lista de información de un boleto (simulada)
                    VStack(alignment: .leading, spacing: 5) {
                        TicketDetailRow(text: "Fecha y hora")
                        TicketDetailRow(text: "Ubicación del estadio")
                        TicketDetailRow(text: "Ubicación en el estadio (sector, fila y asiento)")
                        TicketDetailRow(text: "Equipo local")
                        TicketDetailRow(text: "Equipo visitante")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 3)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Perfil")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $showingTicketRegistration) {
            // Aquí puedes presentar una vista para registrar un nuevo boleto
            // Por ahora, será una vista simple de ejemplo
            RegisterNewTicketView()
        }
    }
}

// MARK: - Componentes Auxiliares para YourMatchesView

// Fila para detalle de boleto
struct TicketDetailRow: View {
    let text: String

    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .font(.system(size: 8))
                .foregroundColor(.gray)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
}

// Vista de ejemplo para registrar un nuevo boleto
struct RegisterNewTicketView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var matchName: String = ""
    @State private var date: Date = Date()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Detalles del Boleto")) {
                    TextField("Nombre del Partido", text: $matchName)
                    DatePicker("Fecha y Hora", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    // Puedes añadir más campos aquí: estadio, asientos, equipos, etc.
                }
            }
            .navigationTitle("Registrar Boleto")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        // Lógica para guardar el boleto
                        print("Boleto guardado: \(matchName) el \(date)")
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct YourMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            YourMatchesView()
        }
    }
}