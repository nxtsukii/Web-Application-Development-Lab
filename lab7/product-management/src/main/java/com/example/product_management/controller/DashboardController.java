package com.example.product_management.controller;

import com.example.product_management.service.ProductService;
import com.example.product_management.entity.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {
    @Autowired
    private ProductService productService;

    @GetMapping
    public String showDashboard(Model model) {
        Map<String, Long> categoryCounts = productService.countAllCategories();

        BigDecimal totalValue = productService.calculateTotalValue();
        BigDecimal avgPrice = productService.calculateAveragePrice();

        List<Product> lowStock = productService.findLowStockProducts(10);
        List<Product> recent = productService.getRecentProducts();

        model.addAttribute("categoryCounts", categoryCounts);
        model.addAttribute("totalValue", totalValue);
        model.addAttribute("avgPrice", avgPrice);
        model.addAttribute("lowStock", lowStock);
        model.addAttribute("recent", recent);

        return "dashboard";
    }
}
