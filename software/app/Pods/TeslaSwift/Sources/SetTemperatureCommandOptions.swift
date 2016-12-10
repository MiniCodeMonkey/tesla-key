//
//  SetTemperatureCommandOptions.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 10/11/2016.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper

open class SetTemperatureCommandOptions: Mappable {

	open var driverTemp: Double?
	open var passengerTemp: Double?
	init(driverTemperature: Double, passengerTemperature: Double) {
		driverTemp = driverTemperature
		passengerTemp = passengerTemperature
	}
	
	required public init?(map: Map) { }
	
	open func mapping(map: Map) {
		driverTemp		<- map["driver_temp"]
		passengerTemp	<- map["passenger_temp"]
	}
}
