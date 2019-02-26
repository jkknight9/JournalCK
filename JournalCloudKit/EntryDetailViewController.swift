//
//  EntryDetailViewController.swift
//  JournalCloudKit
//
//  Created by Jack Knight on 2/25/19.
//  Copyright © 2019 Jack Knight. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry?{
        didSet{
            loadViewIfNeeded()
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyTextView.layer.borderWidth = 1
        bodyTextView.layer.borderColor = UIColor.black.cgColor
        bodyTextView.layer.cornerRadius = 5
        

        // Do any additional setup after loading the view.
    }
    
    func updateView(){
        titleTextField.text = entry?.title
        bodyTextView.text = entry?.bodyText
    }
    

    
    @IBAction func saveButtonTapped(_ sender: Any) {

        guard let title = titleTextField.text,
            let body = bodyTextView.text else {return}
        if let entry = entry{
            
            EntryController.shared.updateEntry(entry: entry, title: title, body: body) { (success) in
                if success{
                    print("SUCCESS Updating Entry")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }else {
                    print("Failure updating entry")
                }
            }
            
        }else{
            
            EntryController.shared.addEntryWith(title: title, body: body) { (success) in
                if success{
                    print("SUCCESS creating new entry")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }else {
                    print("Failure creating new entry")
                }
            }
        }
    }
    
}

