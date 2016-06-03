//
//  Address.swift
//  CoreDataSample
//
//  Created by Dipen Panchasara on 03/06/16.
//  Copyright © 2016 CoreData Sample. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Address: NSManagedObject {
        
    // MARK: - Private
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    class func saveUser(paramDict:Dictionary<String, AnyObject>, withContext context:NSManagedObjectContext) -> Void {
        
        let entityDescription = NSEntityDescription.entityForName(CoreData.AddressEntity, inManagedObjectContext: context)
        
        let objAddress = Address.init(entity: entityDescription!, insertIntoManagedObjectContext: context)

        objAddress.street = paramDict[Constants.kStreet] as? String
        objAddress.locality = paramDict[Constants.kLocality] as? String
        objAddress.city = paramDict[Constants.kCity] as? String
        objAddress.state = paramDict[Constants.kState] as? String
        objAddress.country = paramDict[Constants.kCountry] as? String
    }
    
    class func getAddressObject(paramDict:Dictionary<String, AnyObject>, withContext context:NSManagedObjectContext) -> Address {
        
        let entityDescription = NSEntityDescription.entityForName(CoreData.AddressEntity, inManagedObjectContext: context)
        
        let objAddress = Address.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
        
        objAddress.street = paramDict[Constants.kStreet] as? String
        objAddress.locality = paramDict[Constants.kLocality] as? String
        objAddress.city = paramDict[Constants.kCity] as? String
        objAddress.state = paramDict[Constants.kState] as? String
        objAddress.country = paramDict[Constants.kCountry] as? String
        
        return objAddress
    }
    
    class func getAddressObject(paramDict:Dictionary<String, AnyObject>, forUser:User, withContext context:NSManagedObjectContext) -> Address {
        
        let entityDescription = NSEntityDescription.entityForName(CoreData.AddressEntity, inManagedObjectContext: context)
        
        let objAddress = Address.init(entity: entityDescription!, insertIntoManagedObjectContext: context)
        
        objAddress.street = paramDict[Constants.kStreet] as? String
        objAddress.locality = paramDict[Constants.kLocality] as? String
        objAddress.city = paramDict[Constants.kCity] as? String
        objAddress.state = paramDict[Constants.kState] as? String
        objAddress.country = paramDict[Constants.kCountry] as? String
        objAddress.user = forUser
        
        return objAddress
    }
}
