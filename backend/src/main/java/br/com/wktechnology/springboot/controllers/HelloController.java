package br.com.wktechnology.springboot.controllers;

import br.com.wktechnology.springboot.controllers.responses.JsonUploadResponse;
import br.com.wktechnology.springboot.dtos.PersonJson;
import br.com.wktechnology.springboot.dtos.CandidatesOfStateDTO;
import br.com.wktechnology.springboot.entities.Person;
import br.com.wktechnology.springboot.repositories.PersonRepository;
import br.com.wktechnology.springboot.services.ReportService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static br.com.wktechnology.WktechnologyApplication.convertToPersonList;

@RestController
@RequestMapping("/api")
public class HelloController {

    @Autowired
    private final ObjectMapper objectMapper;
    @Autowired
    private final PersonRepository repository;
    @Autowired
    private final ReportService service;

    public HelloController(ObjectMapper objectMapper, PersonRepository repository, ReportService service) {
        this.objectMapper = objectMapper;
        this.repository = repository;
        this.service = service;
    }

    @GetMapping(value = "/report")
    public ResponseEntity<String> getReport(){
        service.getAllPeopleBMIAndTheRanges();
        return ResponseEntity.ok( "executed");
    }

    @GetMapping(value = "/candidates-of-each-state")
    public ResponseEntity<List<CandidatesOfStateDTO>> getCandidatesOfEachState(){
        List<CandidatesOfStateDTO> result = service.getPeopleCountOfEachState();
        return ResponseEntity.ok( result);
    }

    @PostMapping(value = "/uploadJson", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<JsonUploadResponse> uploadFile(@RequestParam("file") MultipartFile jsonFile) {
        try {

            byte[] jsonFileBytes = jsonFile.getBytes();
            ObjectMapper mapper = new ObjectMapper();

            JsonNode jsonNode = objectMapper.readTree(jsonFileBytes);

            List<PersonJson> peopleJson = new ArrayList<>();
            if (jsonNode.isArray()) {
                for (JsonNode node : jsonNode) {
                    PersonJson person = mapper.treeToValue(node, PersonJson.class);
                    peopleJson.add(person);
                }
            }
            List<Person> people = convertToPersonList(peopleJson);
            savePeopleBatch(people); //Warning: Batch insert

            String fileName = jsonFile.getOriginalFilename();
            long fileSize = jsonFile.getSize();
            System.out.println("File uploaded successfully: " + fileName + "fileSize:" + fileSize);
            JsonUploadResponse response = new JsonUploadResponse(
                    fileName,
                    fileSize,
                    "File uploaded successfully"
            );

            return ResponseEntity.ok(response);

        } catch (IOException e) {
            return ResponseEntity
                    .internalServerError()
                    .body(new JsonUploadResponse(
                            null,
                            0L,
                            "Error processing file: " + e.getMessage()
                    ));
        }
    }

    @Transactional
    public void savePeopleBatch(List<Person> people) {
        repository.saveAll(people); // Bulk save to database
    }
}