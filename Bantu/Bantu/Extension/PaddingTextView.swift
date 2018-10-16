//
//  PaddingTextView.swift
//  Bantu
//
//  Created by Gior Fasolini on 16/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit

class PaddingTextView: UITextView, UITextViewDelegate {
    
    func setTextView() {
        self.text = "Placeholders"
        self.textColor = UIColor.lightGray
        self.returnKeyType = .done
        self.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.text == "Placeholders" {
            self.text = ""
            self.textColor = UIColor.black
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.text == "" {
            self.text = "Placeholders"
            self.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = self.frame.size.width
        self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = self.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        self.frame = newFrame
    }

}

