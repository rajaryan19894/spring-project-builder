<#assign
    entityClass  = Entity
    entityVar    = Entity?uncap_first
    validatorName = Entity + "Validator"
>
package ${basePackage}.${packages.validator()};

import ${basePackage}.common.validator.BaseValidator;
import ${EntityPackage}.${entityClass};
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ${validatorName} implements BaseValidator<${entityClass}> {
    @Override
    public void validate(${entityClass} ${entityVar}) {
    }
}



