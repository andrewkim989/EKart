package com.andrewkim.ekart.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.andrewkim.ekart.models.Address;

@Repository
public interface AddressRepository extends CrudRepository <Address, Long> {
	List <Address> findAll();
}
