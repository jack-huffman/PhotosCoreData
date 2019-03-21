//
//  ContactsTableViewController.swift
//  Photos Core Data
//
//  Created by Jack Huffman on 3/19/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//

import UIKit
import CoreData

class ContactsTableViewController: UITableViewController {

    @IBOutlet var tableView: UITableView!
    
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadContacts()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadContacts()
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        if let cell = cell as? ContactTableViewCell {
            let contact = contacts[indexPath.row]
            cell.nameLabel = contact.name
            cell.phoneLabel = contact.phoneNumber
            cell.contactImage = contact.image
        }
        return cell
    }

    func loadContacts() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            self.contacts = try managedContext.fetch(fetchRequest)
        } catch {
            alertNotifyUser(message: "Fetch for contacts could not be performed")
            return
        }
    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) {
            (alertAction) -> Void in
            print("OK selected")
        })
        
        self.present(alert, animated: true, completion: nil)
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            // Remove from core data
            deleteContact(at: indexPath)
        }
    }
    
    func deleteContact(at indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        
        if let managedObjectContext = contact.managedObjectContext {
            managedObjectContext.delete(contact)
            
            do {
                try managedObjectContext.save()
                self.contacts.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                alertNotifyUser(message: "Delete failed")
                tableView.reloadData()
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NewContactViewController, let segueIdentifier = segue.identifier, segueIdentifier == "existingContact", let row = tableView.indexPathForSelectedRow?.row {
            destination.passedContact = contacts[row]
        }
    }
}
