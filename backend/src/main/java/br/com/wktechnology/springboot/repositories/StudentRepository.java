package br.com.wktechnology.springboot.repositories;

import br.com.wktechnology.springboot.entities.Student;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentRepository extends JpaRepository<Student, Long> {
}