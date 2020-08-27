import Foundation

public struct TaggingModel {
    public var text: String
    public var range: NSRange
    public var attribute: [NSAttributedString.Key: Any]
    public var symbolAttribute: [NSAttributedString.Key: Any]
}
