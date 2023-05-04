# RXKit ![Cocoapods](https://img.shields.io/cocoapods/v/RXKit.svg)

使用RxSwift提供一套完整开发工具。

## 链式调用

设置背景色和布局
```swift
        UIView.rx.new
            .set(by: \.backgroundColor, .white)
            .add2(self).layout { mk in
                mk.edges.equalToSuperview()
            }
```
响应式修改属性值
```swift
        UIView.rx.new
            .set(by: \.backgroundColor, .just(.red))
            .add2(self).layout { mk in
                mk.edges.equalToSuperview()
            }
```
## 容器管理

注册
```swift
        RXContainer.shared.register { _ in 
            return UIViewController()
        }
```

使用
```swift
RXContainer.shared.resolve(UIViewController.self)
```
        

## TODO
1. 声明式RXView
2. RXPreview预览uiview



## 结构
### 依赖
- RxSwift 响应式
- SnapKit 布局
### Example
xcodegen 生成项目
