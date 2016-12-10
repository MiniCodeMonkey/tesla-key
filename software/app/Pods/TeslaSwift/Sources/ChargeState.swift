//
//  ChargeState.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 14/03/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper

open class ChargeState: Mappable {
	
	public enum ChargingState: String {
		case Complete = "Complete"
		case Charging = "Charging"
		case Disconnected = "Disconnected"
	}
	
	public struct Distance {
		fileprivate var value: Double
		
		public init(miles: Double?) {
			value = miles ?? 0.0
		}
		public init(kms: Double) {
			value = kms / 1.609344
		}
		
		public var miles: Double { return value }
		public var kms: Double { return value * 1.609344 }
	}
	
	/**
	Current state of the charging
	*/
	open internal(set) var chargingState: ChargingState?
	/**
	Charge to max rate or standard
	*/
	open internal(set) var chargeToMaxRange: Bool?
	open internal(set) var maxRangeChargeCounter: Int?
	/**
	Vehicle connected to supercharger?
	*/
	open internal(set) var fastChargerPresent: Bool?
	
	/**
	Rated Miles
	*/
	open internal(set) var ratedBatteryRange: Distance?
	/**
	Range estimated from recent driving
	*/
	open internal(set) var estimatedBatteryRange: Distance?
	/**
	Ideal Miles
	*/
	open internal(set) var idealBatteryRange: Distance?
	/**
	Percentage of the battery
	*/
	open internal(set) var batteryLevel: Int?
	/**
	Current flowing into the battery
	*/
	open internal(set) var batteryCurrent: Double?
	
	open internal(set) var chargeStartingRange: Double?
	open internal(set) var chargeStartingSOC: Double?
	
	/**
	Voltage. Only has value while charging
	*/
	open internal(set) var chargerVoltage: Int?
	/**
	Max current allowed by charger and adapter
	*/
	open internal(set) var chargerPilotCurrent: Int?
	/**
	Current actually being drawn
	*/
	open internal(set) var chargerActualCurrent: Int?
	/**
	KW of charger
	*/
	open internal(set) var chargerPower: Int?
	
	
	/**
	Only valid while charging
	*/
	open internal(set) var timeToFullCharge: Double?
	/**
	miles/hour while charging or -1 if not charging
	*/
	open internal(set) var chargeRate: Distance?
	/**
	Vehicle charging port is open?
	*/
	open internal(set) var chargePortDoorOpen: Bool?
    
	open internal(set) var chargeEnergyAdded: Double?
    
    open internal(set) var chargeDistanceAddedIdeal: Distance?
    open internal(set) var chargeDistanceAddedRated: Distance?
    
    
    open internal(set) var chargeLimitSOC: Int?
    open internal(set) var chargeLimitSOCMax: Int?
    open internal(set) var chargeLimitSOCMin: Int?
    open internal(set) var chargeLimitSOCStandard: Int?
    
    
    
	
	public required init?(map: Map) { }
	
	open func mapping(map: Map) {
		
		let distanceTransform = TransformOf<Distance, Double>(fromJSON: { Distance(miles: $0!) }, toJSON: {$0?.miles})
		
		chargingState               <- map["charging_state"]
		chargeToMaxRange            <- map["charge_to_max_range"]
		maxRangeChargeCounter       <- map["max_range_charge_counter"]
		fastChargerPresent          <- map["fast_charger_present"]
		ratedBatteryRange           <- (map["battery_range"], distanceTransform)
		estimatedBatteryRange       <- (map["est_battery_range"], distanceTransform)
		idealBatteryRange           <- (map["ideal_battery_range"], distanceTransform)
		batteryLevel                <- map["battery_level"]
		batteryCurrent              <- map["battery_current"]
		chargeStartingRange         <- map["charge_starting_range"]
		chargeStartingSOC           <- map["charge_starting_soc"]
		chargerVoltage              <- map["charger_voltage"]
		chargerPilotCurrent         <- map["charger_pilot_current"]
		chargerActualCurrent        <- map["charger_actual_current"]
		chargerPower                <- map["charger_power"]
		timeToFullCharge            <- map["time_to_full_charge"]
		chargeRate                  <- (map["charge_rate"], distanceTransform)
		chargePortDoorOpen          <- map["charge_port_door_open"]
        
        chargeLimitSOC              <- map["charge_limit_soc"]
        chargeLimitSOCMax           <- map["charge_limit_soc_max"]
        chargeLimitSOCMin           <- map["charge_limit_soc_min"]
        chargeLimitSOCStandard      <- map["charge_limit_soc_std"]
        
        chargeEnergyAdded           <- map["charge_energy_added"]
        chargeDistanceAddedIdeal    <- (map["charge_miles_added_ideal"], distanceTransform)
        chargeDistanceAddedRated    <- (map["charge_miles_added_rated"], distanceTransform)
	}
}
