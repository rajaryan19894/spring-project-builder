<#assign
    entityClass  = Entity
    dtoRequestName   = entityClass  + "Request"
>
package ${basePackage}.${packages.dto()};

public record ${dtoRequestName}(

) {
}
