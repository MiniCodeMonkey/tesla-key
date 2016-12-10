//
//  GenericResponse.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 24/06/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper

open class Response<T:Mappable>: Mappable {
	
	open var response: T!
	
	// MARK: Mappable protocol
	required public init?(map: Map) {
		if map["response"].currentValue == nil {
			return nil
		}
	}
	
	open func mapping(map: Map) {
		response	<- map["response"]
	}
	
}

open class ArrayResponse<T:Mappable>: Mappable {
	
	open var response: [T]!
	
	// MARK: Mappable protocol
	required public init?(map: Map) {
		if map["response"].currentValue == nil {
			return nil
		}
	}
	
	open func mapping(map: Map) {
		response	<- map["response"]
	}
	
}


open class BoolResponse: Mappable {
	
	open var response: Bool!
	
	// MARK: Mappable protocol
	required public init?(map: Map) {
		if map["response"].currentValue == nil {
			return nil
		}
	}
	
	open func mapping(map: Map) {
		response	<- map["response"]
	}
	
}
