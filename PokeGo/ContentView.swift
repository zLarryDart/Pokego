import SwiftUI

struct ContentView: View {
    @State private var pokemonList: [Pokemon] = []
    @State private var isLoading = true

    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView("Cargando...")
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 110))]) {
                        ForEach(pokemonList, id: \.name) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                PokemonCard(pokemon: pokemon)
                            }
                        }
                    }
                }
                .navigationTitle("Pokedex")
            }
        }
        .onAppear {
            fetchPokemon()
        }
    }
    
    func fetchPokemon() {
        PokemonService.shared.fetchPokemonList { result in
            switch result {
            case .success(let list):
                DispatchQueue.main.async {
                    self.pokemonList = list.results
                    self.isLoading = false
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct PokemonCard: View {
    let pokemon: Pokemon
    @State private var imageUrl: String?

    var body: some View {
        VStack {
            if let imageUrl = imageUrl {
                RemoteImage(url: imageUrl)
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            }
            Text(pokemon.name.capitalized)
                .font(.caption)
        }
        .onAppear {
            loadPokemonDetails()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
    }

    private func loadPokemonDetails() {
        PokemonService.shared.fetchPokemonDetail(for: pokemon) { result in
            switch result {
            case .success(let details):
                DispatchQueue.main.async {
                    self.imageUrl = details.sprites.front_default
                }
            case .failure:
                self.imageUrl = nil
            }
        }
    }
}
