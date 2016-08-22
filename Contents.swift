//: Playground - noun: a place where people can play

import UIKit

protocol Regex {
    func matches(for string: String) -> [NSTextCheckingResult]
}

class PerlRegex {
    static func new(regex: String) -> Regex {
        do {
            let nsRegex = try NSRegularExpression(pattern: regex, options: .allowCommentsAndWhitespace)
            return ValidRegex(regex: nsRegex)
        }
        catch {
            return InvalidRegex()
        }
    }
}

fileprivate class InvalidRegex: Regex {
    func matches(for string: String) -> [NSTextCheckingResult] {
        return []
    }
}

fileprivate class ValidRegex: Regex {
    let regex: NSRegularExpression

    init(regex: NSRegularExpression) {
        self.regex = regex
    }

    func matches(for string: String) -> [NSTextCheckingResult] {
        return self.regex.matches(in: string, range: NSMakeRange(0, string.characters.count))
    }
}

class Matcher {
    let regex: Regex
    let string: String

    init(regex: Regex, string: String) {
        self.regex = regex
        self.string = string
    }

    func matches() -> [NSTextCheckingResult] {
        return regex.matches(for: string)
    }
}

infix operator =~

func =~(left: String, right: String) -> Matcher {
    return Matcher(regex: PerlRegex.new(regex: right), string: left)
}

func While(_ regex: Matcher, _ exec: (NSTextCheckingResult) -> ()) {
    for match in regex.matches() {
        exec(match)
    }
}

func If(_ regex: Matcher, _ exec: () -> ()) {
    if regex.matches().count > 0 {
        exec()
    }
}

let haystack = "This is a sentence with ises"
While (haystack =~ "is") {
    print(NSStringFromRange($0.range))
}

If (haystack =~ "is") {
    print("Works!")
}
