//
//  ViewController.swift
//  deneme
//
//  Created by erhan demirci on 11.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        CoreDataManager.shared.saveAlbumInfo(artistName: "erhan", movieName: "album", image: "image", listeners: "listeners", playCount: "playCount", published: "playCount")
       print(CoreDataManager.shared.fetchArtists())

    }
   
    


    


}
