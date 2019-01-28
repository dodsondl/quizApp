//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber = 0
    var score = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       nextQuestion()
        
       
        
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }
        if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber = questionNumber+1
        
        nextQuestion()
        
    }
    
    
    func updateUI() {
        progressLabel.text = "\(questionNumber+1)/13"
        scoreLabel.text = "Score: \(score)"
        
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber+1)
       
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
            let nextQuestion = allQuestions.list[questionNumber]
            questionLabel.text = nextQuestion.questionText
            updateUI()
         
        }
        else {
            let alert = UIAlertController(title: "End of Quiz", message: "Press OK to resart", preferredStyle: .alert)
            let resartAction = UIAlertAction(title: "OK", style: .default, handler: {
                (UIAlertAction) in
                self.startOver()
            })
            alert.addAction(resartAction)
            present(alert, animated: true, completion: nil)
        }
      
    }
    
    
    func checkAnswer() {
     
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("Correct")
            score += 1
        }
        else {
            ProgressHUD.showError("Incorrect")
        }
        
    }
    
    
    func startOver() {
        
      
        
        questionNumber = 0
        score = 0
        
       nextQuestion()
       
    }
    

    
}
