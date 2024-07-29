package com.example.aniverseapp.controller;

import com.example.aniverseapp.ChatPreview;
import com.example.aniverseapp.Response;
import com.example.aniverseapp.dto.MessageDTO;
import com.example.aniverseapp.service.ChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/chat")
public class ChatController {

    @Autowired
    private ChatService chatService;

    @GetMapping("/{userId}/{otherUsername}")
    public Response<List<MessageDTO>> getChatMessages(@PathVariable Long userId, @PathVariable String otherUsername) {
        return chatService.getChatMessages(userId, otherUsername);
    }

    @PostMapping("/send")
    public Response<MessageDTO> sendMessage(@RequestParam Long senderId, @RequestParam String receiverName, @RequestParam String content) {
        return chatService.sendMessage(senderId, receiverName, content);
    }

    @GetMapping("/previews/{userId}")
    public Response<List<ChatPreview>> getChatPreviews(@PathVariable Long userId) {
        return chatService.getChatPreviews(userId);
    }

}
