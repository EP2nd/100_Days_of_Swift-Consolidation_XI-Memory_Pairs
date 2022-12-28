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
    
    var pairToCheck = [String]()
    
    let initialView = InitialViewController()
    let allPairs = Pairs.allPairs
    var separatedPairs = Pairs.separatedPairs
    
    var score = 0
    var numberOfCardsShown = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hue: 0.6, saturation: 1, brightness: 0.3, alpha: 1)
        
        navigationController?.navigationBar.isHidden = true
        
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
        
        separatedPairs.removeAll()
        separatedPairs += Pairs.allPairs.keys.map { "\($0)" }
        separatedPairs += Pairs.allPairs.values.map { "\($0)" }
        separatedPairs += [""]
        
        DispatchQueue.main.async {
            self.separatedPairs.shuffle()
            
            for i in 0 ..< self.buttons.count {
                self.buttons[i].setTitle(self.separatedPairs[i], for: .normal)
            }
        }
    }
    
    @IBAction func cardTapped(_ sender: UIButton) {
        
        /// Making sure no more than two buttons can be shown:
        guard numberOfCardsShown < 2 else { return }
        
        numberOfCardsShown += 1
        print(sender.tag)
        print(numberOfCardsShown)
        
        let keyOrValue = sender.currentTitle!
        
        pairToCheck.append(keyOrValue)
        print(pairToCheck)
        
        /// Hiding the card's back and showing its content:
        sender.setImage(UIImage(), for: .normal)
        sender.setTitle(keyOrValue, for: .normal)
        
        if numberOfCardsShown < 3 && pairToCheck.count == 2 {
            
            let isFirstKey = allPairs[pairToCheck[0]] != nil
            print(isFirstKey)
            let isSecondKey = allPairs[pairToCheck[1]] != nil
            print(isSecondKey)
            
            if isFirstKey {
                let value = allPairs[pairToCheck[0]]!
                print(value)
                
                if allPairs[pairToCheck[0]] == pairToCheck[1] {
                    score += 1
                    print(score)
                    
                    sender.isHidden = true
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        sender.setImage(UIImage(named: "swift"), for: .normal)
                        self.numberOfCardsShown = 0
                        self.pairToCheck.removeAll()
                    }
                }
            } else if isSecondKey {
                let value = allPairs[pairToCheck[1]]!
                print(value)
                
                if allPairs[pairToCheck[1]] == pairToCheck[0] {
                    score += 1
                    print(score)
                    
                    sender.isHidden = true
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        sender.setImage(UIImage(named: "swift"), for: .normal)
                        self.numberOfCardsShown = 0
                        self.pairToCheck.removeAll()
                    }
                }
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

