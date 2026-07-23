package com.arzin.service.domain

import java.time.Instant
import java.util.UUID

data class {{SERVICE_NAME_UPPER}}Entity(
    val id: UUID = UUID.randomUUID(),
    val name: String,
    val createdAt: Instant = Instant.now(),
    val updatedAt: Instant = Instant.now(),
    val version: Long = 0
)
