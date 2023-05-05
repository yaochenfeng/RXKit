//
//  RXViewModel.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/5/4.
//

protocol ViewModelType {
    associatedtype State
    associatedtype Output
    func getOutput(_ state: State) -> Output
}
