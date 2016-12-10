//
//  GuiSettings.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 17/03/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper

open class GuiSettings: Mappable {
	
	open var distanceUnits: String?
	open var temperatureUnits: String?
	open var chargeRateUnits: String?
	open var time24Hours: Bool?
	open var rangeDisplay: String?
	
	required public init?(map: Map) { }
	
	open func mapping(map: Map) {
		distanceUnits		<- map["gui_distance_units"]
		temperatureUnits	<- map["gui_temperature_units"]
		chargeRateUnits		<- map["gui_charge_rate_units"]
		time24Hours			<- map["gui_24_hour_time"]
		rangeDisplay		<- map["gui_range_display"]
	}
}
