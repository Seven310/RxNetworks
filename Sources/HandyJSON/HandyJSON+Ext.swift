//
//  HandyJSON+Ext.swift
//  RxNetworks
//
//  Created by Condy on 2023/4/15.
//

import Foundation
import HandyJSON

extension HandyJSON {
    
    /// 映射非空数据，字段数据为空则取后者`infomation`对应字段数据
    /// Map the not nil data.
    /// - Parameter infomation: Data source to be mapped.
    /// - Returns: Mapped data.
    public func mappingNotNil<T: HandyJSON>(with infomation: T?) -> T {
        guard let infomation = infomation else {
            return self as! T
        }
        let dict_ = Dictionary(Mirror(reflecting: infomation).children.map { ($0.label, $0.value) }) { $1 }
        var dict: [String: Any] = [:]
        for property in Mirror(reflecting: self).children {
            guard let key = property.label else {
                continue
            }
            if case Optional<Any>.some(let value) = property.value { //非空判断
                dict[key] = value
            } else {
                dict[key] = dict_[key]
            }
        }
        let result = T.deserialize(from: dict)
        return result ?? (self as! T)
    }
}