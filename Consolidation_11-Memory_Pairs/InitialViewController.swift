//
//  InitialViewController.swift
//  Consolidation_11-Memory_Pairs
//
//  Created by Edwin Przeźwiecki Jr. on 18/12/2022.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet var startGameButton: UIButton!
    @IBOutlet var addPairsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hue: 0.6, saturation: 1, brightness: 0.3, alpha: 1)
        
        if let pairsURL = Bundle.main.url(forResource: "pairs", withExtension: "txt") {
            if let pairs = try? String(contentsOf: pairsURL) {
                let lines = pairs.components(separatedBy: "\n")
                
                for line in lines {
                    let components = line.components(separatedBy: ": ")
                    
                    Pairs.allPairs[components[0]] = components[1]
                }
            }
        }
        
        Pairs.separatedPairs += Pairs.allPairs.keys.map { "\($0)" }
        Pairs.separatedPairs += Pairs.allPairs.values.map { "\($0)" }
        Pairs.separatedPairs += [""]
    }
    
    @IBAction func startGame(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func addPairs(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "PairsTableViewController") as? PairsTableViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
