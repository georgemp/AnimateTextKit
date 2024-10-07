//
//  ViewController.swift
//  AnimateText
//
//  Created by George Philip Malayil on 21/09/24.
//

import Cocoa
import QuartzCore
import Anima

class ViewController: NSViewController {

    var textLayer: CATextLayer!

    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        view.wantsLayer = true
        // Do any additional setup after loading the view.
        view.layer?.backgroundColor = NSColor.white.cgColor

        // Create and configure the CATextLayer
        textLayer = CATextLayer()

        textLayer.string = "# Hello, World!"
        textLayer.fontSize = 20
        textLayer.foregroundColor = NSColor.black.cgColor
        textLayer.alignmentMode = .left
        textLayer.contentsScale = view.window?.screen?.backingScaleFactor ?? 2.0


        view.layer?.addSublayer(textLayer)
        let preferredFrameSize = textLayer.preferredFrameSize()
        print("preferredFrameSize: \(preferredFrameSize)")
        textLayer.bounds = CGRectMake(0, 0, preferredFrameSize.width, preferredFrameSize.height)
        print("view.bounds: \(view.bounds)")
        textLayer.position = CGPoint(x: 20 + preferredFrameSize.width/2, y: view.bounds.height - 20 - preferredFrameSize.height/2 )
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func animationType1() {
                let currentFontSize = self.textLayer.fontSize
                let currentBounds = self.textLayer.bounds
                let currentPosition = self.textLayer.position
                print("currentPosition: \(currentPosition), currentBounds: \(currentBounds)")
        
        
                let fontSizeAnimation = CABasicAnimation(keyPath: #keyPath(CATextLayer.fontSize))
                fontSizeAnimation.fromValue = 20
                fontSizeAnimation.toValue = 40
                fontSizeAnimation.duration = 1.0
                self.textLayer.fontSize = 40

                let targetBounds = CGRect(origin: .zero, size: self.textLayer.preferredFrameSize())
                let targetPosition = CGPoint(x: 20 + targetBounds.width/2, y: view.bounds.height - 20 - targetBounds.height/2 )

                let positionAnimation = CABasicAnimation(keyPath: #keyPath(CATextLayer.position))
                positionAnimation.fromValue = NSValue(point: currentPosition)
                positionAnimation.toValue = NSValue(point: targetPosition)
                self.textLayer.position = targetPosition

                let boundsAnimation = CABasicAnimation(keyPath: #keyPath(CATextLayer.bounds))
                boundsAnimation.fromValue = NSValue(rect: currentBounds)
                boundsAnimation.toValue = targetBounds
                self.textLayer.bounds = targetBounds
        
                CATransaction.begin()
                textLayer.add(fontSizeAnimation, forKey: "fontSize")
                textLayer.add(positionAnimation, forKey: "position")
                textLayer.add(boundsAnimation, forKey: "bounds")
                CATransaction.commit()
    }

    func animationType2() {
        Anima.animate(withDecay: .velocity) {
            self.textLayer.fontSize = 40

            let targetBounds = CGRect(origin: .zero, size: self.textLayer.preferredFrameSize())
            let targetPosition = CGPoint(x: 20 + targetBounds.width/2, y: view.bounds.height - 20 - targetBounds.height/2 )
            self.textLayer.position = targetPosition
            self.textLayer.bounds = targetBounds
        }
    }

    @IBAction func animateText(_ sender: Any) {
        animationType2()
    }
}

