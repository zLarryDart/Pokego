import Foundation

struct PokemonList: Decodable {
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let url: String
}

struct PokemonDetail: Decodable {
    let id: Int
    let name: String
    let sprites: PokemonSprites
    let types: [PokemonTypeEntry]
    let stats: [PokemonStat]
}

struct PokemonStat: Decodable {
    let base_stat: Int
    let stat: Stat
}

struct Stat: Decodable {
    let name: String
}

struct PokemonSprites: Decodable {
    let front_default: String 
}

struct PokemonTypeEntry: Decodable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Decodable {
    let name: String
}
