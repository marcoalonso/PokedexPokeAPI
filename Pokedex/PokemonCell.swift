//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Marco Alonso Rodriguez on 17/04/23.
//

import Foundation
import UIKit
import Kingfisher

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
        
    func setup(pokemon: ResponsePokemonModel){
        guard let url = URL(string: "\(pokemon.sprites.other?.home.frontDefault ?? "")") else { return }
        pokemonImage.kf.setImage(with: url)
        pokemonName.text = pokemon.name
    }
    
}
