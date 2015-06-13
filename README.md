# AppExtensionsDemo

## Introduction

This is an example project for getting familiary with App Extensions, introduced in iOS 8.

## Checklist

- [x] Basic app with Today widget working
- [x] Can open host application
- [x] Setting up shared container
- [x] Two-way data updates
- [ ] Snapshotting
- [ ] Experimenting with multiple Today widgets
- [ ] Adding different data stores

## Discussion

### Project setup 🚧

Extensions in iOS cannot exist without a container app. This leads to the following structure:

* [AppExtensionsDemo](https://github.com/jozsef-vesza/AppExtensionsDemo/tree/master/AppExtensionsDemo): The main app, and container project.
* [SegmentedToday](https://github.com/jozsef-vesza/AppExtensionsDemo/tree/master/SegmentedToday): The Today widget.
* [TodoKit](https://github.com/jozsef-vesza/AppExtensionsDemo/tree/master/TodoKit): An embedded framework for shared code.

### Creating an extension 🐣

This step is relatively straightforward. All you have to do is add a new target to your existing project.

### Sharing code ♻️

In order to share code between an app, and its extension, you can create embedded frameworks (also an iOS 8 addition).

It's important to remember, that extensions work with a restricted API, and in this case, the restriction also applies to any embedded frameworks. Make sure you set "Require Only App-Extension-Safe API" on your extension target to "Yes".

### Sharing data 💾

Your extension may be bundled together with the container app, but this doesn't mean they have direct access to each other's data.

In order to enable data sharing, you'll have to add both targets to a common app group. Enable App Groups in each target's Capabilities screen, and specify an identifier. 

You can verify your configuration later by checking the Entitlements file for your targets:

```xml
<dict>
	<key>com.apple.security.application-groups</key>
	<array>
		<string>group.your-bundle-id</string>
	</array>
</dict>
```

From this point, you have multiple ways to store data, including Core Data, files or user defaults. An example for saving to user defaults:

```swift

func saveItems(items: [YourModel]) {

	let appGroupId = "group.your-bundle-id"
	let defaults = NSUserDefaults(suiteName: appGroupId)

	defaults?.setValue(items, forKey: savedDataKey)
	defaults?.synchronize()
}
```

### Synchronizing state 😎

This is the tricky part. Now our app, and extension share code and data, but this doesn't mean they are automatically updated.

Extensions and container apps are separate processes, which means, methods, such as listening to `NSUserDefaultsDidChangeNotification` is not very helpful.

My solution was the following:

Since the extension, and its container don't have direct access to each other, in-memory state management didn't seem like a good idea. So instead of providing accessors, the store exposes method calls, which go _directly_ to `NSUserDefaults`:

```swift
public struct ShoppingItemStore: ShoppingStoreType {
    
    public func items() -> [ShoppingItem] {
        
        if let loaded = loadItems() {
            return loaded
        }
        
        return defaultItems
    }
    
    public func toggleItem(item: ShoppingItem) {
        
        let initial = items()
        
        let updated = initial.map { original -> ShoppingItem in
            return original == item ?
                ShoppingItem(name: original.name, status: !original.status) : original
        }
        
        saveItems(updated)
    }
    
    private func saveItems(items: [ShoppingItem]) {
        
        let boxedItems = items.map { item -> [String : Bool] in
            return [item.name : item.status]
        }
        
        defaults?.setValue(boxedItems, forKey: savedDataKey)
        defaults?.synchronize()
    }
    
    private func loadItems() -> [ShoppingItem]? {
        
        if let loaded = defaults?.valueForKey(savedDataKey) as? [[String : Bool]] {
            
            let unboxed = loaded.map { dict -> ShoppingItem in
                
                return ShoppingItem(name: dict.keys.first!, status: dict.values.first!)
            }
            
            return unboxed
        }
        
        return nil
    }
}
```

This makes sure that there is no invalid state kept in memory.

The second trick is noticing how interacting with the notification center triggers lifecycle events.

Whenever the user pulls down the notification center, your widget's view controller will receive a `viewWillAppear(_:)` call, making it a good place to update your UI.

However, the same is not true for your container app. When the user dismisses the notification center, your container's application delegate will receive the `applicationDidBecomeActive(_:)` call. You can post a notification here:

```swift
let updateDataNotification = "updateNeeded"

func applicationDidBecomeActive(application: UIApplication) {
   NSNotificationCenter.defaultCenter().postNotificationName(updateDataNotification, object: nil)
}
```

And subscribe in your view controllers, to trigger the update:

```swift
override func viewWillAppear(animated: Bool) {
   super.viewWillAppear(animated)
        
   NSNotificationCenter.defaultCenter().addObserverForName(updateDataNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (_) -> Void in
       // reload UI
   }
}
```

### Conclusion

Extensions are definitely a welcome improvement. Although dealing with them is not necessarily difficult, but there are definitely some tricky parts. 

I am really hoping for improved data sharing (perhaps some IPC hooks). In the meantime, you can use third party tools, such as [MMWormhole](https://github.com/mutualmobile/MMWormhole) to ease the process. 😉

### Resources

* [App extension programming guide](https://developer.apple.com/library/ios/documentation/General/Conceptual/ExtensibilityPG/)
* [Sharing data between iOS apps and app extensions](http://www.atomicbird.com/blog/sharing-with-app-extensions)
* [Sharing NSUserDefaults between your app and a Today Extension on iOS 8](http://tapadoo.com/2014/sharing-nsuserdefaults-between-your-app-and-a-today-extension-on-ios-8/)

