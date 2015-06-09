//
//  ViewController.swift
//  GraphicMotion
//
//  Created by Noirozr on 15/6/5.
//  Copyright (c) 2015年 Yongjia Liu. All rights reserved.
//


//注释部分为简单的变形动画
import UIKit

class ViewController: UIViewController {
    
//    var aPath: UIBezierPath!
//    var bPath: UIBezierPath!
//    var shape: CAShapeLayer!
    var currentY: CGFloat!
    var waterWaveWidth: CGFloat!
    var waveCycle: CGFloat!
    var waveSpeed: CGFloat!
    var waveGrowth: CGFloat!
    var offsetX: CGFloat!
    
    var firstLayer: CAShapeLayer!
    var secondLayer: CAShapeLayer!
    var displayLink: CADisplayLink!
    
    var count: Int = 0
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var ColorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.aPath = UIBezierPath()
//        self.aPath.moveToPoint(CGPointMake(100.0, 0.0))
//        self.aPath.addLineToPoint(CGPointMake(200.0, 40.0))
//        self.aPath.addLineToPoint(CGPointMake(160, 140))
//        self.aPath.addLineToPoint(CGPointMake(40, 140))
//        self.aPath.addLineToPoint(CGPointMake(0.0, 40))
//        self.aPath.closePath()
//        
//        self.bPath = UIBezierPath()
//        self.bPath.moveToPoint(CGPointMake(0.0, 0.0))
//        self.bPath.addLineToPoint(CGPointMake(100.0, 40.0))
//        self.bPath.addLineToPoint(CGPointMake(120, 140))
//        self.bPath.addLineToPoint(CGPointMake(-10, 100))
//        self.bPath.addLineToPoint(CGPointMake(0.0, 40))
//        self.bPath.closePath()
//        
//        self.shape = CAShapeLayer()
//        shape.drawsAsynchronously = true
//        shape.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2)
//        shape.path = self.aPath.CGPath
//        shape.lineWidth = 3.0
//        shape.lineCap = kCALineCapRound
//        shape.lineJoin = kCALineJoinRound
//        shape.strokeColor = UIColor.whiteColor().CGColor
//        shape.fillColor = UIColor.redColor().CGColor
//        self.view.layer.addSublayer(shape)
        
        self.firstLayer = CAShapeLayer()
        firstLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2)
        firstLayer.fillColor = UIColor(red: 223/255, green: 83/255, blue: 64/255, alpha: 1.0).CGColor
        
        self.secondLayer = CAShapeLayer()
        secondLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2)
        secondLayer.fillColor = UIColor(red: 236/255, green: 90/255, blue: 66/255, alpha: 1.0).CGColor
        
        currentY = self.view.frame.size.height/4
        offsetX = 0
        waveSpeed = 0.4/CGFloat(M_PI)
        waterWaveWidth  = self.view.frame.size.width
        waveGrowth = 1
        waveCycle =  1.29 * CGFloat(M_PI) / waterWaveWidth
        self.view.layer.addSublayer(firstLayer)
        self.view.layer.addSublayer(secondLayer)
        
        
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
    
    @IBAction func stopAnimation(sender: AnyObject) {
        self.displayLink.invalidate()
        self.displayLink = nil
    }
    func beginCount() {
        
        count += 1
        self.countLabel.text = "\(count)"
        var fcount: Float = Float(count)
        if fcount <= 255.0 {
            self.ColorView.backgroundColor = UIColor(red: CGFloat(fcount/255), green: 1, blue: 0, alpha: 1.0)
        } else {
            fcount -= 255.0
            self.ColorView.backgroundColor = UIColor(red: 1, green: CGFloat((255 - fcount)/255), blue: 0, alpha: 1.0)
        }
        
        self.setWave()
    }
    
    func setWave() {
        var wavepath = UIBezierPath()
        var wavepath2 = UIBezierPath()
        if currentY > 10 {
            currentY = currentY - waveGrowth
        }
        var y = currentY
        offsetX = waveSpeed + offsetX
        wavepath.moveToPoint(CGPointMake(0, y))
        wavepath2.moveToPoint(CGPointMake(0, y))
        for x in 0...Int(waterWaveWidth) {
            
            y = 20 * sin(waveCycle * CGFloat(x) + offsetX) + currentY
            wavepath.addLineToPoint(CGPointMake(CGFloat(x), y))

        }
        
        for x in 0...Int(waterWaveWidth) {
            
            y = 20 * cos(waveCycle * CGFloat(x) + offsetX) + currentY
            wavepath2.addLineToPoint(CGPointMake(CGFloat(x), y))

        }
        
        wavepath.addLineToPoint(CGPointMake(waterWaveWidth, self.view.frame.size.height/2))
        wavepath.addLineToPoint(CGPointMake(0, self.view.frame.size.height/2))
        wavepath2.addLineToPoint(CGPointMake(waterWaveWidth, self.view.frame.size.height/2))
        wavepath2.addLineToPoint(CGPointMake(0, self.view.frame.size.height/2))
        wavepath.closePath()
        wavepath2.closePath()
        firstLayer.path = wavepath.CGPath
        secondLayer.path = wavepath2.CGPath
    }

}

