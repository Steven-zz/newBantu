//
//  AddDraftViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 10/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class AddDraftViewController: UIViewController {
    
    
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var aboutTextField: UITextView!
    @IBOutlet weak var studentNoTextField: UITextField!
    @IBOutlet weak var teacherNo: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var accessTextView: UITextView!
    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
    }
    
    @objc func saveButtonTapped() {
        
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
