package com.example.product_management.service;

import com.example.product_management.entity.Product;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import org.springframework.data.domain.Sort;

public interface ProductService {
    
    List<Product> getAllProducts(Sort sort);
    
    Optional<Product> getProductById(Long id);
    
    Product saveProduct(Product product);
    
    void deleteProduct(Long id);
    
    // List<Product> searchProducts(String keyword);
    
    List<Product> getProductsByCategory(String category, Sort sort);

    List<Product> advancedSearch(String name, String category, BigDecimal minPrice, BigDecimal maxPrice);

    List<String> getAllCategories();

    Page<Product> searchProducts(String keyword, Pageable pageable);

    long countByCategory(String category);

    BigDecimal calculateTotalValue();

    BigDecimal calculateAveragePrice();

    List<Product> findLowStockProducts(int threshold);

    List<Product> getRecentProducts(); // 5 most recent

    Map<String, Long> countAllCategories();
}
