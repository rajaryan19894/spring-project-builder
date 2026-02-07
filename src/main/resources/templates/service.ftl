<#assign
    entityClass  = Entity
    entityVar    = entity

    repoName = Entity + naming.suffix().repository()
    serviceName    = Entity + naming.suffix().service()
    mapperName     = Entity + naming.suffix().mapper()
    dtoRequestName   = entityClass  + "Request"

    entityObjectName = entityClass?uncap_first
    repoObjectName = repoName?uncap_first
    mapperObjectName  = mapperName?uncap_first

    idType = persistence.idType()
>
package ${basePackage}.${packages.service()};

import ${basePackage}.${packages.dto()}.${dtoRequestName};
import ${basePackage}.exception.ResourceNotFoundException;
import ${basePackage}.${packages.mapper()}.${mapperName};
import ${EntityPackage}.${entityClass};
import ${basePackage}.${packages.repository()}.${repoName};
import ${basePackage}.validator.CommonValidator;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ${serviceName} {
    private final ${repoName} ${repoObjectName};
    private final ${mapperName} ${mapperObjectName};

    private final CommonValidator commonValidator;

    public List<${entityClass}> findAll() {
        return ${repoObjectName}.findAll();
    }

    public ${entityClass} findById(${idType} id) {
        return ${repoObjectName}.findById(id)
                .orElseThrow(() ->
                        new ResourceNotFoundException("${entityClass} not found: " + id));
    }

    public List<${entityClass}> create${entityClass}(List<${dtoRequestName}> requestList) {
        commonValidator.requireNonEmpty(requestList);

        return requestList.stream()
                .map(this::create${entityClass})
                .toList();
    }

    public ${entityClass} create${entityClass}(${dtoRequestName} request) {
        commonValidator.requireNonNull(request);

        ${entityClass} ${entityVar} = ${mapperObjectName}.fromDTO(request);

        // todo - impl create logic

        return ${repoObjectName}.save(${entityVar});
    }

    public void delete${entityClass}(${idType} id) {
        ${entityClass} ${entityObjectName} = findById(id);
        ${repoObjectName}.delete(${entityObjectName});
    }
}
