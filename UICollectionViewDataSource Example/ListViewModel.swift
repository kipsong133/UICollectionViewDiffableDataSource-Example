//
//  ListViewModel.swift
//  UICollectionViewDataSource Example
//
//  Created by 김우성 on 2023/03/19.
//

import Foundation

// Diffable DataSource 의 경우 "Hashable" 채택
struct ListViewModel: Hashable {
    let id: Int
    let title: String?
    let content: String?
    
    init(id: Int, title: String?, content: String?) {
        self.id = id
        self.title = title
        self.content = content
    }
}
