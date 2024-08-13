//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Winky51 on 26.07.2024.
//

import UIKit

final class ResultViewController: UIViewController {

    @IBOutlet var resultImageView: UIImageView!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var resultDescriptionLabel: UILabel!
    
    var answerChosen: [Answer] = []
    private var sortedAnswers: [Animal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        resultImageView.layer.cornerRadius = 25
        
        sortingAnswers(answerChosen)
        

        // Do any additional setup after loading the view.
    }
    @IBAction func doneAction() {
        dismiss(animated: true)
    }
}

private extension ResultViewController {
    func sortingAnswers(_ answers: [Answer]) {
        var dogTypeCount = 0
        var catTypeCount = 0
        var rabbitTypeCount = 0
        var turtleTypeCount = 0
        
        for answer in answers {
            switch answer.animal {
            case .dog:
                dogTypeCount += 1
            case .cat:
                catTypeCount += 1
            case .rabbit:
                rabbitTypeCount += 1
            case .turtle:
                turtleTypeCount += 1
            case .undefinedAnimal:
                break
            }
        }
        
        if dogTypeCount < catTypeCount || dogTypeCount < turtleTypeCount || dogTypeCount < rabbitTypeCount {
            dogTypeCount = 0
        } else {
            sortedAnswers.append(.dog)
        }
        
        if catTypeCount < dogTypeCount || catTypeCount < rabbitTypeCount || catTypeCount < turtleTypeCount {
            catTypeCount = 0
        } else {
            sortedAnswers.append(.cat)
        }
        
        if rabbitTypeCount < dogTypeCount || rabbitTypeCount < catTypeCount || rabbitTypeCount < turtleTypeCount {
            rabbitTypeCount = 0
        } else {
            sortedAnswers.append(.rabbit)
        }
        
        if turtleTypeCount < dogTypeCount || turtleTypeCount < catTypeCount || turtleTypeCount < rabbitTypeCount {
            turtleTypeCount = 0
        } else {
            sortedAnswers.append(.turtle)
        }
        
        showResult()
    }
    
    func showResult() {
        if sortedAnswers.count > 1 {
            resultImageView.image = UIImage(named: Animal.undefinedAnimal.animalIcon)
            resultLabel.text = "Вы \(Animal.undefinedAnimal.rawValue)"
            resultDescriptionLabel.text = Animal.undefinedAnimal.definition
        } else {
            sortedAnswers.forEach { animal in
                resultImageView.image = UIImage(named: animal.animalIcon)
                resultLabel.text = "Вы \(animal.rawValue)"
                resultDescriptionLabel.text = animal.definition
            }
            
        }
        
    }
}
