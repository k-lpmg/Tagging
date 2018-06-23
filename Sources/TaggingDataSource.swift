//
//  TaggingDataSource.swift
//  Tagging
//
//  Created by DongHeeKang on 2018. 6. 24..
//

public protocol TaggingDataSource: class {
    func tagging(_ tagging: Tagging, didChangedTagableList tagableList: [String])
    func tagging(_ tagging: Tagging, didChangedTaggedList taggedList: [TaggingModel])
}

public extension TaggingDataSource {
    func tagging(_ tagging: Tagging, didChangedTagableList tagableList: [String]) {return}
    func tagging(_ tagging: Tagging, didChangedTaggedList taggedList: [TaggingModel]) {return}
}
