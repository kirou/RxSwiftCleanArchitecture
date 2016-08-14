//
//  ArrayTransform.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/12.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class ArrayTransform<T:RealmSwift.Object where T:Mappable> : TransformType {
    
    typealias Object = List<T>
    typealias JSON = Array<AnyObject>
    
    func transformFromJSON(value: AnyObject?) -> List<T>? {
        let result = List<T>()
        if let tempArr = value as! Array<AnyObject>? {
            for entry in tempArr {
                let mapper = Mapper<T>()
                let model : T = mapper.map(entry)!
                result.append(model)
            }
        }
        return result
    }
    
    func transformToJSON(value: List<T>?) -> Array<AnyObject>? {
        if (value?.count > 0)
        {
            var result = Array<T>()
            for entry in value! {
                result.append(entry)
            }
            return result
        }
        return nil
    }
}