//
//  YourMatchesView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 07/11/25.
//

import SwiftUI

struct YourMatchesView: View {
    @State private var showingTicketRegistration = false
    @State private var tickets: [Ticket] = [
        Ticket(localTeam: "Team A", visitorTeam: "Team B", date: Date(), stadium: "Estadio Central", seat: "Sector 3, Fila 5, Asiento 12")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // MARK: - Cabecera
                VStack(alignment: .leading, spacing: 5) {
                    Text("Sobre tus partidos")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                    
                    Text("Aquí puedes ver tus boletos y registrar nuevos partidos.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // MARK: - Botón Registrar Nuevo Boleto
                Button(action: { showingTicketRegistration = true }) {
                    HStack {
                        Image(systemName: "square.and.pencil")
                            .font(.title2)
                            .foregroundColor(.yellow)
                            .padding(.trailing, 5)
                        
                        Text("Registrar un nuevo boleto")
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.yellow.opacity(0.5), lineWidth: 1)
                    )
                }
                .padding(.horizontal)
                
                // MARK: - Lista de boletos
                VStack(spacing: 15) {
                    ForEach(tickets, id: \.id) { ticket in
                        TicketCardView(ticket: ticket)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        .navigationTitle("Tus Partidos")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingTicketRegistration) {
            RegisterNewTicketView()
        }
    }
}

// MARK: - Modelo de Ticket
struct Ticket: Identifiable {
    let id = UUID()
    let localTeam: String
    let visitorTeam: String
    let date: Date
    let stadium: String
    let seat: String
}

// MARK: - Tarjeta de Boleto
struct TicketCardView: View {
    let ticket: Ticket
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(ticket.localTeam) vs \(ticket.visitorTeam)")
                    .font(.headline)
                    .foregroundColor(.yellow)
                Spacer()
                Image(systemName: "ticket.fill")
                    .foregroundColor(.yellow)
            }

            Divider()

            VStack(alignment: .leading, spacing: 4) {
                TicketDetailRow(text: "Fecha: \(ticket.date.formatted(.dateTime.month().day().hour().minute()))")
                TicketDetailRow(text: "Estadio: \(ticket.stadium)")
                TicketDetailRow(text: "Asiento: \(ticket.seat)")
            }
            .font(.subheadline)
            .foregroundColor(.primary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.03), radius: 3, x: 0, y: 2)
    }
}


// MARK: - Fila de detalle
struct TicketDetailRow: View {
    let text: String
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "circle.fill")
                .font(.system(size: 6))
                .foregroundColor(.gray)
            Text(text)
        }
    }
}

// MARK: - Vista Registrar Nuevo Boleto
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
                }
            }
            .navigationTitle("Registrar Boleto")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") { presentationMode.wrappedValue.dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
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
