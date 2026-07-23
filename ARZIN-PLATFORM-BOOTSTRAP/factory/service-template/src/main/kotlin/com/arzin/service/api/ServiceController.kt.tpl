package com.arzin.service.api

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/v1/{{SERVICE_NAME_LOWER}}")
class {{SERVICE_NAME_UPPER}}Controller {

    @GetMapping("/health")
    fun health(): Map<String, String> = mapOf(
        "service" to "{{SERVICE_NAME}}",
        "status" to "UP",
        "version" to "1.0.0"
    )

    @GetMapping("/info")
    fun info(): Map<String, String> = mapOf(
        "name" to "{{SERVICE_NAME}}",
        "type" to "ARZIN Domain Service",
        "profile" to "{{PROFILE:-developer}}"
    )
}
