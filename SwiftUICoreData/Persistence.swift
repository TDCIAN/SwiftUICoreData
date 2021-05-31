//
//  Persistence.swift
//  SwiftUICoreData
//
//  Created by 김정민 on 2021/05/31.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "TodoList") // 여기에 코어데이터 파일 이름 들어가야 한다
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}
