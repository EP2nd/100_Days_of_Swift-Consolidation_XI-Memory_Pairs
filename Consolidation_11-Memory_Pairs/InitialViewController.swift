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
    
    var allPairs = [String: String]()
    var separatedPairs = [String]()
    
    var viewController = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hue: 0.6, saturation: 1, brightness: 0.3, alpha: 1)
        
        if let pairsURL = Bundle.main.url(forResource: "pairs", withExtension: "txt") {
            if let pairs = try? String(contentsOf: pairsURL) {
                var lines = pairs.components(separatedBy: "\n")
                
                for line in lines {
                    var components = line.components(separatedBy: ": ")
                    
                    allPairs[components[0]] = components[1]
                }
            }
        }
        
        separatedPairs += allPairs.keys.map { "\($0)" }
        separatedPairs += allPairs.values.map { "\($0)" }
        separatedPairs += [""]
        print(separatedPairs)
    }
    
    @IBAction func startGame(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func addPairs(_ sender: Any) {
        
    }
}
