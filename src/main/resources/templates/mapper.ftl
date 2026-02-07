<#assign
    entityClass  = Entity
    mapperName     = Entity + naming.suffix().mapper()
    dtoRequestName   = entityClass  + "Request"
    dtoResponseName  = entityClass  + "Response"
>
package ${basePackage}.${packages.mapper()};

import ${basePackage}.common.mapper.BaseMapper;
import ${basePackage}.${packages.dto()}.${dtoRequestName};
import ${basePackage}.${packages.dto()}.${dtoResponseName};
import ${EntityPackage}.${entityClass};
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ${mapperName} extends
        BaseMapper<${entityClass}, ${dtoRequestName}, ${dtoResponseName}> {
}
