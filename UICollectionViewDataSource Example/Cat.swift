//
//  Cat.swift
//  UICollectionViewDataSource Example
//
//  Created by 김우성 on 2023/03/19.
//

import UIKit

class Cat: Hashable {
    var id = UUID()
    var name: String
    var thumbnilStr: String?
    
    init(name: String, thumbnilStr: String? = nil) {
        self.name = name
        self.thumbnilStr = thumbnilStr
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Cat, rhs: Cat) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Cat {
    static let allCats = [
        Cat(
            name: "첫 번째 고양이",
            thumbnilStr: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg"
        ),
        Cat(
            name: "두 번째 고양이",
            thumbnilStr: "https://cdn2.thecatapi.com/images/MTc5NjI5Mw.jpg"
        ),
        Cat(
            name: "세 번째 고양이",
            thumbnilStr: "https://cdn2.thecatapi.com/images/MTUzMjkzMg.jpg"
        ),
        Cat(
            name: "네 번째 고양이",
            thumbnilStr: "https://cdn2.thecatapi.com/images/MTcwMDE1Mw.jpg"
        ),
        Cat(
            name: "다섯 번째 고양이",
            thumbnilStr: "https://cdn2.thecatapi.com/images/MTY4OTE5Mw.jpg"
        ),
        Cat(
            name: "여섯 번째 고양이",
            thumbnilStr: "https://cdn2.thecatapi.com/images/ad3.jpg"
        ),
        Cat(
            name: "일곱 번째 고양이",
            thumbnilStr: "https://cdn2.thecatapi.com/images/aa1.jpg"
        ),
        Cat(
            name: "여덟 번째 고양이",
            thumbnilStr: "https://cdn2.thecatapi.com/images/4m2.jpg"
        ),
        Cat(
            name: "열한번 번째 고양이",
            thumbnilStr: "https://cdn2.thecatapi.com/images/JBkP_EJm9.jpg"
        ),
        Cat(
            name: "열 번째 고양이",
            thumbnilStr: "https://cdn2.thecatapi.com/images/1nv.jpg"
        ),
        Cat(
            name: "아홉 번째 고양이",
            thumbnilStr: "https://cdn2.thecatapi.com/images/4v.jpg"
        )
    ]
}
