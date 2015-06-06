//
//  ViewController.swift
//  GraphicMotion
//
//  Created by Noirozr on 15/6/5.
//  Copyright (c) 2015年 Yongjia Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var aPath: UIBezierPath!
    var bPath: UIBezierPath!
    var shape: CAShapeLayer!
    var displayLink: CADisplayLink!
    var count: Int = 0
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.aPath = UIBezierPath()
        self.aPath.moveToPoint(CGPointMake(100.0, 0.0))
        self.aPath.addLineToPoint(CGPointMake(200.0, 40.0))
        self.aPath.addLineToPoint(CGPointMake(160, 140))
        self.aPath.addLineToPoint(CGPointMake(40, 140))
        self.aPath.addLineToPoint(CGPointMake(0.0, 40))
        self.aPath.closePath()
        
        self.bPath = UIBezierPath()
        self.bPath.moveToPoint(CGPointMake(0.0, 0.0))
        self.bPath.addLineToPoint(CGPointMake(100.0, 40.0))
        self.bPath.addLineToPoint(CGPointMake(120, 140))
        self.bPath.addLineToPoint(CGPointMake(-10, 100))
        self.bPath.addLineToPoint(CGPointMake(0.0, 40))
        self.bPath.closePath()
        
        self.shape = CAShapeLayer()
        shape.drawsAsynchronously = true
        shape.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2)
        shape.path = self.aPath.CGPath
        shape.lineWidth = 3.0
        shape.lineCap = kCALineCapRound
        shape.lineJoin = kCALineJoinRound
        shape.strokeColor = UIColor.whiteColor().CGColor
        shape.fillColor = UIColor.redColor().CGColor
        self.view.layer.addSublayer(shape)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startAnimation(sender: AnyObject) {
        
//        var pathAnimation = CABasicAnimation(keyPath: "path")
//        pathAnimation.fromValue = self.aPath.CGPath
//        pathAnimation.toValue = self.bPath.CGPath
//        pathAnimation.duration = 0.5
//        pathAnimation.autoreverses = false
//        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
//        
//        shape.addAnimation(pathAnimation, forKey: "animationKey")
//        shape.path = self.bPath.CGPath
        
        self.displayLink = CADisplayLink(target: self, selector: Selector("beginCount"))
        self.displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    
    func beginCount() {
        
        count += 1
        self.countLabel.text = "\(count)"
    }

}

