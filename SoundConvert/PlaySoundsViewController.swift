//
//  PlaySoundVievControllerViewController.swift
//  SoundConvert
//
//  Created by Anton on 30.11.2017.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit
import AVFoundation
import Social
class PlaySoundsViewController: UIViewController {
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    //@IBOutlet weak var ShareButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    
    func StopAudio(){
        if let audioPlayerNode = audioPlayerNode {
            audioPlayerNode.stop()
        }
        if let stopTimer = stopTimer {
            stopTimer.invalidate()
        }
        configureUI(.notPlaying)
        if let audioEngine = audioEngine {
            audioEngine.stop()
            audioEngine.reset()
        }
    }
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }

    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        StopAudio()
    }
    @IBAction func ShareButtonPressed(_ sender: Any) {
        let activity = UIActivityViewController.init(activityItems: [audioFile], applicationActivities: nil)
        activity.popoverPresentationController?.sourceView = self.view
        self.present(activity,animated: true, completion:nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        snailButton.contentMode = .center
        snailButton.imageView?.contentMode = .scaleAspectFit
        chipmunkButton.contentMode = .center
        chipmunkButton.imageView?.contentMode = .scaleAspectFit
        rabbitButton.contentMode = .center
        rabbitButton.imageView?.contentMode = .scaleAspectFit
        vaderButton.contentMode = .center
        vaderButton.imageView?.contentMode = .scaleAspectFit
        echoButton.contentMode = .center
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.contentMode = .center
        reverbButton.imageView?.contentMode = .scaleAspectFit
        stopButton.contentMode = .center
        stopButton.imageView?.contentMode = .scaleAspectFit
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
        
    }
    
}


