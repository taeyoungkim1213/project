package com.bitstudy.app.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler {
}
