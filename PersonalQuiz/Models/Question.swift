//
//  Question.swift

//  PersonalQuiz
//
//  Created by Winky51 on 26.07.2024.
//

struct Question {
    let title: String
    let type: ResponseType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] {
        [
            Question(
                title: "Какую пищу вы предпочитаете?",
                type: .single,
                answers: [
                    Answer(title: "Рыба", animal: .cat),
                    Answer(title: "Стейк", animal: .dog),
                    Answer(title: "Морковь", animal: .rabbit),
                    Answer(title: "Кукуруза", animal: .turtle)
                ]
            ),
            
            Question(
                title: "Что вам нравится больше?",
                type: .multiple,
                answers: [
                    Answer(title: "Бегать", animal: .dog),
                    Answer(title: "Прыгать", animal: .rabbit),
                    Answer(title: "Спать", animal: .cat),
                    Answer(title: "Плавать", animal: .turtle),
                ]
            ),
            
            Question(
                title: "Любите ли вы паоездки на машине?",
                type: .ranged,
                answers: [
                    Answer(title: "Ненавижу", animal: .turtle),
                    Answer(title: "Не люблю", animal: .cat),
                    Answer(title: "Люблю", animal: .dog),
                    Answer(title: "Обожаю", animal: .rabbit)
                ]
            )
        ]
    }
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

struct Answer {
    let title: String
    let animal: Animal
}

enum Animal: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    case undefinedAnimal = "❓"
    
    var definition: String {
        switch self {
        case .dog:
            "Вам нравится быть с друзьями.Вы окружаете себя людьми, которые вам нравятся и всегда готовы помочь."
        case .cat:
            "Вы себе на уме. Любите гулять сами по себе. Вы цените одиночество."
        case .rabbit:
            "Вам нравится все мягкое. Вы здоровы и полны энергии."
        case .turtle:
            "Ваша сила - в мудрости. Медленный и вдумчивый выигрывает на больших дистанциях."
        case .undefinedAnimal:
            "К сожалению нам не удалось определить ваш тип животного."
        }
        
    }
    
    var animalIcon: String {
        switch self {
        case .dog:
            "dog"
        case .cat:
            "cat"
        case .rabbit:
            "rabbit"
        case .turtle:
            "turtle"
        case .undefinedAnimal:
            "undefined"
        }
    }
}
