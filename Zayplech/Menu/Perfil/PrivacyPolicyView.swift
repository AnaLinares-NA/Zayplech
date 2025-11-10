//
//  PrivacyPolicyView.swift
//  Zayplech
//
//  Created by Ana Linares Guzmán on 07/11/25.
//

import SwiftUI

struct PrivacyPolicyView: View {

    private let privacyPolicyMessage = """

Última actualización: [fecha actual]

En ZAYPLECH, la privacidad y seguridad de nuestros usuarios es una prioridad.
Esta Política de Privacidad explica cómo recopilamos, usamos, almacenamos, compartimos y protegemos la información personal y no personal de los usuarios que utilizan nuestra aplicación móvil (“la App”).

ZAYPLECH ha sido desarrollada por [tu nombre o empresa], utilizando tecnologías nativas de Apple con el propósito de garantizar el más alto nivel de rendimiento, confidencialidad y protección de datos.

--------------------------------------------

1. ACEPTACIÓN DE LA POLÍTICA

Al descargar, registrarse o utilizar la App, el usuario acepta los términos descritos en esta Política de Privacidad.
Si no está de acuerdo con alguno de estos términos, debe abstenerse de utilizar ZAYPLECH.

Nos reservamos el derecho de modificar esta Política en cualquier momento. Los cambios se comunicarán mediante notificación en la App o por correo electrónico.
El uso continuado después de dichos cambios implicará la aceptación de la nueva versión.

--------------------------------------------

2. INFORMACIÓN QUE RECOPILAMOS

2.1. Información personal  
ZAYPLECH puede recopilar los siguientes datos personales al momento del registro o durante el uso de la App:
- Nombre completo y correo electrónico
- Género (opcional, pero necesario para activar ciertas funciones de seguridad enfocadas en mujeres)
- Idioma preferido
- Contraseña cifrada
- País y zona horaria

2.2. Información de geolocalización  
Para ofrecer orientación, rutas seguras y asistencia en tiempo real, la App recopila información de ubicación (GPS, dirección IP o triangulación de red).
Esta información se usa exclusivamente para brindar funciones de seguridad, mapas y alertas contextuales.

2.3. Información de uso  
Recopilamos datos como:
- Interacciones dentro de la App (pantallas visitadas, botones presionados)
- Duración de las sesiones
- Errores o fallos técnicos

Esta información es anónima y se utiliza para mejorar el rendimiento de ZAYPLECH y optimizar la experiencia del usuario.

2.4. Datos de voz y traducción  
Cuando el usuario utiliza el módulo de traducción o reconocimiento de voz, ZAYPLECH emplea tecnologías nativas de Apple (AVFoundation y Speech) para procesar el audio localmente o mediante los servicios de Apple.
La App no almacena grabaciones de voz ni comparte estos datos con terceros.

2.5. Datos conversacionales (ZayplechBrain)  
El módulo de inteligencia artificial ZayplechBrain procesa texto o frases ingresadas por el usuario para generar respuestas contextuales.
Toda la información se maneja localmente en el dispositivo, sin conexión a servidores externos.
ZAYPLECH no conserva registros permanentes de las conversaciones, y su IA no recopila información personal identificable.

--------------------------------------------

3. USO DE LA INFORMACIÓN

La información recopilada se utiliza para los siguientes fines:
- Crear y mantener la cuenta del usuario
- Proporcionar servicios personalizados según el perfil (por ejemplo, funciones de seguridad para mujeres)
- Mostrar información contextual y ubicación en el mapa
- Activar funciones de traducción y comunicación en tiempo real
- Mejorar el rendimiento, estabilidad y accesibilidad de la App
- Enviar notificaciones de seguridad, recordatorios o actualizaciones
- Analizar de manera agregada el comportamiento de uso para mejorar la experiencia general

ZAYPLECH no utiliza los datos personales para publicidad ni para vender información a terceros.

--------------------------------------------

4. COMPARTICIÓN DE DATOS CON TERCEROS

ZAYPLECH no comparte información personal con terceros, salvo en los siguientes casos:
- Cumplimiento legal: Si una autoridad competente lo requiere en el marco de una investigación legal.
- Emergencias: Cuando el usuario activa una alerta de seguridad o comparte su ubicación con contactos de confianza, la App enviará los datos estrictamente necesarios para ofrecer asistencia inmediata.
- Servicios de Apple: En funciones de voz o reconocimiento que dependen de APIs del sistema operativo, la información es procesada bajo las políticas de privacidad de Apple.

En ningún caso se transfieren datos a servidores externos ni a países fuera del marco legal aplicable.

--------------------------------------------

5. SEGURIDAD DE LA INFORMACIÓN

ZAYPLECH utiliza protocolos de seguridad avanzados y tecnologías de cifrado para proteger la información de sus usuarios:
- Cifrado AES y HTTPS en toda la comunicación con servicios del sistema
- Almacenamiento local mediante SwiftData, protegido por sandbox de iOS
- Contraseñas almacenadas en el Keychain del dispositivo
- Control de permisos para acceso a cámara, micrófono, ubicación y notificaciones

El equipo de ZAYPLECH realiza auditorías internas periódicas para prevenir accesos no autorizados, pérdida o alteración de datos.

--------------------------------------------

6. ALMACENAMIENTO LOCAL Y FUNCIONAMIENTO SIN CONEXIÓN

ZAYPLECH ha sido diseñada para operar incluso en entornos con conectividad limitada.
La App utiliza SwiftData para guardar temporalmente información relevante como rutas, mensajes, configuraciones y respuestas de IA, lo que permite su funcionamiento sin conexión a Internet.
Toda esta información se guarda solo en el dispositivo del usuario y se elimina automáticamente al cerrar sesión o desinstalar la App.

--------------------------------------------

7. ACCESIBILIDAD E INCLUSIÓN

ZAYPLECH está comprometida con la accesibilidad y la inclusión digital.
La App es compatible con las funciones de accesibilidad de Apple, incluyendo VoiceOver, Dynamic Type y alto contraste.
Además, el diseño busca ser inclusivo y seguro, ofreciendo asistencia personalizada a mujeres y usuarios en situación de vulnerabilidad.

--------------------------------------------

8. DERECHOS DEL USUARIO

El usuario tiene derecho a:
- Acceder a los datos personales que la App conserva sobre él
- Solicitar la rectificación o eliminación de datos inexactos
- Revocar su consentimiento para el tratamiento de datos
- Solicitar la eliminación completa de su cuenta y de toda la información asociada

Para ejercer estos derechos, puede comunicarse al correo: correo@zayplech.com, indicando su solicitud y acreditando su identidad.

--------------------------------------------

9. RETENCIÓN Y ELIMINACIÓN DE DATOS

ZAYPLECH conservará los datos personales solo durante el tiempo necesario para proporcionar los servicios solicitados.
Una vez cumplida esa finalidad, los datos serán eliminados de forma segura y permanente del dispositivo o del entorno de almacenamiento local.

--------------------------------------------

10. PRIVACIDAD DE MENORES

ZAYPLECH está dirigida a mayores de 16 años.
No recopilamos deliberadamente información de menores de edad.
En caso de detectar un registro de un menor sin consentimiento verificable de los padres o tutores, eliminaremos sus datos de inmediato.

--------------------------------------------

11. RESPONSABILIDAD DEL USUARIO

El usuario es responsable de:
- Mantener la confidencialidad de sus credenciales
- Proporcionar información veraz y actualizada
- No compartir su cuenta con terceros
- Usar las funciones de localización y comunicación de forma ética y responsable

--------------------------------------------

12. TRANSFERENCIA INTERNACIONAL DE DATOS

Actualmente, ZAYPLECH no realiza transferencias internacionales de datos.
Todos los procesos se ejecutan dentro del ecosistema de Apple y el dispositivo del usuario.

--------------------------------------------

13. CAMBIOS EN LA POLÍTICA DE PRIVACIDAD

ZAYPLECH se reserva el derecho de modificar esta Política en cualquier momento.
Cualquier cambio será publicado en la App y, cuando sea necesario, notificado al usuario mediante correo electrónico o mensaje emergente dentro de la aplicación.

--------------------------------------------

14. CONTACTO

Si tienes preguntas, comentarios o inquietudes relacionadas con esta Política de Privacidad o el tratamiento de tus datos, puedes comunicarte con nuestro equipo de privacidad en:

Correo electrónico: correo@zayplech.com  
Sitio web: www.zayplech.com

--------------------------------------------

COMPROMISO FINAL

En ZAYPLECH creemos que la tecnología debe servir para conectar, proteger y empoderar a las personas.
Nuestra prioridad es ofrecer una herramienta segura, humana y transparente.
Por eso, cada línea de código fue pensada para respetar la privacidad, garantizar la inclusión y brindar confianza a quienes más la necesitan.

"""


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // MARK: - Mascota y Mensaje
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text("Política de Privacidad de ZAYPLECH")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top, 10)
                    
                    Text(privacyPolicyMessage)
                        .font(.body)
                        .foregroundColor(.primary)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Perfil")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    PrivacyPolicyView()
}
