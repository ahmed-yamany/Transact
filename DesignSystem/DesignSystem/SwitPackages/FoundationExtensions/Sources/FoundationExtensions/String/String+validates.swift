//
//  String+validates.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import Foundation

public extension String {
    /// Validate a string against a specified pattern using regular expressions.
    ///
    /// - Parameters:
    ///   - pattern: The regular expression pattern to match against.
    /// - Returns: `true` if the string matches the pattern; otherwise, `false`
    func validates(to pattern: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: self)
    }
    
    /// Check if the string is a valid Egypt phone number.
    ///
    /// - Returns: `true` if the string is a valid Egypt phone number; otherwise, `false`.
    func isValidEgyptianPhoneNumber() -> Bool {
        let regex = #"^01[0-9]{9}$"#
        return validates(to: regex)
    }
    
    /// Check if the string is a valid email address.
    ///
    /// - Returns: `true` if the string is a valid email address; otherwise, `false`.
    func isValidEmail() -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return validates(to: emailPattern)
    }
    
    func isLink() -> Bool {
        let urlRegex = #"^(https?|ftp)://(?:[\w-]+\.)+[a-z]{2,}(?:\/\S*)?$"#
        return validates(to: urlRegex)
    }
}
