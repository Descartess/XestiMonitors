//
//  CloudIdentityMonitor.swift
//  XestiMonitors
//
//  Created by J. G. Pusey on 2018-03-12.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

import Foundation

///
/// A `CloudIdentityMonitor` instance monitors ...
///
public class CloudIdentityMonitor: BaseNotificationMonitor {
    ///
    /// Encapsulates changes to ...
    ///
    public enum Event {
        ///
        ///
        ///
        case didChange(AnyObject?)
    }

    ///
    /// Initializes a new `CloudIdentityMonitor`.
    ///
    /// - Parameters:
    ///   - queue:      The operation queue on which the handler executes. By
    ///                 default, the main operation queue is used.
    ///   - handler:    The handler to call when ...
    ///
    public init(queue: OperationQueue = .main,
                handler: @escaping (Event) -> Void) {
        self.fileManager = .init()
        self.handler = handler

        super.init(queue: queue)
    }

    public var cloudIdentity: AnyObject? {
        return fileManager.ubiquityIdentityToken as AnyObject?
    }

    private let fileManager: FileManager
    private let handler: (Event) -> Void

    override public func addNotificationObservers() {
        super.addNotificationObservers()

        observe(.NSUbiquityIdentityDidChange) { [unowned self] _ in
            self.handler(.didChange(self.cloudIdentity))
        }
    }
}
