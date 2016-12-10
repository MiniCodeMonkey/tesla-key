//
//  CommandResponse.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 05/04/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper

open class CommandResponse: Mappable {
	
	open var result: Bool?
	open var reason: String?
	
	required public init?(map: Map) { }
	
	open func mapping(map: Map) {
		result	<- map["response.result"]
		reason	<- map["response.reason"]
	}
}
