//
//  Address+CoreDataProperties.swift
//  CoreDataSample
//
//  Created by Dipen Panchasara on 03/06/16.
//  Copyright © 2016 CoreData Sample. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Address {

    @NSManaged var street: String?
    @NSManaged var locality: String?
    @NSManaged var city: String?
    @NSManaged var state: String?
    @NSManaged var country: String?
    @NSManaged var user: User?

}
