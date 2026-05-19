import SwiftUI

struct ProfileView: View {
    
    @State private var planetaFavorito = planets[2]
    @State private var mostrarSelectorPlaneta = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.05, green: 0.05, blue: 0.17)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        tarjetaPerfil
                        seccionFavorito
                        seccionAcercaDe
                        botonCerrarSesion
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("Perfil")
            .preferredColorScheme(.dark)
            .sheet(isPresented: $mostrarSelectorPlaneta) {
                selectorPlaneta
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }
    
    var tarjetaPerfil: some View {
        VStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: [.purple, Color(red: 0.30, green: 0.10, blue: 0.80)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing))
                    .frame(width: 90, height: 90)
                Image(systemName: "person.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
            VStack(spacing: 4) {
                Text("Carlos")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Explorador Espacial")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.5))
            }
            HStack(spacing: 30) {
                statItem(valor: "8", etiqueta: "Visitados")
                Rectangle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 1, height: 30)
                statItem(valor: "1", etiqueta: "Favorito")
                Rectangle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 1, height: 30)
                statItem(valor: "∞", etiqueta: "Curiosidad")
            }
            .padding()
            .background(Color.white.opacity(0.07))
            .cornerRadius(14)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
    
    func statItem(valor: String, etiqueta: String) -> some View {
        VStack(spacing: 4) {
            Text(valor)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(etiqueta)
                .font(.caption2)
                .foregroundColor(.white.opacity(0.5))
        }
    }
    
    var seccionFavorito: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Mi planeta favorito")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.5))
                .textCase(.uppercase)
                .padding(.horizontal)
            
            VStack(spacing: 12) {
                HStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(
                                colors: [planetaFavorito.color1, planetaFavorito.color2],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing))
                            .frame(width: 64, height: 64)
                        Image(planetaFavorito.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(planetaFavorito.name)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text(planetaFavorito.type)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                        Text(planetaFavorito.funFact)
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.4))
                            .lineLimit(2)
                    }
                    Spacer()
                }
                
                Button(action: { mostrarSelectorPlaneta = true }) {
                    HStack {
                        Image(systemName: "arrow.triangle.2.circlepath")
                        Text("Cambiar favorito")
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                    .foregroundColor(.purple)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.purple.opacity(0.15))
                    .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.white.opacity(0.07))
            .cornerRadius(14)
            .padding(.horizontal)
        }
    }
    
    var selectorPlaneta: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.08, green: 0.08, blue: 0.20)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(planets) { planeta in
                            Button(action: {
                                planetaFavorito = planeta
                                mostrarSelectorPlaneta = false
                            }) {
                                HStack(spacing: 14) {
                                    ZStack {
                                        Circle()
                                            .fill(LinearGradient(
                                                colors: [planeta.color1, planeta.color2],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing))
                                            .frame(width: 50, height: 50)
                                        Image(planeta.imageName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 46, height: 46)
                                            .clipShape(Circle())
                                    }
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(planeta.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(planeta.type)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    Spacer()
                                    if planetaFavorito.name == planeta.name {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.purple)
                                    }
                                }
                                .padding()
                                .background(Color.white.opacity(
                                    planetaFavorito.name == planeta.name ? 0.12 : 0.06))
                                .cornerRadius(14)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("Elegir favorito")
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Cerrar") { mostrarSelectorPlaneta = false }
                        .foregroundColor(.purple)
                }
            }
        }
    }
    
    var seccionAcercaDe: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Acerca de")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.5))
                .textCase(.uppercase)
                .padding(.horizontal)
            
            VStack(spacing: 0) {
                filaInfo(icono: "info.circle.fill", color: .blue, texto: "Versión 1.0")
                Rectangle()
                    .fill(Color.white.opacity(0.08))
                    .frame(height: 1)
                    .padding(.horizontal)
                filaInfo(icono: "globe", color: .green, texto: "Datos de la NASA")
                Rectangle()
                    .fill(Color.white.opacity(0.08))
                    .frame(height: 1)
                    .padding(.horizontal)
                filaInfo(icono: "heart.fill", color: .red, texto: "Hecho con SwiftUI")
            }
            .background(Color.white.opacity(0.07))
            .cornerRadius(14)
            .padding(.horizontal)
        }
    }
    
    var botonCerrarSesion: some View {
        Button(action: {
            print("Cerrar sesión")
        }) {
            Text("Cerrar sesión")
                .foregroundColor(.red)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white.opacity(0.07))
                .cornerRadius(14)
        }
        .padding(.horizontal)
    }
    
    func filaInfo(icono: String, color: Color, texto: String) -> some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                    .frame(width: 32, height: 32)
                Image(systemName: icono)
                    .font(.caption)
                    .foregroundColor(.white)
            }
            Text(texto)
                .foregroundColor(.white)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}
