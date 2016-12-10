//
//  RemoteStartDriveCommandOptions.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 10/11/2016.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper

open class RemoteStartDriveCommandOptions: Mappable {

	open var password: String?
	init(password: String) {
		self.password = password
	}
	
	required public init?(map: Map) { }
	
	open func mapping(map: Map) {
		password		<- map["password"]
	}
}
