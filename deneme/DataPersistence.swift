//
//  DataPersistence.swift

//

//

import Foundation
import CoreData

class DataPersistence {
    
    static let containerName: String = "DownloadedVideo"
    static let entityName: String = "DownloadedVideo"
    static let attributeID: String = "movieID"
    static let attributeName: String = "name"
    static let attributeImage: String = "image"
    static let attributeEpisodeLinks: String = "episodeLinks"
    static let attributeModel: String = "movieID"
    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    public static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    // MARK: - Core Data Saving support
    static private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data Fetching
    static func fetchFavorites() -> [AnyObject] {
        var favoritesItems = [AnyObject]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchResults = try persistentContainer.viewContext.fetch(fetchRequest)
            
           
            for item in fetchResults as! [NSManagedObject]{
                if let idNumber = item.value(forKey: attributeName) as? AnyObject {
                    favoritesItems.append(idNumber)
                }
            }
            for item in fetchResults as! [NSManagedObject]{
                if let idNumber = item.value(forKey: attributeEpisodeLinks) as? AnyObject {
                    print("erga",idNumber[1])
                    favoritesItems.append(idNumber)
                }
            }
        } catch let error{
            print(error.localizedDescription)
        }
        
        return favoritesItems
    }
    static func isIdContain(movieID:String) -> Bool {
        var IdisContain=false
        var favoritesItems = [AnyObject]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchResults = try persistentContainer.viewContext.fetch(fetchRequest)
            
           
            for item in fetchResults as! [NSManagedObject]{
                
                if let idNumber = item.value(forKey: attributeID) as? String {
                    if movieID == idNumber // same movie have on download
                    {
                        IdisContain=true
                    }
                }
            }
         
        } catch let error{
            print(error.localizedDescription)
        }
        
        return IdisContain
    }
    
    
    
    // MARK: - Core Data Add
   
    
    // MARK: - Core Data Remove
    static func removeDownloadedVideo(moveId: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate.init(format: "\(attributeName)==\(moveId)")
        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects as! [NSManagedObject] {
                context.delete(object)
            }
            saveContext()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
