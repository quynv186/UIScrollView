//
//  ViewScroll.swift
//  UIScrollView
//
//  Created by admin on 10/27/2016.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var sld_Zoom: UISlider!
    @IBOutlet weak var scrollView: UIScrollView!
    var photo = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        
        let imgView = UIImageView(image: UIImage(named: "shop1-0.jpg"))
        imgView.frame = CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height)
        
        imgView.isUserInteractionEnabled = true
        imgView.isMultipleTouchEnabled = true
        imgView.contentMode = .scaleAspectFit

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapImg(gesture:)))
        tap.numberOfTapsRequired = 1
        imgView.addGestureRecognizer(tap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapImg(gesture:)))
        doubleTap.numberOfTapsRequired = 2
        imgView.addGestureRecognizer(doubleTap)
        tap.require(toFail: doubleTap)
        
        photo = imgView
        scrollView.contentSize = CGSize(width: imgView.bounds.width, height: imgView.bounds.height)
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
        
        self.scrollView.addSubview(imgView)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photo
    }
    
    func tapImg(gesture : UITapGestureRecognizer) {
        let position = gesture.location(in: photo)
        zoomRectForScale(scale: scrollView.zoomScale * 1.5, center: position)
        
    }
    
    func doubleTapImg(gesture : UITapGestureRecognizer) {
        let position = gesture.location(in: photo)
        zoomRectForScale(scale: scrollView.zoomScale * 0.5, center: position)
    }
    
    func zoomRectForScale(scale : CGFloat, center : CGPoint) {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        
        scrollView.zoom(to: zoomRect, animated: true)
    }
    
    @IBAction func sld_Zoom(_ sender: UISlider) {
        let position = CGPoint(x: scrollView.bounds.size.width / 2, y: scrollView.bounds.size.height / 2)
        zoomRectForScale(scale : CGFloat(sender.value), center : position)
        
    }


}
