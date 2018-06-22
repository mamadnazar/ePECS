//
//  DataManager.swift
//  ePECS
//
//  Created by ITLabAdmin on 5/22/18.
//  Copyright © 2018 neobis. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    
    class var shared: DataManager {
        struct Static {
            static let instance = DataManager()
        }
        return Static.instance
    }
    
    // Not yet in category
    var card_ball = Card(index: 9, name: "мяч", image: #imageLiteral(resourceName: "мяч"))
    var card_pc = Card(index: 10, name: "компьютер", image: #imageLiteral(resourceName: "компьютер"))
    var card_tv = Card(index: 11, name: "телевизор", image: #imageLiteral(resourceName: "телевизор"))
    var card_swing = Card(index: 12, name: "качели", image: #imageLiteral(resourceName: "качели"))
    var card_slide = Card(index: 13, name: "горка", image: #imageLiteral(resourceName: "горка"))
    // Family category cards
    var card_meGirl = Card(index: 100, name: "я", image: #imageLiteral(resourceName: "meGirl"))
    var card_meGirl2 = Card(index: 101, name: "я", image: #imageLiteral(resourceName: "meGirl2"))
    var card_meBoy = Card(index: 102, name: "я", image: #imageLiteral(resourceName: "meBoy"))
    var card_mother = Card(index: 103, name: "мама", image: #imageLiteral(resourceName: "mother"))
    var card_father = Card(index: 104, name: "папа", image: #imageLiteral(resourceName: "man"))
    var card_father2 = Card(index: 105, name: "папа", image: #imageLiteral(resourceName: "man_2"))
    var card_grandfather = Card(index: 106, name: "дедушка", image: #imageLiteral(resourceName: "grandfather"))
    var card_grandmother = Card(index: 107, name: "бабушка", image: #imageLiteral(resourceName: "grandmother"))
    var card_baby = Card(index: 108, name: "ребенок", image: #imageLiteral(resourceName: "baby"))
    var card_twins = Card(index: 109, name: "близнецы", image: #imageLiteral(resourceName: "twins"))
    var card_family = Card(index: 110, name: "семья", image: #imageLiteral(resourceName: "family"))
    // Everyday_words category cards
    var card_want = Card(index: 200, name: "хочу", image: #imageLiteral(resourceName: "хочу"))
    var card_yes = Card(index: 201, name: "да", image: #imageLiteral(resourceName: "да"))
    var card_no = Card(index: 202, name: "нет", image: #imageLiteral(resourceName: "нет"))
    var card_eat = Card(index: 204, name: "кушать", image: #imageLiteral(resourceName: "кушать"))
    var card_drink = Card(index: 205, name: "пить", image: #imageLiteral(resourceName: "пить"))
    var card_help = Card(index: 206, name: "помоги", image: #imageLiteral(resourceName: "помоги"))
    var card_forAWalk = Card(index: 207, name: "гулять", image: #imageLiteral(resourceName: "гулять"))
    var card_sleep = Card(index: 208, name: "спать", image: #imageLiteral(resourceName: "спать"))
    // Emotions Category
    var card_laughing = Card(index: 300, name: "смешно", image: #imageLiteral(resourceName: "laughing"))
    var card_sad = Card(index: 301, name: "печально", image: #imageLiteral(resourceName: "sad"))
    var card_sad2 = Card(index: 302, name: "печально", image: #imageLiteral(resourceName: "sad-2"))
    var card_inLove = Card(index: 303, name: "нравиться", image: #imageLiteral(resourceName: "in-love"))
    var card_sceptic = Card(index: 304, name: "сомнительно", image: #imageLiteral(resourceName: "sceptic"))
    var card_smile = Card(index: 305, name: "улыбка", image: #imageLiteral(resourceName: "smile"))
    var card_thinking = Card(index: 306, name: "думаю", image: #imageLiteral(resourceName: "thinking"))
    
    var categories: [String: Array<Card>]?
    var basicCards: Array<Card>?
    
    init() {
        categories = [
            "Семья": [card_meGirl, card_meGirl2, card_meBoy, card_mother,      card_father, card_father2, card_grandfather, card_grandmother, card_baby, card_twins, card_family],
            "Ежедневные слова": [card_yes, card_no, card_want, card_eat, card_drink, card_help, card_forAWalk, card_sleep, ],
            "Эмоции": [card_laughing, card_sad, card_sad2, card_inLove, card_sceptic, card_smile, card_thinking]
        ]
        basicCards = [card_meGirl, card_want, card_yes, card_no, card_father, card_mother, card_eat, card_drink, card_help, card_sleep]
    }
    
    public func getBasicCards() -> [Card] {
        return basicCards!
    }
    
    public func getCategories() -> [String : Array<Card>] {
        return categories!
    }
    
    public func setBasicCards(cards: [Card]) {
        basicCards = cards
    }
    
    public func setCategories(category: String, cards: Array<Card>){
        
    }
    
    
}
