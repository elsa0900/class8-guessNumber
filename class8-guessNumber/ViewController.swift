//
//  ViewController.swift
//  class8-guessNumber
//
//  Created by 劉美君 on 2024/4/27.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputBgImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var warnTextLabel: UILabel!
    @IBOutlet weak var gameRoundLabel: UILabel!
    
    @IBOutlet weak var rangeContentView: UIStackView!
    @IBOutlet weak var rangeNumberSwitch: UISwitch!
    @IBOutlet weak var rangeTitleLabel: UILabel!
    @IBOutlet weak var minRangeTextField: UITextField!
    @IBOutlet weak var maxRangeTextField: UITextField!
    @IBOutlet weak var rangeConfirmBtn: UIButton!
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var replayBtn: UIButton!
    
    var minNumberWord = 1
    var maxNumberWord = 100
    var answer: Int = 0
    var gameRoundCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answer = Int.random(in: minNumberWord...maxNumberWord)
        // Do any additional setup after loading the view.
        replayBtn.isHidden = true
        gameRoundLabel.text = "Round \(gameRoundCount)"
        toggleSettingRange(false)
    }
//    開啟設定 範圍
    
    @IBAction func settingRange(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.3) {
            self.toggleSettingRange(sender.isOn)
        }
    }
    @IBAction func confirmRange(_ sender: Any) {
        maxNumberWord = Int(maxRangeTextField.text!) ?? 100
        minNumberWord = Int(minRangeTextField.text!) ?? 0
        answer = Int.random(in: minNumberWord ... maxNumberWord)
        
        resetGame()
        toggleSettingRange(false)
    }
    
    @IBAction func submitResult(_ sender: UIButton) {
        let inputAnswer = Int(inputTextField.text!) ?? 0
//        print(answer)s
        if inputAnswer == 0 || inputAnswer < minNumberWord || inputAnswer > maxNumberWord {
            warnTextLabel.text = "請注意填寫的值！"
        }else if inputAnswer < answer {
            minNumberWord = inputAnswer
            gameRoundCount += 1
            resultLabel.text = "數字範圍：\(inputAnswer) ~ \(maxNumberWord)"
        }else if inputAnswer > answer {
            gameRoundCount += 1
            maxNumberWord = inputAnswer
            resultLabel.text = "數字範圍：\(minNumberWord) ~ \(maxNumberWord)"
        }else {
            endTheGame(true)
        }
        gameRoundLabel.text = "Round \(gameRoundCount)"
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        inputTextField.text = ""
        resetGame()
        endTheGame(false)
    }
    
    fileprivate func endTheGame(_ isOn: Bool) {
        if isOn == true {
            inputBgImageView.image = UIImage(named: "boom")
            UIView.animate(withDuration: 0.3) {
                self.inputBgImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            }
        }else{
            inputBgImageView.image = UIImage(named: "bomb")
            UIView.animate(withDuration: 0.3) {
                self.inputBgImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
        submitBtn.isHidden = isOn
        inputTextField.isHidden = isOn
        replayBtn.isHidden = !isOn
    }
    
   
    func toggleSettingRange(_ isOn: Bool) {
        rangeNumberSwitch.isOn = isOn
        rangeContentView.isHidden = !isOn
        rangeTitleLabel.isHidden = !isOn
    }
    
    func resetGame(){
        gameRoundCount = 0
        resultLabel.text = ""
        maxRangeTextField.text = ""
        minRangeTextField.text = ""
        gameRoundLabel.text = "Round \(gameRoundCount)"
    }
    
}

