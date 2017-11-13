//
//  ViewController.swift
//  MagicalGrid
//
//  Created by Dai Tran on 11/13/17.
//  Copyright © 2017 Dai Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let numberPerRow = 15
    var cells: [String: UIView] = [String: UIView]()
    
    var selectedView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let viewCellWidth = view.frame.width / 15

        for j in 0...30 {
            for i in 0...numberPerRow {
                let viewCell = UIView()
                viewCell.backgroundColor = randomColor()
                viewCell.frame = CGRect(x: CGFloat(i) * viewCellWidth, y: CGFloat(j) * viewCellWidth, width: viewCellWidth, height: viewCellWidth)
                viewCell.layer.borderWidth = 0.5
                viewCell.layer.borderColor = UIColor.black.cgColor
                view.addSubview(viewCell)
                
                let key = "\(i)|\(j)"
                cells[key] = viewCell
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        let viewCellWidth = view.frame.width / 15
        
        let x = Int(location.x / viewCellWidth)
        let y = Int(location.y / viewCellWidth)
        
        let key = "\(x)|\(y)"
        
        guard let cell = cells[key] else { return }
        
        if (cell != selectedView) {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedView?.layer.transform = CATransform3DIdentity
            }, completion: nil)
            
            selectedView = cell
        }
        view.bringSubview(toFront: cell)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            cell.layer.transform = CATransform3DMakeScale(3, 3, 3)
        }, completion: nil)
        
        if (gesture.state == .ended) {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedView?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

