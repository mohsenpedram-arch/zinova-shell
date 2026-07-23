package com.arzin.service.security

import org.springframework.stereotype.Component

@Component
class {{SERVICE_NAME_UPPER}}SecurityPolicy {
    
    fun canAccess(resource: String, role: String): Boolean {
        // پیاده‌سازی سطح دسترسی
        return true
    }
}
