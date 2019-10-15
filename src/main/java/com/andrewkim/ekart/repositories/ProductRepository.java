package com.andrewkim.ekart.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.andrewkim.ekart.models.Product;

@Repository
public interface ProductRepository extends CrudRepository <Product, Long> {
	List <Product> findAll();
	List <Product> findByProductNameContaining (String product);
}
