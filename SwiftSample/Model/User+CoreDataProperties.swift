//
//  User+CoreDataProperties.swift
//  CoreDataSample
//
//  Created by Dipen Panchasara on 02/06/16.
//  Copyright © 2016 CoreData Sample. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var email: String?
    @NSManaged var address: NSSet?
}
