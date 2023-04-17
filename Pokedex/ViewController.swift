//
//  ViewController.swift
//  Pokedex
//
//  Created by Marco Alonso Rodriguez on 17/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    var timerGetPokemons = Timer()
    let pokemonManager = PokemonManager()
    var numPokemon = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getPokemons()
    }
    
    func getPokemons() {
        timerGetPokemons = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(getPokemonList), userInfo: nil, repeats: true)
    }

    @objc func getPokemonList(){
        //Validar si es menos de 150
        if numPokemon < 10 {
            pokemonManager.getPokemon(id: numPokemon) { infoPokemon, _ in
                print(infoPokemon.forms[0].name)
            }
            numPokemon += 1
            print("Debug: numPokemon \(numPokemon)")

        } else {
            timerGetPokemons.invalidate()
            print("Timer invalidated!")
        }
        
        
    }

}

