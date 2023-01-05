//
//  SavedPairs.swift
//  Consolidation_11-Memory_Pairs
//
//  Created by Edwin Przeźwiecki Jr. on 21/12/2022.
//

import Foundation

struct SavedPairs {
    
    static var allPairs = [String: String]()
    static var separatedPairs = [String]()
    
    mutating func load() {
        
        let defaults = UserDefaults.standard
        let jsonDecoder = JSONDecoder()
        
        if let savedAllPairs = defaults.value(forKey: "allPairs") as? Data,
           let savedSeparatedPairs = defaults.value(forKey: "separatedPairs") as? Data {
            
            do {
                SavedPairs.allPairs = try jsonDecoder.decode([String:String].self, from: savedAllPairs)
                SavedPairs.separatedPairs = try jsonDecoder.decode([String].self, from: savedSeparatedPairs)
            } catch {
                print("Failed to load saved pairs.")
            }
        }
    }
    
    mutating func save() {
        
        let defaults = UserDefaults.standard
        let jsonEncoder = JSONEncoder()
        
        if let savedAllPairs = try? jsonEncoder.encode(SavedPairs.allPairs),
           let savedSeparatedPairs = try? jsonEncoder.encode(SavedPairs.separatedPairs) {
            
            defaults.set(savedAllPairs, forKey: "allPairs")
            defaults.set(savedSeparatedPairs, forKey: "separatedPairs")
        } else {
            print("Failed to save pairs.")
        }
    }
}
