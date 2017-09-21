import Quick

public func when(_ description: String, closure: @escaping () -> Void) {
    context("when \(description)", closure)
}

public func whether(_ description: String, closure: @escaping () -> Void) {
    context("whether \(description)", closure)
}
