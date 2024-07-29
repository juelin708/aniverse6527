package com.example.aniverseapp.service;

import com.example.aniverseapp.dao.Message;
import com.example.aniverseapp.dao.User;
import com.example.aniverseapp.dao.MessageRepository;
import com.example.aniverseapp.dao.UserRepository;
import com.example.aniverseapp.Response;
import com.example.aniverseapp.converter.MessageConverter;
import com.example.aniverseapp.ChatPreview;
import com.example.aniverseapp.dto.MessageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ChatService {

    @Autowired
    private MessageRepository messageRepository;

    @Autowired
    private UserRepository userRepository;

    public Response<List<MessageDTO>> getChatMessages(Long userId, String otherUsername) {
        User user1 = userRepository.findById(userId).orElse(null);
        User user2 = userRepository.findByUsername(otherUsername);
        if (user1 == null || user2 == null) {
            return Response.newFailure("Users not found"); 
        }
        List<Message> messages = messageRepository.findBySenderAndReceiverOrderByTimestampAsc(user1, user2);
        messages.addAll(messageRepository.findByReceiverAndSenderOrderByTimestampAsc(user1, user2));
        messages.sort((m1, m2) -> m1.getTimestamp().compareTo(m2.getTimestamp()));
        List<MessageDTO> dtos = new ArrayList<>();
        for (Message msg : messages) {
            dtos.add(MessageConverter.convertToMessageDTO(msg));
        }
        return Response.newSuccess(dtos, null);
    }

    public Response<MessageDTO> sendMessage(Long senderId, String receiverName, String content) {
        User sender = userRepository.findById(senderId).orElse(null);
        User receiver = userRepository.findByUsername(receiverName);
        if (sender == null || receiver == null) {
            return Response.newFailure("Users not found"); 
        }
        Message message = new Message();
        message.setSender(sender);
        message.setReceiver(receiver);
        message.setContent(content);
        messageRepository.save(message);
        return Response.newSuccess(MessageConverter.convertToMessageDTO(message), "Message sent successfully");
    }

    public Message getLastMessage(Long userId1, Long userId2) {
        User user1 = userRepository.findById(userId1).orElse(null);
        User user2 = userRepository.findById(userId2).orElse(null);
        if (user1 == null || user2 == null) {
            return null; 
        }
        List<Message> messages1 = messageRepository.findBySenderAndReceiverOrderByTimestampAsc(user1, user2);
        List<Message> messages2 = messageRepository.findByReceiverAndSenderOrderByTimestampAsc(user1, user2);
        List<Message> messages = messages1;
        messages.addAll(messages2);
        messages.sort((m1, m2) -> m2.getTimestamp().compareTo(m1.getTimestamp())); // sort in descending order
        return messages.isEmpty() ? null : messages.get(0); // return the latest message or null if no messages
    }

    public Response<List<ChatPreview>> getChatPreviews(Long userId) {
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            return Response.newFailure("User not found");
        }

        List<User> contacts = new ArrayList<>(user.getFollowings());
        contacts.retainAll(user.getFans());

        List<ChatPreview> chatPreviews = contacts.stream().map(contact -> {
            Message lastMessage = this.getLastMessage(userId, contact.getId());
            return new ChatPreview(contact.getUsername(), lastMessage != null ? lastMessage.getContent() : "");
        }).collect(Collectors.toList());

        return Response.newSuccess(chatPreviews, null);
    }
}
