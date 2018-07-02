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
    
    //var categories: [String: Array<Card>]?
    var basicCards: Array<Card>?
    var categories2 = [(name: String, value: Array<Card>)]()
    
    private let additionCard = Card(index: 99, name: "", image: #imageLiteral(resourceName: "add"))
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
    // My room
    var card_fan = Card(index: 400, name: "вентилятор", image: #imageLiteral(resourceName: "вентилятор"))
    var card_mirror = Card(index: 401, name: "зеркало", image: #imageLiteral(resourceName: "зеркало"))
    var card_picture = Card(index: 402, name: "картина", image: #imageLiteral(resourceName: "картина"))
    var card_bookshelf = Card(index: 403, name: "книжная полка", image: #imageLiteral(resourceName: "книжная полка"))
    var card_computer = Card(index: 404, name: "компьютер", image: #imageLiteral(resourceName: "компьютер"))
    var card_armchair = Card(index: 405, name: "кресло", image: #imageLiteral(resourceName: "кресло"))
    var card_bed = Card(index: 406, name: "кровать", image: #imageLiteral(resourceName: "кровать"))
    var card_workspace = Card(index: 407, name: "рабочий стол", image: #imageLiteral(resourceName: "рабочий стол"))
    var card_shelf = Card(index: 408, name: "шкаф", image: #imageLiteral(resourceName: "шкаф"))
    var card_toys = Card(index: 409, name: "игрушки", image: #imageLiteral(resourceName: "игрушки"))
    // Living room
    var card_door = Card(index: 500, name: "дверь", image: #imageLiteral(resourceName: "дверь"))
    var card_couch = Card(index: 501, name: "диван", image: #imageLiteral(resourceName: "диван"))
    var card_window = Card(index: 502, name: "окно", image: #imageLiteral(resourceName: "окно"))
    var card_table = Card(index: 503, name: "стол", image: #imageLiteral(resourceName: "стол"))
    var card_tv = Card(index: 504, name: "телевизор", image: #imageLiteral(resourceName: "телевизор"))
    var card_flowers = Card(index: 505, name: "цветы", image: #imageLiteral(resourceName: "цветы"))
    // Bathroom
    var card_bath = Card(index: 600, name: "ванная", image: #imageLiteral(resourceName: "ванная"))
    var card_soap = Card(index: 601, name: "мыло", image: #imageLiteral(resourceName: "мыло"))
    var card_cleaners = Card(index: 602, name: "очистители", image: #imageLiteral(resourceName: "очистители"))
    var card_sink = Card(index: 603, name: "раковина", image: #imageLiteral(resourceName: "раковина"))
    var card_washingmachine = Card(index: 604, name: "стиральная машина", image: #imageLiteral(resourceName: "стиральная машина"))
    var card_toilet = Card(index: 605, name: "унитаз", image: #imageLiteral(resourceName: "унитаз"))
    var card_toiletpaper = Card(index: 606, name: "туалетная бумага", image: #imageLiteral(resourceName: "туалетная бумага"))
    var card_hairdryer = Card(index: 607, name: "фен", image: #imageLiteral(resourceName: "фен"))
    // Kitchen
    var card_colander = Card(index: 700, name: "дуршлаг", image: #imageLiteral(resourceName: "дуршлаг"))
    var card_pan = Card(index: 701, name: "кастрюля", image: #imageLiteral(resourceName: "кастрюля"))
    var card_microoven = Card(index: 702, name: "микроволновка", image: #imageLiteral(resourceName: "микроволновка"))
    var card_eatingtable = Card(index: 703, name: "обеденный стол", image: #imageLiteral(resourceName: "обеденный стол"))
    var card_cutlery = Card(index: 704, name: "столовые приборы", image: #imageLiteral(resourceName: "столовые приборы"))
    var card_chair = Card(index: 705, name: "стул", image: #imageLiteral(resourceName: "стул"))
    var card_plate = Card(index: 706, name: "тарелка", image: #imageLiteral(resourceName: "тарелки"))
    var card_fridge = Card(index: 707, name: "холодильник", image: #imageLiteral(resourceName: "холодильник"))
    var card_teapot = Card(index: 708, name: "чайник", image: #imageLiteral(resourceName: "чайник"))
    // Street
    var card_tree = Card(index: 800, name: "дерево", image: #imageLiteral(resourceName: "дерево"))
    var card_houses = Card(index: 801, name: "дома", image: #imageLiteral(resourceName: "дома"))
    var card_house = Card(index: 802, name: "домик", image: #imageLiteral(resourceName: "домик"))
    var card_road = Card(index: 803, name: "дорога", image: #imageLiteral(resourceName: "дорога"))
    var card_carousel = Card(index: 804, name: "карусель", image: #imageLiteral(resourceName: "карусель"))
    var card_stall = Card(index: 805, name: "ларек с попкорном", image: #imageLiteral(resourceName: "ларек с попкорном"))
    var card_trashbin = Card(index: 806, name: "мусорный бак", image: #imageLiteral(resourceName: "мусорный бак"))
    var card_trafficlight = Card(index: 807, name: "светофор", image: #imageLiteral(resourceName: "светофор"))
    var card_swing = Card(index: 808, name: "качели", image: #imageLiteral(resourceName: "качели"))
    var card_slide = Card(index: 809, name: "горка", image: #imageLiteral(resourceName: "горка"))
    var card_ball = Card(index: 810, name: "мяч", image: #imageLiteral(resourceName: "мяч"))
    // Transport
    var card_bicycle = Card(index: 900, name: "велосипед", image: #imageLiteral(resourceName: "велосипед"))
    var card_ship = Card(index: 901, name: "корабль", image: #imageLiteral(resourceName: "корабль"))
    var card_car = Card(index: 902, name: "машина", image: #imageLiteral(resourceName: "машина"))
    var card_motorcycle = Card(index: 903, name: "мотоцикл", image: #imageLiteral(resourceName: "мотоцикл"))
    var card_train = Card(index: 904, name: "поезд", image: #imageLiteral(resourceName: "поезд"))
    var card_plane = Card(index: 905, name: "самолет", image: #imageLiteral(resourceName: "самолет"))
    var card_ambulance = Card(index: 906, name: "скорая помощь", image: #imageLiteral(resourceName: "скорая помощь_"))
    var card_taxi = Card(index: 907, name: "такси", image: #imageLiteral(resourceName: "такси"))
    var card_van = Card(index: 908, name: "фургон", image: #imageLiteral(resourceName: "фургон"))
    // Fruits and veges
    var card_watermelon = Card(index: 10, name: "арбуз", image: #imageLiteral(resourceName: "арбуз"))
    var card_apple = Card(index: 11, name: "яблоко", image: #imageLiteral(resourceName: "яблоко"))
    var card_banana = Card(index: 12, name: "банан", image: #imageLiteral(resourceName: "банан"))
    var card_cabbage = Card(index: 13, name: "капуста", image: #imageLiteral(resourceName: "капуста"))
    var card_limon = Card(index: 14, name: "лимон", image: #imageLiteral(resourceName: "лимое"))
    var card_onion = Card(index: 15, name: "лук", image: #imageLiteral(resourceName: "лук"))
    var card_carrot = Card(index: 16, name: "морковь", image: #imageLiteral(resourceName: "морковь"))
    var card_cucumber = Card(index: 17, name: "огурец", image: #imageLiteral(resourceName: "огурец"))
    var card_pepper = Card(index: 18, name: "перец", image: #imageLiteral(resourceName: "перец"))
    var card_tomato = Card(index: 19, name: "помидор", image: #imageLiteral(resourceName: "помидор"))
    var card_cherries = Card(index: 20, name: "черешня", image: #imageLiteral(resourceName: "черешня"))
    var card_corn = Card(index: 30, name: "кукуруза", image: #imageLiteral(resourceName: "кукуруза"))
    // Products
    var card_bar = Card(index: 21, name: "батончик", image: #imageLiteral(resourceName: "батончик"))
    var card_jam = Card(index: 22, name: "варенье", image: #imageLiteral(resourceName: "варенье"))
    var card_cake = Card(index: 23, name: "кекс", image: #imageLiteral(resourceName: "кекс"))
    var card_flour = Card(index: 24, name: "мука", image: #imageLiteral(resourceName: "мука"))
    var card_cookie = Card(index: 25, name: "печенье", image: #imageLiteral(resourceName: "печенья"))
    var card_donut = Card(index: 26, name: "пончик", image: #imageLiteral(resourceName: "пончик"))
    var card_cheese = Card(index: 27, name: "сыр", image: #imageLiteral(resourceName: "сыр"))
    var card_bread = Card(index: 28, name: "хлеб", image: #imageLiteral(resourceName: "хлеб"))
    var card_egg = Card(index: 29, name: "яйцо", image: #imageLiteral(resourceName: "яйцо"))
    
    init() {
//        categories = [
//            "Семья": [card_meGirl, card_meGirl2, card_meBoy, card_mother,      card_father, card_father2, card_grandfather, card_grandmother, card_baby, card_twins, card_family, additionCard],
//            "Ежедневные слова": [card_yes, card_no, card_want, card_eat, card_drink, card_help, card_forAWalk, card_sleep, additionCard],
//            "Эмоции": [card_laughing, card_sad, card_sad2, card_inLove, card_sceptic, card_smile, card_thinking, additionCard]
//        ]
        categories2 = [
                        ("Семья", [card_meGirl, card_meGirl2, card_meBoy, card_mother, card_father, card_father2, card_grandfather, card_grandmother, card_baby, card_twins, card_family, additionCard]),
                        ("Ежедневные слова", [card_yes, card_no, card_want, card_eat, card_drink, card_help, card_forAWalk, card_sleep, additionCard]),
                        ("Эмоции", [card_laughing, card_sad, card_sad2, card_inLove, card_sceptic, card_smile, card_thinking, additionCard]),
                        ("Моя комната", [card_bed, card_mirror, card_picture, card_bookshelf, card_computer, card_armchair, card_fan, card_workspace, card_shelf, card_toys, additionCard]),
                        ("В зале", [card_tv, card_couch, card_bookshelf, card_window, card_table, card_door, card_flowers, additionCard]),
                        ("В ванне", [card_bath, card_mirror, card_soap, card_cleaners, card_sink, card_washingmachine, card_toilet, card_toiletpaper, card_hairdryer, additionCard]),
                        ("На кухне", [card_microoven, card_pan, card_colander, card_eatingtable, card_sink, card_cutlery, card_table, card_plate, card_fridge, card_teapot, additionCard]),
                        ("На улице", [card_tree, card_house, card_houses, card_road, card_carousel, card_stall, card_trashbin, card_trafficlight, card_flowers, additionCard]),
                        ("Транспорт", [card_car, card_ship, card_bicycle, card_motorcycle, card_train, card_plane, card_ambulance, card_taxi, card_van, additionCard]),
                        ("Овощи и фрукты", [card_apple, card_banana, card_watermelon, card_cabbage, card_corn, card_limon, card_onion, card_carrot, card_cucumber, card_tomato, card_pepper, card_cherries, additionCard]),
                        ("Продукты", [card_cookie, card_jam, card_cake, card_flour, card_bar, card_donut, card_cheese, card_bread, card_egg, additionCard]),
        ]
        basicCards = [card_meGirl, card_want, card_yes, card_no, card_father, card_mother, card_eat, card_drink, card_help, card_sleep]
    }
    
    public func getBasicCards() -> [Card] {
        return basicCards!
    }
    
//    public func getCategories() -> [String : Array<Card>] {
//        return categories!
//    }
//
    public func getCategories2() -> [(String, Array<Card>)] {
        return categories2
    }
    
    public func setBasicCards(cards: [Card]) {
        basicCards = cards
    }
    
//    public func setCategories(allCards: [String: [Card]]){
//        categories = allCards
//    }
    
    public func setCategories2(categories: [(String, Array<Card>)]) {
        categories2 = categories
    }
    
}
