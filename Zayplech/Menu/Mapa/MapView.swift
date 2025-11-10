//
//  MapView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 21/10/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var searchBarText: String = ""
    @State private var showCategories: Bool = true
    @State private var showStadiumsSheet = false
    @State private var showHospitalsSheet = false
    @State private var showRefugiosSheet = false
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )
    
    @State private var localSearch: MKLocalSearch? = nil
    @State private var searchPin: LocationPin? = nil
    @State private var stadiums = StadiumsData.stadiums
    @State private var hospitals = HospitalDataView.hospitals
    @State private var refugios = RefugiosDataView.refugios
    
    // MARK: Pines seleccionados por categoría
    var selectedPins: [LocationPin] {
        var pins: [LocationPin] = []
        
        pins += stadiums.filter { $0.isSelected }.map { LocationPin(coordinate: $0.coordinate) }
        pins += hospitals.filter { $0.isSelected }.map { LocationPin(coordinate: $0.coordinate) }
        pins += refugios.filter { $0.isSelected }.map { LocationPin(coordinate: $0.coordinate) }
        
        return pins
    }
    
    // MARK: Todos los pines visibles (seleccionados + búsqueda)
    var allPins: [LocationPin] {
        var pins = selectedPins
        if let searchPin = searchPin {
            pins.append(searchPin)
        }
        return pins
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                // MARK: Barra de búsqueda + botón desplegable
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        
                        TextField("¿A dónde quieres ir?", text: $searchBarText, onCommit: {
                            searchLocation()
                        })
                        .padding(.vertical, 10)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                    
                    Spacer().frame(width: 15)
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            showCategories.toggle()
                        }
                    }) {
                        Image(systemName: showCategories ? "chevron.down.circle.fill" : "chevron.up.circle.fill")
                            .foregroundColor(.orange)
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                
                // MARK: Categorías horizontales
                if showCategories {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            
                            CategoryIconView(imageName: "restaurante", text: "Restaurantes")
                            Button(action: {
                                withAnimation(.spring()) { showStadiumsSheet.toggle() }
                            }) { CategoryIconView(imageName: "estadios", text: "Estadios") }
                            Button(action: {
                                withAnimation(.spring()) { showHospitalsSheet.toggle() }
                            }) { CategoryIconView(imageName: "hospitales", text: "Hospitales") }
                            Button(action: {
                                withAnimation(.spring()) { showRefugiosSheet.toggle() }
                            }) { CategoryIconView(imageName: "refugios", text: "Refugio") }
                            CategoryIconView(imageName: "tu_hospedaje", text: "Hospedaje")
                            CategoryIconView(imageName: "casas_de_cambio", text: "Casas de Cambio")
                            CategoryIconView(imageName: "entretenimiento", text: "Entretenimiento")
                            CategoryIconView(imageName: "parques", text: "Parques")
                            CategoryIconView(imageName: "museos", text: "Museos")
                        }
                        .padding(.horizontal, 5)
                    }
                    .padding(.bottom, 20)
                    .transition(.asymmetric(
                        insertion: .move(edge: .top).combined(with: .opacity),
                        removal: .move(edge: .top).combined(with: .opacity)
                    ))
                }
                
                // MARK: Mapa principal
                Map(coordinateRegion: $region, interactionModes: [.all], annotationItems: allPins) { pin in
                    MapMarker(coordinate: pin.coordinate, tint: .red)
                }
                .edgesIgnoringSafeArea(.all)
            }
            
            // MARK: Sheet Estadios
            if showStadiumsSheet {
                sheetOverlay { StadiumsSheetView(stadiums: $stadiums) } closeAction: { showStadiumsSheet = false }
            }
            
            // MARK: Sheet Hospitales
            if showHospitalsSheet {
                sheetOverlay { HospitalSheetView(hospitals: $hospitals) } closeAction: { showHospitalsSheet = false }
            }
            
            // MARK: Sheet Refugios
            if showRefugiosSheet {
                sheetOverlay { RefugiosSheetView(refugios: $refugios) } closeAction: { showRefugiosSheet = false }
            }
        }
        // MARK: Observa cambios en selección
        .onChange(of: stadiums.map { $0.isSelected }) { _ in adjustMapRegion() }
        .onChange(of: hospitals.map { $0.isSelected }) { _ in adjustMapRegion() }
        .onChange(of: refugios.map { $0.isSelected }) { _ in adjustMapRegion() }
    }
    
    // MARK: - Buscar ubicaciones
    func searchLocation() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        localSearch = MKLocalSearch(request: request)
        localSearch?.start { response, error in
            guard let coordinate = response?.mapItems.first?.placemark.coordinate else { return }
            withAnimation {
                region.center = coordinate
                region.span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                searchPin = LocationPin(coordinate: coordinate)
            }
        }
    }
    
    // MARK: - Ajusta región según los pines seleccionados
    func adjustMapRegion() {
        let coords = selectedPins.map { $0.coordinate }
        guard !coords.isEmpty else { return }
        
        let minLat = coords.map { $0.latitude }.min()! - 0.03
        let maxLat = coords.map { $0.latitude }.max()! + 0.03
        let minLon = coords.map { $0.longitude }.min()! - 0.03
        let maxLon = coords.map { $0.longitude }.max()! + 0.03
        
        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat)/2,
                                            longitude: (minLon + maxLon)/2)
        let span = MKCoordinateSpan(latitudeDelta: maxLat - minLat,
                                    longitudeDelta: maxLon - minLon)
        
        withAnimation {
            region.center = center
            region.span = span
        }
    }
}

// MARK: - Componente reutilizable de sheet con fondo
extension MapView {
    @ViewBuilder
    func sheetOverlay<Content: View>(@ViewBuilder content: @escaping () -> Content, closeAction: @escaping () -> Void) -> some View {
        VStack {
            Spacer()
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button(action: { withAnimation(.spring()) { closeAction() } }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.orange)
                    }
                }
                .padding()
                Divider()
                content()
                    .frame(maxHeight: 300)
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding(.horizontal)
            .padding(.bottom, 30)
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
        .edgesIgnoringSafeArea(.bottom)
        .zIndex(1)
    }
}

// MARK: - Modelo Pin
struct LocationPin: Identifiable, Equatable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    static func == (lhs: LocationPin, rhs: LocationPin) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Categoría Icono
struct CategoryIconView: View {
    let imageName: String
    let text: String
    var iconSize: CGFloat = 60

    var body: some View {
        VStack(spacing: 5) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: iconSize, height: iconSize)
            Text(text)
                .font(.caption2)
                .foregroundColor(.black)
                .lineLimit(1)
                .frame(width: 70)
        }
    }
}

#Preview {
    MapView()
}
