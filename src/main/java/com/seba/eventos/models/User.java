package com.seba.eventos.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.util.Date;
import java.util.List;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "First Name no puede estar vacio!")
    private String firstName;
    @NotBlank(message = "Last Name no puede estar vacio!")
    private String lastName;
    @Column(unique = true)
    @NotBlank(message = "Email no puede estar vacio!")
    @Email(message = "El email no es valido!")
    private String email;
    @NotBlank(message = "Location no puede estar vacio!")
    private String location;
    private String state;
    @NotBlank(message = "Por favor, ingresa un password")
    @Size(min = 8, max = 64, message = "El password debe contener entre 8 y 20 caracteres")
    private String password;
    @Transient
    @NotBlank(message = "Por favor, ingresa un password")
    private String passwordConfirmation;
    @Column(updatable = false)
    private Date createdAt;
    private Date updatedAt;

    //Relacion 1:n a Eventos
    @OneToMany(mappedBy = "user_event", fetch = FetchType.LAZY)
    private List<Event> events;

    //Relacion muchos a muchos de usuario a eventos
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "users_events", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "event_id"))
    private List<Event> eventosAsistire;

    //Relacion 1:n hacia mensajes
    @OneToMany(mappedBy = "author", fetch = FetchType.LAZY)
    private List<Message> messages;

    public User() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordConfirmation() {
        return passwordConfirmation;
    }

    public void setPasswordConfirmation(String passwordConfirmation) {
        this.passwordConfirmation = passwordConfirmation;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public List<Event> getEvents() {
        return events;
    }

    public void setEvents(List<Event> events) {
        this.events = events;
    }

    public List<Event> getEventosAsistire() {
        return eventosAsistire;
    }

    public void setEventosAsistire(List<Event> eventosAsistire) {
        this.eventosAsistire = eventosAsistire;
    }

    public List<Message> getMessages() {
        return messages;
    }

    public void setMessages(List<Message> messages) {
        this.messages = messages;
    }

    @PrePersist
    protected void onCreate() {
        this.createdAt = new Date();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = new Date();
    }
}
