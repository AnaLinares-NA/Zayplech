//
//  TraduccionView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 21/10/25.
//

import Foundation
import AVFoundation
import Speech
import SwiftUI
import Combine

class VoiceRecognitionViewModel: ObservableObject {
    @Published var textoReconocido = ""
    @Published var textoTraducido = ""
    @Published var isRecording = false
    @Published var micPermissionGranted = false
    @Published var speechPermissionGranted = false
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    let isPreview: Bool
        
        init(isPreview: Bool = false) {
            self.isPreview = isPreview
            if isPreview {
                // Setup mock data para preview si quieres
                textoReconocido = "Texto de ejemplo en preview"
                textoTraducido = "ejemplo neivorp ne otxeT"
                micPermissionGranted = true
                speechPermissionGranted = true
                isRecording = false
            }
        }
    
    var idiomaOrigen: String = "es"
    var idiomaDestino: String = "en"
    
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    func requestPermissions() {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                self.micPermissionGranted = granted
                if !granted {
                    self.alertMessage = NSLocalizedString("permiso_microfono_denegado", comment: "")
                    self.showAlert = true
                }
            }
        }
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    self.speechPermissionGranted = true
                case .denied:
                    self.alertMessage = NSLocalizedString("permiso_voz_denegado", comment: "")
                    self.showAlert = true
                default:
                    self.speechPermissionGranted = false
                }
            }
        }
    }
    
    func startRecording() {
        guard !isPreview else {
            print("Preview mode: startRecording no hace nada")
            return
        }
        
        recognitionTask?.cancel()
        recognitionTask = nil
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            alertMessage = NSLocalizedString("error_configurar_audio", comment: "")
            showAlert = true
            return
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            alertMessage = NSLocalizedString("error_inicio_reconocimiento", comment: "")
            showAlert = true
            return
        }
        recognitionRequest.shouldReportPartialResults = true
        
        let locale = Locale(identifier: idiomaOrigen)
        guard let speechRecognizer = SFSpeechRecognizer(locale: locale), speechRecognizer.isAvailable else {
            alertMessage = NSLocalizedString("error_reconocedor_no_disponible", comment: "")
            showAlert = true
            return
        }
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result {
                DispatchQueue.main.async {
                    self.textoReconocido = result.bestTranscription.formattedString
                    // Mock traducción: invertir texto
                    self.textoTraducido = String(self.textoReconocido.reversed())
                }
            }
            
            if let error = error {
                print("Error reconocimiento: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.stopRecording()
                }
            }
        }
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.removeTap(onBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
            DispatchQueue.main.async {
                self.isRecording = true
                self.textoReconocido = ""
                self.textoTraducido = ""
            }
        } catch {
            alertMessage = NSLocalizedString("error_inicio_audio", comment: "")
            showAlert = true
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        isRecording = false
    }
    
    func speakTranslation() {
        guard !textoTraducido.isEmpty else { return }
        let utterance = AVSpeechUtterance(string: textoTraducido)
        utterance.voice = AVSpeechSynthesisVoice(language: idiomaDestino)
        speechSynthesizer.speak(utterance)
    }
}

// MARK: - ProfileView
struct TraduccionView: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    @StateObject private var viewModel: VoiceRecognitionViewModel

        init(isPreview: Bool = false) {
            _viewModel = StateObject(wrappedValue: VoiceRecognitionViewModel(isPreview: isPreview))
        }
    
    let idiomas = ["es": "Español", "en": "Inglés", "fr": "Francés", "de": "Alemán", "it": "Italiano"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                HStack(spacing: 20) {
                    VStack {
                        Text(t("traduccion_idioma_origen"))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Picker("Idioma Origen", selection: $viewModel.idiomaOrigen)  {
                            ForEach(idiomas.keys.sorted(), id: \.self) { key in
                                Text(idiomas[key] ?? key)
                                    .foregroundColor(.white)  // texto en blanco
                                    .tag(key)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color.naranjaMelocoton)
                        .cornerRadius(8)
                    }
                    
                    VStack {
                        Text(t("traduccion_idioma_destino"))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Picker("Idioma Destino", selection: $viewModel.idiomaDestino) {
                            ForEach(idiomas.keys.sorted(), id: \.self) { key in
                                Text(idiomas[key] ?? key)
                                    .foregroundColor(.white)  // texto en blanco
                                    .tag(key)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color.naranjaMelocoton)
                        .cornerRadius(8)
                    }
                }

                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(t("traduccion_texto_reconocido"))
                        .font(.headline)
                    ScrollView {
                        Text(viewModel.textoReconocido.isEmpty ? t("traduccion_esperando") : viewModel.textoReconocido)
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .background(Color.azulCielo.opacity(0.1))
                            .cornerRadius(10)
                    }
                    
                    Text(t("traduccion_texto_traducido"))
                        .font(.headline)
                    ScrollView {
                        Text(viewModel.textoTraducido.isEmpty ? t("traduccion_esperando") : viewModel.textoTraducido)
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .background(Color.lilaSuave.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                HStack(spacing: 30) {
                    Button(action: {
                        viewModel.isRecording ? viewModel.stopRecording() : viewModel.startRecording()
                    }) {
                        Image(systemName: viewModel.isRecording ? "mic.fill" : "mic.slash.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                            .background(viewModel.isRecording ? Color.rosaMagenta : Color.moradoMedio)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .disabled(!viewModel.micPermissionGranted || !viewModel.speechPermissionGranted)
                    .animation(.easeInOut, value: viewModel.isRecording)
                    
                    Button(action: viewModel.speakTranslation) {
                        Image(systemName: "speaker.wave.2.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color.blanco)
                            .padding()
                            .background(Color.azulCielo)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .disabled(viewModel.textoTraducido.isEmpty)
                }
                .padding(.top)
                
                Spacer()
            }
            .background(Color.blanco.ignoresSafeArea())
            .onAppear {
                viewModel.requestPermissions()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(t("error")), message: Text(viewModel.alertMessage), dismissButton: .default(Text(t("aceptar"))))
            }
        }
    }
}


#Preview {
    TraduccionView(isPreview: true)
        .environmentObject(LocalizationManager.shared)
        .environment(\.locale, Locale(identifier: "es"))
}
