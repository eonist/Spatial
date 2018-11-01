# Spatial
Definition: **Spatial** | ˈspeɪʃ(ə)l | adjective | **describes how objects fit together in space**

<img width="900" alt="img" src="https://rawgit.com/stylekit/img/master/spatial_github.svg">

### What is it
Hassle-free AutoLayout, tailored for interactivity and animation.

### How does it work
- Spatial is just extensions and enums which enable you to write less boilerplate code
- Spatial is interchangeable with Vanilla AutoLayout
- Spatial comes with examples how you can animate with AutoLayout
- Spatial uses plain and simple math under the hood.

### How do I get it
- Carthage `github "eonist/Spatial"`
- Manual Open `Spatial.xcodeproj`
- CocoaPod (Coming soon)

### Example:

```swift
bt1.activateConstraint{ view in
   let anchor = Constraint.anchor(view, to: self, align: .topLeft, alignTo: .topLeft)
   let size = Constraint.size(view, size: CGSize.init(width: 96, height: 24))
   return [anchor.x,anchor.y,size.w,size.h]
}
```

```swift
[btn1,btn2,btn3].activateConstraint { views in
   let anchors = Constraint.distribute(vertically: views, align: .topLeft)
   let sizes = views.map{Constraint.size($0, size: CGSize(width:96,height:42))}
   return (anchors, sizes)
}
```

### Todo:
- Complete the spaceAround and spaceBetween methods
- Add one-liner accessors
