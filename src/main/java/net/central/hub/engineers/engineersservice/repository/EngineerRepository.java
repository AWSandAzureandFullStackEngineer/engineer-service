package net.central.hub.engineers.engineersservice.repository;

import net.central.hub.engineers.engineersservice.entity.Engineer;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface EngineerRepository extends JpaRepository<Engineer, UUID> {
}
