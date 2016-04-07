//
//  DrawView.swift
//  
//
//  Created by Remi Robert on 11/07/15.
//
//

//Scrux

import UIKit
import Masonry

public class TextDrawer: UIView, TextEditViewDelegate {

    private var textEditView: TextEditView!
    private var drawTextView: DrawTextView!
    
    private var initialTransformation: CGAffineTransform!
    private var initialCenterDrawTextView: CGPoint!
    private var initialRotationTransform: CGAffineTransform!
    private var initialReferenceRotationTransform: CGAffineTransform!
    
    private var activieGestureRecognizer = NSMutableSet()
    private var activeRotationGesture: UIRotationGestureRecognizer?
    private var activePinchGesture: UIPinchGestureRecognizer?
    
    private lazy var tapRecognizer: UITapGestureRecognizer! = {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleTapGesture:")
        tapRecognizer.delegate = self
        return tapRecognizer
    }()
    
    private lazy var panRecognizer: UIPanGestureRecognizer! = {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        panRecognizer.delegate = self
        return panRecognizer
    }()
    
    private lazy var rotateRecognizer: UIRotationGestureRecognizer! = {
        let rotateRecognizer = UIRotationGestureRecognizer(target: self, action: "handlePinchGesture:")
        rotateRecognizer.delegate = self
        return rotateRecognizer
    }()

    private lazy var zoomRecognizer: UIPinchGestureRecognizer! = {
        let zoomRecognizer = UIPinchGestureRecognizer(target: self, action: "handlePinchGesture:")
        zoomRecognizer.delegate = self
        return zoomRecognizer
    }()
    
    public func clearText() {
        text = ""
    }
    
    public func resetTransformation() {
        drawTextView.transform = initialTransformation
        drawTextView.mas_updateConstraints({ (make: MASConstraintMaker!) -> Void in
            make.edges.equalTo()(self)
            make.centerX.and().centerY().equalTo()(self)
        })
        drawTextView.center = center
        //drawTextView.sizeTextLabel()
    }
    
    //MARK: -
    //MARK: Setup DrawView
    
    private func setup() {
        self.layer.masksToBounds = true
        drawTextView = DrawTextView()
        initialTransformation = drawTextView.transform
        addSubview(drawTextView)
        drawTextView.mas_makeConstraints { (make: MASConstraintMaker!) -> Void in
            make.edges.equalTo()(self)
        }

        textEditView = TextEditView()
        textEditView.delegate = self

        addSubview(textEditView)
        textEditView.mas_makeConstraints { (make: MASConstraintMaker!) -> Void in
            make.edges.equalTo()(self)
        }
        
        addGestureRecognizer(tapRecognizer)
        addGestureRecognizer(panRecognizer)
        addGestureRecognizer(rotateRecognizer)
        addGestureRecognizer(zoomRecognizer)
        
        initialReferenceRotationTransform = CGAffineTransformIdentity
    }
    
    //MARK: -
    //MARK: Initialisation
    
    init() {
        super.init(frame: CGRectZero)
        setup()
        drawTextView.textLabel.font = drawTextView.textLabel.font.fontWithSize(44)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func textEditViewFinishedEditing(text: String) {
        textEditView.hidden = true
        drawTextView.text = text
    }
}

//MARK: -
//MARK: Proprety extension

public extension TextDrawer {
    
    public var fontSize: CGFloat! {
        set {
            drawTextView.textLabel.font = drawTextView.textLabel.font.fontWithSize(newValue)
        }
        get {
            return  drawTextView.textLabel.font.pointSize
        }
    }
    
    public var font: UIFont! {
        set {
            drawTextView.textLabel.font = newValue
        }
        get {
            return drawTextView.textLabel.font
        }
    }
    
    public var textColor: UIColor! {
        set {
            drawTextView.textLabel.textColor = newValue
        }
        get {
            return drawTextView.textLabel.textColor
        }
    }
    
    public var textAlignement: NSTextAlignment! {
        set {
            drawTextView.textLabel.textAlignment = newValue
        }
        get {
            return drawTextView.textLabel.textAlignment
        }
    }
    
    public var textBackgroundColor: UIColor! {
        set {
            drawTextView.textLabel.backgroundColor = newValue
        }
        get {
            return drawTextView.textLabel.backgroundColor
        }
    }
    
    public var text: String! {
        set {
            drawTextView.text = newValue
        }
        get {
            return drawTextView.text
        }
    }
    
    public var textSize: Int! {
        set {
            textEditView.textSize = newValue
        }
        get {
            return textEditView.textSize
        }
    }
}

//MARK: -
//MARK: Gesture handler extension

extension TextDrawer: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func handleTapGesture(recognizer: UITapGestureRecognizer) {
        textEditView.textEntry = text
        textEditView.isEditing = true
        textEditView.hidden = false
    }
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self)
        switch recognizer.state {
        case .Began, .Ended, .Failed, .Cancelled:
            initialCenterDrawTextView = drawTextView.center
        case .Changed:
            drawTextView.center = CGPointMake(initialCenterDrawTextView.x + translation.x,
                initialCenterDrawTextView.y + translation.y)
        default: return
        }
    }
    
    func handlePinchGesture(recognizer: UIGestureRecognizer) {
        var transform = initialRotationTransform
        
        switch recognizer.state {
        case .Began:
            if activieGestureRecognizer.count == 0 {
                initialRotationTransform = drawTextView.transform
            }
            activieGestureRecognizer.addObject(recognizer)
            break
            
        case .Changed:
            for currentRecognizer in activieGestureRecognizer {
                transform = applyRecogniser(currentRecognizer as? UIGestureRecognizer, currentTransform: transform)
            }
            drawTextView.transform = transform
            break
            
        case .Ended, .Failed, .Cancelled:
            initialRotationTransform = applyRecogniser(recognizer, currentTransform: initialRotationTransform)
            activieGestureRecognizer.removeObject(recognizer)
        default: return
        }

    }
    
    private func applyRecogniser(recognizer: UIGestureRecognizer?, currentTransform: CGAffineTransform) -> CGAffineTransform {
        if let recognizer = recognizer {
            if recognizer is UIRotationGestureRecognizer {
                return CGAffineTransformRotate(currentTransform, (recognizer as! UIRotationGestureRecognizer).rotation)
            }
            if recognizer is UIPinchGestureRecognizer {
                let scale = (recognizer as! UIPinchGestureRecognizer).scale
                return CGAffineTransformScale(currentTransform, scale, scale)
            }
        }
        return currentTransform
    }
}

//MARK: -
//MARK: Render extension

public extension TextDrawer {
    
    public func render() -> UIImage? {
        return renderTextOnView(self)
    }
    
    public func renderTextOnView(view: UIView) -> UIImage? {
        let size = UIScreen.mainScreen().bounds.size
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return renderTextOnImage(img)
    }
    
    public func renderTextOnImage(image: UIImage) -> UIImage? {
        let size = image.size
        let scale = size.width / CGRectGetWidth(self.bounds)
        let color = layer.backgroundColor

        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        
        image.drawInRect(CGRectMake(CGRectGetWidth(self.bounds) / 2 - (image.size.width / scale) / 2,
            CGRectGetHeight(self.bounds) / 2 - (image.size.height / scale) / 2,
            image.size.width / scale,
            image.size.height / scale))
        layer.backgroundColor = UIColor.clearColor().CGColor
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        layer.backgroundColor = color

        
        let drawnImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return UIImage(CGImage: drawnImage.CGImage!, scale: 1, orientation: drawnImage.imageOrientation)
    }
}
