package net.central.hub.engineers.engineersservice.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.*;

import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
public class Engineer {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
}
