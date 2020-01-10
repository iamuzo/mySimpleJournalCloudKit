//
//  JournalsTableViewController.swift
//  mySimpleJournal
//
//  Created by Uzo on 1/8/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class JournalsTableViewController: UITableViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var journalNameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Your Journals"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    //MARK:- Actions
    @IBAction func addJournalButtonTapped(_ sender: UIBarButtonItem) {
        guard let journalName = journalNameTextfield.text, !journalName.isEmpty else { return }
        JournalController.sharedGlobalInstance.createNewJournal(name: journalName)
        journalNameTextfield.text = ""
        journalNameTextfield.endEditing(true)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.sharedGlobalInstance.journals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        let journal = JournalController.sharedGlobalInstance.journals[indexPath.row]
        cell.textLabel?.text = journal.name
        cell.detailTextLabel?.text = String("\(journal.entries.count) entries")
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let journal = JournalController.sharedGlobalInstance.journals[indexPath.row]
            JournalController.sharedGlobalInstance.deleteJournal(journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == "toJournalDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? JournalDetailTableViewController else {return}
            
            let journal = JournalController.sharedGlobalInstance.journals[indexPath.row]
            destinationVC.journal = journal
        }
    }
}
