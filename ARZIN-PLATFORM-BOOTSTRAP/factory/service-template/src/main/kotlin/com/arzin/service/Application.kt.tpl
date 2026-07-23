package com.arzin.service

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class {{SERVICE_NAME_UPPER}}Application

fun main(args: Array<String>) {
    runApplication<{{SERVICE_NAME_UPPER}}Application>(*args)
}
