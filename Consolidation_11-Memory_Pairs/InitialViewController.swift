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
    
    let viewController = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = UIColor(hue: 0.6, saturation: 1, brightness: 0.3, alpha: 1)
    }
    
    @IBAction func startGame(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func addPairs(_ sender: Any) {
        
    }
}
