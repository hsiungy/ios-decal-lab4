//
//  SearchViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var pokemonArray: [Pokemon] = []
    var filteredArray: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonArray = PokemonGenerator.getPokemonArray()
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PokemonGenerator.categoryDict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "prototype", for: indexPath) as! CollectionViewCell
        cell.imageViewOutlet.image = UIImage(named: PokemonGenerator.categoryDict[indexPath.row]!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.filteredArray = filteredPokemon(ofType: indexPath.row)
        performSegue(withIdentifier: "searchToCategory", sender: Any?.self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "searchToCategory" {
                if let dest = segue.destination as? CategoryViewController {
                    dest.pokemonArray = self.filteredArray
                }
            }
        }
    }
    
    // Utility function to iterate through pokemon array for a single category
    func filteredPokemon(ofType type: Int) -> [Pokemon] {
        var filtered: [Pokemon] = []
        for pokemon in pokemonArray {
            if (pokemon.types.contains(PokemonGenerator.categoryDict[type]!)) {
                filtered.append(pokemon)
            }
        }
        return filtered
    }


}
