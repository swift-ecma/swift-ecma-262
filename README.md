# swift-ecma-262

Use this package when you write text into JavaScript source, as ECMA-262 (the ECMAScript Language Specification) defines it. It has one entry point so far: `ECMA_262.Template.Literal(text)` turns any text into the characters of a template literal, and `String(_:)` adds the two backticks. The result can go into a script as it is.

## Laws

- The cooked value of the template literal is the given text, scalar for scalar.
- `\` and `` ` `` are always escaped. `$` is escaped only when `{` follows it, the one place a template literal would start a substitution.
- A carriage return is written as `\r`, because a template literal reads CR and CR LF as LF. Line feeds, U+2028 and U+2029 are left as they are, since a template literal allows them.
- The text is read as UTF-8 code units. Every character that needs an escape is ASCII, and an ASCII byte never occurs inside a multi-byte sequence, so this matches what the JavaScript lexer reads: a backtick or backslash followed by a combining mark is still escaped.
