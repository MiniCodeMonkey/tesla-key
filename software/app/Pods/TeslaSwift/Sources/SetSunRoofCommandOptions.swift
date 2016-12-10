//
//  SetSunRoofCommandOptions.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 10/11/2016.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper

open class SetSunRoofCommandOptions: Mappable {

	open var state: RoofState?
	open var percent: Int?
	init(state: RoofState, percent: Int) {
		self.state = state
		self.percent = percent
	}
	
	required public init?(map: Map) { }
	
	open func mapping(map: Map) {
		state		<- (map["state"],EnumTransform())
		percent		<- map["percent"]
	}
}
