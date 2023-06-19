//
//  Constant.swift
//  Setup
//
//  Created by Hemant kumar on 17/06/23.
//

import Foundation

let fullnamePredicate = NSPredicate(format: "SELF MATCHES %@", "^[\\S\\s]{3,}$")
let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$")
