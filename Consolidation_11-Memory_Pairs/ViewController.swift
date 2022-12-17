//
//  ViewController.swift
//  Consolidation_11-Memory_Pairs
//
//  Created by Edwin Przeźwiecki Jr. on 09/11/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var gridView: UIImageView!
    
    @IBOutlet var buttons: [UIButton]!
    
    var pairs = [String: String]()
    var separatedPairs = [String]()
    
    var score = 0
    var numberOfCardsShown = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hue: 0.6, saturation: 1, brightness: 0.3, alpha: 1)
        
        drawGridOfRectangles()
        
        pairs = ["var": "variable", "let": "constant", "struct": "contract", "func": "function", "enum": "enumeration", "closure": "self", "Swift": "SwiftUI", "@": "State", "map": "compactMap", "+=": "operator", "try": "catch", "Apple": "Park"]
        
        separatedPairs += pairs.keys.map { "\($0)" }
        separatedPairs += pairs.values.map { "\($0)" }
        print(separatedPairs)
        
        for button in buttons {
            button.setImage(UIImage(named: "swift"), for: .normal)
            
            button.imageView?.contentMode = .center
            button.imageView?.contentMode = .scaleAspectFit
            button.layer.borderWidth = 5
            button.layer.borderColor = UIColor.purple.cgColor
        }
        
        shuffleCards()
    }
    
    func shuffleCards(action: UIAlertAction! = nil) {
        DispatchQueue.main.async {
            self.separatedPairs.shuffle()
            
            for i in 0 ..< self.buttons.count {
                self.buttons[i].setTitle(self.separatedPairs[i], for: .normal)
            }
        }
    }
    
    @IBAction func cardTapped(_ sender: UIButton) {
        
        let keyOrValue = sender.currentTitle!
        
        print(keyOrValue)
        
        /// Hiding the card's back:
        sender.setImage(UIImage(), for: .normal)
        sender.setTitle(keyOrValue, for: .normal)
        
        print("Button tapped.")
        
        numberOfCardsShown += 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if self.numberOfCardsShown >= 2 {
                sender.setImage(UIImage(named: "swift"), for: .normal)
            }
        }
    }
    
    func promptToAddPairs() {
        
    }
    
    func addPairs() {
        
    }
    
    func drawGridOfRectangles() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1024, height: 768))
        
        let grid = renderer.image { ctx in
            
                for row in 0..<5 {
                    for column in 0..<5 {
                        let rectangle = CGRect(x: column * 201, y: row * 151, width: 220, height: 165).insetBy(dx: 20, dy: 20)
                        
                        ctx.cgContext.setStrokeColor(UIColor.magenta.cgColor)
                        ctx.cgContext.setLineWidth(5)
                        
                        ctx.cgContext.addRect(rectangle)
                        ctx.cgContext.drawPath(using: .stroke)
                }
            }
        }
        gridView.image = grid
    }
}

