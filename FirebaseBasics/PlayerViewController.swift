//
//  PlayerViewController.swift
//  FirebaseBasics
//
//  Created by Akhil Koothal on 2/27/18.
//  Copyright © 2018 Akhil Koothal. All rights reserved.
//

import UIKit
import AAPlayer

class PlayerViewController: UIViewController,AAPlayerDelegate {

    @IBOutlet weak var player: AAPlayer!
    var video = "https://firebasestorage.googleapis.com/v0/b/basics-245cd.appspot.com/o/users%2Fraja.mp4?alt=media&token=7bfc6101-bca0-4fb2-8db9-47ca9b6b67b8"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("videoURL: ",video)
        player.delegate = self
        player.playVideo(video)
        // Do any additional setup after loading the view.
    }
    @IBAction func backCOntroller(_ sender: Any)
    {
        stopPlay()
        dismiss(animated: true, completion: nil)
    }
    
    func callBackDownloadDidFinish(_ status: playerItemStatus?) {
        
        let status:playerItemStatus = status!
        switch status {
        case .readyToPlay:
            break
        case .failed:
            break
        default:
            break
        }
    }
    
    func startPlay() {
        //optional method
        player.startPlayback()
    }
    
    func stopPlay() {
        //optional method
        player.pausePlayback()
    }
}
