package com.leszko.calculator;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

/**
     * The day of the week named "Calculator".
     * Calculator
     */

@Service
public class Calculator {

        final static int umlNUMBER1 = 3; 
	@Cacheable("sum") 
	public int sum(int a, int b) {
		return a + b; 
	}
}
