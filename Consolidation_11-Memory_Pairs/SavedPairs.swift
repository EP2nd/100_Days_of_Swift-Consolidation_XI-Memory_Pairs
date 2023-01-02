//
//  SavedPairs.swift
//  Consolidation_11-Memory_Pairs
//
//  Created by Edwin Przeźwiecki Jr. on 21/12/2022.
//

import Foundation

struct SavedPairs {
    
    static func load() -> [Pairs] {
        var pairs = [Pairs]()
        let defaults = UserDefaults.standard
        
        if let savedPairs = defaults.object(forKey: "pairs") as? Data, let firstRun = defaults.value(forKey: "firstRun") as? Bool {
            let jsonDecoder = JSONDecoder()
            
            do {
                pairs = try jsonDecoder.decode([Pairs].self, from: savedPairs)
                Pairs.firstRun = firstRun
            } catch {
                print("Failed to load saved pairs.")
            }
        }
        return pairs
    }
    
    static func save(pairs: [Pairs]) {
        let jsonEncoder = JSONEncoder()
        let defaults = UserDefaults.standard
        
        if let savedPairs = try? jsonEncoder.encode(pairs) {
            defaults.set(savedPairs, forKey: "pairs")
        } else {
            print("Failed to save pairs.")
        }
        
        defaults.set(Pairs.firstRun, forKey: "firstRun")
    }
}
