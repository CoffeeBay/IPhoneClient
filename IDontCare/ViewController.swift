//
//  ViewController.swift
//  IDontCare
//
//  Created by 이동규 on 2016. 11. 20..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    var musics: [MPMediaItem] = []
    
    @IBOutlet weak var IPTextView: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkPermission()
    }
    
    
    func checkPermission() {
        let status = MPMediaLibrary.authorizationStatus()
        
        switch status {
        case .notDetermined:
            MPMediaLibrary.requestAuthorization({ (newStatus) in
                dump(newStatus)
                if newStatus == .authorized {
                    self.initTableView()
                }
            })
            
        case .authorized:
            initTableView()
            
        default:
            print("default")
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTableView() {
        print("initTableView")
        let allOfMusics = MPMediaQuery.songs().items!
        for item in allOfMusics {
            if let title = item.title {
                if title == "Ne-Yo - So Sick" {
                    musics.append(item)
                }
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = musics[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let baseURL = IPTextView.text {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MusicPlayViewController") as? MusicPlayViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.baseURL = baseURL
            vc?.musics = self.musics
            vc?.nowPlayingMusicSequence = indexPath.row
        }
    }
}
