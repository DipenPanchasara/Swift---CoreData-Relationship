//
//  CoreDataController.swift
//  CoreDataSample
//
//  Created by Dipen Panchasara on 02/06/16.
//  Copyright © 2016 CoreData Sample. All rights reserved.
//

import UIKit
import CoreData

class CoreDataController: UIViewController, NSFetchedResultsControllerDelegate {
    
    let ReuseIdentifierToDoCell = "UserCell"
    var selectedUserId:NSManagedObjectID!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do
        {
            try self.fetchedResultsController.performFetch()
        }
        catch
        {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Method to add new user
    @IBAction func addNewUser()
    {
        let dictUserInfo:[String:AnyObject!] = [Constants.kFirstName:"Bertha", Constants.kLastName:"Lee", Constants.kEmail:"bertha.lee79@example.com"]

        var addresses = [[String: AnyObject]]()
        addresses.append([Constants.kStreet:"3286", Constants.kLocality:"Northaven Rd", Constants.kCity:"Santa ana", Constants.kState:"Oregon", Constants.kCountry:"USA"])
        addresses.append([Constants.kStreet:"5592", Constants.kLocality:"Pockrus page rd", Constants.kCity:"Santa ana", Constants.kState:"Oregon", Constants.kCountry:"USA"])

        User.createNewUserWithUserInfoDict(dictUserInfo, addresses: addresses)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "userDetailSegue")
        {
            if let objUDVC: UserDetailViewController = segue.destinationViewController as? UserDetailViewController {
                objUDVC.objectID = selectedUserId
            }
        }
    }
    
    // MARK: - lazy init FetchResultController
    lazy var fetchedResultsController: NSFetchedResultsController = {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest(entityName: CoreData.UserEntity)
        
        // Add Sort Descriptors
        let sortDescriptor = NSSortDescriptor(key: Constants.kFirstName, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDel.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    // MARK: -
    // MARK: Fetched Results Controller Delegate Methods
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch (type) {
        case .Insert:
            if let indexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            break;
        case .Delete:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            break;
        case .Update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! UserTableViewCell
                configureCell(cell, atIndexPath: indexPath)
            }
            break;
        case .Move:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
            if let newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            }
            break;
        }
    }
}

extension CoreDataController : UITableViewDataSource, UITableViewDelegate
{
    // MARK: -
    // MARK: Table View Data Source Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        if let sections = fetchedResultsController.sections
        {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let sections = fetchedResultsController.sections
        {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(ReuseIdentifierToDoCell, forIndexPath: indexPath) as! UserTableViewCell
        
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: UserTableViewCell, atIndexPath indexPath: NSIndexPath)
    {
        // Fetch User
        let objUser = fetchedResultsController.objectAtIndexPath(indexPath) as! User
        
        // Update Cell
        if let firstName = objUser.firstName, lastName = objUser.lastName
        {
            cell.lblFullName.text = NSString(format: "\(firstName) \(lastName)") as String
            cell.lblEmail.text = objUser.email
            
            let objUserAddress = objUser.address?.allObjects[0] as! Address
            cell.lblCountry.text = objUserAddress.country
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let objUser = fetchedResultsController.objectAtIndexPath(indexPath) as! User
        
        selectedUserId = objUser.objectID
        self.performSegueWithIdentifier("userDetailSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            let objUser = self.fetchedResultsController.objectAtIndexPath(indexPath) as! User
            
            User.deleteUser(objUser)

        }
    }
}
