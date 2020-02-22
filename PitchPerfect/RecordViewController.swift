//
//  RecordViewController.swift
//  PitchPerfect
//
//  Created by David Iriarte on 18/02/20.
//  Copyright © 2020 David Iriarte. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    var audioRecorder : AVAudioRecorder!
    let STOP_SEGUE = "stopRecording"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopBtn.isEnabled=false
    }
    
    
    @IBAction func record(_ sender: Any) {
        stopBtn.isEnabled=true
        recordBtn.isEnabled=false
        recordLabel.text = "Recording..."
        

        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        stopBtn.isEnabled=false
              recordBtn.isEnabled=true
              recordLabel.text = "Tap to record"
        
        audioRecorder.stop()
           let audioSession = AVAudioSession.sharedInstance()
           try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
        performSegue(withIdentifier: STOP_SEGUE, sender: audioRecorder.url)
        } else {
            recordLabel.text = "Error recording"
        }
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == STOP_SEGUE {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recorderAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recorderAudioURL
        }
    }

}

