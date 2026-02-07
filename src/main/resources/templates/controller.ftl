<#assign
    entityClass  = Entity
    entityVar    = entity
    entityId     = entityVar + "Id"
    entityKebab  = entityVar?replace("([a-z0-9])([A-Z])", "$1-$2", "r")?lower_case
    entityPlural = entityKebab + (rest.pluralizeEndpoints()?then("s", ""))

    controllerName = Entity + naming.suffix().controller()
    serviceName    = Entity + naming.suffix().service()
    mapperName     = Entity + naming.suffix().mapper()
    dtoRequestName   = entityClass  + "Request"
    dtoResponseName  = entityClass  + "Response"

    serviceObjectName = serviceName?uncap_first
    mapperObjectName  = mapperName?uncap_first

    idType = persistence.idType()

    basePathPrefix = rest.basePathInclude()?then(rest.basePath(), "")
    requestMapping = basePathPrefix?has_content?then(
                          basePathPrefix + "/" + entityPlural
                          , "/" + entityPlural
                      )
>
package ${basePackage}.${packages.controller()};

import ${basePackage}.common.annotation.GlobalApiResponses;
import ${basePackage}.${packages.dto()}.${dtoRequestName};
import ${basePackage}.${packages.dto()}.${dtoResponseName};
import ${basePackage}.${packages.mapper()}.${mapperName};
import ${basePackage}.${packages.service()}.${serviceName};
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@GlobalApiResponses
@RequestMapping("${requestMapping}")
public class ${controllerName} {
    private final ${serviceName} ${serviceObjectName};
    private final ${mapperName} ${mapperObjectName};

    @GetMapping
    public ResponseEntity<List<${dtoResponseName}>> getAll() {
        return ResponseEntity.ok(
            ${mapperObjectName}.toDTO(
                ${serviceObjectName}.findAll()
            )
        );
    }

    @GetMapping("/{${entityId}}")
    public ResponseEntity<${dtoResponseName}> getById(@PathVariable ${idType} ${entityId}) {
        return ResponseEntity.ok(
            ${mapperObjectName}.toDTO(
                ${serviceObjectName}.findById(${entityId})
            )
        );
    }

    @PostMapping("/bulk")
    public ResponseEntity<List<${dtoResponseName}>> createAll(
            @Valid @RequestBody List<${dtoRequestName}> requestList) {
        return ResponseEntity.ok(
            ${mapperObjectName}.toDTO(
                ${serviceObjectName}.create${Entity}(requestList)
            )
        );
    }

    @PostMapping
    public ResponseEntity<${dtoResponseName}> create(
            @Valid @RequestBody ${dtoRequestName} request) {
        return ResponseEntity.ok(
            ${mapperObjectName}.toDTO(
                ${serviceObjectName}.create${Entity}(request)
            )
        );
    }

    @DeleteMapping("/{${entityId}}")
    public ResponseEntity<Void> delete(@PathVariable ${idType} ${entityId}) {
        ${serviceObjectName}.delete${Entity}(${entityId});
        return ResponseEntity.noContent().build();
    }
}
