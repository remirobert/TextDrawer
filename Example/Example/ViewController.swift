//
//  ViewController.swift
//  Example
//
//  Created by Remi Robert on 17/07/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

import UIKit
import TextDrawer

class ViewController: UIViewController {
    
    @IBOutlet var containerControlView: UIView!
    @IBOutlet var drawTextView: TextDrawer!
    @IBOutlet var imageViewBackground: UIImageView!
    
    @IBAction func changeTextColor(sender: AnyObject) {
        drawTextView.textColor = (sender as! UIButton).backgroundColor
    }
    
    @IBAction func changeBackgroundColor(sender: AnyObject) {
        drawTextView.textBackgroundColor = (sender as! UIButton).backgroundColor
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawTextView.textBackgroundColor = UIColor.clearColor()
        drawTextView.textColor = UIColor.whiteColor()
        drawTextView.text = "TextDrawer"
        self.view.bringSubviewToFront(containerControlView)
    }

    @IBAction func renderImage(sender: AnyObject) {
         //drawTextView.renderTextOnImage(imageViewBackground.image!)
        let image = drawTextView.renderTextOnView(imageViewBackground)
        self.performSegueWithIdentifier("previewSegue", sender: image)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "previewSegue" {
            (segue.destinationViewController as! PreviewViewController).image = sender as? UIImage
        }
    }
}
