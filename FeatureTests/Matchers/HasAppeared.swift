import EarlGrey

func grey_waitUntilVisible(_ matcher: GREYMatcher, timeout: CFTimeInterval = 5.0, pollInterval: CFTimeInterval = 0.1) {
    let appeared = GREYCondition(name: "Waiting for \(matcher) to match") { _ in
        var error: NSError?

        EarlGrey.select(elementWithMatcher: matcher)
            .assert(grey_sufficientlyVisible(), error: &error)

        return error == nil
    }.wait(withTimeout: timeout, pollInterval: pollInterval)

    GREYAssertTrue(appeared, reason: "Failed waiting for \(matcher) to match")
}
