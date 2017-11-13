//
//  ViewController.swift
//  WebviewDemo
//
//  Created by 花志雄 on 2017/11/8.
//  Copyright © 2017年 花志雄. All rights reserved.
//

import UIKit

import Starscream

class ViewController: UIViewController, WebSocketDelegate {
    
    var socket: WebSocket!
    @IBOutlet weak var myWebview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        socket = WebSocket(url: URL(string: "ws://tools.ziellon.net:9000/")!)
//        socket = WebSocket(url: URL(string: "ws://localhost:8080/")!, protocols: ["chat","superchat"])
        socket.delegate = self
        print("TRYING TO CONNECT")
        socket.connect()
        print("DONE TRYING")

//        socket = WebSocket(url: URL(string: "ws://tools.ziellon.net:9000/")!)
//        //websocketDidConnect
//        socket.onConnect = {
//            print("websocket is connected")
//        }
//        //websocketDidDisconnect
//        socket.onDisconnect = { (error: Error?) in
//            print("websocket is disconnected: \(error?.localizedDescription)")
//        }
//        //websocketDidReceiveMessage
//        socket.onText = { (text: String) in
//            print("got some text: \(text)")
//        }
//        //websocketDidReceiveData
//        socket.onData = { (data: Data) in
//            print("got some data: \(data.count)")
//        }
//        //you could do onPong as well.
//        socket.connect()





//        let request = URLRequest(url: URL(string: "http://www.google.com")!)
        let request = URLRequest(url: URL(string: "http://g1.misa.com.tw/python/rfid_warrning_list.php")!)

        myWebview.loadRequest(request)

    }
    
    //以下5個function是WebSocketDelegate所要implement的function
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocketDidConnect")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocketDidDisconnect")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("websocketDidReceiveMessage")
        print("Received text: \(text)")
        
//        if let data = text.data(using: .utf8) {
//
//            //2.把JSON資料轉換成JsonObject的格式，3.再把JsonObject的格式轉換成String: Any的dictionary Array
//            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers), let articleDictionary = jsonObject as? [String: Any] {
//
//                    print("\(articleDictionary)")
//
//
//            }
//            else {
//                print("error1")
//            }
//        }
//        else {
//            print("error2")
//        }
        
        if let jsonObject = convertToDictionary(text: text) {

            debugPrint("\(jsonObject)")

            if let detail = jsonObject["detail"] as? String, let type = jsonObject["type"] as? String,
                let priority = jsonObject["priority"] as? Int, let time_stamp = jsonObject["time_stamp"] as? Double {

                debugPrint("detail --> \(detail)")
                debugPrint("type --> \(type)")
                debugPrint("priority --> \(priority)")
                debugPrint("time_stamp --> \(time_stamp)")
            }
        }

    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("websocketDidReceiveData")
    }
    
    func websocketDidReceivePong(socket: WebSocketClient, data: Data?) {
        print("Got pong! Maybe some data: \(String(describing: data?.count))")
    }
    
    
//    var socket: WebSocket!

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.socket = WebSocket(url: URL(string: "ws://tools.ziellon.net:9000/")!)
//        self.socket.delegate = self
//        print("TRYING TO CONNECT")
//        self.socket.connect()
//        print("DONE TRYING")
//    }
    
    
    //convert String to JSONObject Dictionary
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    //convert String to JSONObject Dictionary Array
    func convertToDictionaries(text: String) -> [[String: Any]]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    


}

