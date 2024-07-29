package com.example.aniverseapp.converter;

import com.example.aniverseapp.dao.Message;
import com.example.aniverseapp.dto.MessageDTO;

public class MessageConverter {
    
    public static MessageDTO convertToMessageDTO(Message message) {
        MessageDTO dto = new MessageDTO();
        dto.setId(message.getId());
        dto.setSenderName(message.getSender().getUsername());
        dto.setReceiverId(message.getReceiver().getId());
        dto.setContent(message.getContent());
        dto.setTimestamp(message.getTimestamp());
        return dto;
    }
}
