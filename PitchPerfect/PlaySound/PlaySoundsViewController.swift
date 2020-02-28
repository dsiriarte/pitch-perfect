//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by David Iriarte on 19/02/20.
//  Copyright © 2020 David Iriarte. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    

    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highButton: UIButton!
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL : URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode:AVAudioPlayerNode!
    var stopTimer: Timer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
        stopButton.contentMode = .center
        stopButton.imageView?.contentMode = .scaleAspectFit
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        print("a")
    }
    

   // MARK: Actions

    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch sender {
        case slowButton:
            playSound(rate : 0.5)
        case fastButton :
            playSound(rate : 1.5)
        case highButton:
            playSound(pitch : 1000)
        case lowButton :
            playSound(pitch : -1000)
        case echoButton :
            playSound(echo : true)
        case reverbButton :
            playSound(reverb : true)
            print("reverb")
        default:
            break
        }
        configureUI(.playing)
    }

    @IBAction func stopButtonPressed(_ sender: AnyObject) {
       stopAudio()
    }

}
