import SwiftUI

struct AidDetailView: View {
    let content: AidContent
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 30) {
                
                Text(content.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                ForEach(Array(content.steps.enumerated()), id: \.1.id) { index, step in
                    VStack(spacing: 15) {
                        Text("Paso \(index + 1)")
                            .font(.system(size: 40, weight: .heavy, design: .rounded))
                            .foregroundColor(.orange)
                        
                        Image(systemName: step.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.orange.opacity(0.8))
                        
                        Text(step.text)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.orange.opacity(0.1))
                    )
                }
                
                Spacer(minLength: 20)
            }
            .padding()
        }
        .navigationTitle(content.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
