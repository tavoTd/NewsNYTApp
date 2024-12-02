//
//  RealmManager.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 01/12/24.
//

import Foundation
import RealmSwift

class RealmManager {
    
    public static let shared = RealmManager()
    private lazy var realm: Realm = {
        do {
            let realm = try Realm()
            return realm

        } catch {
            fatalError("Error inicializando Realm: \(error.localizedDescription)")
        }
    }()
    
    private init() {}
    
    private func performTransaction(_ block: (Realm) -> Void) {
        do {
            try realm.write {
                block(realm)
            }
        } catch {
            print("Error en la transacción de Realm: \(error.localizedDescription)")
        }
    }
    
    func delete<T: Object>(object: T.Type) {
        self.performTransaction { realm in
            realm.delete(realm.objects(object))
        }
    }
    
    func insert<T: Object>(object: T) {
        self.performTransaction { realm in
            realm.add(object)
        }
    }
    
    func getAll<T: Object>(objects: T.Type) -> [T]? {
        var objectArray: [T] = []

        self.performTransaction { realm in
            let realmData = realm.objects(T.self)
            for element in realmData {
                objectArray.append(element)
            }
        }
        
        return objectArray
    }
}
