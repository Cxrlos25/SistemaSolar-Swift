import SwiftUI

struct ExploreView: View {
    
    @State private var busqueda = ""
    @State private var filtroTipo: String? = nil
    @State private var mostrarFiltros = false
    @State private var ordenarPorLunas = false
    
    var planetasFiltrados: [Planet] {
        var lista = planets
        if let tipo = filtroTipo {
            lista = lista.filter { $0.type == tipo }
        }
        if !busqueda.isEmpty {
            lista = lista.filter { $0.name.localizedCaseInsensitiveContains(busqueda) }
        }
        if ordenarPorLunas {
            lista = lista.sorted { $0.moons > $1.moons }
        }
        return lista
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.05, green: 0.05, blue: 0.17)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 12) {
                        chipsFiltro
                        
                        HStack {
                            Text("Planetas")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                            Spacer()
                            Text("\(planetasFiltrados.count) resultados")
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.4))
                        }
                        .padding(.horizontal)
                        
                        ForEach(planetasFiltrados) { planeta in
                            NavigationLink(destination: PlanetDetailView(planeta: planeta)) {
                                filaPlaneta(planeta: planeta)
                            }
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("Explorar")
            .searchable(text: $busqueda, prompt: "Buscar planeta...")
            .preferredColorScheme(.dark)
            .sheet(isPresented: $mostrarFiltros) {
                vistaFiltros
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: { mostrarFiltros = true }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(filtroTipo != nil ? .purple : .white)
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Button(action: { ordenarPorLunas.toggle() }) {
                        Image(systemName: ordenarPorLunas ? "textformat.abc" : "moon.stars.fill")
                            .foregroundColor(ordenarPorLunas ? .purple : .white)
                    }
                }
            }
        }
    }
    
    var chipsFiltro: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                chipFiltro(texto: "Todos", seleccionado: filtroTipo == nil) {
                    filtroTipo = nil
                }
                chipFiltro(texto: "Rocosos", seleccionado: filtroTipo == "Planeta Rocoso") {
                    filtroTipo = "Planeta Rocoso"
                }
                chipFiltro(texto: "Gaseosos", seleccionado: filtroTipo == "Gigante Gaseoso") {
                    filtroTipo = "Gigante Gaseoso"
                }
                chipFiltro(texto: "Hielo", seleccionado: filtroTipo == "Gigante de Hielo") {
                    filtroTipo = "Gigante de Hielo"
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
    
    func chipFiltro(texto: String, seleccionado: Bool, accion: @escaping () -> Void) -> some View {
        Button(action: accion) {
            Text(texto)
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(seleccionado ? Color.purple : Color.white.opacity(0.1))
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
    }
    
    func filaPlaneta(planeta: Planet) -> some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: [planeta.color1, planeta.color2],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing))
                    .frame(width: 58, height: 58)
                Image(planeta.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 54, height: 54)
                    .clipShape(Circle())
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(planeta.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(planeta.type)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
                HStack(spacing: 10) {
                    Label(planeta.distance, systemImage: "ruler.fill")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.4))
                    Label("\(planeta.moons)", systemImage: "moon.fill")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.4))
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.white.opacity(0.3))
        }
        .padding()
        .background(Color.white.opacity(0.06))
        .cornerRadius(14)
        .padding(.horizontal)
    }
    
    var vistaFiltros: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.08, green: 0.08, blue: 0.20)
                    .ignoresSafeArea()
                VStack(spacing: 16) {
                    botonFiltro(tipo: "Planeta Rocoso", icono: "mountain.2.fill")
                    botonFiltro(tipo: "Gigante Gaseoso", icono: "cloud.fill")
                    botonFiltro(tipo: "Gigante de Hielo", icono: "snowflake")
                    Button(action: {
                        filtroTipo = nil
                        mostrarFiltros = false
                    }) {
                        Text("Limpiar filtro")
                            .foregroundColor(.red)
                            .padding()
                    }
                    Spacer()
                }
                .padding(.top, 20)
            }
            .navigationTitle("Filtrar")
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Cerrar") { mostrarFiltros = false }
                        .foregroundColor(.purple)
                }
            }
        }
    }
    
    func botonFiltro(tipo: String, icono: String) -> some View {
        Button(action: {
            filtroTipo = tipo
            mostrarFiltros = false
        }) {
            HStack(spacing: 14) {
                Image(systemName: icono)
                    .foregroundColor(.purple)
                    .frame(width: 30)
                Text(tipo)
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                Spacer()
                if filtroTipo == tipo {
                    Image(systemName: "checkmark")
                        .foregroundColor(.purple)
                }
            }
            .padding()
            .background(Color.white.opacity(0.07))
            .cornerRadius(12)
            .padding(.horizontal)
        }
    }
}

#Preview {
    ExploreView()
        .preferredColorScheme(.dark)
}
