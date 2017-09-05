//
//  Extensions.swift
//  Releave
//
//  Created by Harrison Melton on 9/3/17.
//  Copyright © 2017 Harrison Melton. All rights reserved.
//

import Foundation
import Alamofire

extension String {
    // This function trims the String of white spaces and new lines
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
