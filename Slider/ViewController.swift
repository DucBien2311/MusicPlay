//
//  ViewController.swift
//  Slider
//
//  Created by NguyenDucBien on 11/25/16.
//  Copyright © 2016 NguyenDucBien. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,  AVAudioPlayerDelegate{
    
    @IBOutlet weak var sld_Volume: UISlider!
    @IBOutlet weak var btn_Play: UIButton!
    
    @IBOutlet weak var lblCurrentTime: UILabel!
    
    @IBOutlet weak var lblTotalTime: UILabel!
    
    
    @IBOutlet weak var sldDuration: UISlider!
    var audio = AVAudioPlayer()
    var count = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        count = true
        audio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: ".mp3")!))
        audio.prepareToPlay()
        addThumbImgForSlider()
        addDuration()
        btn_Play.setImage(UIImage(named: "pause.png"), forState: .Normal)
        audio.delegate = self
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        sldDuration.maximumValue = Float(audio.duration)
        
    }
    //setup
    
    func updateTime() {
        self.lblCurrentTime.text = String(format: "%2.2f", audio.currentTime/60)
        self.sldDuration.value = Float(audio.currentTime)
        self.lblTotalTime.text = String(format: "%2.2f", audio.duration/60)
        
        let minutes = Int(audio.currentTime / 60)
        let seconds = Int(audio.currentTime % 60)
        
        if minutes < 10 && seconds < 10
        {
            lblCurrentTime.text = String(" 0\(minutes):0\(seconds)")
        }
        else if minutes > 10 && seconds < 10
        {
            lblCurrentTime.text = String(" \(minutes):0\(seconds)")
        }
        else if minutes > 10 && seconds > 10
        {
            lblCurrentTime.text = String(" \(minutes):\(seconds)")
        }
        else
        {
            lblCurrentTime.text = String(" 0\(minutes):\(seconds)")
        }
        
        let min = Int(audio.duration / 60)
        let sec = Int(audio.duration % 60)
        if min < 10
        {
            lblTotalTime.text = String("0\(min):\(sec)")
        }
        else
        {
            lblTotalTime.text = String("\(min):\(sec)")
        }
        
        
    }
    
    func addDuration() {
        sldDuration.setThumbImage(UIImage(named: "duration.png"), forState: .Normal)
    }
    
    func addThumbImgForSlider() {
        sld_Volume.setThumbImage(UIImage(named: "thumb.png"), forState: .Normal)
        sld_Volume.setThumbImage(UIImage(named: "thumbHightLight.png"), forState: .Highlighted)
        
    }
    
    @IBAction func action_Play(sender: AnyObject) {
        var play_Btn = sender as! UIButton
        
        if count == true
        {
            audio.play()
            count = false
            play_Btn.setImage(UIImage(named: "play.png"), forState: UIControlState.Normal)
            
        }
        else
        {
            audio.pause()
            count = true
            play_Btn.setImage(UIImage(named: "pause.png"), forState: UIControlState.Normal)
            
        }
    }
    
    @IBAction func sld_Volume(sender: UISlider) {
        audio.volume = sender.value
    }
    
    @IBAction func sld_Duration(sender: UISlider) {
        audio.currentTime = Double(sender.value)
    }
    
    
    @IBAction func action_Switch(sender: UISwitch) {
        
        
        if sender.on{
            audio.numberOfLoops = -1
        }
        else
        {
            audio.numberOfLoops = 0
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        count = true
        btn_Play.setImage(UIImage(named: "pause.png"), forState: .Normal)
        
    }
    
    
    
}

