package com.arzin.service.events

import java.time.Instant
import java.util.UUID

data class DomainEvent(
    val eventId: UUID = UUID.randomUUID(),
    val eventType: String,
    val timestamp: Instant = Instant.now(),
    val source: String = "{{SERVICE_NAME}}",
    val payload: Map<String, Any> = emptyMap()
)
