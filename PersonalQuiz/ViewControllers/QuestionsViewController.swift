//
//  ViewController.swift
//  PersonalQuiz
//
//  Created by Winky51 on 26.07.2024.
//

import UIKit

final class QuestionsViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionProgress: UIProgressView!
    
    @IBOutlet weak var singleQuestionStackView: UIStackView!
    @IBOutlet var singleQuestionButtons: [UIButton]!
    
    @IBOutlet var multipleQuestionStackView: UIStackView!
    @IBOutlet var multipleQuestionLabels: [UILabel]!
    @IBOutlet var multipleQuestionSwitches: [UISwitch]!
    
    @IBOutlet var rangedQuestionStackView: UIStackView!
    @IBOutlet var rangedQuestionLabels: [UILabel]!
    @IBOutlet var rangedQuestionSlider: UISlider!
    
    private let questions = Question.getQuestions()
    
    private var questionIndex = 0
    private var answerChosen: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        updateUI()
        let answersCount = Float(questions.count - 1)
        rangedQuestionSlider.maximumValue = answersCount
        rangedQuestionSlider.value = answersCount / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as? ResultViewController
        resultVC?.answerChosen = answerChosen
    }
    
    @IBAction func singleQuestionButtonAction(_ sender: UIButton) {
        guard let buttonIndex = singleQuestionButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        answerChosen.append(currentAnswer)
        
        nextQuestion()
        
    }
    
    @IBAction func multipleQuestionButtonAction() {
        
        for (multipleSwitch, answer) in zip(multipleQuestionSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answerChosen.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedQuestionButtonAction() {
        
        let index = lrintf(rangedQuestionSlider.value)
        answerChosen.append(currentAnswers[index])
        
        nextQuestion()
        
    }
}
//MARK: - Private methods
private extension QuestionsViewController {
    func updateUI() {
        
        let currentQuestion = questions[questionIndex]
        let totalProgress = Float(questions.count) / Float(questionIndex)
        
        for stackView in [singleQuestionStackView, multipleQuestionStackView, rangedQuestionStackView] {
            stackView?.isHidden = true
        }
        
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        questionProgress.setProgress(totalProgress, animated: true)
        questionLabel.text = currentQuestion.title
        
        setQuestion(for: currentQuestion.type)
        
    }
    
    func setQuestion(for questionType: ResponseType) {
        
        switch questionType {
        case .single:
            showSingleQuestion(with: currentAnswers)
        case .multiple:
            showMultipleQuestion(with: currentAnswers)
        case .ranged:
            showRangedQuestion(with: currentAnswers)
        }
        
    }
    
    func showSingleQuestion(with answers: [Answer]) {
        singleQuestionStackView.isHidden.toggle()
        
        for (button, answer) in zip(singleQuestionButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    func showMultipleQuestion(with answers: [Answer]) {
        multipleQuestionStackView.isHidden.toggle()
        
        for (label, answer) in zip(multipleQuestionLabels, answers) {
            label.text = answer.title
        }
    }
    
    func showRangedQuestion(with answers: [Answer]) {
        rangedQuestionStackView.isHidden.toggle()
        
        rangedQuestionLabels.first?.text = answers.first?.title
        rangedQuestionLabels.last?.text = answers.last?.title
        }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}

