import Foundation
import WatchConnectivity

@objc(WatchConnectivity)
class WatchConnectivity: CDVPlugin {
    private var messageHandler: WatchMessageHandler?
    private var eventCallbackId: String?
    
    @objc(initialize:)
    func initialize(command: CDVInvokedUrlCommand) {
        if WCSession.default.isSupported() {
            messageHandler = WatchMessageHandler(commandDelegate: commandDelegate, callbackId: command.callbackId)
            WCSession.default.delegate = messageHandler
            WCSession.default.activate()
        } else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "WatchConnectivity is not supported on this device")
            commandDelegate.send(pluginResult, callbackId: command.callbackId)
        }
    }
    
    @objc(sendMessage:)
    func sendMessage(command: CDVInvokedUrlCommand) {
        guard let message = command.arguments[0] as? [String: Any] else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Invalid message format")
            commandDelegate.send(pluginResult, callbackId: command.callbackId)
            return
        }

        if WCSession.default.isReachable {
            WCSession.default.sendMessage(message, replyHandler: { response in
                let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: response)
                self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
            }, errorHandler: { error in
                let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.localizedDescription)
                self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
            })
        } else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Watch is not reachable")
            commandDelegate.send(pluginResult, callbackId: command.callbackId)
        }
    }
}
