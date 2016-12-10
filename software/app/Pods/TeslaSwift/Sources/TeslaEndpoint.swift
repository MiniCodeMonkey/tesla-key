//
//  TeslaEndpoint.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 16/04/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation

enum Endpoint {
	
	case authentication
	case vehicles
	case mobileAccess(vehicleID: Int)
	case chargeState(vehicleID: Int)
	case climateState(vehicleID: Int)
	case driveState(vehicleID: Int)
	case guiSettings(vehicleID: Int)
	case vehicleState(vehicleID: Int)
	case command(vehicleID: Int, command:VehicleCommand)
}

extension Endpoint {
	
	var path: String {
		switch self {
		case .authentication:
			return "/oauth/token"
		case .vehicles:
			return "/api/1/vehicles"
		case .mobileAccess(let vehicleID):
			return "/api/1/vehicles/\(vehicleID)/mobile_enabled"
		case .chargeState(let vehicleID):
			return "/api/1/vehicles/\(vehicleID)/data_request/charge_state"
		case .climateState(let vehicleID):
			return "/api/1/vehicles/\(vehicleID)/data_request/climate_state"
		case .driveState(let vehicleID):
			return "/api/1/vehicles/\(vehicleID)/data_request/drive_state"
		case .guiSettings(let vehicleID):
			return "/api/1/vehicles/\(vehicleID)/data_request/gui_settings"
		case .vehicleState(let vehicleID):
			return "/api/1/vehicles/\(vehicleID)/data_request/vehicle_state"
		case let .command(vehicleID, command):
			return "/api/1/vehicles/\(vehicleID)/\(command.path())"
		}
	}
	
	var method: String {
		switch self {
		case .authentication, .command:
			return "POST"
		case .vehicles, .mobileAccess, .chargeState, .climateState, .driveState, .guiSettings, .vehicleState:
			return "GET"
		}
	}
	
	func baseURL(_ useMockServer: Bool) -> String {
		if useMockServer {
			return "https://private-623898-modelsapi.apiary-mock.com"
		} else {
			return "https://owner-api.teslamotors.com"
		}
	}
}
