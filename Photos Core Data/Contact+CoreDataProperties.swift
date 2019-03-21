//
//  Contact+CoreDataProperties.swift
//  Photos Core Data
//
//  Created by Jack Huffman on 3/19/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var rawImage: NSData?
    @NSManaged public var phoneNumber: String?

}
