import Byte

extension ECMA_262.Template {
    public struct Literal: Sendable, Hashable {
        public let characters: String

        public init(_ text: String) {
            var bytes: [Byte] = []
            bytes.reserveCapacity(text.utf8.count)
            var units = text.utf8.makeIterator()
            var pending = units.next()
            while let unit = pending {
                pending = units.next()
                switch unit {
                case UInt8(ascii: "\\"):
                    bytes += "\\\\"

                case UInt8(ascii: "`"):
                    bytes += "\\`"

                case UInt8(ascii: "$") where pending == UInt8(ascii: "{"):
                    bytes += "\\$"

                case UInt8(ascii: "\r"):
                    bytes += "\\r"

                default:
                    bytes.append(Byte(bitPattern: unit))
                }
            }
            self.characters = String(decoding: bytes, as: UTF8.self)
        }
    }
}
