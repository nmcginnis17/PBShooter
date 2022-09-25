//
//  ViewController.swift
//  PBShots
//
//  Created by Nicholas McGinnis on 9/19/22.
//

import UIKit

class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    var startBtn: UIButton!
    var challengeBtn: UIButton!
    var settingsBtn: UIButton!
    var shotsLabel: UILabel!
    var statsLabel: UILabel!
    var timeLabel: UILabel!
    var highscoreLabel: UILabel!
    var challengeLabel: UILabel!
    var marker: UIImage!
    
    var countDownTime = 20
    var shots = 0
    var bps = 0
    var highscore = 0
    var highestBPS = 0
    var secondsRemaining = 0
    var secondsPassed = 0
    var challengeMessage = ""
    var url = URL(string: "https://apps.apple.com/us/app/paintball-shots/id6443480452")
    var markers = ["amp", "dsr", "minigs", "pe", "geo"]
    var selectedMarker = ""
    let markerView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if secondsRemaining > 0 && secondsRemaining < countDownTime {
            shots += 1
            statsLabel.text = "\(shots) Shots | \(bps) BPS"
            print(shots)
        }
    }
    
    @objc func play() {
        startBtn.isHidden = true
        restart()
    }
    
    @objc func settingsMenu(_ sender: UIButton) {
        print("tap")
        let settingsVC = Settings()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc func challengeFriend(_ sender: UIButton) {
        guard let message = challengeLabel.text else { return }
        let vc = UIActivityViewController(activityItems: [message], applicationActivities: [])
        present(vc, animated: true)
    }
    
    func setup() {
        secondsRemaining = countDownTime
        highscore = defaults.object(forKey: "highScore") as? Int ?? 0
        highestBPS = defaults.object(forKey: "highestbps") as? Int ?? 0
        selectedMarker = defaults.object(forKey: "myMarker") as? String ?? "minigs"
        navigationController?.isNavigationBarHidden = true
        
        view = UIView()
        
        let bgImage = UIImageView(frame: UIScreen.main.bounds)
        bgImage.image = UIImage(named: "paintball")
        bgImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(bgImage, at: 0)
        
        markerView.translatesAutoresizingMaskIntoConstraints = false
        markerView.image = UIImage(named: "\(selectedMarker)")
        markerView.contentMode = UIView.ContentMode.scaleAspectFit
        view.addSubview(markerView)
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        settingsBtn = UIButton()
        settingsBtn.setImage(UIImage(systemName: "line.3.horizontal", withConfiguration: largeConfig), for: .normal)
        settingsBtn.translatesAutoresizingMaskIntoConstraints = false
        settingsBtn.tintColor = UIColor.white
        settingsBtn.addTarget(self, action: #selector(settingsMenu), for: .touchUpInside)
        view.addSubview(settingsBtn)
        
        statsLabel = UILabel()
        statsLabel.translatesAutoresizingMaskIntoConstraints = false
        statsLabel.font = UIFont(name: "Menlo", size: 32)
        statsLabel.text = "\(shots) Shots | \(bps) BPS"
        statsLabel.textColor = UIColor.white
        view.addSubview(statsLabel)
        
        timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.text = "\(secondsRemaining) Seconds Remaining"
        timeLabel.font = UIFont(name: "Menlo", size: 16)
        timeLabel.textColor = UIColor.white
        view.addSubview(timeLabel)
        
        startBtn = UIButton()
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        startBtn.addTarget(self, action: #selector(play), for: .touchUpInside)
        startBtn.setTitle("Tap To\nStart", for: .normal)
        startBtn.titleLabel?.textAlignment = .center
        startBtn.titleLabel?.numberOfLines = 0
        startBtn.titleLabel?.font = UIFont(name: "Menlo", size: 32)
        startBtn.tintColor = UIColor.white
        view.addSubview(startBtn)
        
        highscoreLabel = UILabel()
        highscoreLabel.translatesAutoresizingMaskIntoConstraints = false
        highscoreLabel.text = "Best Score:\n\(highscore) Shots | \(highestBPS) BPS"
        highscoreLabel.font = UIFont(name: "Menlo", size: 18)
        highscoreLabel.textAlignment = .right
        highscoreLabel.numberOfLines = 0
        highscoreLabel.textColor = UIColor.white
        view.addSubview(highscoreLabel)
        
        challengeBtn = UIButton()
        challengeBtn.translatesAutoresizingMaskIntoConstraints = false
        challengeBtn.setTitle("Challenge\na Friend!", for: .normal)
        challengeBtn.titleLabel?.font = UIFont(name: "Menlo", size: 18)
        challengeBtn.addTarget(self, action: #selector(challengeFriend), for: .touchUpInside)
        challengeBtn.tintColor = UIColor.white
        challengeBtn.titleLabel?.textAlignment = .left
        challengeBtn.titleLabel?.numberOfLines = 0
        view.addSubview(challengeBtn)
        
        challengeLabel = UILabel()
        challengeLabel.translatesAutoresizingMaskIntoConstraints = false
        challengeMessage = "Can you beat my highscore?\n\(highscoreLabel.text!)\n\(url!)"
        challengeLabel.text = challengeMessage
        challengeLabel.isHidden = true
        
        
        NSLayoutConstraint.activate([
            settingsBtn.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            settingsBtn.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 10),
            statsLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 75),
            statsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: statsLabel.bottomAnchor, constant: 10),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            markerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            markerView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0),
            markerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            markerView.widthAnchor.constraint(equalToConstant: 400),
            highscoreLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 5),
            highscoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 5),
            challengeBtn.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 5),
            challengeBtn.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 5)
            
        ])
    }


}

