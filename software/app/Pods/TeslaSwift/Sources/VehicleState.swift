//
//  VehicleState.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 20/03/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper

open class VehicleState: Mappable {
	
	open var driverDoorOpen: Bool?
	open var driverRearDoorOpen: Bool?
	open var passengerDoorOpen: Bool?
	open var passengerRearDoorOpen: Bool?
	open var frontTrunkOpen: Bool?
	open var rearTrunkOpen: Bool?
	open var firmwareVersion: String?
	open var locked: Bool?
	open var sunRoofInstalled: Bool?
	open var sunRoofState: String?
	open var sunRoofPercentageOpen: Int? // null if not installed
	open var darkRims: Bool?
	open var wheelType: String?
	open var hasSpoiler: Bool?
	open var roofColor: String? // "None" for panoramic roof
	open var perfConfig: String?
	
	
	// MARK: Mappable protocol
	required public init?(map: Map) {
		
	}
	
	open func mapping(map: Map) {
		driverDoorOpen			<- map["df"]
		driverRearDoorOpen		<- map["dr"]
		passengerDoorOpen		<- map["pf"]
		passengerRearDoorOpen	<- map["pr"]
		frontTrunkOpen			<- map["ft"]
		rearTrunkOpen			<- map["rt"]
		firmwareVersion			<- map["car_version"]
		locked					<- map["locked"]
		sunRoofInstalled		<- map["sun_roof_installed"]
		sunRoofState			<- map["sun_roof_state"]
		sunRoofPercentageOpen	<- map["sun_roof_percent_open"]
		darkRims				<- map["dark_rims"]
		wheelType				<- map["wheel_type"]
		hasSpoiler				<- map["has_spoiler"]
		roofColor				<- map["roof_color"]
		perfConfig				<- map["perf_config"]
	}
}
