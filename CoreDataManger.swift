


import UIKit
import CoreData

class CoreDataManager {
    
    static let containerName: String = "downloadedVideos"
    static let entityName: String = "DownloadedVideo"
    static let attributeID: String = "movieID"
    static let attributeName: String = "name"
    static let attributeImage: String = "image"
    static let attributeEpisodeLinks: String = "episodeLinks"
    static let attributeModel: String = "movieID"

static let shared = CoreDataManager()
    

let persistentContainer: NSPersistentContainer = {
let container = NSPersistentContainer(name: containerName)
container.loadPersistentStores(completionHandler: { (store, error) in
if let error = error {
  print(error)
}

})
return container
}()
    
func fetchArtists() -> [ArtistSaved] {
let context = persistentContainer.viewContext
        
let fetchRequest = NSFetchRequest<ArtistSaved>(entityName: "ArtistSaved")
    do {
let artists = try context.fetch(fetchRequest)
//fetchRequest.includesSubentities = false
        for item in artists as! [NSManagedObject]{
            
            if let idNumber = item.value(forKey: "name") as? String {
                print(idNumber)
            }
            if let idNumber = item.value(forKey: "movieName") as? String {
                print(idNumber)
            }
        }
        
return artists

        
} catch let fetchErr {
print(fetchErr)
    return []
    }
    
}
    
    
func saveAlbumInfo(artistName: String, movieName: String, image: String, listeners: String, playCount: String, published: String) {
    
let context = CoreDataManager.shared.persistentContainer.viewContext
    
let artist = NSEntityDescription.insertNewObject(forEntityName: "ArtistSaved", into: context) as! ArtistSaved
    
artist.setValue(artistName, forKey: "name")
artist.setValue(movieName, forKey: "movieName")
    
let albumSaved = NSEntityDescription.insertNewObject(forEntityName: "AlbumSaved", into: context) as! AlbumSaved
    

albumSaved.setValue(image, forKey: "image")
albumSaved.setValue(listeners, forKey: "listeners")
albumSaved.setValue(playCount, forKey: "playcount")
albumSaved.setValue(published, forKey: "published")
    
albumSaved.artist = artist
    

 
    do {
        try context.save()
    
    } catch let saveErr {
    print("Failed to save artists", saveErr)

}
    
}


    
    
    
    


    
    
    
    
    
    
    
    
    
    
}
