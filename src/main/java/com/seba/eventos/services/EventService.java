package com.seba.eventos.services;

import com.seba.eventos.models.Event;
import com.seba.eventos.models.User;
import com.seba.eventos.repositories.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventService {

    @Autowired
    private EventRepository eventRepository;

    public Event createEvent(Event event) {
        return eventRepository.save(event);
    }

    public List<Event> allEventsWithState(String state) {
        return eventRepository.findByState(state);
    }

    public List<Event> allEventsWithoutState(String state) {
        return eventRepository.findByStateIsNot(state);
    }

    public Event findById(Long id) {
        return eventRepository.findById(id).orElse(null);
    }

    public Event updateEvent(Event event) {
        return eventRepository.save(event);
    }

    public void deleteEvent(Long id) {
        eventRepository.deleteById(id);
    }

    //Administrar Evento
    public void adminEvents(Event event, User user, boolean
            join) {
        if (join){
            event.getAsistentes().add(user);
        }else {
            event.getAsistentes().remove(user);
        }
        eventRepository.save(event);
    }
}
