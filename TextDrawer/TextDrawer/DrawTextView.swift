//
//  DrawTextView.swift
//  
//
//  Created by Remi Robert on 11/07/15.
//
//

import Masonry

class CustomLabel: UILabel {
    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, 5, 0, 5)))
    }
}

public class DrawTextView: UIView {

    var textLabel: CustomLabel!
    
    var text: String! {
        didSet {
            textLabel.text = text
            sizeTextLabel()
        }
    }

    init() {
        super.init(frame: CGRectZero)
        
        layer.masksToBounds = true
        backgroundColor = UIColor.clearColor()
        textLabel = CustomLabel()
        textLabel.font = textLabel.font.fontWithSize(44)
        textLabel.textAlignment = NSTextAlignment.Center
        textLabel.numberOfLines = 0
        textLabel.textColor = UIColor.blackColor()
        textLabel.backgroundColor = UIColor.clearColor()
        addSubview(textLabel)
        
        textLabel.mas_makeConstraints { (make: MASConstraintMaker!) -> Void in
            make.right.and().left().equalTo()(self)
            make.centerY.equalTo()(self)
            make.centerX.equalTo()(self)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func sizeTextLabel() {
        let oldCenter = textLabel.center
        let styleText = NSMutableParagraphStyle()
        styleText.alignment = NSTextAlignment.Center
        let attributsText = [NSParagraphStyleAttributeName:styleText, NSFontAttributeName:UIFont.boldSystemFontOfSize(textLabel.font.pointSize)]
        let sizeParentView = CGSizeMake(CGRectGetWidth(superview!.frame) - 10, CGRectGetHeight(superview!.frame) - 10)
        let sizeTextLabel = (NSString(string: textLabel.text!)).boundingRectWithSize(superview!.frame.size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributsText, context: nil)
        textLabel.frame.size = CGSizeMake(sizeTextLabel.width + 10, sizeTextLabel.height + 10)
        textLabel.center = oldCenter
    }
}
