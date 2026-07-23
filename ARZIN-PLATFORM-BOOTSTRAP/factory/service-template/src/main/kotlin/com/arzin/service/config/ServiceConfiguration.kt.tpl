package com.arzin.service.config

import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.Bean
import java.time.Clock

@Configuration
class {{SERVICE_NAME_UPPER}}Configuration {

    @Bean
    fun clock(): Clock = Clock.systemUTC()
}
