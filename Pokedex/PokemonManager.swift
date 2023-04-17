//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Marco Alonso Rodriguez on 17/04/23.
//

import Foundation

struct PokemonManager {
    func getPokemon(id: Int = 1, completion: @escaping (ResponsePokemonModel, Error?) -> ()) {
        
        guard let url = URL(string:  "https://pokeapi.co/api/v2/pokemon/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error al obtener pokemosn")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(ResponsePokemonModel.self, from: data)
                
                completion(decodedData, nil)
            } catch {
                print("Debug: error \(error.localizedDescription)")
            }
            
            
        }.resume()
    }
}
