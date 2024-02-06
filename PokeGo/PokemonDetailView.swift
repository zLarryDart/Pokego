import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @State private var imageUrl: String? = nil
    @State private var attack: Int = 0
    @State private var defense: Int = 0
    @State private var hp: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Ataque: \(attack)")
                Text("Defensa: \(defense)")
                Text("HP: \(hp)")
            }
            .padding()
            if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .frame(width: 400, height: 400) 
                .padding()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            }
            
            Text(pokemon.name.capitalized)
                .font(.title)
                .padding()
            
            
        }
        
        .onAppear {
            loadPokemonDetails()
        }
    }
    
    private func loadPokemonDetails() {
        PokemonService.shared.fetchPokemonDetail(for: pokemon) { result in
            switch result {
            case .success(let details):
                DispatchQueue.main.async {
                    self.imageUrl = details.sprites.front_default
                    self.attack = details.stats.first(where: { $0.stat.name == "attack" })?.base_stat ?? 0
                    self.defense = details.stats.first(where: { $0.stat.name == "defense" })?.base_stat ?? 0
                    self.hp = details.stats.first(where: { $0.stat.name == "hp" })?.base_stat ?? 0
                }
            case .failure:
                self.imageUrl = nil
            }
        }
    }
}

