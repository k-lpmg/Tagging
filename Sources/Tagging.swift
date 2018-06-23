//
//  Tagging.swift
//  Tagging
//
//  Created by DongHeeKang on 2018. 6. 16..
//  Copyright © 2018년 k-lpmg. All rights reserved.
//

import UIKit
import Foundation

public protocol TaggingDataSource: NSObjectProtocol {
    func tagging(_ tagging: Tagging, didChangedTagableList tagableList: [String])
    func tagging(_ tagging: Tagging, didChangedTaggedList taggedList: [TaggingModel])
}

open class Tagging: UIView {
    
    // MARK: - Properties
    
    private var currentTaggingText: String? {
        didSet {
            guard let currentTaggingText = currentTaggingText, let tagableList = tagableList else {return}
            let matchedTagableList = tagableList.filter {
                $0.contains(currentTaggingText.lowercased()) || $0.contains(currentTaggingText.uppercased())
            }
            dataSource?.tagging(self, didChangedTagableList: matchedTagableList)
        }
    }
    private var currentTaggingRange: NSRange?
    private var tagRegex: NSRegularExpression! {return try! NSRegularExpression(pattern: "\(symbol)([^\\s\\K]+)")}
    
    public private(set) var taggedList: [TaggingModel] = []
    public weak var dataSource: TaggingDataSource?
    
    open var symbol: String = "@"
    open var tagableList: [String]?
    open var defaultAttributes: [NSAttributedStringKey: Any] = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        return [NSAttributedStringKey.foregroundColor: UIColor.black,
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15),
                NSAttributedStringKey.paragraphStyle: paragraphStyle,
                NSAttributedStringKey.underlineStyle: NSNumber(value: 0)]
    }()
    open var taggedAttributes: [NSAttributedStringKey: Any] = {return [NSAttributedStringKey.underlineStyle: NSNumber(value: 1)]}()
    
    // MARK: - UI Components
    
    open let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Con(De)structor
    
    public init() {
        super.init(frame: .zero)
        
        commonSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonSetup()
    }
    
    // MARK: - Public methods
    
    public func updateTaggedList(allText: String, tagText: String) {
        guard let range = currentTaggingRange else {return}
        
        let origin = (allText as NSString).substring(with: range)
        let tag = tagFormat(tagText)
        let replace = tag.appending(" ")
        let changed = (allText as NSString).replacingCharacters(in: range, with: replace)
        let tagRange = NSMakeRange(range.location, tag.count)
        
        taggedList.append(TaggingModel(text: tagText, range: tagRange))
        for i in 0..<taggedList.count-1 {
            var location = taggedList[i].range.location
            let length = taggedList[i].range.length
            if location > tagRange.location {
                location += replace.count - origin.count
                taggedList[i].range = NSMakeRange(location, length)
            }
        }
        
        textView.text = changed
        updateAttributeText(selectedLocation: range.location+replace.count)
        dataSource?.tagging(self, didChangedTaggedList: taggedList)
    }
    
    // MARK: - Private methods
    
    private func commonSetup() {
        setProperties()
        addSubview(textView)
        layout()
    }
    
    private func setProperties() {
        textView.delegate = self
    }
    
    private func tagFormat(_ text: String) -> String {
        return symbol.appending(text)
    }
    
}

// MARK: - Layout

extension Tagging {
    
    private func layout() {
        addConstraints(
            [NSLayoutConstraint(item: textView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0),
             NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
             NSLayoutConstraint(item: textView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0),
             NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)])
    }
    
}

// MARK: - UITextViewDelegate

extension Tagging: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        tagging(textView: textView)
        updateAttributeText(selectedLocation: textView.selectedRange.location)
    }
    
    public func textViewDidChangeSelection(_ textView: UITextView) {
        tagging(textView: textView)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        updateTaggedList(range: range, textCount: text.utf16.count)
        return true
    }
    
}

// MARK: - Tagging Algorithm

extension Tagging {
    
    private func matchedData(taggingCharacters: [Character], selectedLocation: Int, taggingText: String) -> (NSRange?, String?) {
        var matchedRange: NSRange?
        var matchedString: String?
        let tag = String(taggingCharacters.reversed())
        let textRange = NSMakeRange(selectedLocation-tag.count, tag.count)
        
        guard tag == symbol else {
            let matched = tagRegex.matches(in: taggingText, options: .reportCompletion, range: textRange)
            if matched.count > 0, let range = matched.last?.range {
                matchedRange = range
                matchedString = (taggingText as NSString).substring(with: range).replacingOccurrences(of: symbol, with: "")
            }
            return (matchedRange, matchedString)
        }
        
        matchedRange = textRange
        matchedString = symbol
        return (matchedRange, matchedString)
    }
    
    private func tagging(textView: UITextView) {
        let selectedLocation = textView.selectedRange.location
        let taggingText = (textView.text as NSString).substring(with: NSMakeRange(0, selectedLocation))
        let space: Character = " "
        let lineBrak: Character = "\n"
        var tagable: Bool = false
        var characters: [Character] = []
        
        for char in Array(taggingText).reversed() {
            if char == symbol.first {
                characters.append(char)
                tagable = true
                break
            } else if char == space || char == lineBrak {
                tagable = false
                break
            }
            characters.append(char)
        }
        
        guard tagable else {
            currentTaggingRange = nil
            currentTaggingText = nil
            return
        }
        
        let data = matchedData(taggingCharacters: characters, selectedLocation: selectedLocation, taggingText: taggingText)
        currentTaggingRange = data.0
        currentTaggingText = data.1
    }
    
    private func updateAttributeText(selectedLocation: Int) {
        let attributedString = NSMutableAttributedString(string: textView.text)
        attributedString.addAttributes(defaultAttributes, range: NSMakeRange(0, textView.text.utf16.count))
        taggedList.forEach { (model) in
            let underLineRange = NSMakeRange(model.range.location+1, model.range.length-1)
            attributedString.addAttributes(taggedAttributes, range: underLineRange)
        }
        
        textView.attributedText = attributedString
        textView.selectedRange = NSMakeRange(selectedLocation, 0)
    }
    
    private func updateTaggedList(range: NSRange, textCount: Int) {
        taggedList = taggedList.filter({ (model) -> Bool in
            if model.range.location < range.location && range.location < model.range.location+model.range.length {
                return false
            }
            if range.length > 0 {
                if range.location <= model.range.location && model.range.location < range.location+range.length {
                    return false
                }
            }
            return true
        })
        
        for i in 0..<taggedList.count {
            var location = taggedList[i].range.location
            let length = taggedList[i].range.length
            if location >= range.location {
                if range.length > 0 {
                    if textCount > 1 {
                        location += textCount - range.length
                    } else {
                        location -= range.length
                    }
                } else {
                    location += textCount
                }
                taggedList[i].range = NSMakeRange(location, length)
            }
        }
        
        currentTaggingText = nil
        dataSource?.tagging(self, didChangedTaggedList: taggedList)
    }
    
}
