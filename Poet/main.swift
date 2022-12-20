//
//  main.swift
//  Poet
//
//  Created by Eetu Eskelinen on 20.12.2022.
//

import Foundation
import AppKit

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
