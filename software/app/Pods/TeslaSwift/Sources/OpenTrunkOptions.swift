//
//  OpenTrunkOptions.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 16/04/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper


public enum OpenTrunkOptions: String, Mappable {
	
	case Rear = "rear"
	
	public init?(map: Map) {
		self = .Rear
	}
	
	public mutating func mapping(map: Map) {
		self	<- (map["which_trunk"], EnumTransform())
	}
}
