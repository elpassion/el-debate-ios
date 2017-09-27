public func forceCast<T>(_ object: Any) -> T {
    guard let casted = object as? T else {
        fatalError("Expected \(object) to be of type \(T.self), got \(type(of: object)) instead")
    }

    return casted
}
