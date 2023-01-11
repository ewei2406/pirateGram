//
//  Controller.swift
//  pirategram
//
//  Created by Eddie Wei on 1/10/23.
//

import Foundation

enum Page {
    case auth
    case home
}

class Controller: ObservableObject {
    @Published var currentUserID: String?
    @Published var currentUser: User?
    @Published var currentPage: Page = .auth
    @Published var visiblePosts = [Post]()
    
    
}
