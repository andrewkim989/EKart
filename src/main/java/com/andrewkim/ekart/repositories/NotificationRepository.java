package com.andrewkim.ekart.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.andrewkim.ekart.models.Notification;

@Repository
public interface NotificationRepository extends CrudRepository <Notification, Long>{
	List<Notification> findAll();
}
