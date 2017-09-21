public protocol Validator {

    associatedtype Value

    func validate(_ value: Value) throws

}

public class AnyValidator<V>: Validator {

    private let _validate: (V) throws -> Void

    public init<U: Validator> (_ validator: U) where U.Value == V {
        self._validate = validator.validate
    }

    public func validate(_ value: V) throws {
        try self._validate(value)
    }

}
