//
//  JournalDetailTableViewController.swift
//  mySimpleJournal
//
//  Created by Uzo on 1/8/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class JournalDetailTableViewController: UITableViewController {
    
    //MARK:- Properties
    var journal: Journal?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        updateViews()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let journal = journal else { return 0 }
        return journal.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        guard let journal = journal else { return UITableViewCell() }
        
        let entry = journal.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = String("\(entry.timeStamp)")
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let journal = journal else { return }
            
            let entry = journal.entries[indexPath.row]
            
            JournalController.sharedGlobalInstance.deleteEntry(entry: entry, fromjournal: journal)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addEntryVC" {
            guard let journal = journal else { return }
            let destinationVC = segue.destination as? EntryViewController
            destinationVC?.journal = journal
        }
        
        if segue.identifier == "showEntry" {
            guard let journal = journal else { return }
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? EntryViewController else { return }
            
            let entry = journal.entries[indexPath.row]
            destinationVC.journal = journal
            destinationVC.entry = entry
        }
    }
    
    //MARK:- Custom Methods
    private func updateViews() {
        guard let journal = journal else { return }
        self.navigationItem.title = journal.name
    }
}
