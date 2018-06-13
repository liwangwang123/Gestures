//
//  ViewController.swift
//  Gestures
//
//  Created by lemo on 2018/6/13.
//  Copyright © 2018年 wangli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var netRotation: CGFloat = 0
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1, 旋转手势
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(rotationAction(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(rotation)
        
        //2, 轻扫手势-- 四个方法需要单独添加
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        downSwipe.direction = .down
        imageView.addGestureRecognizer(downSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        leftSwipe.direction = .left
        imageView.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        rightSwipe.direction = .right
        imageView.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        upSwipe.direction = .up
        imageView.addGestureRecognizer(upSwipe)
        
        //3, 长按手势
        let long = UILongPressGestureRecognizer(target: self, action: #selector(longAction(_:)))
        imageView.addGestureRecognizer(long)
        
        //4, 捏合手势
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(_:)))
        imageView.addGestureRecognizer(pinch)
        
        //5, 单击
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        imageView.addGestureRecognizer(tap1)
        
        //6, 双击
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(tapAcrion2(_:)))
        tap2.numberOfTapsRequired = 2
        //当一个 view 既有单击手势,也有双击手势时,需要准确的判断出单双击手势,require方法在判断不是双击之后,再响应单击
        tap1.require(toFail: tap2)
        imageView.addGestureRecognizer(tap2)
    }
    
    //旋转手势旋转
    @objc func rotationAction(_ rotation: UIRotationGestureRecognizer) {
        let roration1 = rotation.rotation//角度
        let tramsform = CGAffineTransform(rotationAngle: roration1 + netRotation)
        rotation.view?.transform = tramsform
        if rotation.state == UIGestureRecognizerState.ended {
            netRotation += roration1
        }
        print("rotation:\(rotation.velocity)")
    }

    //轻扫移动
    var X: CGFloat = 0
    var Y: CGFloat = 0
    @objc func swipeAction(_ swipe: UISwipeGestureRecognizer) {
        
        switch swipe.direction {
        case UISwipeGestureRecognizerDirection.left:
            X = -10 + X
            let tranform = CGAffineTransform(translationX: X, y: Y)
            imageView.transform = tranform
            print("letf")
        case UISwipeGestureRecognizerDirection.right:
            X = 10 + X
            let tranform = CGAffineTransform(translationX: X, y: Y)
            imageView.transform = tranform
            print("right")
        case UISwipeGestureRecognizerDirection.down:
            Y = 10 + Y
            let tranform = CGAffineTransform(translationX: X, y: Y)
            imageView.transform = tranform
            print("down")
        case UISwipeGestureRecognizerDirection.up:
            Y = -10 + Y
            let tranform = CGAffineTransform(translationX: X, y: Y)
            imageView.transform = tranform
            print("up")
        default:
            print("不知道")
        }
    }
    
    //长按旋转
    var longAngle: CGFloat = 0
    @objc func longAction(_ long: UILongPressGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            self.longAngle = self.longAngle + 1.0
            let tranform = CGAffineTransform(rotationAngle: self.longAngle)
            self.imageView.transform = tranform
            print("长按")
        }
    }
    
    //捏合手势
    @objc func pinchAction(_ pinch: UIPinchGestureRecognizer) {
        let scale = pinch.scale
        let tranform = CGAffineTransform(scaleX: scale, y: scale)
        imageView.transform = tranform
        print("捏合")
    }
    
    //单击手势
    @objc func tapAction(_ tap: UITapGestureRecognizer) {
        print("单击")
    }
    
    //双击手势
    @objc func tapAcrion2(_ tap: UITapGestureRecognizer) {
        print("双击")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}

