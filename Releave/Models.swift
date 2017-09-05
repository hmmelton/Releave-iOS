//
//  Models.swift
//  Releave
//
//  Created by Harrison Melton on 9/4/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import Foundation

struct User {
    var id: String
    var facebookId: String
    var firstName: String
    var lastName: String
    var email: String
    var paid: Bool?
    var paidExp: UInt64?
    var stripeToken: String?
}
