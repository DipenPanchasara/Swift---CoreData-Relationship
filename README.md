# Swift-CoreData-Relationship
##Objective
Application Sample performs CoreData operation with relationship. A `User` can have multiple `Address`, User->>Address is a One-to-Many relationship. Application Create/Insert new User with its respective Addresses using CoreData relationship.

##Things Covered
1. CoreData operations Insert, Update & Delete.
2. One-to-Many Relationship.
3. Cascade Delete. (When user is deleted, its respective addresses also removed from database using Cascade delete property.)
4. Use of `NSManagedObjectID` to access `NSManagedObject` in another ViewController.
5. List of all the Users using `NSFetchedResultsController`

