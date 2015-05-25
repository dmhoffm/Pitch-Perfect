//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by David Hoffman on 5/16/15.
//  Copyright (c) 2015 JohnMuirHealth. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    //
    // outlets to control display of labels and buttons
    @IBOutlet weak var tapToRecord: UILabel!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        stopButton.hidden = true
        tapToRecord.hidden = false
        recordingInProgress.hidden = true
        println("will appear")
    }

    //
    // button actions
    
    // record audio button, record the user's voice
    @IBAction func recordAudio(sender: UIButton) {
        
        // set up buttons
        recordingInProgress.hidden = false
        tapToRecord.hidden = true
        stopButton.hidden = false
        recordButton.enabled = false
        
        // construct path for recording:
        // directory/timestamp.wav
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println("recording to \(filePath) in progress")
        
        //
        // set up and start recording
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.meteringEnabled = true
        audioRecorder.delegate = self  // make me a delegate to receive end of recording callback
        audioRecorder.prepareToRecord()
        audioRecorder.record()
      }

    //
    // stop recording button
    @IBAction func stopRecordAudio(sender: UIButton) {
        recordingInProgress.hidden = true;
        tapToRecord.hidden = false
        stopButton.hidden = true
        recordButton.enabled = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    //
    // delegate and framework callbacks
    
    //  audio recording finished
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag {
            recordedAudio = RecordedAudio(fromFilePathUrl: recorder.url, fromTitle: recorder.url.lastPathComponent)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            println("recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    // about to segue to playback screen
    // send over recorded audio object for playback
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            playSoundsVC.recordedAudio = sender as! RecordedAudio
        }
    }
 }

