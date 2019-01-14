//
//  ViewController.swift
//  Drawing
//
//  Created by user on 1/4/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        drawPainting(context: context)
      
    }
    
    
    func drawPainting(context: CGContext ) {
        
        // let startPoint = CGPoint(x: 0, y: 0)
        // let endPoint = CGPoint(x: 100, y: 100)
        
        //  context.move(to: startPoint)
        //  context.addLine(to: endPoint)
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(10)
        
        
        lines.forEach {  (line) in
            for (index, point) in line.enumerated() {
                if index == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
            
        }
        
        context.strokePath()
        
    }
    
    
    var lines = [[CGPoint]]()
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        
        // add the point to the line
        lastLine.append(point)
        
        // add it to the lines array
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
}

class ViewController: UIViewController {

    let canvas = Canvas()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(canvas)
        canvas.backgroundColor = UIColor.lightGray
        canvas.frame = view.frame.insetBy(dx: 20, dy: 20)
    }


}

