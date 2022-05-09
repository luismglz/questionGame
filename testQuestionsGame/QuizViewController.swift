//
//  ViewController.swift
//  testQuestionsGame
//
//  Created by ISSC_612_2022 on 03/05/22.
// 3 vidas por cada jugador
// para ganar el jugador debe tener un score de 5


import UIKit
import GameKit

class ViewController: UIViewController {
    
    var totalLifesPLayer1 = 3{
        didSet {
            imgLifeSpanPlayer1.image = UIImage(named: "lifes\(totalLifesPLayer1)")
        }
    }
    
    var totalLifesPLayer2 = 3{
        didSet {
            imgLifeSpanPlayer2.image = UIImage(named: "lifes\(totalLifesPLayer2)")
        }
    }
    
    
    @IBOutlet weak var player1Label: UILabel!
    
    @IBOutlet weak var player2Label: UILabel!
    
    @IBOutlet weak var imgLifeSpanPlayer1: UIImageView!
    
    @IBOutlet weak var imgLifeSpanPlayer2: UIImageView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var btnIsTrue: UIButton!
    
    @IBOutlet weak var btnIsFalse: UIButton!
    
    @IBOutlet weak var questionRelatedImage: UIImageView!
    
    var currentAnswer = ""
    
    var currentQuestion : String = ""
    
    var userAnswer = ""
    
    var score = 0
    
    var generatedQuestion = ""
    
    var answerOfGeneratedQuestion = ""
    
    var selectedAnswer = ""
    
    @IBOutlet weak var btnPlay: UIButton!
    
    var url = URL(string: "")
    
    var previouslyUsedQuestionsPlayer1: [Int] = []
    
    var previouslyUsedQuestionsPlayer2: [Int] = []
    
    var currentPlayerFlag = 0
    
    //var isPlayer1 = true
    
    let quiz = [
        ["Coca-Cola was the first soft drink in the space", "True", "https://tentulogo.com/wp-content/uploads/2017/06/cocacola-logo.jpg"],
        ["Little Boy is the nicknamed of bomb that was dropped on Hiroshima?", "True", "https://www.atomicarchive.com/media/photographs/hiroshima/media/atomic-bomb-dome.jpg"],
        ["Its swift from apple?", "True", "https://blog.desafiolatam.com/wp-content/uploads/2018/05/swift-logo.png"],
        ["Hong Kong belongs United Kingdom", "False", "https://upload.wikimedia.org/wikipedia/commons/2/27/HK_Portland_Street_Night.jpg"],
        ["The longest river in the world is the Amazon River", "False","https://media.newstrack.in/uploads/lifestyle-health/travel-news/Jun/07/big_thumb/00_60bdc1dd6b7c2.jpg"],
        ["The moon is wider than Australia", "False", "https://spaceplace.nasa.gov/review/all-about-the-moon/the-moon-near-side.en.jpg"],
        ["In Scotland, the unicorn is their national animal", "True", "https://i2-prod.dailyrecord.co.uk/scotland-now/article23884687.ece/ALTERNATES/s1200b/0_JS142181323-1.jpg"],
        ["Nepal is the only country in the world without a rectangular flag.", "True", "https://img.jakpost.net/c/2019/09/03/2019_09_03_78912_1567484272._large.jpg"],
        ["The Philippines is an archipelagic country that has the most number of islands.", "False","https://www.state.gov/wp-content/uploads/2019/04/Philippines-2196x1406.jpg"],
        ["An acute angle is less than 90 degrees", "True","https://res.cloudinary.com/dk-find-out/image/upload/q_70,c_pad,w_1200,h_630,f_auto/Reflex_angle_xnxe7b.jpg"],
        ["Dubai is home to the tallest man-made structure ever built", "True","https://assets.hotelplan.com/content/TH/00/092/526/hotel/de/leadimage/317067.jpg"],
        ["The bear has caused more human deaths than any other mammal in history.", "False","https://upload.wikimedia.org/wikipedia/commons/thumb/7/71/2010-kodiak-bear-1.jpg/1200px-2010-kodiak-bear-1.jpg"],
        ["The Great Wall of China is visible from space", "False", "https://res.klook.com/images/fl_lossy.progressive,q_65/c_fill,w_1295,h_864/w_80,x_15,y_15,g_south_west,l_Klook_water_br_trans_yhcmh3/activities/phu1gln7aa5gdoftdya2/BadalingGreatWallinBeijingPrivateTransfer.jpg"],
        ["The national flag of EE.UU has 51 stars", "True","https://www.napi.hu/fototar/fototar/202202/orig/image1644933429.jpg/800/?v=2022030101"],
        ["Pneumonia is an infection that affects lungs", "True", "https://post.healthline.com/wp-content/uploads/2020/08/732x549_THUMBNAIL_Double_Pneumonia-1-732x549.jpg"],
        ["The human body consists of 150 bones", "False", "https://static.independent.co.uk/s3fs-public/thumbnails/image/2019/04/16/11/human-skeleton-1517257035kd4.jpg?width=1200"],
        ["Mt. Everest is the highest mountain in the world", "True", "https://static.independent.co.uk/2022/02/09/12/newFile-3.jpg?width=1200"],
        ["Yokohama is the second most populous city in Japan", "True", "https://www.kayak.com.mx/rimg/himg/2e/4f/94/hotelsdotcom-535589-4a8033b0_w-338890.jpg?width=1366&height=768&crop=true"],
        ["World War II started in 1945", "False", "https://s26162.pcdn.co/wp-content/uploads/2019/12/france-wwii.jpg"],
        ["The national game of India is Cricket.", "True", "https://d1e00ek4ebabms.cloudfront.net/production/f1f68b21-fc38-482f-bf14-46b41f44ca04.jpg"],
        ["The national game of the USA is Baseball", "True", "https://images.teamusa.org/-/media/TeamUSA/Baseball/Misc/Frazier_todd_080521_1440x810.png"],
        ["The Eiffel tower is located in Paris", "True", "https://ychef.files.bbci.co.uk/976x549/p02pp8ss.jpg"],
        ["The Titanic sank in 1912", "True", "https://nypost.com/wp-content/uploads/sites/2/2017/01/170103-titanic-ship-feature.jpg?quality=75&strip=all"]
    ]
    
