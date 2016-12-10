//
//  ChargeLimitPercentageCommandOptions.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 10/11/2016.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper

open class ChargeLimitPercentageCommandOptions: Mappable {
	
	open var percent: Int?
	
	init(limit: Int) {
		percent = limit
	}
	
	required public init?(map: Map) { }
	
	open func mapping(map: Map) {
		percent	<- map["percent"]
	}
}
