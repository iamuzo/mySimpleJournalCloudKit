//
//  JournalEntryDetailViewController.swift
//  mySimpleJournal
//
//  Created by Uzo on 2/4/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class JournalEntryDetailViewController: UIViewController {
    
    // MARK: - Properties
    var entry: Journal? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    // MARK: - OUTLETS
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalEntryBodyTextView: UITextView!
    @IBOutlet weak var clearTextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        journalTitleTextField.delegate = self as UITextFieldDelegate
    }
    
    // MARK: - ACTIONS
    @IBAction func addJournalEntryButtonTapped(_ sender: UIBarButtonItem) {
        
        if (entry != nil) {
            print("Update Journal Entry")
        } else {
            print("Create Journal Entry")
            
            guard let title = journalTitleTextField.text,
                !title.isEmpty else { return }
            
            guard let body = journalEntryBodyTextView.text,
                !body.isEmpty else { return }
            
            JournalController.sharedGlobalInstance.createJournalInstance(
                with: title,
                entry: body) {
                (result) in
                
                switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    @IBAction func clearTextButtonTapped(_ sender: UIButton) {
        journalEntryBodyTextView.text = ""
        journalEntryBodyTextView.endEditing(true)
    }
    
    // MARK: - CUSTOM METHODS
    func updateViews() {
        guard let existingJournalEntry = entry else { return }
        
        journalTitleTextField.text = existingJournalEntry.name
        journalEntryBodyTextView.text = existingJournalEntry.entry
        clearTextButton.isHidden = true
    }
    
}

extension JournalEntryDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
    }
}
