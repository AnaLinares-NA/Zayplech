struct StadiumsSheetView: View {
    @Binding var stadiums: [Stadium]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "stadium")
                    .font(.title2)
                    .foregroundColor(.orange)
                Text("Estadios")
                    .font(.headline)
                Spacer()
            }
            .padding(.bottom, 5)
            
            ScrollView {
                ForEach($stadiums) { $stadium in
                    HStack {
                        Text(stadium.name)
                        Spacer()
                        Toggle("", isOn: $stadium.isSelected)
                            .labelsHidden()
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white).shadow(radius: 5))
        .padding(.horizontal)
    }
}
