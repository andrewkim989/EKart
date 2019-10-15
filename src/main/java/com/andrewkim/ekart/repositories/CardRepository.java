package com.andrewkim.ekart.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.andrewkim.ekart.models.Card;

@Repository
public interface CardRepository extends CrudRepository <Card, Long> {
	List <Card> findAll();
}
