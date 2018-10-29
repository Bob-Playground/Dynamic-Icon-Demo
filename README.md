# 动态更换 APP icon 示例

## 简介

系统要求：iOS 10.3+

## icon 生成

icon 生成：[图标工厂](https://icon.wuruihong.com)

## icon 的规格和存放位置

如果仅有 iPhone APP，则需要以下8种规格的图标：  

```
icon-20@2x.png
icon-20@3x.png
icon-29@2x.png
icon-29@3x.png
icon-40@2x.png
icon-40@3x.png
icon-60@2x.png
icon-60@3x.png
```

其中，`icon`是需要替换的名称，短横线后面的数字是图片的尺寸（单位：pt）。另外，`icon-1024.png`仅用于 `Assets.xcassets` 的 `AppIcon` 中，动态换 icon 时不需要。 可选 icon 图片的需要放在 `main bundle` 中，而不是 `Assets.xcassets` 中。  

## 相关 API

```swift
extension UIApplication {

    // If false, alternate icons are not supported for the current process.
    @available(iOS 10.3, *)
    open var supportsAlternateIcons: Bool { get }

    
    // Pass `nil` to use the primary application icon. The completion handler will be invoked asynchronously on an arbitrary background queue; be sure to dispatch back to the main queue before doing any further UI work.
    @available(iOS 10.3, *)
    open func setAlternateIconName(_ alternateIconName: String?, completionHandler: ((Error?) -> Void)? = nil)

    
    // If `nil`, the primary application icon is being used.
    @available(iOS 10.3, *)
    open var alternateIconName: String? { get }
}
```

## API 文档

#### supportsAlternateIcons

The value of this property is true only when the system allows you to change the icon of your app. To declare your app's alternate icons, include them in the CFBundleIcons key of your app's Info.plist file.

#### setAlternateIconName(_:completionHandler:)

`alternateIconName`  
The name of the alternate icon, as declared in the `CFBundleAlternateIcons` key of your app's Info.plist file. Specify nil if you want to display the app's primary icon, which you declare using the `CFBundlePrimaryIcon` key. Both keys are subentries of the `CFBundleIcons` key in your app's Info.plist file.  

`completionHandler`  
A handler to be executed with the results. After attempting to change your app's icon, the system reports the results by calling your handler. (The handler is executed on a UIKit-provided queue, and not necessarily on your app's main queue.)   

#### alternateIconName

When the system is displaying one of your app's alternate icons, the value of this property is the name of the alternate icon (from your app's Info.plist file). When the system is displaying your app's primary icon, the value of this property is nil.

## 参考链接

[一个写的比较详细的博客](https://blog.csdn.net/KimBing/article/details/77996756?utm_source=blogxgwz10)

[无弹框更换App图标](http://daiyi.pro/2017/05/01/ChangeYourAppIcons2/)

[About Info.plist Keys and Values](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009247)

[CFBundleIcons](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html#//apple_ref/doc/uid/TP40009249-SW13)

