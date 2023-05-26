package com.seba.eventos.controllers;

import com.seba.eventos.models.Event;
import com.seba.eventos.models.States;
import com.seba.eventos.models.User;
import com.seba.eventos.services.EventService;
import com.seba.eventos.services.MessageService;
import com.seba.eventos.services.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Arrays;

@Controller
public class EventController {

    @Autowired
    private UserService userService;
    @Autowired
    private EventService eventService;
    @Autowired
    private MessageService messageService;

    private boolean isNotAuthenticated(HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        return userId == null;
    }

    @GetMapping("/events")
    public String dashboard(HttpSession session, Model model, @ModelAttribute("event") Event event) {
        if (isNotAuthenticated(session)) {
            return "redirect:/";
        }
        User user = userService.findUserById((Long) session.getAttribute("userId"));
        model.addAttribute("user", user);
        model.addAttribute("states", States.states);
        model.addAttribute("allEventsWithState", eventService.allEventsWithState(user.getState()));
        model.addAttribute("allEventsWithoutState", eventService.allEventsWithoutState(user.getState()));
        return "/event/index.jsp";

    }

    @PostMapping("/new/event")
    public String createEvent(@Valid @ModelAttribute("event") Event event, BindingResult result, Model model) {
        if (result.hasErrors()) {
            User user = userService.findUserById(event.getUser_event().getId());
            model.addAttribute("user", user);
            model.addAttribute("states", States.states);
            model.addAttribute("allEventsWithState", eventService.allEventsWithState(user.getState()));
            model.addAttribute("allEventsWithoutState", eventService.allEventsWithoutState(user.getState()));
            return "/event/index.jsp";
        }
        eventService.createEvent(event);
        return "redirect:/events";
    }

    @GetMapping("/events/{idEvent}/edit")
    public String editEvent(@PathVariable("idEvent") Long idEvent, @ModelAttribute("event") Event event, HttpSession session, Model model) {
        if (isNotAuthenticated(session)) {
            return "redirect:/";
        }
        Event event1 = eventService.findById(idEvent);
        Long userId = (Long) session.getAttribute("userId");
        if (event1 == null) {
            return "redirect:/events";
        }
        if (event1.getUser_event().getId() == userId){
            model.addAttribute("user", userService.findUserById((Long) session.getAttribute("userId")));
            model.addAttribute("event", event1);
            model.addAttribute("states", States.states);
            return "/event/editEvent.jsp";
        }else {
            return "redirect:/events";
        }

    }

    @PutMapping("/{id}")
    public String putEvent(@Valid @ModelAttribute("event") Event event, BindingResult result, @PathVariable("id") Long id, HttpSession session, Model model) {
        if (isNotAuthenticated(session)) {
            return "redirect:/";
        }
        if (result.hasErrors()) {
            Event event1 = eventService.findById(id);
            if (event1 == null) {
                return "redirect:/events";
            }
            String[] listaEstados = Arrays.stream(States.states)
                    .filter(state -> !state.contains(event1.getState()))
                    .toArray(String[]::new);
            model.addAttribute("user", userService.findUserById((Long) session.getAttribute("userId")));
            model.addAttribute("event", event1);
            model.addAttribute("states", listaEstados);
            return "/event/editEvent.jsp";
        }
        eventService.updateEvent(event);
        return "redirect:/events";
    }

    @DeleteMapping("/events/{id}")
    public String deleteEvent(@PathVariable("id") Long id, HttpSession session) {
        if (isNotAuthenticated(session)){
            return "redirect:/";
        }
        eventService.deleteEvent(id);
        return "redirect:/events";
    }

    @GetMapping("/event/{id}/{opcion}")
    public String adminEvents(@PathVariable("id") Long id, @PathVariable("opcion") String opcion, HttpSession session) {
        if (isNotAuthenticated(session)) {
            return "redirect:/";
        }
        Event event = eventService.findById(id);
        boolean join = (opcion.equals("join"));
        User user = userService.findUserById((Long) session.getAttribute("userId"));
        eventService.adminEvents(event, user, join);
        return "redirect:/events";
    }

    //Messages
    @GetMapping("/events/{id}")
    public String showEvent(@PathVariable("id")Long id, Model model, HttpSession session){
        if (isNotAuthenticated(session)){
            return "redirect:/";
        }
        model.addAttribute("event", eventService.findById(id));
        return "/event/showEvent.jsp";
    }
    @PostMapping("/events/{idEvento}/comment")
    public String createMessage(@PathVariable("idEvento") Long id, @RequestParam("comment") String comment, HttpSession session, RedirectAttributes redirectAttributes) {
        if (isNotAuthenticated(session)) {
            return "redirect:/";
        }
        if (comment.equals("")){
            redirectAttributes.addFlashAttribute("error", "Porfavor escribe un comentario!");
            return "redirect:/events/" + id;
        }
        Event event = eventService.findById(id);
        User user = userService.findUserById((Long) session.getAttribute("userId"));
        messageService.message(user, event, comment);
        return "redirect:/events/" + id;
    }
}
