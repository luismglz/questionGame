//
//  LevelSelectionViewController.swift
//  testQuestionsGame
//
//  Created by Luis GL on 14/05/22.
//

import UIKit

class LevelSelectionViewController: UIViewController {

    var lifesMaxPerLevelSelected = Int()
    var scoreMaxPerLevelSelected = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  
   
    
    
    @IBAction func onSelectDifficulty(_ sender: UIButton) {
        let title = sender.currentTitle!
        
        switch (title){
        case "Easy":
            lifesMaxPerLevelSelected = 3
            scoreMaxPerLevelSelected = 5
            performSegue(withIdentifier: "difficultyToQuizGameSegue", sender: nil)
        case "Medium":
            lifesMaxPerLevelSelected = 2
            scoreMaxPerLevelSelected = 7
            performSegue(withIdentifier: "difficultyToQuizGameSegue", sender: nil)
        case "Hard":
            lifesMaxPerLevelSelected = 1
            scoreMaxPerLevelSelected = 10
            performSegue(withIdentifier: "difficultyToQuizGameSegue", sender: nil)
        default: break
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "difficultyToQuizGameSegue"{
            let data = segue.destination as! QuizViewController
            data.scoreMaxPerLevel = scoreMaxPerLevelSelected
            data.lifesMaxPerLevel = lifesMaxPerLevelSelected
        }
        
    }
    

}
