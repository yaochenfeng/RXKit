//
//  NSMutableAttributedString+Rx.swift
//  RXKit
//
//  Created by yaochenfeng on 2023/3/22.
//

#if canImport(UIKit)
import UIKit
public extension Reactive where Base: NSMutableAttributedString {
    /// 替换属性
    func add(_ attribute: [NSAttributedString.Key: Any], range: NSRange) -> Self {
        base.addAttributes(attribute, range: range)
        return self
    }
    /// 添加属性
    func add(_ key: NSAttributedString.Key, value: Any?, range: NSRange) -> Self {
        if let value = value {
            base.addAttribute(key, value: value, range: range)
        } else {
            base.removeAttribute(key, range: range)
        }
        return self
    }
    /// 字体
    func font(_ font: UIFont, range: NSRange) -> Self {
        base.addAttributes([NSAttributedString.Key.font: font], range: range)
        return self
    }
    /// 颜色
    func color(_ color: UIColor, range: NSRange) -> Self {
        base.addAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
        return self
    }
    /// 背景色
    func bgColor(_ color: UIColor, range: NSRange) -> Self {
        base.addAttributes([NSAttributedString.Key.backgroundColor: color], range: range)
        return self
    }
    /// 链接
    func link(_ value: String, range: NSRange) -> Self {
        guard let url = URL(string: value) else { return self }
        return linkURL(url, range: range)
    }
    /// 链接
    func linkURL(_ value: URL, range: NSRange) -> Self {
        base.addAttributes([NSAttributedString.Key.link: value], range: range)
        return self
    }
    /// 设置字体倾斜度，取值为float，正值右倾，负值左倾 ios16有问题
    func oblique(_ value: CGFloat = 0.1, range: NSRange) -> Self {
        base.addAttributes([NSAttributedString.Key.obliqueness: value], range: range)
        return self
    }
    
    /// 字符间距
    func kern(_ value: CGFloat, range: NSRange) -> Self {
        base.addAttributes([.kern: value], range: range)
        return self
    }
    
    /// 设置字体的横向拉伸，取值为float，正值拉伸 ，负值压缩
    func expansion(_ value: CGFloat, range: NSRange) -> Self {
        base.addAttributes([.expansion: value], range: range)
        return self
    }
    
    /// 设置下划线
    func underline(_ style: NSUnderlineStyle = .single, _ color: UIColor, range: NSRange) -> Self {
        base.addAttributes([
            .underlineColor: color,
            .underlineStyle: style.rawValue
        ], range: range)
        return self
    }
    
    /// 设置删除线
    func strikethrough(_ style: NSUnderlineStyle = .single, _ color: UIColor, range: NSRange) -> Self {
        base.addAttributes([
            .strikethroughColor: color,
            .strikethroughStyle: style.rawValue,
        ], range: range)
        return self
    }
    
    /// 设置删除线
    func stroke(_ color: UIColor, _ value: CGFloat = 0, range: NSRange) -> Self {
        base.addAttributes([
            .strokeColor: color,
            .strokeWidth: value,
        ], range: range)
        return self
    }
    
    /// 设置基准位置 (正上负下)
    func baseline(_ value: CGFloat, range: NSRange) -> Self {
        base.addAttributes([.baselineOffset: value], range: range)
        return self
    }
    
    /// 设置段落
    func paraStyle(_ alignment: NSTextAlignment,
                   lineSpacing: CGFloat = 0,
                   paragraphSpacingBefore: CGFloat = 0,
                   lineBreakMode: NSLineBreakMode = .byTruncatingTail,
                   range: NSRange) -> Self {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        style.lineBreakMode = lineBreakMode
        style.lineSpacing = lineSpacing
        style.paragraphSpacingBefore = paragraphSpacingBefore
        base.addAttributes([.paragraphStyle: style], range: range)
        return self
    }
    
    /// 设置段落
    func paragraphStyle(_ style: NSMutableParagraphStyle, range: NSRange) -> Self {
        base.addAttributes([.paragraphStyle: style], range: range)
        return self
    }
}
public extension Reactive where Base == NSAttributedString {
    /// 可编辑
    var edit: Reactive<NSMutableAttributedString> {
        if let mt = base as? NSMutableAttributedString {
            return mt.rx
        } else {
            return NSMutableAttributedString(attributedString: base).rx
        }
    }
}
/// 获取富文本
public extension Reactive where Base: NSAttributedString {
    /// 获取附件
    func richTextAttachments() -> [NSTextAttachment] {
        var attachments: [NSTextAttachment] = []
        base.enumerateAttribute(.attachment, in: .init(location: 0, length: base.length), options: .longestEffectiveRangeNotRequired) { value, _, _ in
            if let value = value as? NSTextAttachment {
                attachments.append(value)
            }
        }
        return attachments
    }
    ///  range所选区域的所在段落
    func parapraghRange(for range: NSRange) -> NSRange {
        let string = NSString(string: base.string)
        var star: Int = 0
        var end: Int = 0
        var ptr: Int = 0
        string.getParagraphStart(&star, end: &end, contentsEnd: &ptr, for: range)
        return .init(location: star, length: end - star)
    }
}
#endif
