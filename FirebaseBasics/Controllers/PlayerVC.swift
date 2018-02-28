//
//  PlayerVC.swift
//  FirebaseBasics
//
//  Created by Akhil Koothal on 2/28/18.
//  Copyright © 2018 Akhil Koothal. All rights reserved.
//

import UIKit
import AAPlayer


class PlayerVC: UIViewController,AAPlayerDelegate {

    @IBOutlet weak var player: AAPlayer!
    var video:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("video url: ",video)
        player.delegate = self
        player.playVideo(video)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func doneButtonPressed(_ sender: Any)
    {
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
