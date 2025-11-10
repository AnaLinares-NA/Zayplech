//
//  ZonaAccesibilidadView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 08/11/25.
//

import SwiftUI

struct ZonaAccesibilidadView: View {
    @State private var showMapa: Bool = false
    
    let lightGray = Color(red: 0.95, green: 0.95, blue: 0.95)

    @State private var zoomScale: CGFloat = 1.0
    @State private var lastZoomScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if showMapa {
                    VStack(spacing: 0) {
                        HStack {
                            Button(action: { showMapa = false }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.gray)
                                    .frame(width: 44, height: 44)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)

                        HStack{
                            Image("zona_de_accesibilidad")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            
                            Text("Zonas de accesibilidad")
                                .font(.custom("HelveticaNeue-Bold", size: 24))
                                .foregroundColor(.blue)
 
                        }
                        .padding(20)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("ESTADIO BBVA")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("UBICACIÓN DENTRO DEL ESTADIO")
                                .font(.caption2)
                                .foregroundColor(.black)
                            Text("PLANTA BAJA")
                                .font(.caption2.bold())
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 25)
                        
                        Color.clear
                            .overlay(
                                Image("MapaPB")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.azulCielo, lineWidth: 3)
                                    )
                                    .offset(offset)
                                    .scaleEffect(zoomScale)
                                    .gesture(
                                        MagnificationGesture()
                                            .onChanged { value in
                                                zoomScale = lastZoomScale * value
                                            }
                                            .onEnded { _ in
                                                lastZoomScale = zoomScale
                                                if zoomScale < 0.5 { zoomScale = 0.5 }
                                                if zoomScale > 3.0 { zoomScale = 3.0 }
                                                lastZoomScale = zoomScale
                                            }
                                    )
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                var newOffset = CGSize(
                                                    width: lastOffset.width + value.translation.width,
                                                    height: lastOffset.height + value.translation.height
                                                )
                                                let maxPan: CGFloat = 200 * zoomScale
                                                newOffset.width = min(max(newOffset.width, -maxPan), maxPan)
                                                newOffset.height = min(max(newOffset.height, -maxPan), maxPan)
                                                offset = newOffset
                                            }
                                            .onEnded { _ in
                                                lastOffset = offset
                                            }
                                    )
                                    .frame(width: 350, height: 350)
                            )
                            .frame(height: 350)
                            .padding(.horizontal, 25)
                            .padding(.bottom, 20)

                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 10) {
                                LegendItem(imageName: "line.diagonal", text: "SIN ACCESO", isSymbol: true)
                                LegendItem(imageName: "stairs", text: "ESCALERAS", isSymbol: true)
                                LegendItem(imageName: "fork.knife", text: "CONCESIONES", isSymbol: true)
                                LegendItem(imageName: "cross.fill", text: "ENFERMERÍA", isSymbol: true)
                                LegendItem(imageName: "figure.roll", text: "BAÑO HOMBRES", isSymbol: true, customColor: .blue)
                                LegendItem(imageName: "figure.roll", text: "BAÑO MUJERES", isSymbol: true, customColor: .pink)
                                LegendItem(imageName: "figure.roll", text: "BAÑO MUJERES + BAÑO FAMILIAR", isSymbol: true, customColor: .moradoMedio)
                                LegendItem(imageName: "questionmark.circle.fill", text: "ATENCIÓN AL AFICIONADO", isSymbol: true, customColor: .blue)
                            }
                            .padding(.horizontal, 30)
                            .padding(.bottom, 20)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(maxHeight: .infinity)
                    }
                    .background(lightGray)
                } else {
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Zonas de accesibilidad")
                                .font(.largeTitle.bold())
                                .foregroundColor(.blue)
                            
                            Text("Selecciona el estadio en el que desees conocer sus zonas accesibles.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Image("estadioBBVA")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .clipped()
                            
                            HStack {
                                HStack(spacing: 8) {
                                    Image("zona_de_accesibilidad")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                    
                                    Text("Estadio BBVA")
                                        .font(.body.bold())
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    showMapa.toggle()
                                }) {
                                    Text("Seleccionar")
                                        .font(.caption.bold())
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 12)
                                        .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(.blue.opacity(0.15))
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(.blue, lineWidth: 1)
                                        )
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.blue.opacity(0.05))
                        )
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Vista auxiliar de leyenda
struct LegendItem: View {
    let imageName: String
    let text: String
    let isSymbol: Bool
    var customColor: Color = .gray
    
    var body: some View {
        HStack(spacing: 10) {
            if isSymbol {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(customColor)
            } else {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 20)
            }
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.black)
        }
    }
}

// MARK: - Preview
#Preview {
    ZonaAccesibilidadView()
}
