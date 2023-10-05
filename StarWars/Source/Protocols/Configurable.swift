//
//  Configurable.swift
//  StarWars
//
//  Created by Roman on 9/13/23.
//

///https://stackoverflow.com/questions/52919034/swift-protocol-with-associated-type-how-to-use-in-an-abstract-method

import Foundation

public protocol Configurable {
    associatedtype ViewModel
    /// Конфигурирует view с экземпляром associatedtype type ViewModel
    /// Экземпляр ViewModel содержащий данные необходимые для отображения view
    func configure(with viewModel: ViewModel)
}
