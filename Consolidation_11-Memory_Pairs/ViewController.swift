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
    var buttonsTags = [Int]()
    
    let initialView = InitialViewController()
    
    var numberOfCardsShown = 0
    var numberOfCardsPaired = 0
    
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
        
        SavedPairs.separatedPairs.removeAll()
        SavedPairs.separatedPairs += SavedPairs.allPairs.keys.map { "\($0)" }
        SavedPairs.separatedPairs += SavedPairs.allPairs.values.map { "\($0)" }
        SavedPairs.separatedPairs += [""]
        
        DispatchQueue.main.async {
            SavedPairs.separatedPairs.shuffle()
            
            for i in 0 ..< self.buttons.count {
                self.buttons[i].setTitle(SavedPairs.separatedPairs[i], for: .normal)
            }
        }
    }
    
    @IBAction func cardTapped(_ sender: UIButton) {
        
        guard numberOfCardsShown < 2 else { return }
        
        numberOfCardsShown += 1
        
        let keyOrValue = sender.currentTitle!
        
        pairToCheck.append(keyOrValue)
        buttonsTags.append(sender.tag)
        
        flipCard(card: sender, from: UIImage(), to: keyOrValue)
        
        if numberOfCardsShown < 3 && pairToCheck.count == 2 {
            
            /// Boolean check of the string to determine if it is one of the keys located somewhere in the dictionary of pairs:
            let isFirstKey = SavedPairs.allPairs[pairToCheck[0]] != nil
            let isSecondKey = SavedPairs.allPairs[pairToCheck[1]] != nil
            
            if isFirstKey {
                if SavedPairs.allPairs[pairToCheck[0]] == pairToCheck[1] {
                    numberOfCardsPaired += 1
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.buttons[self.buttonsTags[0]].isHidden = true
                        self.buttons[self.buttonsTags[1]].isHidden = true
                        self.numberOfCardsShown = 0
                        self.pairToCheck.removeAll()
                        self.buttonsTags.removeAll()
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.flipBack()
                        self.numberOfCardsShown = 0
                        self.pairToCheck.removeAll()
                        self.buttonsTags.removeAll()
                    }
                }
            } else if isSecondKey {
                
                if SavedPairs.allPairs[pairToCheck[1]] == pairToCheck[0] {
                    numberOfCardsPaired += 1
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.buttons[self.buttonsTags[0]].isHidden = true
                        self.buttons[self.buttonsTags[1]].isHidden = true
                        self.numberOfCardsShown = 0
                        self.pairToCheck.removeAll()
                        self.buttonsTags.removeAll()
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.flipBack()
                        self.numberOfCardsShown = 0
                        self.pairToCheck.removeAll()
                        self.buttonsTags.removeAll()
                    }
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.flipBack()
                    self.numberOfCardsShown = 0
                    self.pairToCheck.removeAll()
                    self.buttonsTags.removeAll()
                }
            }
        }
        
        if numberOfCardsPaired == 12 {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let alertController = UIAlertController(title: "Congratulations!", message: "You managed to pair all the cards!\nTap \"Continue\" to play again!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Continue", style: .default) { [weak self] _ in
                    for button in self!.buttons {
                        button.setImage(UIImage(named: "swift"), for: .normal)
                        button.isHidden = false
                        
                        self!.numberOfCardsPaired = 0
                    }
                    self!.shuffleCards()
                })
                
                self.present(alertController, animated: true)
            }
        }
    }
    
    func flipCard(card object: UIButton, from image: UIImage, to string: String) {
        
        UIButton.transition(with: object, duration: 1.0, options: [
            .transitionFlipFromBottom, .showHideTransitionViews
        ], animations: {
            object.setImage(image, for: .normal)
            object.setTitle(string, for: .normal)
        })
    }
    
    func flipBack() {
        
        UIButton.transition(with: buttons[buttonsTags[0]], duration: 1.0, options: [
            .transitionFlipFromBottom, .showHideTransitionViews
        ], animations: {
            self.buttons[self.buttonsTags[0]].setImage(UIImage(named: "swift"), for: .normal)
        })
        
        UIButton.transition(with: buttons[buttonsTags[1]], duration: 1.0, options: [
            .transitionFlipFromBottom, .showHideTransitionViews
        ], animations: {
            self.buttons[self.buttonsTags[1]].setImage(UIImage(named: "swift"), for: .normal)
        })
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
