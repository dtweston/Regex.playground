# Regex.playground
A playground for imitating Perl's regex functionality

Some quick examples of Perl's built-in regular expression handling:

```perl
my $haystack = 'This is a sentence with ises';
if ($haystack =~ /is/) {
    print "Works!"
}

while ($haystack =! /is/) {
  print "Do something with match: $0"
}
```

in Swift this becomes:

```swift
let haystack = "This is a sentence with ises"
If (haystack =~ "is") {
    print("Works!")
}

while (haystack =~ "is") {
    print("Do something with match: $0")
}
```
