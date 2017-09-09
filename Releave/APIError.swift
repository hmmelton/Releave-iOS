//
//  APIError.swift
//  Releave
//
//  Created by Harrison Melton on 9/8/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//
// This structure is used for errors related to network requests to the Releave API.

import Foundation

struct APIError {
    let statusCode: Int
    let description: String
}
