//
//  File.swift
//  
//
//  Created by Ibrahim Koteish on 9/3/22.
//

import Foundation

public func getXcodeProjectPath(in path: String) throws -> String {

  let fileManager = FileManager.default
  let enumerator = fileManager.enumerator(atPath: path)!

  var xcodeProjPath: String? = nil

  while let element = enumerator.nextObject() as? String {
    guard element.hasSuffix("project.pbxproj") else { continue }
    xcodeProjPath =  path + "/" + element
    break
  }

  guard let xcodeProjPath = xcodeProjPath else { throw XcodeProjScannerError.missingXcodeProj }

  return xcodeProjPath
}

// this here because we cannot write x = y ?? try z
// instead we should write x = try throwable(y) ?? z
public func throwable<A>(_ value: A) throws -> A {
  return value
}


public extension String {
  var dropLastPathComponent: String {
    self.hasSuffix("/") ? String(self.dropLast()) : self
  }
}
