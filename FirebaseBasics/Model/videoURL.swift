//
//  videoURL.swift
//  FirebaseBasics
//
//  Created by Akhil Koothal on 2/26/18.
//  Copyright © 2018 Akhil Koothal. All rights reserved.
//

import Foundation
import Firebase

class videos
{
    
    var videoName:String
    var videoURL:String
    
    let ref: DatabaseReference!
    init (videoName:String,videoUrl:String)
    {
        self.videoName = videoName
        self.videoURL = videoUrl
        ref = Database.database().reference().child("video").childByAutoId()
        
    }
    
//    init(snapshot:DataSnapshot)
//    {
//        ref = snapshot.ref
//        if let value = snapshot.value as? [String:Any] {
//            print(value["videoName"] as! String)
//        }
//    }
//    
    func videoDictionary()->[String:Any]
    {
        return[
            "videoName":videoName,
            "videoURL" : videoURL
        ]
    }
    func save()
    {
       ref.setValue(videoDictionary())
    }
    
    
}
class videoRetrievals
{
    func videoNameRetrieve()->Array<String>
    {
        var text = [String]()
        let refernce = Database.database().reference().child("video")
        DispatchQueue.global(qos: .userInitiated).async {
       
        DispatchQueue.main.async {
    
        
                refernce.observe(.childAdded, with: {(snapshot1) in
                    let values = snapshot1.value as? [String:Any]
                    let videoName = values?["videoName"]!
                    print("videoName : ",videoName)
                    text.append(videoName as! String)
                    print("TEXT: ",text)
                })
        }
        }
        return text
    }
    
}
