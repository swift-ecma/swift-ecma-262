extension ECMA_262.Template {
    public struct Literal: Sendable, Hashable {
        public let characters: String

        public init(_ text: String) {
            var characters = ""
            characters.reserveCapacity(text.utf8.count)
            var scalars = text.unicodeScalars.makeIterator()
            var pending = scalars.next()
            while let scalar = pending {
                pending = scalars.next()
                switch scalar {
                case "\\":
                    characters.append("\\\\")
                case "`":
                    characters.append("\\`")
                case "$" where pending == "{":
                    characters.append("\\$")
                case "\r":
                    characters.append("\\r")
                default:
                    characters.unicodeScalars.append(scalar)
                }
            }
            self.characters = characters
        }
    }
}
