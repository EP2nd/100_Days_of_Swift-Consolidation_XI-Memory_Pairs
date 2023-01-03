//
//  SavedPairs.swift
//  Consolidation_11-Memory_Pairs
//
//  Created by Edwin Przeźwiecki Jr. on 21/12/2022.
//

import Foundation

struct SavedPairs {
    
    static func load() -> [Pairs] {
        
        let defaults = UserDefaults.standard
        let jsonDecoder = JSONDecoder()
        
        var pairs = [Pairs]()
        
        if let savedPairs = defaults.object(forKey: "pairs") as? Data {
            
            do {
                pairs = try jsonDecoder.decode([Pairs].self, from: savedPairs)
            } catch {
                print("Failed to load saved pairs.")
            }
        }
        return pairs
    }
    
    static func save(pairs: [Pairs]) {
        
        let defaults = UserDefaults.standard
        let jsonEncoder = JSONEncoder()
        
        if let savedPairs = try? jsonEncoder.encode(pairs) {
            defaults.set(savedPairs, forKey: "pairs")
        } else {
            print("Failed to save pairs.")
        }
    }
}
