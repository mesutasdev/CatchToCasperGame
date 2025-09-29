//
//  ViewController.swift
//  CatchToCasper
//
//  Created by asdirector on 19.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var casperArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var developer: UILabel!
    
  
    @IBOutlet weak var casper1: UIImageView!
    @IBOutlet weak var casper2: UIImageView!
    @IBOutlet weak var casper3: UIImageView!
    @IBOutlet weak var casper4: UIImageView!
    @IBOutlet weak var casper5: UIImageView!
    @IBOutlet weak var casper6: UIImageView!
    @IBOutlet weak var casper7: UIImageView!
    @IBOutlet weak var casper8: UIImageView!
    @IBOutlet weak var casper9: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Puan: \(score)"
        
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil {
            highScore = 0
            highScoreLabel.text = "En Yüksek Puan: \(highScore)"
        }
        
        if let newScore = storedHighscore as? Int {
           highScore = newScore
            highScoreLabel.text = "En Yüksek Puan: \(highScore)"
        }
        
        
        
        // images
        
        casper1.isUserInteractionEnabled = true
        casper2.isUserInteractionEnabled = true
        casper3.isUserInteractionEnabled = true
        casper4.isUserInteractionEnabled = true
        casper5.isUserInteractionEnabled = true
        casper6.isUserInteractionEnabled = true
        casper7.isUserInteractionEnabled = true
        casper8.isUserInteractionEnabled = true
        casper9.isUserInteractionEnabled = true
        
      
        
        scoreLabel.text = "Puan: \(score)"
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector (increaseScore))
        
        casper1.addGestureRecognizer(recognizer1)
        casper2.addGestureRecognizer(recognizer2)
        casper3.addGestureRecognizer(recognizer3)
        casper4.addGestureRecognizer(recognizer4)
        casper5.addGestureRecognizer(recognizer5)
        casper6.addGestureRecognizer(recognizer6)
        casper7.addGestureRecognizer(recognizer7)
        casper8.addGestureRecognizer(recognizer8)
        casper9.addGestureRecognizer(recognizer9)
        
        casperArray = [casper1,casper2,casper3,casper4,casper5,casper6,casper7,casper8,casper9]
      
        // timers
        counter = 20
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideCasper), userInfo: nil, repeats: true)
        
        
        hideCasper()
        
        
    }
 
    
   @objc  func hideCasper (){
        //casper1.isHidden = true
        for casper in casperArray {
            casper.isHidden = true
        }
        
        let random = Int( arc4random_uniform(UInt32(casperArray.count - 1)))
        casperArray[random].isHidden = false
    }
    
@objc func increaseScore( ) {
    score += 1
    scoreLabel.text = "Puan: \(score)"
        
    }
    
    @objc func countDown () {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            for casper in casperArray {
                casper.isHidden = true
            }
            
            //highScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "En Yüksek Puan: \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "highscore")
            }
            
            
            
            // Alert
            let alert = UIAlertController(title: "Zaman doldu!", message: "Tekrar oynamak ister misin?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Kapat", style: UIAlertAction.Style.cancel) { UIAlertAction in
                exit(0)
            }
            
            
            let rePlayButton = UIAlertAction(title: "Tekrar Oyna", style: UIAlertAction.Style.default) { UIAlertAction in
                
                
                // Replay Function
                self.score = 0
                self.scoreLabel.text = "Puan:\(self.score)"
                self.counter = 20
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideCasper), userInfo: nil, repeats: true)
                
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(rePlayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    }
    
}


        
  
