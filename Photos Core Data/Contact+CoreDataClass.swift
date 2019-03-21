//
//  Contact+CoreDataClass.swift
//  Photos Core Data
//
//  Created by Jack Huffman on 3/19/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//
//
import UIKit
import Foundation
import CoreData

@objc(Contact)
public class Contact: NSManagedObject {
    
    var image: UIImage? {
        get {
            if let imageData = rawImage as Data? {
                return UIImage(data: imageData)
            }
            return nil
        } set {
            let imageData = newValue!.pngData() as NSData?
            rawImage = imageData
        }
    }
    
    convenience init?(name: String?, phoneNumber: String?, image: UIImage?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate  //UIKit is needed to access UIApplication
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
                return nil
        }
        self.init(entity: Contact.entity(), insertInto: managedContext)
        self.name = name
        self.phoneNumber = phoneNumber
        self.image = image
    }
    
    func update(name: String, phoneNumber: String, image: UIImage) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.image = image
    }
}
