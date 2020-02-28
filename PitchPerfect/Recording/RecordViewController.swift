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
    var audioRecorder : AVAudioRecorder!
    let STOP_SEGUE = "stopRecording"
    private var recording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recordBtn.contentMode = .center
        recordBtn.imageView?.contentMode = .scaleAspectFit
    }
    
    
    
    @IBAction func recordBtnClicked(_ sender: Any) {
        if !recording {
            record()
            recording = true
            if let image = UIImage(named: "Stop") {
                recordBtn.setImage(image, for: [])
            }
        } else {
            stopRecording()
            recording = false
            if let image = UIImage(named: "Record") {
                recordBtn.setImage(image, for: [])
            }
        }
    }
    
    private func record() {
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
    
    private func stopRecording() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: STOP_SEGUE, sender: audioRecorder.url)
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

