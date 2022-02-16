//
//  Library.swift
//  VKApp
//
//  Created by hayk on 18/06/2019.
//  Copyright © 2019 Tairian. All rights reserved.
//

import UIKit
import RealmSwift

func +=<K,V>(catcher: inout Dictionary<K,V>, target: Dictionary<K,V>) {
    for (k, v) in target {
        catcher[k] = v
    }
}

public func deleteObjects(_ type: Object.Type) {
    
    do {
        let realm = try Realm()
        let objects = realm.objects(type)
        
        for object in objects {
            try realm.write {
                realm.delete(object)
            }
        }
        
    } catch {
        print(error)
    }
}

public func objects(_ type: Object.Type) -> Results<Object>? {
    do {
        let realm = try Realm()
        return realm.objects(type)
    } catch {
        print(error)
        return nil
    }
}

public func saveObjects<RealmObject: Object>(_ objects: [RealmObject]) {
    do {
        let realm = try Realm()
        try realm.write { realm.add(objects) }
    } catch {
        print(error)
    }
}

public func getDocumentDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

public func heightForLabelText(_ text: String, withViewWidth width: CGFloat, font: UIFont) -> CGFloat {
    
    let attrString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: font])
    
    let size = attrString.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
    
    return size.height
}

public func stringFromDate(_ date: Date, inDateFormat dateFormat: String) -> String {
        
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    formatter.locale = Locale(identifier: "ru_RU")
    
    return formatter.string(from: date).lowercased()
}

public func dateDescription(_ date: Date) -> String {
    
    let requestedComponent: Set<Calendar.Component> = [.day, .hour, .minute, .second]
    
    let calendar = Calendar.current
    
    let difference = calendar.dateComponents(requestedComponent, from: date, to: Date())
    
    let dateComponents = calendar.dateComponents(in: .current, from: Date())
    
    let newsDateComponents = calendar.dateComponents(in: .current, from: date)
    
    if newsDateComponents.year != dateComponents.year {
        return stringFromDate(date, inDateFormat: "d LLL yyyy г.")
    }
    
    if newsDateComponents.day != dateComponents.day &&
        difference.day! < 2 {
        return stringFromDate(date, inDateFormat: "вчера в HH:mm")
    }
    
    if newsDateComponents.day != dateComponents.day {
        return stringFromDate(date, inDateFormat: "d LLL в HH:mm")
    }
    
    if difference.hour! > 0 {
        
        switch difference.hour! {
        case 1:
            return "час назад"
        case 2:
            return "два часа назад"
        case 3:
            return "три часа назад"
        default:
            return stringFromDate(date, inDateFormat: "сегодня в HH:mm")
        }
    }
    
    if difference.minute! > 1 {
        return stringFromDate(date, inDateFormat: "m минут назад")
    }
    
    if difference.minute! == 1 {
        return "минуту назад"
    }
    
    if difference.second! >= 10 {
        return stringFromDate(date, inDateFormat: "s секунд назад")
    }
    
    return "только что"
}
