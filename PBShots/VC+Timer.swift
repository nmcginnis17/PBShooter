//
//  VC+Timer.swift
//  PBShots
//
//  Created by Nicholas McGinnis on 9/19/22.
//

import Foundation
import UIKit

extension ViewController {
     
    func startTimer(_ sender: UIButton) {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if(self.secondsRemaining == 0) {
                timer.invalidate()
                self.bps = (self.shots/self.countDownTime)
                self.statsLabel.text = "\(self.shots) Shots / \(self.bps) BPS"
                self.timeLabel.text = "Guns Down!\nBarrel Bags On!"
                self.timeLabel.numberOfLines = 0
                self.timeLabel.textAlignment = .center
                self.startBtn.setTitle("Restart", for: .normal)
                self.startBtn.isHidden = false
                if self.shots > self.highscore {
                    self.defaults.set(self.shots, forKey: "highScore")
                    self.defaults.set(self.bps, forKey: "highestbps")
                }
                self.updateScore()
            } else {
                self.secondsRemaining -= 1
                self.secondsPassed += 1
                self.timeLabel.text = "\(self.secondsRemaining) Seconds Remaining"
                self.bps = (self.shots/self.secondsPassed)
            }
        }
    }
    
    func restart() {
        self.secondsRemaining = self.countDownTime
        self.shots = 0
        self.bps = 0
        self.timeLabel.text = "\(self.secondsRemaining) Seconds Remaining"
        startTimer(self.startBtn)
    }
    
    func updateScore() {
        highscore = defaults.object(forKey: "highScore") as? Int ?? 0
        highestBPS = defaults.object(forKey: "highestbps") as? Int ?? 0
        self.highscoreLabel.text = "Best Score:\n\(self.highscore) Shots | \(self.highestBPS) BPS"
    }
    
}
