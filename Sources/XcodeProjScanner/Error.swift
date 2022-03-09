//
//  File.swift
//  
//
//  Created by Ibrahim Koteish on 9/3/22.
//

import Foundation

public struct XcodeProjScannerError: Error, CustomStringConvertible {
  let rawValue: String

  private init(rawValue: String) {
    self.rawValue = rawValue
  }

  public static let missingXcodeProj = XcodeProjScannerError(
    rawValue: "Could not find XcodeProject in the provided path"
  )

  public static let wrongProjectPathArgument = XcodeProjScannerError(
    rawValue: "the provided path is incorrect"
  )

  public var description: String { self.rawValue }
}
