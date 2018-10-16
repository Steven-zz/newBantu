//
//  PaddingTextField.swift
//  
//
//  Created by Resky Javieri on 08/10/18.
//

import UIKit

extension UITextField {
    
    func setIndentLeftPadding() {
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 20))
        self.leftView = paddingView
        self.leftViewMode = .always
        
    }
}


extension UITextView {
    
    func setIndentTextView() {
        self.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        self.text = "Placeholders"
        self.textColor = UIColor.lightGray
        self.returnKeyType = .done
        self.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    
    
    
}

extension UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Placeholders" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
}
