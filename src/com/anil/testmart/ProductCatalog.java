package com.anil.testmart;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.jws.WebService;

@WebService
public class ProductCatalog {
	
	public List<String> getProductCategories() {
		List<String> categories = new ArrayList<String>(); 
		categories.add("books");
		categories.add("pens");
		categories.add("accessories");
		categories.add("notebooks");
		categories.add("essays");
		return categories;
	}

	
}
