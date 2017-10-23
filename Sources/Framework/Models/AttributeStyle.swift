enum AttributeStyle {

    case question
    case description
    case answer
    case welcome
    case enterPin
    case userName
    case commentBody
    case commentDate

}

extension AttributeStyle {

    var attributes: AttributesDescriptor {
        switch self {
        case .question:
            return AttributesDescriptor(textStyle: .question, alignment: .center, lineSpacing: 10.0)
        case .description:
            return AttributesDescriptor(textStyle: .description, alignment: .left, lineSpacing: 5.0)
        case .answer:
            return AttributesDescriptor(textStyle: .answer)
        case .welcome:
            return AttributesDescriptor(textStyle: .welcome, alignment: .center)
        case .enterPin:
            return AttributesDescriptor(textStyle: .enterPin)
        case .userName:
            return AttributesDescriptor(textStyle: .userName)
        case .commentBody:
            return AttributesDescriptor(textStyle: .commentBody, alignment: .left, lineSpacing: 3.0)
        case .commentDate:
            return AttributesDescriptor(textStyle: .commentDate)
        }
    }

}
