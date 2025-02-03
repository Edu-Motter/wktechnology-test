package br.com.wktechnology.springboot.dtos;

import br.com.wktechnology.springboot.entities.BloodType;

public record CandidateBloodTypeAndAgeDTO(BloodType bloodType, Integer age) { }

