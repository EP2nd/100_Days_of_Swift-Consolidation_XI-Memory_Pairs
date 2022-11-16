//
//  ViewController.swift
//  Consolidation_11-Memory_Pairs
//
//  Created by Edwin Przeźwiecki Jr. on 09/11/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var gridView: UIImageView!
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    @IBOutlet var button9: UIButton!
    @IBOutlet var button10: UIButton!
    @IBOutlet var button11: UIButton!
    @IBOutlet var button12: UIButton!
    @IBOutlet var button13: UIButton!
    @IBOutlet var button14: UIButton!
    @IBOutlet var button15: UIButton!
    @IBOutlet var button16: UIButton!
    @IBOutlet var button17: UIButton!
    @IBOutlet var button18: UIButton!
    @IBOutlet var button19: UIButton!
    @IBOutlet var button20: UIButton!
    @IBOutlet var button21: UIButton!
    @IBOutlet var button22: UIButton!
    @IBOutlet var button23: UIButton!
    @IBOutlet var button24: UIButton!
    @IBOutlet var button25: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hue: 0.6, saturation: 1, brightness: 0.3, alpha: 1)
        
        drawGridOfRectangles()
    }
    
    func drawGridOfRectangles() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1024, height: 768))
        
        let grid = renderer.image { ctx in
            //ctx.cgContext.translateBy(x: 20, y: 20)
            
                for row in 0..<5 {
                    for column in 0..<5 {
                        let rectangle = CGRect(x: column * 200, y: row * 150, width: 220, height: 165).insetBy(dx: 20, dy: 20)
                        
                        ctx.cgContext.setStrokeColor(UIColor.orange.cgColor)
                        ctx.cgContext.setLineWidth(5)
                        
                        ctx.cgContext.addRect(rectangle)
                        ctx.cgContext.drawPath(using: .stroke)
                }
            }
        }
        gridView.image = grid
    }
}

