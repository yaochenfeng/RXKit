# RXKit
使用RxSwift提供一套完整开发工具。

## 链式调用
```swift
        UIView.rx.new
            .set(by: \.backgroundColor, .white)
            .add2(self).layout { mk in
                mk.edges.equalToSuperview()
            }
```

## 结构
### 依赖
- RxSwift 响应式
- SnapKit 布局
### Example
xcodegen 生成项目
