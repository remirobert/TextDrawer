//
//  PreviewViewController.swift
//  
//
//  Created by Remi Robert on 20/07/15.
//
//

import UIKit

class PreviewViewController: UIViewController {

    var image: UIImage?
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func returnController(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = image {
            imageView.image = image
        }
    }

}
