//
//  ViewController.swift
//  PBShots
//
//  Created by Nicholas McGinnis on 9/19/22.
//

import UIKit

class ViewController: UIViewController {
    
    var startBtn: UIButton!
    var shotsLabel: UILabel!
    var statsLabel: UILabel!
    var timeLabel: UILabel!
    var marker: UIImage!
    
    var shots = 0
    var bps = 0
    var secondsRemaining = 20
    var secondsPassed = 0
    
    
    override func loadView() {
        view = UIView()
        
        let bgImage = UIImageView(frame: UIScreen.main.bounds)
        bgImage.image = UIImage(named: "paintball")
        bgImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(bgImage, at: 0)
        
        statsLabel = UILabel()
        statsLabel.translatesAutoresizingMaskIntoConstraints = false
        statsLabel.font = UIFont.systemFont(ofSize: 32)
        statsLabel.text = "\(shots) Shots | \(bps) BPS"
        view.addSubview(statsLabel)
        
        timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.text = "\(secondsRemaining) Seconds Remaining"
        view.addSubview(timeLabel)
        
        startBtn = UIButton()
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        startBtn.addTarget(self, action: #selector(play), for: .touchUpInside)
        startBtn.setTitle("Start", for: .normal)
        view.addSubview(startBtn)
        
        let markerView = UIImageView()
        markerView.translatesAutoresizingMaskIntoConstraints = false
        markerView.image = UIImage(named: "minigs")
        markerView.contentMode = UIView.ContentMode.scaleAspectFit
        view.addSubview(markerView)
        
        
        NSLayoutConstraint.activate([
            statsLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100),
            statsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: statsLabel.bottomAnchor, constant: 10),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startBtn.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 100),
            startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            markerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            markerView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0),
            markerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            markerView.widthAnchor.constraint(equalToConstant: 400),
            markerView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shots += 1
        statsLabel.text = "\(shots) Shots / \(bps) BPS"
        print(shots)
    }
    
    @objc func play() {
        startBtn.isHidden = true
        restart()
    }


}

