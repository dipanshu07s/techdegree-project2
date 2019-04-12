//
//  Trivia.swift
//  EnhanceQuizStarter
//
//  Created by Dipanshu Sehrawat on 12/04/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

struct Trivia {
    let questions: [Question] = [
        Question(question: "This was the only US President to serve more than two consecutive terms", options: ["Franklin D. Rooservolt", "Woodrow Wilson", "Andrew Jackson"], answer: "Franklin D. Rooservolt"),
        Question(question: "Which of the following countries has the most residents?", options: ["Nigeria", "Russia", "Iran", "Vietnam"], answer: "Nigeria"),
        Question(question: "In what year was the United Nation founded", options: ["1918", "1919", "1945", "1954"], answer: "1945"),
        Question(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive", options: ["Paris", "Washington D.C.", "New York City", "Boston"], answer: "New York City"),
        Question(question: "Which nation produces the most oil?", options: ["Iraq", "Brazil", "Canada"], answer: "Canada"),
        Question(question: "Which country has most recently won consecutive World Cups in Soccer?", options: ["Brazil", "Argetina", "Spain"], answer: "Brazil"),
        Question(question: "Which of the following rivers is longest?", options: ["Yangtze", "Mississippi", "Congo"], answer: "Mississippi"),
        Question(question: "Which city is the oldest?", options: ["Mexico City", "Cape Town", "San Juan", "Sydney"], answer: "Mexico City"),
        Question(question: "Which country was the first to allow women to vote in national elections", options: ["Poland", "United States", "Sweden", "Senegal"], answer: "Poland"),
        Question(question: "Which of these countries won the most medals in the 2012 Summer Games", options: ["Germany", "Japan", "Great Britian"], answer: "Great Britian")
    ]
    
    var askedQuestions = [Int]()
    
    mutating func randomQuestion() -> Question {
        var randomNumber = 0
        repeat {
            randomNumber = Int.random(in: 0..<questions.count)
        } while askedQuestions.contains(randomNumber)
        askedQuestions.append(randomNumber)
        return questions[randomNumber]
    }
}


























