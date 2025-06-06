//
//  UserDefaultsStorage.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 06/06/25.
//

import Foundation

protocol ItemStorageProtocol {
    func fetchItems() -> [JavaProjectsModel]
    func saveItems(_ item: [JavaProjectsModel])
    func removeItem(_ item: JavaProjectsModel)
}

class UserDefaultsStorage: ItemStorageProtocol {
    private let key = "savedItems"

    func fetchItems() -> [JavaProjectsModel] {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let decoded = try JSONDecoder().decode([JavaProjectsModel].self, from: data)
                print("✅ Decodificação bem-sucedida, total: \(decoded.count) itens")
                return decoded
            } catch {
                print("❌ Erro ao decodificar: \(error)")
            }
        } else {
            print("❌ Nenhum dado salvo")
        }
        return []
    }

    func saveItems(_ items: [JavaProjectsModel]) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func removeItem(_ item: JavaProjectsModel) {
        var items = fetchItems()
        items.removeAll { $0.id == item.id }
        saveItems(items)
    }
}
