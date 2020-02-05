//
//  JournalEntriesListViewController.swift
//  mySimpleJournal
//
//  Created by Uzo on 2/4/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class JournalEntriesListViewController: UIViewController {

    // MARK: - PROPERTIES
    var indicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: - OUTLETS
    @IBOutlet weak var journalEntriesListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        journalEntriesListTableView.reloadData()
        
    }
    
    // MARK: - Custome Methods
    func configureTableView() {
        title = "Your Journal Entries"
        journalEntriesListTableView.delegate = self
        journalEntriesListTableView.dataSource = self
    }
    
    func showActivityIndicator() {
        self.journalEntriesListTableView.isHidden = true
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.tag = 100
        view.addSubview(indicator)
    }
    
    func removeActivityIndicator() {
        self.journalEntriesListTableView.isHidden = false
        indicator.stopAnimating()
    }
    
    func setupView() {
        showActivityIndicator()
        loadData()
    }
    
    func loadData() {
        JournalController.sharedGlobalInstance.fetchJournals { (result) in
            print(result)
            switch result {
                case .success(let journals):
                    print(journals)
                self.updateViews()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            self.journalEntriesListTableView.reloadData()
            self.showMessage()
            
        }
    }
    
    func showMessage(){
        let returnedRecordsCount = JournalController.sharedGlobalInstance.journals.count
        
        if returnedRecordsCount == 0 {
            self.journalEntriesListTableView.isHidden = true
            indicator.stopAnimating()
            noRecordsLabel()
        } else {
            removeActivityIndicator()
        }
    }
    
    func noRecordsLabel() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = view.center
        label.textAlignment = .center
        label.text = "No Records Yet"
        self.view.addSubview(label)
    }
    
    func presentHypeAlert(for: Journal?) {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "journalEntryDetailVC" {
            guard let indexPath = journalEntriesListTableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as?
                JournalEntryDetailViewController else { return }
            
            let journalEntry = JournalController.sharedGlobalInstance.journals[indexPath.row]
            destinationVC.entry = journalEntry
        }
    }

}

extension JournalEntriesListViewController: UITableViewDelegate{}

extension JournalEntriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.sharedGlobalInstance.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = journalEntriesListTableView.dequeueReusableCell(withIdentifier: "journalEntryCell", for: indexPath)
        
        let journalEntry = JournalController.sharedGlobalInstance.journals[indexPath.row]
        
        cell.textLabel?.text = journalEntry.name
        cell.detailTextLabel?.text = journalEntry.timestamp.dateAsString()
        return cell
    }
    
    
}
