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
    
    let initialView = InitialViewController()
    var separatedPais = Pairs.separatedPairs
    
    var score = 0
    var numberOfCardsShown = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hue: 0.6, saturation: 1, brightness: 0.3, alpha: 1)
        
        drawGridOfRectangles()
        
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
            self.separatedPais.shuffle()
            
            for i in 0 ..< self.buttons.count {
                self.buttons[i].setTitle(self.separatedPais[i], for: .normal)
            }
        }
    }
    
    @IBAction func cardTapped(_ sender: UIButton) {
        
        guard numberOfCardsShown < 2 else { return }
        
        numberOfCardsShown += 1
        
        let keyOrValue = sender.currentTitle!
        
        /// Hiding the card's back and showing its content:
        sender.setImage(UIImage(), for: .normal)
        sender.setTitle(keyOrValue, for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if self.numberOfCardsShown < 3 {
                sender.setImage(UIImage(named: "swift"), for: .normal)
                self.numberOfCardsShown = 0
            }
        }
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

