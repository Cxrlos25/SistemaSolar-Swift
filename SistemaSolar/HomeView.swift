import SwiftUI

struct HomeView: View {
    
    @State private var mostrarAlerta = false
    @State private var planetaSeleccionado = 0
    
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.17)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    encabezado
                    tarjetaPrincipal
                    galeriaPlanetas
                    seccionDatos
                    botonExplorar
                }
                .padding(.bottom, 30)
            }
        }
        .alert("¡Listo para explorar! 🚀", isPresented: $mostrarAlerta) {
            Button("Vamos", role: .cancel) {}
        } message: {
            Text("Ve a la pestaña Explorar para ver todos los planetas.")
        }
    }
    
    var encabezado: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Bienvenido")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.6))
                Text("Sistema Solar")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            Spacer()
            ZStack {
                Circle()
                    .fill(.purple)
                    .frame(width: 45, height: 45)
                Image(systemName: "person.fill")
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    var tarjetaPrincipal: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack {
                LinearGradient(
                    colors: [Color(red: 0.10, green: 0.05, blue: 0.30),
                             Color(red: 0.02, green: 0.02, blue: 0.15)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                Image(planets[planetaSeleccionado].imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .shadow(color: planets[planetaSeleccionado].color1.opacity(0.8), radius: 20)
                    .offset(x: 70, y: -10)
            }
            .frame(height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            LinearGradient(colors: [.clear, .black.opacity(0.7)],
                           startPoint: .center, endPoint: .bottom)
                .frame(height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .leading, spacing: 5) {
                Text(planets[planetaSeleccionado].name)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                
                Text(planets[planetaSeleccionado].type)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                
                HStack(spacing: 5) {
                    ForEach(0..<planets.count, id: \.self) { i in
                        Circle()
                            .fill(i == planetaSeleccionado ? Color.purple : Color.white.opacity(0.4))
                            .frame(width: i == planetaSeleccionado ? 8 : 5,
                                   height: i == planetaSeleccionado ? 8 : 5)
                            .onTapGesture {
                                withAnimation { planetaSeleccionado = i }
                            }
                    }
                }
                .padding(.top, 4)
            }
            .padding(18)
        }
        .padding(.horizontal)
        .gesture(
            DragGesture().onEnded { value in
                if value.translation.width < -40 {
                    withAnimation {
                        planetaSeleccionado = min(planetaSeleccionado + 1, planets.count - 1)
                    }
                } else if value.translation.width > 40 {
                    withAnimation {
                        planetaSeleccionado = max(planetaSeleccionado - 1, 0)
                    }
                }
            }
        )
    }
    
    var galeriaPlanetas: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Galería")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(planets) { planeta in
                        VStack(spacing: 6) {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(
                                        colors: [planeta.color1, planeta.color2],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing))
                                    .frame(width: 70, height: 70)
                                Image(planeta.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 66, height: 66)
                                    .clipShape(Circle())
                            }
                            Text(planeta.name)
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .onTapGesture {
                            if let idx = planets.firstIndex(where: { $0.id == planeta.id }) {
                                withAnimation { planetaSeleccionado = idx }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    var seccionDatos: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Datos curiosos")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            datoDestacado(icono: "thermometer.sun.fill", color: .orange,
                          titulo: "El más caliente",
                          subtitulo: "Venus — 465°C")
            datoDestacado(icono: "wind", color: .blue,
                          titulo: "El más ventoso",
                          subtitulo: "Neptuno — 2,100 km/h")
            datoDestacado(icono: "mountain.2.fill", color: Color(red: 0.76, green: 0.27, blue: 0.06),
                          titulo: "El más alto",
                          subtitulo: "Marte — Olympus Mons 22 km")
        }
    }
    
    func datoDestacado(icono: String, color: Color, titulo: String, subtitulo: String) -> some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 44, height: 44)
                Image(systemName: icono)
                    .foregroundColor(color)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(titulo)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Text(subtitulo)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.06))
        .cornerRadius(14)
        .padding(.horizontal)
    }
    
    var botonExplorar: some View {
        Button(action: {
            print("Botón explorar presionado")
            mostrarAlerta = true
        }) {
            HStack {
                Image(systemName: "rocket.fill")
                Text("Iniciar Exploración")
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                LinearGradient(colors: [.purple, Color(red: 0.30, green: 0.10, blue: 0.80)],
                               startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(16)
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
