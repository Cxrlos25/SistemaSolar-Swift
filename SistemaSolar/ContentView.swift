import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Inicio", systemImage: "house.fill")
                }
            ExploreView()
                .tabItem {
                    Label("Explorar", systemImage: "sparkles")
                }
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person.circle.fill")
                }
        }
        .tint(.purple)
        .preferredColorScheme(.dark)
    }
}
