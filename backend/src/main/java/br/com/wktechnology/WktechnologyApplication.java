package br.com.wktechnology;

import br.com.wktechnology.springboot.repositories.CandidateRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class WktechnologyApplication {

    public static void main(String[] args) {
        SpringApplication.run(WktechnologyApplication.class, args);
    }

    @Bean
    public CommandLineRunner commandLineRunner(ApplicationContext ctx, CandidateRepository repository) {
        return args -> System.out.println("Spring Boot Application running in http://localhost:8082");
    }
}
