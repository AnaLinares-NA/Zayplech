import SwiftUI

struct MenuView: View {
    @Binding var showMenu: Bool
    @EnvironmentObject var localizationManager: LocalizationManager

    let idiomas = [
        "en": "English",
        "fr": "Français",
        "de": "Deutsch",
        "it": "Italiano",
        "pt": "Português",
        "ja": "日本語",
        "ar": "العربية",
        "zh-Hans": "简体中文",
        "ru": "Русский",
        "es": "Español"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(t("cambiar_idioma"))
                .font(.headline)
                .padding(.bottom, 10)

            ForEach(idiomas.sorted(by: { $0.value < $1.value }), id: \.key) { key, value in
                Button(action: {
                    localizationManager.setLanguage(key)
                    withAnimation {
                        showMenu = false
                    }
                }) {
                    HStack {
                        Text(value)
                            .foregroundColor(localizationManager.currentLanguage == key ? .naranjaMelocoton : .primary)
                        Spacer()
                        if localizationManager.currentLanguage == key {
                            Image(systemName: "checkmark")
                                .foregroundColor(.naranjaMelocoton)
                        }
                    }
                    .padding(.vertical, 6)
                }
            }

            Spacer()
        }
        .padding()
    }
}
