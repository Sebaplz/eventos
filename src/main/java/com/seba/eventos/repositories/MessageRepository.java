package com.seba.eventos.repositories;

import com.seba.eventos.models.Message;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessageRepository extends CrudRepository<Message, Long> {
//    List<Message> findAllByIdEvent(Long id);
}
