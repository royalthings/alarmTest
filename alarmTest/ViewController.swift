//
//  ViewController.swift
//  alarmTest
//
//  Created by Дмитрий Ага on 9/20/19.
//  Copyright © 2019 Дмитрий Ага. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

   @IBOutlet weak var picker: UIPickerView!
   @IBOutlet weak var countdownLable: UILabel!
   @IBOutlet weak var startButton: UIButton!

   var secondsRemaining = 39600
   var timer: Timer?
   
   var soundEnable = true
   var audioPlayer: AVAudioPlayer?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //countdownLable.isHidden = true
      
      picker.isHidden = true
      playMusic()

      
   }

   func playMusic() {
      
      let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "play", ofType: "mp3")!)
      try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: .defaultToSpeaker)
      try! AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
      try! audioPlayer = AVAudioPlayer(contentsOf: alertSound)
      audioPlayer?.volume = 0
      audioPlayer?.numberOfLoops = 1000000000000000
      audioPlayer?.prepareToPlay()
      audioPlayer?.play()
   }

   @IBAction func startButtonAction(_ sender: Any) {
      
      startButton.isHidden = true
      picker.isHidden = true
      countdownLable.isHidden = false
      countdownLable.text = String(secondsRemaining)
      
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrementTimer), userInfo: nil, repeats: true)
      
   }
   
   @objc func decrementTimer() {
      secondsRemaining -= 1
      countdownLable.text = String(secondsRemaining)
      if secondsRemaining == 0 {
         timer?.invalidate()
         secondsRemaining = 1
         
         picker.selectRow(0, inComponent: 0, animated: false)
         countdownLable.isHidden = true
         picker.isHidden = false
         startButton.isHidden = false
         audioPlayer?.volume = 1
      }
   }
   
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
   
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return 40000
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return String(row + 1)
   }
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      secondsRemaining = row + 1
      
   }
   
   
}

