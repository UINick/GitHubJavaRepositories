//
//  ImageRepository.swift
//  Java Repositories
//
//  Created by Nicholas Forte on 12/05/25.
//

import Foundation
import UIKit

protocol ImageRepositoryProtocol {
    func loadImage(from url: String, completion: @escaping (UIImage?) -> Void)
}

class ImageRepository: ImageRepositoryProtocol {
    func loadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = URL(string: url) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
}
