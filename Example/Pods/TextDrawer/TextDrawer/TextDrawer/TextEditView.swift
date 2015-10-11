//
//  TextEditView.swift
//  
//
//  Created by Remi Robert on 11/07/15.
//
//

import UIKit
import Masonry

protocol TextEditViewDelegate {
    func textEditViewFinishedEditing(text: String)
}

public class TextEditView: UIView {

    private var textView: UITextView!
    private var textContainer: UIView!
    
    var delegate: TextEditViewDelegate?

    var textSize: Int! = 42
    
    var textEntry: String! {
        set {
            textView.text = newValue
        }
        get {
            return textView.text
        }
    }
    
    var isEditing: Bool! {
        didSet {
            if isEditing == true {
                textContainer.hidden = false;
                userInteractionEnabled = true;
                backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.65)
                textView.becomeFirstResponder()
            }
            else {
                backgroundColor = UIColor.clearColor()
                textView.resignFirstResponder()
                textContainer.hidden = true;
                userInteractionEnabled = false;
                delegate?.textEditViewFinishedEditing(textView.text)
            }
        }
    }
        
    init() {
        super.init(frame: CGRectZero)
        
        isEditing = false
        textContainer = UIView()
        textContainer.layer.masksToBounds = true
        addSubview(textContainer)
        textContainer.mas_makeConstraints { (make: MASConstraintMaker!) -> Void in
            make.edges.equalTo()(self)
        }
        
        textView = UITextView()
        textView.tintColor = UIColor.whiteColor()
        textView.font = UIFont.systemFontOfSize(44)
        textView.textColor = UIColor.whiteColor()
        textView.backgroundColor = UIColor.clearColor()
        textView.returnKeyType = UIReturnKeyType.Done
        textView.clipsToBounds = true
        textView.delegate = self
        
        textContainer.addSubview(textView)
        textView.mas_makeConstraints { (make: MASConstraintMaker!) -> Void in
            make.edges.equalTo()(self.textContainer)
        }
        
        textContainer.hidden = true
        userInteractionEnabled = false
        
        keyboardNotification()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

extension TextEditView: UITextViewDelegate {
    
    public func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            isEditing = false
            return false
        }
        if textView.text.characters.count + text.characters.count > textSize {
            return false
        }
        return true
    }
}

extension TextEditView {
    
    func keyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil, queue: nil) { (notification: NSNotification) -> Void in
            if let userInfo = notification.userInfo {
                self.textContainer.layer.removeAllAnimations()
                if let keyboardRectEnd = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue,
                    let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.floatValue {
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.textContainer.mas_updateConstraints({ (make: MASConstraintMaker!) -> Void in
                                make.bottom.offset()(-CGRectGetHeight(keyboardRectEnd))
                            })
                            UIView.animateWithDuration(NSTimeInterval(duration), delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                                self.textContainer.layoutIfNeeded()
                                }, completion: nil)
                        })
                }
            }
        }
    }
}
