package com.seba.eventos.services;

import com.seba.eventos.models.Event;
import com.seba.eventos.models.Message;
import com.seba.eventos.models.User;
import com.seba.eventos.repositories.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MessageService {
    @Autowired
    private MessageRepository messageRepository;

    public void message(User user, Event event, String message){
        Message message1 = new Message(message, user, event);
        messageRepository.save(message1);
    }
}
