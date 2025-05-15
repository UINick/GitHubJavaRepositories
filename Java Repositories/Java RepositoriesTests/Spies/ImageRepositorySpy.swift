//
//  ImageRepositorySpy.swift
//  Java RepositoriesTests
//
//  Created by Nicholas Forte on 14/05/25.
//

import Foundation
import UIKit
@testable import Java_Repositories

class ImageRepositorySpy: ImageRepositoryProtocol {

    var loadimageCalled = false
    
    func loadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        loadimageCalled = true
        completion (nil)
    }
}
