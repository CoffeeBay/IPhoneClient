//
//  MusicPlayViewController.swift
//  IDontCare
//
//  Created by 이동규 on 2016. 11. 20..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import MediaPlayer
import Alamofire

class MusicPlayViewController: UIViewController {

    var musics: [MPMediaItem] = []
    var nowPlayingMusicSequence = 0
    var baseURL: String!
    var isPlaying = true
    var musicPlayer = MPMusicPlayerController()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playStopBtn: UIButton!
    
    @IBAction func musicPlayStopPressed(_ sender: UIButton) {
        if isPlaying {
            musicPlayer.stop()
            self.playStopBtn.setBackgroundImage(UIImage(named: "ic_play_arrow"), for: .normal)
        } else {
            musicPlayer.play()
            self.playStopBtn.setBackgroundImage(UIImage(named: "ic_stop"), for: .normal)
        }
        
        isPlaying = !isPlaying
    }
    
    @IBAction func playNextMusicPressed(_ sender: UIButton) {
        nowPlayingMusicSequence += 1
        if nowPlayingMusicSequence == musics.count {
            nowPlayingMusicSequence = 0
            musicPlayer.nowPlayingItem = musics[nowPlayingMusicSequence]
            musicPlayer.play()
        } else {
            musicPlayer.skipToNextItem()
        }
        setMusic()
    }
    
    @IBAction func playPrevMusicPressed(_ sender: UIButton) {
        nowPlayingMusicSequence -= 1
        if nowPlayingMusicSequence == -1 {
            nowPlayingMusicSequence = musics.count - 1
            musicPlayer.nowPlayingItem = musics[nowPlayingMusicSequence]
            musicPlayer.play()
        } else {
            musicPlayer.skipToPreviousItem()
        }
        setMusic()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        musicPlayer.setQueue(with: MPMediaItemCollection(items: musics))
        musicPlayer.nowPlayingItem = musics[nowPlayingMusicSequence]
        musicPlayer.play()
        musicPlayer.repeatMode = .all
        setMusic()
    }
    
    func setMusic() {
        if let title = musicPlayer.nowPlayingItem?.title {
            if title == "Ne-Yo - So Sick" {
                self.imageView.image = UIImage(named: "neyo-so sick")
                self.titleLabel.text = title
            }
        }
    }
}
