import SwiftUI

struct PlanetDetailView: View {
    
    let planeta: Planet
    @State private var mostrarDato = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [planeta.color2.opacity(0.6), Color(red: 0.05, green: 0.05, blue: 0.17)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    imagenPlaneta
                    infoBasica
                    descripcionCard
                    estadisticasGrid
                    datoCurioso
                }
                .padding(.bottom, 40)
            }
        }
        .navigationTitle(planeta.name)
        .preferredColorScheme(.dark)
        .onAppear {
            withAnimation(.easeIn(duration: 0.5)) {
                mostrarDato = true
            }
        }
    }
    
    var imagenPlaneta: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(
                    colors: [planeta.color1.opacity(0.4), planeta.color2.opacity(0.2)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                .frame(width: 230, height: 230)
                .blur(radius: 20)
            
            Image(planeta.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .shadow(color: planeta.color1.opacity(0.8), radius: 25)
                .scaleEffect(mostrarDato ? 1.0 : 0.8)
                .animation(.spring(response: 0.5, dampingFraction: 0.6), value: mostrarDato)
        }
        .padding(.top, 10)
    }
    
    var infoBasica: some View {
        VStack(spacing: 6) {
            Text(planeta.name)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.white)
            
            Text(planeta.type)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.6))
                .padding(.horizontal, 14)
                .padding(.vertical, 5)
                .background(Capsule().fill(Color.white.opacity(0.1)))
        }
    }
    
    var descripcionCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Descripción")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.5))
                .textCase(.uppercase)
            
            Text(planeta.description)
                .font(.body)
                .foregroundColor(.white.opacity(0.85))
                .lineSpacing(4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.07))
        .cornerRadius(16)
        .padding(.horizontal)
    }
    
    var estadisticasGrid: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Estadísticas")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.5))
                .textCase(.uppercase)
                .padding(.horizontal)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                celdaStat(icono: "ruler.fill", etiqueta: "Distancia al Sol",
                          valor: planeta.distance, color: .orange)
                celdaStat(icono: "circle.fill", etiqueta: "Diámetro",
                          valor: planeta.diameter, color: .blue)
                celdaStat(icono: "moon.fill", etiqueta: "Lunas",
                          valor: "\(planeta.moons)", color: .purple)
                celdaStat(icono: "paperplane.fill", etiqueta: "Tiempo de viaje",
                          valor: planeta.travelTime, color: .teal)
            }
            .padding(.horizontal)
        }
    }
    
    func celdaStat(icono: String, etiqueta: String, valor: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icono)
                    .foregroundColor(color)
                    .font(.caption)
                Text(etiqueta)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.5))
            }
            Text(valor)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.07))
        .cornerRadius(14)
    }
    
    var datoCurioso: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Dato curioso", systemImage: "lightbulb.fill")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.yellow)
                .textCase(.uppercase)
            
            Text(planeta.funFact)
                .font(.body)
                .foregroundColor(.white.opacity(0.85))
                .lineSpacing(4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.yellow.opacity(0.08))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.yellow.opacity(0.25), lineWidth: 1)
        )
        .cornerRadius(16)
        .padding(.horizontal)
        .opacity(mostrarDato ? 1 : 0)
        .animation(.easeIn(duration: 0.6).delay(0.3), value: mostrarDato)
    }
}

#Preview {
    NavigationStack {
        PlanetDetailView(planeta: planets[4])
    }
    .preferredColorScheme(.dark)
}
