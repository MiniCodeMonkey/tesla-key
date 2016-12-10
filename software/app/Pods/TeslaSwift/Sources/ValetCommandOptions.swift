//
//  ValetCommandOptions.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 12/04/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper

open class ValetCommandOptions: Mappable {
	
	open var on: Bool = false
	open var password: String?
	
	init(valetActivated: Bool, pin: String?) {
		on = valetActivated
		password = pin
	}
	
	required public init?(map: Map) { }
	
	open func mapping(map: Map) {
		on			<- map["on"]
		password	<- map["password"]
	}
}
