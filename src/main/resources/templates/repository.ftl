<#assign
    entityClass = Entity
    repoName    = Entity + naming.suffix().repository()
    idType      = persistence.idType()
>
package ${basePackage}.${packages.repository()};

import org.springframework.data.jpa.repository.JpaRepository;
import ${EntityPackage}.${entityClass};

public interface ${repoName} extends JpaRepository<${entityClass}, ${idType}> {
}
