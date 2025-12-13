package com.example.customer_api.service;

import com.example.customer_api.dto.CustomerRequestDTO;
import com.example.customer_api.dto.CustomerResponseDTO;
import com.example.customer_api.dto.CustomerUpdateDTO;
import com.example.customer_api.entity.CustomerStatus;

import org.springframework.data.domain.Page;

import java.util.List;

public interface CustomerService {
    
    List<CustomerResponseDTO> getAllCustomers();
    
    CustomerResponseDTO getCustomerById(Long id);
    
    CustomerResponseDTO createCustomer(CustomerRequestDTO requestDTO);
    
    CustomerResponseDTO updateCustomer(Long id, CustomerRequestDTO requestDTO);
    
    void deleteCustomer(Long id);
    
    List<CustomerResponseDTO> searchCustomers(String keyword);
    
    List<CustomerResponseDTO> getCustomersByStatus(CustomerStatus status);

    // Advanced search
    List<CustomerResponseDTO> advancedSearch(String name, String email, String status);

    // Pagination
    Page<CustomerResponseDTO> getAllCustomers(int page, int size);

    // Sort
    List<CustomerResponseDTO> getAllCustomers(String sortBy, String sortDir);

    // Pagination + Sort
    Page<CustomerResponseDTO> getAllCustomers(int page, int size, String sortBy, String sortDir);

    // PATCH
    CustomerResponseDTO partialUpdateCustomer(Long id, CustomerUpdateDTO updateDTO);
}