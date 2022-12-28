//
//  PairsTableViewController.swift
//  Consolidation_11-Memory_Pairs
//
//  Created by Edwin Przeźwiecki Jr. on 19/12/2022.
//

import UIKit

class PairsTableViewController: UITableViewController {

    var separatedPairs = Pairs.separatedPairs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pairs"
        
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backAction(sender:)))
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAddition))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbarItems = [spacer, add]
        
        navigationController?.isToolbarHidden = false
    }
    
    @objc func backAction(sender: AnyObject) {
        if Pairs.allPairs.count < 12 {
            
            let alertController = UIAlertController(title: "Too few pairs", message: "Please fill the game's dictionary with at least \(12 - Pairs.allPairs.count) pair(s).", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            
            present(alertController, animated: true)
            
            return
            
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func promptForAddition() {
        
        let alertController = UIAlertController(title: "Add a pair", message: nil, preferredStyle: .alert)
        
        alertController.addTextField()
        alertController.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak alertController] action in
            
            guard let key = alertController?.textFields?[0].text else { return }
            guard let value = alertController?.textFields?[1].text else { return }
            
            self?.addPair(key, value)
        }
        
        alertController.addAction(submitAction)
        
        present(alertController, animated: true)
    }
    
    func addPair(_ key: String, _ value: String) {
        Pairs.allPairs["\(key)"] = "\(value)"
        
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Pairs.allPairs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if let cell = cell as? PairsCell {
            let key = Array(Pairs.allPairs.keys)[indexPath.row]
            let value = Array(Pairs.allPairs.values)[indexPath.row]
            
            cell.textLabel?.text = "\(key): \(value)"
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            
            let title = cell.textLabel!.text
                    
            let components = title!.components(separatedBy: ": ")
            
            let key = components[0]
                
            Pairs.allPairs.removeValue(forKey: key)
            
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