    let choises = ["True", "False"]
    
    
    
    @IBAction func onPlay(_ sender: Any) {
        btnPlay.isHidden = true
        displayElements();
        displayQuestion()
        
    }
    
    
    func generateQuestion() -> Int{
        
        
        if (previouslyUsedQuestionsPlayer1.count == quiz.count) {
            previouslyUsedQuestionsPlayer1 = []
        }
        
        //check used questions
        var randomIndexOfQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: quiz.count)
        
        while (previouslyUsedQuestionsPlayer1.contains(randomIndexOfQuestion)) {
            randomIndexOfQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: quiz.count)
        }
        previouslyUsedQuestionsPlayer1.append(randomIndexOfQuestion)
        
        return randomIndexOfQuestion
        
    }
    
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        let selectedAnswer = sender.currentTitle!
        
        if (validateAnswer(to: selectedAnswer, correctAnswer: answerOfGeneratedQuestion)) {
            score += 1
            print("nice!")
            print("\(score)")
        } else {
            print("Fail")
            totalLifesPLayer1 -= 1
            totalLifesPLayer2 -= 1
        }
        
        
        displayQuestion()
    }
    
    
    func displayQuestion(){
        validateUser()
        currentPlayerFlag += 1
        
        
        let randomIndex = generateQuestion()
        currentQuestion = quiz[randomIndex][0]
        answerOfGeneratedQuestion = quiz[randomIndex][1]
        
        url = URL(string: quiz[randomIndex][2])!
        let data = try? Data(contentsOf: url!)
        questionRelatedImage.image = UIImage(data: data!)
        
        questionLabel.text = currentQuestion
        
    }
    
    func isPlayer2()-> Bool{
        currentPlayerFlag % 2 == 0 ? false : true
    }
    
    func validateUser(){
        if(isPlayer2()){
            player1Label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            player2Label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        }else{
            player2Label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            player1Label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        }
    }
    
    
    
    func validateAnswer(to selectedAnswer: String, correctAnswer: String)->Bool{
        return(selectedAnswer == correctAnswer);
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideElements()
    }
    
    
    func hideElements(){
        btnIsTrue.isHidden = true
        btnIsFalse.isHidden = true
        questionLabel.isHidden = true
        questionRelatedImage.isHidden = true
    }
    
    func displayElements(){
        btnIsTrue.isHidden = false
        btnIsFalse.isHidden = false
        questionLabel.isHidden = false
        questionRelatedImage.isHidden = false
    }
    
    
    
    func displayAlertMessage(title: String, alertDescription: String){
        let alert = UIAlertController(title: title, message: alertDescription, preferredStyle: UIAlertController.Style.alert);
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
}

