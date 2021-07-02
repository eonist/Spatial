# Spatial
![mit](https://img.shields.io/badge/License-MIT-brightgreen.svg)
![platform](https://img.shields.io/badge/Platform-iOS/macOS-blue.svg)
![Lang](https://img.shields.io/badge/Language-Swift%205.0-orange.svg)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift)
[![SwiftLint Sindre](https://img.shields.io/badge/SwiftLint-Sindre-hotpink.svg)](https://github.com/sindresorhus/swiftlint-sindre)
[![codebeat badge](https://codebeat.co/badges/b4ee0d27-b00c-464b-b9b2-c9906cb6c19f)](https://codebeat.co/projects/github-com-eonist-spatial-master)
![Tests](https://github.com/eonist/Spatial/workflows/Tests/badge.svg)

<img width="900" alt="img" src="https://raw.github.com/stylekit/img/master/spatial_github.svg?sanitize=true">

Definition: **Spatial** | ˈspeɪʃ(ə)l | adjective | **describes how objects fit together in space**

### What is it
Hassle-free AutoLayout, tailored for interactivity and animation. Created for how our mental model thinks autolayout works. Not optimized for brevity.

### How does it work
- Spatial is just extensions and enums which enable you to write less boilerplate code
- Spatial is interchangeable with Vanilla AutoLayout
- Spatial comes with examples how you can animate with AutoLayout
- Spatial uses plain and simple math under the hood.

### How do I get it
- SPM `"https://github.com/eonist/Spatial.git"` `"master"`
- Manual Open `Spatial.xcodeproj`

### Example:

```swift
// One-liner, single
btn1.anchorAndSize(to: self, width: 96, height: 24)
// Info regarding parameters and their meaning and effects
btn1.anchorAndSize(to: button, // to what other AutoLayout element should self anchor and size to
						sizeTo: self, // inherit size of another AutoLayout element, overrides to param
						width: 100, // override sizeTo with constant
						height: 50, // override sizeTo with constant
						align: .topCenter, // decides where the pivot of self should be
						alignTo: .bottomCenter, // decides to where self should pivot to
						multiplier: .init(width: 1, height: 1), // multiply sizeTo, or constants
						offset: .init(x: 0, y: 20), // append constant to current position
						sizeOffset: .init(width: -20, height: 0), // append constant to current size
					   useMargin: false) // adher to other autolayouts margin

// Long-hand, single
btn1.activateAnchorAndSize { view in
	let a = Constraint.anchor(view, to: self)
	let s = Constraint.size(view, width: 96, height: 24)
	return (a, s)
}
```

```swift
// Short-hand, bulk
[btn1, btn2, btn3].distributeAndSize(dir: .vertical, width: 96, height: 24)

// Long-hand, bulk
[btn1,btn2,btn3].activateAnchorsAndSizes { views in
   let anchors = Constraint.distribute(vertically: views, align: .topLeft)
   let sizes = views.map { Constraint.size($0, size: .init(width: 96, height: 42)) }
   return (anchors, sizes)
}
```

```swift
// Pin something between something
$0.activateConstraints { view in
   let tl = Constraint.anchor(view, to: self, align: .topLeft, alignTo: .topLeft)
   let br = Constraint.anchor(view, to: viewFinderView, align: .bottomRight, alignTo: .topRight)
   return [tl.x, tl.y, br.x, br.y] // pins a view to the TR of the parent and BL of another sibling-view
}
```

```swift
// Animation
btn.animate(to: 100,align: left, alignTo: .left)
```

```swift
// Distribute
// |[--][--][--][--][--]|
[label1, label2, label3].activateAnchorsAndSizes { views in // for anim: applyAnchorsAndSizes
   let anchors = Constraint.distribute(vertically: views, align: .left) // there is also: horizontally
   let sizes = views.map{ Constraint.size($0, toView: self.frame.width, height: 48)) }
   return (anchors, sizes)
}
```

```swift
// SpaceAround
// |--[]--[]--[]--[]--[]--|
let views: [ConstraintView] = [UIColor.purple, .orange, .red].map {
   let view: ConstraintView = .init(frame: .zero)
   self.addSubview(view)
   view.backgroundColor = $0
   return view
}
views.applySizes(width: 120, height: 48)
views.applyAnchors(to: self, align: .top, alignTo: .top, offset: 20)
views.spaceAround(dir: .hor, parent: self)
```

```swift
// Space between
// |[]--[]--[]--[]--[]|
views.applySizes(width: 120, height: 48)
views.applyAnchors(to: self, align: .top, alignTo: .top, offset: 20)
views.spaceBetween(dir: .horizontal, parent: self, inset:x)
```

### Todo:
- Complete the spaceAround and spaceBetween methods ✅
- Add macOS support ✅
- Make examples with AutoLayout margins not
- Add methods for applyAnchor for horizontal and vertical types
- Document every param in every declaration (Since the API is more stable now) 👈
- Consider renaming anchor and size to pin and fit
