//
//  User.swift
//  CoreDataSample
//
//  Created by Dipen Panchasara on 02/06/16.
//  Copyright © 2016 CoreData Sample. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class User: NSManagedObject {
    
    // MARK: - Private
    convenience init(firstName: String, lastName: String, email: String, entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?)
    {
        self.init(entity: entity, insertIntoManagedObjectContext: context)
    
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    // MARK: - Save User
    class func saveUserWith(userInfo:Dictionary<String, AnyObject>, addresses:[AnyObject], withContext context:NSManagedObjectContext) -> Void {
        
        let entityDescription = NSEntityDescription.entityForName(CoreData.UserEntity, inManagedObjectContext: context)
        
        let objUser = User(entity: entityDescription!, insertIntoManagedObjectContext: context)
        
        objUser.firstName = userInfo[Constants.kFirstName] as? String
        objUser.lastName = userInfo[Constants.kLastName] as? String
        objUser.email = userInfo[Constants.kEmail] as? String
        
        let addressMutableSet = objUser.mutableSetValueForKey(Constants.kAddress)
        for dictAddress in addresses
        {
            let dictAddressParams:[String:AnyObject!] = [Constants.kStreet:dictAddress[Constants.kStreet], Constants.kLocality:dictAddress[Constants.kLocality], Constants.kCity:dictAddress[Constants.kCity], Constants.kState:dictAddress[Constants.kState], Constants.kCountry:dictAddress[Constants.kCountry]]
            let objAddress = Address.getAddressObject(dictAddressParams, withContext: context)
            
            addressMutableSet.addObject(objAddress)
        }
    }
    
    class func createNewUserWithUserInfoDict(dictUserInfo:Dictionary<String, AnyObject>, addresses:[AnyObject]) -> Void {
        
        let mainContext = appDel.managedObjectContext
        
        let tempContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        tempContext.parentContext = mainContext
        
        tempContext.performBlock {
            
            User.saveUserWith(dictUserInfo, addresses: addresses, withContext: tempContext)
            
            if tempContext.hasChanges
            {
                do
                {
                    try tempContext.save()
//                    print("\(CoreData.UserEntity) saved to Temp Context.")
                    
                    if mainContext.hasChanges
                    {
                        do
                        {
                            try mainContext.save()
                            print("\(CoreData.UserEntity) saved successfully.")
                        }
                        catch
                        {
                            let saveError = error as NSError
                            print("Error While saving \(CoreData.UserEntity) to Main Context \(saveError.localizedDescription)")
                        }
                    }
                }
                catch
                {
                    let saveError = error as NSError
                    print("Error \(CoreData.UserEntity) saving user to Temp Context \(saveError.localizedDescription)")
                }
            }
        }
    }

    class func deleteUser(objUser:User) -> Void {
        
        let mainContext = appDel.managedObjectContext
        
        mainContext.deleteObject(objUser)

        mainContext.performBlock {
            
            if mainContext.hasChanges
            {
                do
                {
                    try mainContext.save()
                    print("\(CoreData.UserEntity) deleted successfully.")
                }
                catch
                {
                    let saveError = error as NSError
                    print("Error While deleting \(CoreData.UserEntity) from Main Context \(saveError.localizedDescription)")
                }
            }
        }
    }
    
    class func fetchUsers() -> Void
    {
        let mainContext = appDel.managedObjectContext
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entityForName(CoreData.UserEntity, inManagedObjectContext: mainContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do
        {
            let result = try mainContext.executeFetchRequest(fetchRequest)
         
            for user in result
            {
                let obj:NSManagedObject = user as! NSManagedObject
                                
                let strFirstName = obj.valueForKey(Constants.kFirstName)!
                let strLastName = obj.valueForKey(Constants.kLastName)
                let strEmail = obj.valueForKey(Constants.kEmail)
                let addresses = obj.valueForKey(Constants.kAddress)
                
                print("----------------------------------------------------------------------------------------")
                print("\(strFirstName) \t \(strLastName!) \t \(strEmail!)")
                
                for object in (addresses?.allObjects)! {
                    let objAddress = object as! Address
                    print("\(objAddress.street!), \(objAddress.locality!), \(objAddress.city!), \(objAddress.state!), \(objAddress.country!)")
                }
            }
            print("----------------------------------------------------------------------------------------")
        }
        catch
        {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    // MARK: - Function to update object using NSManagedObjectID
    class func updateUser(objectId:NSManagedObjectID) -> Void
    {
        let tempContext = NSManagedObjectContext.init(concurrencyType: .PrivateQueueConcurrencyType)
        
        tempContext.parentContext = appDel.managedObjectContext
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entityForName(CoreData.UserEntity, inManagedObjectContext: appDel.managedObjectContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        fetchRequest.predicate = NSPredicate(format: "%K contains[c] %@", Constants.kFirstName, "Johnny")
        
        do {
            let result = try appDel.managedObjectContext.executeFetchRequest(fetchRequest)
            print(result)
            
            do
            {
                if let object :NSManagedObject = try  appDel.managedObjectContext.existingObjectWithID(objectId)
                {
                    // do something with it
                    object.setValue("Johnny", forKey: Constants.kFirstName)
                    object.setValue("Depp", forKey: Constants.kLastName)
                    object.setValue("California", forKey: Constants.kEmail)
                }
            } catch {
                let fetchError = error as NSError
                print(fetchError)
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    // MARK: - Function to update object using NSManagedObjectID
    class func getUserObjectWithObjectId(objectId:NSManagedObjectID) -> User
    {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entityForName(CoreData.UserEntity, inManagedObjectContext: appDel.managedObjectContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        var objUser:User!
        
        do
        {
            if let object:NSManagedObject = try  appDel.managedObjectContext.existingObjectWithID(objectId)
            {
                objUser = object as! User
                return objUser
            }
        }
        catch
        {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return objUser
    }

}
