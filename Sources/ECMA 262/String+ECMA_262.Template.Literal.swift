extension String {
    public init(_ literal: ECMA_262.Template.Literal) {
        self = "`" + literal.characters + "`"
    }
}
