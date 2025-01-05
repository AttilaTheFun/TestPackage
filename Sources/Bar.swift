private import Foundation

protocol FooProtocol: Sendable {}

final class Foo: Sendable {
    let fooProtocol: any FooProtocol
    init(fooProtocol: any FooProtocol) {
        self.fooProtocol = fooProtocol
    }
}