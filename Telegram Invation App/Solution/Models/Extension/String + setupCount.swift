//
//  String + setupCount.swift
//  Telegram Invation App
//
//  Created by Артур Миннушин on 14.05.2025.
//

extension String {
    func setupCountString() -> String {
        var newString = ""
        
        if let joindePeopleCount = Int(self) {
            switch joindePeopleCount {
            case 0:
                newString = "вступлений пока нет"
            case 1:
                newString = self + " человек присоеденился"
            case 2...99:
                newString = self + " человек присоеденились"
            case 100...999:
                newString = self + " присоеденились"
            case 1000...999999:
                newString = joindePeopleCount.formattedWithSpaces + " присоеденились"
            default:
                newString = self + "присоеденились"
            }
        } else {
            newString = "вступлений пока нет"
        }
        
        return newString
    }
}
