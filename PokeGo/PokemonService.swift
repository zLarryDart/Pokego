import Foundation

class PokemonService {
    let baseUrl = "https://pokeapi.co/api/v2/"
    
    
    static let shared = PokemonService()
    
    private init() {}
    
    // Función para obtener la lista de Pokémon
    func fetchPokemonList(completion: @escaping (Result<PokemonList, Error>) -> Void) {
        let urlString = "\(baseUrl)pokemon?limit=100"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                completion(.success(pokemonList))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // Función para obtener los detalles de un Pokémon específico
    func fetchPokemonDetail(for pokemon: Pokemon, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        guard let url = URL(string: pokemon.url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let pokemonDetail = try JSONDecoder().decode(PokemonDetail.self, from: data)
                completion(.success(pokemonDetail))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
