import Foundation

/// Defines a structure for events in the system.
///
/// Each specific event type conforms to `EventRepresentable`, making them compatible with the EventBus system.
/// Events include a `params` dictionary for additional data, enhancing flexibility.
/// Defines a structure for events in the system.
///
/// Each specific event type conforms to `EventRepresentable`, making them compatible with the EventBus system.
/// Events include a `params` dictionary for additional data, enhancing flexibility.
public protocol EventRepresentable: Equatable, Codable {
    var key: String { get }
    var params: [String: String] { get }
}

// Default key
public extension EventRepresentable {
    static var key: String {
        String(describing: Self.self)
    }

    var key: String {
        Self.key
    }
}

// Event Types Registry
public enum EventTypesRegistry {
    static func allEventTypes() -> [any EventRepresentable.Type] {
        // Add all your event types here
        [
            ProfileIdentifiedEvent.self,
            ScreenViewedEvent.self,
            ResetEvent.self,
            TrackMetricEvent.self,
            TrackInAppMetricEvent.self,
            RegisterDeviceTokenEvent.self,
            DeleteDeviceTokenEvent.self,
            NewSubscriptionEvent.self
        ]
    }
}

public struct ProfileIdentifiedEvent: EventRepresentable {
    public var params: [String: String] = [:]
    public let identifier: String

    public init(identifier: String, params: [String: String] = [:]) {
        self.identifier = identifier
        self.params = params
    }
}

public struct ScreenViewedEvent: EventRepresentable {
    public var params: [String: String] = [:]
    public let name: String

    public init(name: String, params: [String: String] = [:]) {
        self.name = name
        self.params = params
    }
}

public struct ResetEvent: EventRepresentable {
    public var params: [String: String] = [:]

    public init(params: [String: String] = [:]) {
        self.params = params
    }
}

public struct TrackMetricEvent: EventRepresentable {
    public var params: [String: String] = [:]
    public let deliveryID: String
    public let event: String
    public let deviceToken: String

    public init(deliveryID: String, event: String, deviceToken: String, params: [String: String] = [:]) {
        self.params = params
        self.deliveryID = deliveryID
        self.event = event
        self.deviceToken = deviceToken
    }
}

public struct TrackInAppMetricEvent: EventRepresentable {
    public var params: [String: String] = [:]
    public let deliveryID: String
    public let event: String

    public init(deliveryID: String, event: String, params: [String: String] = [:]) {
        self.params = params
        self.deliveryID = deliveryID
        self.event = event
    }
}

public struct RegisterDeviceTokenEvent: EventRepresentable {
    public var params: [String: String] = [:]
    public let token: String

    public init(token: String, params: [String: String] = [:]) {
        self.token = token
        self.params = params
    }
}

public struct DeleteDeviceTokenEvent: EventRepresentable {
    public var params: [String: String] = [:]

    public init(params: [String: String] = [:]) {
        self.params = params
    }
}

public struct NewSubscriptionEvent: EventRepresentable {
    public var params: [String: String] = [:]
    public let subscribedEventType: String

    init<E: EventRepresentable>(subscribedEventType: E.Type, params: [String: String] = [:]) {
        self.subscribedEventType = E.key
    }
}
