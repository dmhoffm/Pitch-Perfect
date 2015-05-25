//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by David Hoffman on 5/24/15.
//  Copyright (c) 2015 JohnMuirHealth. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var recordedAudio: RecordedAudio!
    
    // Outlet to control display of stop play button
    @IBOutlet weak var stopButton: UIButton!
    
    //
    // on load, initalize audio, hide stop playback button
    override func viewDidLoad() {
        super.viewDidLoad()
        if var filePathURL = recordedAudio.filePathUrl {
            var error = NSErrorPointer()
            audioPlayer = AVAudioPlayer(contentsOfURL: filePathURL, error: error)
            audioPlayer.enableRate = true
            
            audioEngine = AVAudioEngine()
            audioFile = AVAudioFile(forReading: filePathURL, error: error)
            
        } else {
            println("the file path is empty")
        }
        

        // Do any additional setup after loading the view.
        stopButton.hidden = true
    }

    
    //
    // play button actions
    @IBAction func PlaySoundsSlowly(sender: UIButton) {
        println("print slowly snail")
        play(0.5)
    }
    
    @IBAction func PlaySoundsQuickly(sender: UIButton) {
        println("print quickly rabbit")
        play(1.5)
    }
    
    @IBAction func PlaySoundsChipmunk(sender: UIButton) {
        println("print chipmunk sound")
        playAudioWithVariablePitch(1000.0)
    }
    
    @IBAction func PlaySoundsDarth(sender: UIButton) {
        println("print darth vader sound")
        playAudioWithVariablePitch(-1000.0)
    }
    
    // stop playback button
    @IBAction func StopPlayBack(sender: UIButton) {
        stopAudio()
        stopButton.hidden = true
    }
    
    //
    // play audio at a given rate
    private func play(rate: Float) {
        stopAudio()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        stopButton.hidden = false
    }
    
    //
    // play audio at a given pitch
    private func playAudioWithVariablePitch(pitch: Float) {
        stopAudio()
        var pitchPlayer = AVAudioPlayerNode()
        audioEngine.attachNode(pitchPlayer)
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        audioEngine.attachNode(timePitch)
        audioEngine.connect(pitchPlayer, to: timePitch, format: nil)
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: nil)
        pitchPlayer.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        pitchPlayer.play()
        
        stopButton.hidden = false
    }
    
    //
    // stop audio playback
    private func stopAudio(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
