package com.seba.eventos.controllers;

import com.seba.eventos.models.States;
import com.seba.eventos.models.User;
import com.seba.eventos.services.EventService;
import com.seba.eventos.services.UserService;
import com.seba.eventos.util.validator.UserValidator;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class MainController {

    @Autowired
    private UserService userService;
    @Autowired
    private UserValidator userValidator;
    @Autowired
    private EventService eventService;
    @Autowired
    MessageSource messageSource;

    @GetMapping("/")
    public String login(Model model) {
        model.addAttribute("register", new User());
        model.addAttribute("login", new User());
        model.addAttribute("states", States.states);
        return "login.jsp";
    }

    @PostMapping("/login")
    public String loginUser(@Valid @ModelAttribute("login") User loginuser, BindingResult result, Model model, HttpSession session) {
        boolean isAuthenticated = userService.authenticateUser(loginuser.getEmail(), loginuser.getPassword());
        if (isAuthenticated) {
            User user = userService.findByEmail(loginuser.getEmail());
            session.setAttribute("userId", user.getId());
            return "redirect:/events";
        } else {
            model.addAttribute("error", "Credenciales Invalidas!");
            model.addAttribute("register", new User());
            model.addAttribute("states", States.states);
            return "login.jsp";
        }
    }

    @PostMapping("/registration")
    public String register(@Valid @ModelAttribute("register") User user, BindingResult result, Model model, HttpSession session) {
        userValidator.validate(user, result);
        if (result.hasErrors()) {
            model.addAttribute("login", new User());
            model.addAttribute("states", States.states);
            return "login.jsp";
        }

        try {
            User user1 = userService.registerUser(user);
            session.setAttribute("userId", user1.getId());
            return "redirect:/events";
        } catch (DataIntegrityViolationException e) {
            result.rejectValue("email", "error.email", "El email ingresado ya está en uso. Por favor, ingrese otro email.");
            model.addAttribute("login", new User());
            model.addAttribute("states", States.states);
            return "login.jsp";
        }

    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
