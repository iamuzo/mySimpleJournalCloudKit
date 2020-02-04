//
//  EntryViewController.swift
//  mySimpleJournal
//
//  Created by Uzo on 1/9/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    //MARK:- Properties
    var entry: Entry?
    var journal: Journal?
    
    //MARK:- Outlets
    @IBOutlet weak var entryBodyTextField: UITextView!
    @IBOutlet weak var entryTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateViews()
        customizeButtons()
    }

    //MARK:- Custom Methods
    private func clearButton() -> UIButton {
         let clearButton = UIButton()
         clearButton.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(clearButton)
         clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         clearButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return clearButton
    }
    
    private func updateViews() {
        loadViewIfNeeded()
        guard let entry = entry else { return }
        entryTitleTextField.text = entry.title
        entryTitleTextField.isEnabled = false
        entryBodyTextField.text = entry.text
        entryBodyTextField.isEditable = false
    }
    
    private func customizeButtons() {
        if entry != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .edit, target: self, action: #selector(editEntryButtonTapped)
            )
        } else {
            let button = clearButton()
            button.setTitle("Clear Text", for: .normal)
            button.setTitleColor(.cyan, for: .normal)
            button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
            entryBodyTextField.text = "Clear Placeholder Text To Begin"
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .save, target: self, action: #selector(saveEntryButtonTapped)
            )
        }
    }
    
    @objc func clearButtonTapped() {
        entryBodyTextField.text = ""
        entryBodyTextField.endEditing(true)
    }
    
    @objc func saveEntryButtonTapped(){
        guard let journal = journal else { return }
        
        guard let entryTitle = entryTitleTextField.text, !entryTitle.isEmpty else { return }
        
        guard let entryText = entryBodyTextField.text, !entryText.isEmpty else { return }
        
        //createEntryWith(title: entryTitle, bodyText: entryText, for: journal)
        
        entryTitleTextField.text = ""
        entryTitleTextField.endEditing(true)
        entryBodyTextField.text = ""
        entryBodyTextField.endEditing(true)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func editEntryButtonTapped() {
        print("Edit Entry")
        entryTitleTextField.isEnabled = true
        entryBodyTextField.isEditable = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updateEntryButtonTapped))
    }
    
    @objc func updateEntryButtonTapped() {
        print("Update Entry")
        
        guard let entry = entry else { return }
        
        guard let journal = journal else { return }
        
        guard let entryTitle = entryTitleTextField.text, !entryTitle.isEmpty else { return }
        
        guard let entryText = entryBodyTextField.text, !entryText.isEmpty else { return }
        
//        let editedEntry = EntryController.updateEntry(entry: entry, title: entryTitle, text: entryText)
//
//        updateEntryWith(editedEntry: editedEntry, byReplacing: entry, in: journal)
        
        entryTitleTextField.text = ""
        entryTitleTextField.endEditing(true)
        entryBodyTextField.text = ""
        entryBodyTextField.endEditing(true)
        
        self.navigationController?.popViewController(animated: true)
    }

//    private func createEntryWith(title: String, bodyText: String, for journal: Journal) {
//        let newEntry = EntryController.createEntry(title: title, text: bodyText)
//        JournalController.sharedGlobalInstance.addNewEntry(entry: newEntry, toJournal: journal)
//    }
//
//    private func updateEntryWith(editedEntry: Entry, byReplacing oldEntry: Entry, in journal: Journal) {
//        JournalController.sharedGlobalInstance.updateEntry(updatedEntry: editedEntry, oldEntry: oldEntry, inJournal: journal)
//    }
}


