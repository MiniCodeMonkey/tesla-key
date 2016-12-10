//
//  Vehicle.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 05/03/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper

open class Vehicle: Mappable {
	
	open var color: String?
	open var displayName: String?
	open var id: Int?
	open var optionCodes: String?
	open var userID: Int?
	open var vehicleID: Int?
	open var vin: String?
	open var tokens: [String]?
	open var state: String?
	
	// MARK: Mappable protocol
	required public init?(map: Map) {
		
	}
	
	open func mapping(map: Map) {
		color		<- map["color"]
		displayName	<- map["display_name"]
		id			<- map["id"]
		optionCodes	<- map["option_codes"]
		userID		<- map["user_id"]
		vehicleID	<- map["vehicle_id"]
		vin			<- map["vin"]
		tokens		<- map["tokens"]
		state		<- map["state"]
	}
}
