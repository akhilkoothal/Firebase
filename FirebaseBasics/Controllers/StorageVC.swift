//
//  StorageVC.swift
//  FirebaseBasics
//
//  Created by Akhil Koothal on 2/23/18.
//  Copyright © 2018 Akhil Koothal. All rights reserved.
//

import UIKit
import MobileCoreServices
import FirebaseAuth
import Firebase
import FirebaseStorage
import SCLAlertView



class StorageVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    var titles = [String]()
    var videoLinks = [String]()
    
    var NavTitle: String?
    var VideoName: String?
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var selectedProgram = ""
    
    override func viewWillAppear(_ animated: Bool) {
        
//        navigationController.navBar.barTintColor = UIColor.flatOrange
        
        videoRetreive()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        print("user ID: ",Auth.auth().currentUser?.email)
        navigationItem.title = NavTitle
        
        
    }

    @IBAction func VideoRecorder(_ sender: Any)
    {
        getUserVideoName()
    }
    
    func videoRetreive()
    {
        titles = []
        videoLinks = []
        print("Vides    : ")
        print(VideoName)
        
        let refernce = Database.database().reference().child("video")
        
                refernce.observe(.childAdded, with: {(snapshot) in
                    let values = snapshot.value as? [String:Any]
                    let videoName = values?["videoName"]!
                    let videoURL = values?["videoURL"]!
                    
                    self.titles.append(videoName as! String)
                    print("videoName : ",self.titles)
                    self.videoLinks.append(videoURL as! String)
                    print("videoURLS: ",self.videoLinks)
                    self.tableView.reloadData()
                    
                })
    }
    
    func getUserVideoName()
    {
        let alert = SCLAlertView()
        
        let txt = alert.addTextField("Enter your name")
            print("Text value: \(txt.text)")
        
        alert.addButton("Submit", action: { // create button on alert
            print("click click") // action on click
            self.VideoName = txt.text
            
            self.ImagePicker()
        })
        
        alert.showInfo("Video Name", subTitle: "Add Video Name",closeButtonTitle: "Cancel")
        
//        self.ImagePicker()
        
        //self.ImagePicker()
//        print("Data: ",titles)
//        let alert = UIAlertController(title: "Enter video name?", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//        alert.addTextField(configurationHandler: { textField in
//            textField.placeholder = "Video name"
//        })
//
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//
//            if let name = alert.textFields?.first?.text {
//                self.VideoName = name
//                print("Your name: \(self.VideoName!)")
//                self.ImagePicker()
//            }
//        }))
//        present(alert, animated: true)
    }
    func ImagePicker()
    {
        if(UIImagePickerController.isSourceTypeAvailable(.camera))
        {
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil
            {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                imagePicker.mediaTypes = [kUTTypeMovie as String,kUTTypeImage as String]
                imagePicker.cameraCaptureMode = .video
                present(imagePicker, animated: true, completion: {})
            }
            else
            {
                print("Rare camera doesn't exist")
            }
        }
        else
        {
            print("Camera inaccessable")
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedVideo:NSURL = (info[UIImagePickerControllerMediaURL] as? NSURL)
        {
//            let storage = Storage.storage().reference().child("users").child("\(VideoName!)")

            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                 
            
                    let ref = Storage.storage().reference().child("users").child("\(self.VideoName!).mp4").putFile(from: pickedVideo as URL, metadata: nil, completion: { (metadata,error) in
                if error != nil
                {
                    print("Failed to upload: ",error as? Any)
                }
                else
                {
                    print("Success!",metadata as? Any)
                    
                    let download = metadata?.downloadURL()?.absoluteString
                    print("Downloaded String: ",download)
                    let video = videos(videoName: self.VideoName!, videoUrl: download!)
                    video.save()
                    
                    self.dismiss(animated: true, completion: nil)
                }
            })
//            let userReference = ref.child("users")
            }
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Dismiss")
        dismiss(animated: true, completion: nil)
    }
    

    @objc func logoutUser()
    {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoDisplay") as! videoTableCell
        cell.videoTitle.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProgram = videoLinks[indexPath.row]
        
       self.performSegue(withIdentifier: "goToPlayerSegue", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPlayerSegue"
        {
            print("video link: ",selectedProgram)
            let destination = segue.destination as? PlayerVC
            destination?.video = selectedProgram
        }
    }

}



class videoTableCell:UITableViewCell
{
    @IBOutlet weak var videoImageDisplay: UIImageView!
    
    @IBOutlet weak var videoTitle: UILabel!
}

