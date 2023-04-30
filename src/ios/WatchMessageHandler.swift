import Foundation
import WatchConnectivity

class WatchMessageHandler: NSObject, WCSessionDelegate {
    private weak var commandDelegate: CDVCommandDelegate?
    private var callbackId: String?

    init(commandDelegate: CDVCommandDelegate?, callbackId: String?) {
        self.commandDelegate = commandDelegate
        self.callbackId = callbackId
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // ...
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        // ...
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // ...
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        if let callbackId = self.callbackId {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: message)
            pluginResult?.setKeepCallbackAs(true)
            self.commandDelegate?.send(pluginResult, callbackId: callbackId)
        }
        replyHandler(["response": "Message received"])
    }
}
