package com.example.product_management.service;

import com.example.product_management.entity.Product;
import com.example.product_management.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import org.springframework.data.domain.Sort;

import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {
    
    private final ProductRepository productRepository;
    
    @Autowired
    public ProductServiceImpl(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }
    
    @Override
    public List<Product> getAllProducts(Sort sort) {
        return productRepository.findAll(sort);
    }
    
    @Override
    public Optional<Product> getProductById(Long id) {
        return productRepository.findById(id);
    }
    
    @Override
    public Product saveProduct(Product product) {
        // Validation logic can go here
        return productRepository.save(product);
    }
    
    @Override
    public void deleteProduct(Long id) {
        productRepository.deleteById(id);
    }
    
    // @Override
    // public List<Product> searchProducts(String keyword) {
    //     return productRepository.findByNameContaining(keyword);
    // }
    
    @Override
    public List<Product> getProductsByCategory(String category, Sort sort) {
        return productRepository.findByCategory(category, sort);
    }

    @Override
    public List<Product> advancedSearch(String name, String category, BigDecimal minPrice, BigDecimal maxPrice) {
        if (name != null && name.isEmpty()) name = null;
        if (category != null && category.isEmpty()) category = null;

        return productRepository.searchProducts(name, category, minPrice, maxPrice);
    }

    @Override
    public List<String> getAllCategories() {
        return productRepository.findAllCategories();
    }
    
    @Override
    public Page<Product> searchProducts(String keyword, Pageable pageable) {
        return productRepository.findByNameContaining(keyword, pageable);
    }

    @Override
    public long countByCategory(String category) {
        return productRepository.countByCategory(category);
    }

    @Override
    public BigDecimal calculateTotalValue() {
        return productRepository.calculateTotalValue();
    }

    @Override
    public BigDecimal calculateAveragePrice() {
        return productRepository.calculateAveragePrice();
    }

    @Override
    public List<Product> findLowStockProducts(int threshold) {
        return productRepository.findLowStockProducts(threshold);
    }

    @Override
    public List<Product> getRecentProducts() {
        // Fetch last 5 added products (using createdAt timestamp) 
        return productRepository.findTop5ByOrderByCreatedAtDesc(); // Descending order
    }

    @Override
    public Map<String, Long> countAllCategories() {
        List<String> categories = productRepository.findAll()
                .stream()
                .map(Product::getCategory)
                .distinct()
                .toList();

        Map<String, Long> result = new LinkedHashMap<>();

        for (String cat : categories) {
            long count = productRepository.countByCategory(cat);
            result.put(cat, count);
        }

        return result;
    }
}
