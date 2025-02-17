package Lab.Lab13;

import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
@Repeatable(CustomValidations.class)
public @interface CustomValidation {
    Rule rule();
}
