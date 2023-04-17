//
//  ViewController.swift
//  Pokedex
//
//  Created by Marco Alonso Rodriguez on 17/04/23.
//

import UIKit

class PokemonsViewController: UIViewController {
    
    
    @IBOutlet weak var pokemonCollection: UICollectionView!
    
    // MARK:  Variables
    var timerGetPokemons = Timer()
    let pokemonManager = PokemonManager()
    var numPokemon = 1
    
    var pokemonList : [ResponsePokemonModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonCollection.delegate = self
        pokemonCollection.dataSource = self
        getPokemons()
        
        setupCollection()
    }
    
    func setupCollection(){
        pokemonCollection.collectionViewLayout = UICollectionViewFlowLayout()
        if let flowLayout = pokemonCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
        
       

    
    func getPokemons() {
        //Buscar historial en cache, si no hay traer nuevos pokemon
        if let downloadedPokemons = UserDefaults.standard.array(forKey: "pokemonList") as? [ResponsePokemonModel] {
            print("Pokemon encontrados!")
            pokemonList = downloadedPokemons
            pokemonCollection.reloadData()
        }
        
        timerGetPokemons = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(getPokemonList), userInfo: nil, repeats: true)
    }

    @objc func getPokemonList(){
        //Validar si es menos de 150
        if numPokemon < 152 {
            pokemonManager.getPokemon(id: numPokemon) { infoPokemon, _ in
                print(infoPokemon.forms[0].name)
                self.pokemonList.append(infoPokemon)
                DispatchQueue.main.async {
                    self.pokemonCollection.reloadData()
                }
            }
            numPokemon += 1
            print("Debug: numPokemon \(numPokemon)")

        } else {
            timerGetPokemons.invalidate()
            print("Timer invalidated!")
            ///Guardar arreglo en userdefaults
            UserDefaults.standard.set(pokemonList, forKey: "pokemonList")
        }
        
        
    }

}

// MARK:  CollectionFlow
extension PokemonsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
}

extension PokemonsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        
        cell.setup(pokemon: pokemonList[indexPath.row])
        
        return cell
    }
    
    
}
