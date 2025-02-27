package br.com.wktechnology.springboot.controllers;

import br.com.wktechnology.springboot.dtos.*;
import br.com.wktechnology.springboot.entities.Candidate;
import br.com.wktechnology.springboot.repositories.CandidateRepository;
import br.com.wktechnology.springboot.services.CandidateService;
import br.com.wktechnology.springboot.services.ReportService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api")
public class ReportController {

    @Autowired
    private final ObjectMapper objectMapper;
    @Autowired
    private final CandidateRepository repository;
    @Autowired
    private final ReportService service;
    @Autowired
    private final CandidateService candidateService;

    public ReportController(ObjectMapper objectMapper, CandidateRepository repository, ReportService service, CandidateService candidateService) {
        this.objectMapper = objectMapper;
        this.repository = repository;
        this.service = service;
        this.candidateService = candidateService;
    }

    @GetMapping(value = "/candidates-of-each-state")
    public ResponseEntity<List<CandidatesOfStateDTO>> getCandidatesOfEachState(){
        List<CandidatesOfStateDTO> result = service.getPeopleCountOfEachState();
        return ResponseEntity.ok( result);
    }

    @GetMapping(value = "/average-bmi-by-age-range")
    public ResponseEntity<List<AverageBMIByAgeRangeDTO>> getAverageBMIByAgeRange(){
        List<AverageBMIByAgeRangeDTO> result = service.getAverageBMIByAgeRange();
        return ResponseEntity.ok(result);
    }

    @GetMapping(value = "/obesity-rate-by-gender")
    public ResponseEntity<List<ObesityRateByGenderDTO>> getObesityRateByGender(){
        List<ObesityRateByGenderDTO> result = service.getObesityRateByGender();
        return ResponseEntity.ok(result);
    }

    @GetMapping(value = "/average-age-by-blood-type")
    public ResponseEntity<List<AverageAgeByBloodTypeDTO>> getAverageAgeByBloodType(){
        List<AverageAgeByBloodTypeDTO> result = service.getAverageAgeByBloodType();
        return ResponseEntity.ok(result);
    }



    @GetMapping(value = "/number-of-donors-by-blood-type")
    public ResponseEntity<List<NumberOfDonorsByBloodTypeDTO>> getNumberOfDonorsByBloodType(){
        List<NumberOfDonorsByBloodTypeDTO> result = service.getNumberOfDonorsByBloodType();
        return ResponseEntity.ok(result);
    }



    @PostMapping(value = "/upload-json", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<JsonUploadDTO> uploadFile(@RequestPart("file") MultipartFile jsonFile) {
        try {
            byte[] jsonFileBytes = jsonFile.getBytes();
            ObjectMapper mapper = new ObjectMapper();

            JsonNode jsonNode = objectMapper.readTree(jsonFileBytes);

            List<CandidateJsonDTO> peopleJson = new ArrayList<>();
            if (jsonNode.isArray()) {
                for (JsonNode node : jsonNode) {
                    CandidateJsonDTO person = mapper.treeToValue(node, CandidateJsonDTO.class);
                    peopleJson.add(person);
                }
            }
            List<Candidate> candidates = candidateService.parseJsonListToCandidateList(peopleJson);
            candidateService.saveInBatch(candidates); //Warning: Batch insert

            String fileName = jsonFile.getOriginalFilename();
            long fileSize = jsonFile.getSize();
            System.out.println("File uploaded successfully: " + fileName + "fileSize:" + fileSize);
            JsonUploadDTO response = new JsonUploadDTO(
                    fileName,
                    fileSize,
                    "File uploaded successfully"
            );

            return ResponseEntity.ok(response);

        } catch (IOException e) {
            return ResponseEntity
                    .internalServerError()
                    .body(new JsonUploadDTO(
                            null,
                            0L,
                            "Error processing file: " + e.getMessage()
                    ));
        }
    }
}