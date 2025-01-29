package br.com.wktechnology.springboot;

import org.apache.juli.logging.Log;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

import org.springframework.http.MediaType;

@RestController
@RequestMapping("/api")
public class HelloController {

    @PostMapping(value = "/uploadJson", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<FileUploadResponse> uploadFile(@RequestParam("file") MultipartFile file) {
        try {
            // Read the file content
            byte[] fileContent = file.getBytes();

            // Get file details
            String fileName = file.getOriginalFilename();
            long fileSize = file.getSize();

            // Here you can add your logic to process the file
            // For example, save it to a database or process its content

            System.out.println("File uploaded successfully: " + fileName + "fileSize:" + fileSize);
            FileUploadResponse response = new FileUploadResponse(
                    fileName,
                    fileSize,
                    "File uploaded successfully"
            );

            return ResponseEntity.ok(response);

        } catch (IOException e) {
            return ResponseEntity
                    .internalServerError()
                    .body(new FileUploadResponse(
                            null,
                            0L,
                            "Error processing file: " + e.getMessage()
                    ));
        }
    }
}

class FileUploadResponse {
    private String fileName;
    private Long fileSize;
    private String message;

    public FileUploadResponse(String fileName, Long fileSize, String message) {
        this.fileName = fileName;
        this.fileSize = fileSize;
        this.message = message;
    }

    // Getters and setters
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Long getFileSize() {
        return fileSize;
    }

    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}