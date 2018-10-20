# Spatial
Definition: **Spatial** | ˈspeɪʃ(ə)l | adjective | **describes how objects fit together in space**

<img width="995" alt="img" src="https://rawgit.com/stylekit/img/master/IMG_5168.JPG">

### What is it
Hassle-free AutoLayout, tailored for interactivity and animation.

### How does it work
- Spatial is just extensions and enums which enable you to write less boilerplate code
- Spatial is interchangeable with Vanilla AutoLayout
- Spatial comes with many examples how you can animate with AutoLayout
- Spatial uses plain and simple math under the hood. Spatial is only 400 LOC

### How do I get it
- Carthage (Coming soon)
- Download and Drag and drop into XCode
- CocoaPod (Not coming soon, 🔥 CocoaPod can burn in hell 🔥)

### Competition:
- Carthography https://github.com/robb/Cartography , codebeat, loc , stars
- TinyConstraint https://github.com/roberthein/TinyConstraints , codebeat, loc, stars
- Apple NSLayoutConstraint SDK API, Pros: Raw power, Cons: Extremely verbose; tedious to write; difficult to read
- Neon https://github.com/mamaral/Neon, great visual examples
- Anchors https://github.com/onmyway133/Anchors, sickest layout DSL out there, but too magical and alien for some.
### Example:

```swift
button.constrain { view in
	return (stretch:(w:100,h:100),pin:(to:view.parent, at:.topLeft, pivot:.topLeft,inset:UIEdgeInset))//x:.left, y:.top
}
```
### Todo:
- Add support for aligning multiple views, something like:

```swift
constrain([view1, view2, view3]) { views in
    align(top: views)
}
```

- Add support for distribute:

```swift
//bring margin into the fold as well:
//this just sets the x/y to fit the distribution
constrain([view1, view2, view3]) { views in
    views.distribute(.horizontally, to:container, align:.center, spacing:10, offset:CGPoint(x:0,y:0))//spacing
		views.distribute(.horizontally, to:container, align:.center, inset:10, offset:CGPoint(x:0,y:0))//pinned to sides
}
```

- Add support for stacking

```swift
//this changes the w/h to fit the size
//take a look at your flex lib
let views = [logo, title, description]
superview.stack(views, axis: .vertical, spacing: 10)
```

- Research priority and relation

- UIEdgeInset instead of CGRect CGSize CGPoint etc? `UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);`

- support for syntax such as: `make.width.height.equalTo(50) make.center.equalTo(self.view)`

- inset instead of margin `.inset(UIEdgeInsetsMake(20, 20, 20, 20)`

- Syntax such as: `box.size = box.superview.frame.size` and `box.pin = .pin(to:box.superview.,align:.topLeft)`

- Add support for `box.topLeft = box.superview.topLeft.inset(20)` and `box.width = box.superview.width.inset(20)` and `box.size = box.superview.size.inset(20)` 👌

- Ability to store constraint: `let constraint:NSLayoutConstraint = box.superview.topLeft.constraint`

- and `let c: [NSLayoutConstraint] = view.bb.left().top().constraints`

- support for aspectRatio and fit etc, perfect for images

- add support for filling: `box.fill(box.superview, inset: 20)`

- `[box1,box2,box3].left = container.left` and `[box1,box2,box3].distribute(.ver,to:container,gap:10)`

- `distributeX(), distributeY(), distributeXEqualSpacing(), distributeYEqualSpacing()`

- collect many constraints:  (similar to sindres with magic)

```swift
let constraints: [NSLayoutConstraint] = group {
    view1.bb.fill()
    view2.bb.left().top().size(100)
    view3.bb.fillBottom().height(100)
}
```

- `view.edgesToSuperView(insets: .top(10) + .left(10))` and `view.center(in: superview, offset: CGPoint(x: 10, y: 10))`

- Syntax like: `View.pin(to:parent,align:(.lr,.tb),offset:p)
View.stretch(to:parent,hor)`

- Maybe use Sindres with trick in this library, or maybe its perfect for Chaplin
