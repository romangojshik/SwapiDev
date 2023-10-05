//
//  Space.swift
//  StarWars
//
//  Created by Roman on 9/21/23.
//

import UIKit

/// Протокол для основных числовых констант
public protocol OpenGrid {}

/// Содержит основные базовые числовые константы
public extension OpenGrid {
    /// Отступ 15
    var space15: CGFloat { 15 }
    /// Отступ 20
    var space20: CGFloat { 20 }
}

/// Обертка для OpenGrid совместимых типов
public struct GridWrapper<Base>: OpenGrid {
    private let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

/// Протокол описывающий которому должны конформить совместимы с OpenGrid типами
public protocol GridCompatible: AnyObject {}

extension GridCompatible {
    /// Предоставляет namespace обертку для OpenGrid совместимых типов.
    public var grid: GridWrapper<Self> { GridWrapper(self) }
}

extension UIView: GridCompatible {}
extension UIViewController: GridCompatible {}
