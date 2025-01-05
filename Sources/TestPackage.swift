private import Foundation

public protocol TestProtocol {}

public final class TestPackage {
    public init(testProtocol: any TestProtocol) {}
}
