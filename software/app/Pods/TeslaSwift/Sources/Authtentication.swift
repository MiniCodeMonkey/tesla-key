//
//  AuthToken.swift
//  TeslaSwift
//
//  Created by Joao Nunes on 04/03/16.
//  Copyright © 2016 Joao Nunes. All rights reserved.
//

import Foundation
import ObjectMapper

open class AuthToken: Mappable {
	
	var accessToken: String?
	var tokenType: String?
	var createdAt: Date? = Date()
	var expiresIn: TimeInterval?
	
	open var isValid: Bool {
		if let createdAt = createdAt, let expiresIn = expiresIn {
			return -Date().timeIntervalSince(createdAt) < expiresIn
		} else {
			return false
		}
	}
	
	
	// MARK: Mappable protocol
	required public init?(map: Map) {
		if map.JSON.count < 3 { return nil }
	}
	
	open func mapping(map: Map) {
		accessToken	<- map["access_token"]
		tokenType	<- map["token_type"]
		createdAt	<- (map["created_at"], DateTransform())
		expiresIn	<- (map["expires_in"], TransformOf<TimeInterval, Int>(fromJSON: { TimeInterval($0! / 1000) }, toJSON: { Int($0!) * 1000 }))
	}
}

class AuthTokenRequest: Mappable {
	
	var grantType: String?
	var clientID: String?
	var clientSecret: String?
	var email: String?
	var password: String?
	
	init(email: String, password: String, grantType: String, clientID: String, clientSecret: String) {
		self.email = email
		self.password = password
		self.grantType = grantType
		self.clientID = clientID
		self.clientSecret = clientSecret
	}
	
	// MARK: Mappable protocol
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		grantType		<- map["grant_type"]
		clientID		<- map["client_id"]
		clientSecret	<- map["client_secret"]
		email			<- map["email"]
		password		<- map["password"]
	}
}
