//
//  Observable.swift
//  NewsNYTApp
//
//  Created by Gustavo Téllez Díaz on 30/11/24.
//

import UIKit

class Observable<T> {
    
    public var value: T {
        didSet {
            valueChanged()
        }
    }
    
    private var observer: ((_ value: T) -> Void)?
    
    public init(initialValue: T) {
        self.value = initialValue
    }
    
    public func observe(_ observer: @escaping (_ value: T) -> Void) {
        self.observer = observer
    }
    
    fileprivate func valueChanged() {
        DispatchQueue.main.async { [weak self] in
            guard let value = self?.value else {
                return
            }

            self?.observer?(value)
        }
    }
}
