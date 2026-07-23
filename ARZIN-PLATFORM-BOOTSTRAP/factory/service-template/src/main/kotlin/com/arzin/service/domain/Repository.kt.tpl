package com.arzin.service.domain

import java.util.UUID

interface {{SERVICE_NAME_UPPER}}Repository {
    fun findById(id: UUID): {{SERVICE_NAME_UPPER}}Entity?
    fun save(entity: {{SERVICE_NAME_UPPER}}Entity): {{SERVICE_NAME_UPPER}}Entity
    fun deleteById(id: UUID)
    fun findAll(): List<{{SERVICE_NAME_UPPER}}Entity>
}
