import Testing

@testable import ECMA_262

enum `ECMA_262.Template.Literal Tests` {}

extension `ECMA_262.Template.Literal Tests` {
    @Suite
    struct `Escaping` {
        @Test
        func `text without template syntax is written as it is`() {
            #expect(String(ECMA_262.Template.Literal("<p>Count: 1</p>")) == "`<p>Count: 1</p>`")
            #expect(ECMA_262.Template.Literal("").characters.isEmpty)
        }

        @Test
        func `a backslash and a backtick are escaped`() {
            #expect(ECMA_262.Template.Literal("a\\b").characters == "a\\\\b")
            #expect(ECMA_262.Template.Literal("a`b").characters == "a\\`b")
        }

        @Test
        func `a dollar sign is escaped only before an opening brace`() {
            #expect(ECMA_262.Template.Literal("${x}").characters == "\\${x}")
            #expect(ECMA_262.Template.Literal("$x $ {").characters == "$x $ {")
            #expect(ECMA_262.Template.Literal("$$").characters == "$$")
            #expect(ECMA_262.Template.Literal("$${").characters == "$\\${")
        }

        @Test
        func `a carriage return is escaped because a template reads it as a line feed`() {
            #expect(ECMA_262.Template.Literal("a\rb").characters == "a\\rb")
            #expect(ECMA_262.Template.Literal("a\r\nb").characters == "a\\r\nb")
        }

        @Test
        func `line and paragraph separators and line feeds stay as they are`() {
            #expect(ECMA_262.Template.Literal("a\u{2028}b\u{2029}c\nd").characters == "a\u{2028}b\u{2029}c\nd")
        }

        @Test
        func `a backtick or backslash followed by a combining mark is still escaped`() {
            #expect(ECMA_262.Template.Literal("`\u{0301}").characters == "\\`\u{0301}")
            #expect(ECMA_262.Template.Literal("\\\u{0301}").characters == "\\\\\u{0301}")
        }
    }
}
