# Cordova Apple Watch Communication Plugin

This plugin simplifies bidirectional communication between a Cordova application and a WatchKit app for Apple Watch. It uses WatchConnectivity to exchange messages between both applications.

## Features

- Send messages from the Cordova app to the WatchKit app
- Send messages from the WatchKit app to the Cordova app

## Installation

To install the plugin, run the following command in your Cordova project directory:

```bash
cordova plugin add cordova-plugin-apple-watch-communication
```

## Usage

### Sending messages from the Cordova app to the WatchKit app

In your Cordova application, you can use the plugin to send messages to the WatchKit app:

```javascript
cordova.plugins.AppleWatchCommunication.sendMessage({"key": "value"}, successCallback, errorCallback);
```

Replace `"key"` and `"value"` with the key-value pair you want to send to the WatchKit app. The `successCallback` function will be called if the message is successfully sent, while the `errorCallback` function will be called if there is an error during the process.

### Receiving messages from the WatchKit app

In your Cordova application, you can add an event listener to receive messages from the WatchKit app:

```javascript
document.addEventListener("messageFromWatch", function(event) {
    // Handle the message from the WatchKit app
    console.log("Received message from watch:", event.detail);
}, false);
```

### Sending messages from the WatchKit app to the Cordova app

In your WatchKit app, you can use the following code to send a message to the Cordova app:

```swift
if WCSession.default.isReachable {
    WCSession.default.sendMessage(["key": "value"], replyHandler: nil, errorHandler: { error in
        print("Error sending message: \(error.localizedDescription)")
    })
}
```

Replace `"key"` and `"value"` with the key-value pair you want to send to the Cordova app.

## Example

### Sending a message from the Cordova app to the WatchKit app

To send an updated text message to the WatchKit app, you can use the following code in your Cordova app:

```javascript
cordova.plugins.AppleWatchCommunication.sendMessage({"updatedText": "Hello, Apple Watch!"}, function() {
  console.log("Message sent successfully");
}, function(error) {
  console.error("Error sending message:", error);
});
```

### Receiving a message from the WatchKit app in the Cordova app

To receive messages from the WatchKit app in your Cordova app:

```javascript
document.addEventListener("messageFromWatch", function(event) {
    // Handle the message from the WatchKit app
    console.log("Received message from watch:", event.detail);
}, false);
```

### Sending a message from the WatchKit app to the Cordova app

To send a message from the WatchKit app to the Cordova app, use the following code in your WatchKit app:

```swift
if WCSession.default.isReachable {
    WCSession.default.sendMessage(["responseText": "Hello, Cordova app!"], replyHandler: nil, errorHandler: { error in
        print("Error sending message: \(error.localizedDescription)")
    })
}
```

In your WatchKit app, make sure you have implemented the `WCSessionDelegate` protocol and handle the incoming message in the `session(_:didReceiveMessage:replyHandler:)` method.