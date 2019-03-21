//
//  NewContactViewController.swift
//  Photos Core Data
//
//  Created by Jack Huffman on 3/19/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//

import UIKit

class NewContactViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // contact image
    @IBOutlet weak var contactImage: UIImageView!
    
    // text fields
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    
    // passed contact
    var contact: Contact?
    
    // image picker
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create save button
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItems = saveBtn
        
        if passedContact != nil {
            nameTextField.text = passedContact.name
            numberTextField.text = passedContact.phoneNumber
            contactImage.image = passedContact.image
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(NewContactViewController.contactImageTapped(tapGesture:)))
        contactImage.isUserInteractionEnabled = true
        contactImage.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    @objc
    func saveTapped() {
        save()
    }
    
    func save() {
        if nameTextField.text == "" || numberTextField.text == "" || contactImage == nil {
            alertNotifyUser(message: "Contact not saved. Make sure no fields are empty and an image is selected.")
            return
        }
        
        let selectedName = nameTextField.text
        let selectedNumber = numberTextField.text
        let selectedImage = contactImage.image
        
        if contact == nil {
            // contact doesn't exist, create new one
            contact = Contact(name: selectedName, phoneNumber: selectedNumber, image: selectedImage)
        } else {
            // document exists, update existing one
            contact?.update(name: selectedName, phoneNumber: selectedNumber, image: selectedImage)
        }
        if let contact = contact {
            do {
                let managedContext = contact.managedObjectContext
                try managedContext.save()
            } catch {
                alertNotifyUser(message: "The contact could not be saved.")
            }
        } else {
            alertNotifyUser(message: "The contact could not be created.")
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func contactImageTapped(tapGesture: UITapGestureRecognizer) {
        
    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
