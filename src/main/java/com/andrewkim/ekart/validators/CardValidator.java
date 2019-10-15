package com.andrewkim.ekart.validators;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.andrewkim.ekart.models.Card;

@Component
public class CardValidator implements Validator {
	@Override
	public boolean supports(Class<?> clazz) {
		return Card.class.equals(clazz);
	}

	@Override
	public void validate(Object arg0, Errors arg1) {
		
	}

}
