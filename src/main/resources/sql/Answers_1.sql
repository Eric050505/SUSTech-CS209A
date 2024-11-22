insert into JavaProject.Answers (answer_id, question_id, body, creation_date, score, is_accepted, owner_user_id)
values  (79186756, 79186640, 'So the issue was actually in the filepath, it specifies "univ" instead of "univ.db". It confused me because despite the blunder, the connection was still being established so I was looking for the problem elsewhere. When creating the database it created univ and univ.db, whatever univ is, it doesn''t have the tables I created.
conn = DriverManager.getConnection("jdbc:sqlite:C:/sqlite/univ.db");

', '2024-11-14 05:35:18', 1, 0, 14993783),
        (79187245, 79187141, 'There''s no magic to it; it''s actually based on time slicing. The reason why your physical machine has only 10 CPU core, but you see a significant improvement in response time when your JVM threads exceed 10, is because your service load is I/O-bound—it''s an I/O-intensive program. I/O does not consume CPU time slices because modern operating systems handle I/O asynchronously (this is independent of the programming language you''re using; at the lower level, it''s triggered by interrupts rather than the CPU waiting in a busy loop).
You could consider changing your service load to something like a for loop, for example, running for 10^9 iterations. In this case, when the number of concurrent requests exceeds your CPU core, you''ll see that increasing the number of JVM threads beyond the number of CPU core doesn''t help with response time. In fact, as the JVM threads count increases, the response time may gradually increase because the number of CPU core hasn''t increased, and adding JVM threads introduces the overhead of context switching.
', '2024-11-14 10:46:42', 1, 0, 25551604),
        (79187542, 79186968, 'Apparently you are asking to eliminate duplicate objects where “duplicate” means having both the same id and the same email. But then you test for a third field, a date-time string. So the same id and email cannot be considered duplicates unless the date-time is also the same.
Example:
record Lead ( int id , String email , String when ) {}

Lead x = new Lead ( 1 , "alice@example.com" , "2024-01-23T12:30:00" ) ;
Lead y = new Lead ( 1 , "alice@example.com" , "2024-11-07T09:00:00" ) ;

These are not duplicates by your rules. The date-time text differs, so these two objects are not equal given your three-field test.

By the way, you can greatly simplify your code using the convenience methods found on Comparator. This untested code might work:
SequencedSet < Lead > leads =
    new TreeSet <> (
        Comparator
        .comparing ( Lead :: id ) 
        .thenComparing ( Lead :: email ) 
        .thenComparing ( Comparator.comparing ( Lead :: when ).reversed() )
    );
leads.addAll( myLeads ) ;

Our example above should sort in the order: [ y , x ].
', '2024-11-14 13:53:48', 2, 0, 642706),
        (79187561, 79187141, 'This is simplified in many ways but should get you the idea of what''s going on.

JVM Threads (assuming non virtual) are OS/platform threads. But they are not CPU cores. You can have more JVM threads than CPU cores.

It''s true that having more threads than CPU can degrade performance, but only if these threads are busy working.

Tomcat threads are 1 thread per request and in your case each request calls some other resources, so it''s doing IO, not CPU work. You''re what we call IO-bound.

So, in your case, having 200 threads doing almost nothing is not an issue. On the other hand, having only 10 threads would mean that even though they are not used (waiting for IO), you could only have 10 request accepted at the same time.

This is where blocking vs. async is something. If your code was using async stuff (instead of blocking), you would not need 200 threads, only 10 threads would deliver same performance (assuming 10 CPU cores) because they would be available to use when "waiting for IO" instead of being blocked.

This is where virtual threads become a thing: they "automatically transform" blocking code into async code.


EDIT: If you use a visual tool like VisualVM to connect to your JVM and observe threads in live ("Monitor threads" tab I believe, not profiling), this will probably clarify this as well in a visual way seeing threads running or not.
', '2024-11-14 14:07:33', 3, 1, 5389127),
        (79187634, 79186629, 'Awaitility supports that use-case with ConditionFactory#pollInSameThread

Instructs Awaitility to execute the polling of the condition from the same as the test. This is an advanced feature and you should be careful when combining this with conditions that wait forever (or a long time) since Awaitility cannot interrupt the thread when it''s using the same thread as the test. For safety you should always combine tests using this feature with a test framework specific timeout

It should work similar to this for your example code:
    await().pollInSameThread().atMost(10, SECONDS).until(myService::checkCondition);

', '2024-11-14 14:42:23', 1, 1, 5162472),
        (79187886, 79187855, 'Overflow can occur when min<0 and hence max - min is greater than Long.MAX_VALUE.
The obvious answer is to use a BigInteger Otherwise you can check for the exact condition and calculate.
An overflow will occure for the following condition.
if( min < 0 && max>0 && max - Long.MAX_VALUE > min )

In that case range will only be larger than Long.MAX_VALUE if the step==1 or step==2 && min==Long.MIN_VALUE && max==Long.MAX_VALUE. The following equation will cover any other case.
long range = max/step - min/step + (max%step - min%step)/step + 1;

Then our condition becomes.
if( min < 0 && max > 0 && max - Long.MAX_VALUE > min ){
    if( step != 1 ){
        long range = max/step - min/step + (max%step - min%step)/step + 1;
        return range > 0 ? 
          min + ThreadLocalRandom.current().nextLong(range)*step 
          : ThreadLocalRandom.current().nextLong();
    } else{
        long half = max/2 - min/2;
        
        if(ThreadLocalRandom.current().nextBoolean()){
            //pic low
            return return min + ThreadLocalRandom.current().nextLong(half);
        } else{
            long upper = max - half - min;
            return half + min + ThreadLocalRandom.current().nextLong(upper);
        }
    }
}

Another way to manage this is to use the built in RandomGenerator.nextLong(min, max)
min%step + ThreadLocalRandom.current().nextLong( min/step, max/step )*step

This avoids the (max - min ) calculation altogether. The problem is that upper bound is not included. To avoid that we can add 1 to the upper bound.
long upper = max/step == Long.MAX_VALUE ? max/step : max/step + 1;

', '2024-11-14 16:22:21', 1, 1, 2067492),
        (79188292, 79188028, 'Adding Swagger documentation to a non-Spring Boot Spring 5 project can feel a little tricky at first since most examples are aimed at Spring Boot. Let’s go over the options and make it simple to follow along.
For a Spring 5 (non-Spring Boot) project, you’ve got two main options: Springdoc OpenAPI and Springfox. Let''s dive into each option and go over the steps to get it running.

Option 1: Springdoc OpenAPI
Recommended
Springdoc OpenAPI is modern, actively maintained, and works well with newer Spring and OpenAPI specifications. Although it’s mostly aimed at Spring Boot, you can make it work for standard Spring MVC projects too. Here’s how:

Add Dependencies: Open your pom.xml (assuming you’re using Maven) and add these dependencies to include springdoc-openapi and spring-webmvc.
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-ui</artifactId>
    <version>1.8.0</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-webmvc</artifactId>
    <version>5.3.39</version>
</dependency>


Set Up a Configuration Class: Since we’re not using Spring Boot, we’ll need a custom configuration class to load the OpenAPI settings manually. Add a new Java class called OpenApiConfig, and configure it like this:
import org.springdoc.core.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    public GroupedOpenApi publicApi() {
        return GroupedOpenApi.builder()
                .group("public")
                .pathsToMatch("/api/**")
                .build();
    }
}



This setup tells Springdoc to scan for all endpoints under /api/** paths and include them in the generated documentation.

Access the Swagger UI: After setting up, start your application. Then, open your browser and go to http://localhost:8080/swagger-ui.html to see your API documentation in action!


Option 2: Springfox
An Alternative Option
Springfox was a popular choice for generating Swagger documentation, but it’s less maintained nowadays. It can work with Spring 5 for basic Swagger functionality, though it lacks some newer features of OpenAPI.
To use Springfox:

Add Dependencies: Add these dependencies to your pom.xml.
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger2</artifactId>
    <version>3.0.0</version>
</dependency>
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger-ui</artifactId>
    <version>3.0.0</version> <!-- the latest version was in 2020 -->
</dependency>


Create a Swagger Configuration Class: Like with Springdoc, create a SwaggerConfig class to specify how Springfox should scan your APIs.
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;

@Configuration
public class SwaggerConfig {

    @Bean
    public Docket api() {
        return new Docket(DocumentationType.SWAGGER_2)
                .select()
                .apis(RequestHandlerSelectors.any())
                .paths(PathSelectors.any())
                .build();
    }
}


Access Swagger UI: Start your application, and visit http://localhost:8080/swagger-ui/ to view the documentation.



Which one to choose?

Use Springdoc OpenAPI if you want the latest features and smoother support with modern Spring versions. It’s especially good if you might need to support OpenAPI 3.0 or other new specs.
Use Springfox if you only need basic Swagger support and don’t require advanced features, as it’s simpler but less feature-rich.

', '2024-11-14 18:22:43', 0, 0, 2774914),
        (79188387, 79187901, 'Tomcat 11 is designed to support only Servlet 6.1 and Jakarta EE 11 by default, as it implements the Jakarta Servlet 6.1 specification. Release notes.
However, Tomcat is generally backward compatible with older Servlet API versions. This means that if you deploy an application that targets an older Servlet specification (e.g., Servlet 5.0), it may still work with Tomcat 11, but there could be issues related to namespace changes, as Tomcat 11 has fully moved to the jakarta.servlet namespace.
Servlet 5.0 API is under the javax.servlet namespace, following the Java EE conventions, which can cause compatibility issues with Tomcat 11. You would need to refactor older applications (which use javax.servlet) to be compatible with the Jakarta namespace (i.e., jakarta.servlet) to run them on Tomcat 11.
', '2024-11-14 18:40:20', 1, 1, 2774914),
        (79188542, 79186800, 'That is a bit strange but problem was with Coupon and UnderlyingUsage classes. They were also extending other classes and I had to add annotations to them as well. Once annotations for whole hierarchy for Coupon and UnderlyingUsage were added then error disappeard.
So if someone will face the same issue please look into all classes related to the one which you change.
', '2024-11-14 19:25:41', 0, 0, 4952262),
        (79188769, 79187855, 'The Math API has several ~Exact methods that can throw an exception on arithmetic overflow.
public static long random (long min, long max, int step) {
  if (step <= 0) {
      throw new IllegalArgumentException("step must > 0");
  }
  if (max < min) {
      throw new IllegalArgumentException("invalid range! min must <= max");
  }
  try {
    long range = Math.subtractExact (max , min) / step + 1;
    long randomIndex = ThreadLocalRandom.current().nextLong(range);
    return min + randomIndex * step; 
    }
    catch (ArithmeticException ex) {
        throw new IllegalArgumentException 
            ("Invalid range! max - min results in arithmetic overflow");
    }        
}

', '2024-11-14 20:36:48', 1, 0, 5103317),
        (79188782, 79188335, 'first thing you have to do is to exclude  swagger endpoint from your security context (SecurityFilterChain), you already did the configuration in WebSecurityCustomizer , no need to do it again .
what you need  is :
  @Bean
  public WebSecurityCustomizer webSecurityCustomizer() {
  return (web) ->
    web.ignoring()
        .requestMatchers(
            new AntPathRequestMatcher("/user/**"),
                new AntPathRequestMatcher("/v3/api-docs/**"),
                new AntPathRequestMatcher("/swagger-ui/**"),
                new AntPathRequestMatcher("/swagger-ui.html")
        )
  ; 
  }

application.properties (you can change it to yml) :
springdoc.api-docs.enabled=true
springdoc.swagger-ui.path=/swagger-ui.html
springdoc.swagger-ui.enabled=true
springdoc.swagger-ui.operationsSorter=method
springdoc.swagger-ui.tryItOutEnabled=true
springdoc.swagger-ui.filter=true
springdoc.swagger-ui.tagsSorter=alpha
springdoc.api-docs.path=/v3/api-docs

finaly you can keep your OpenAPI() as it is or :
    @OpenAPIDefinition(
        info = @Info(
                contact = @Contact(
                        name = ""
                ),
                description = "",
                title = "",
                version = "",
                license = @License(
                        name = "",
                        url = ""
                ),
                termsOfService = "Terms of service"
        ),
        servers = {
                @Server(
                        description = "Local ENV",
                        url = ""
                ),
                @Server(
                        description = "PROD ENV",
                        url = ""
                ),
                @Server(
                        description = "TEST ENV",
                        url = ""
                )
        },
        security = {
                @SecurityRequirement(
                        name = "bearerAuth"
                )
        }
)
@SecurityScheme(
        name = "bearerAuth",
        description = "JWT auth description",
        scheme = "bearer",
        type = SecuritySchemeType.HTTP,
        bearerFormat = "JWT",
        in = SecuritySchemeIn.HEADER
)

@Configuration
public class SwaggerConfig {

 @Bean
public GroupedOpenApi api() {
    return GroupedOpenApi.builder()
            .group("us/cargosphere/**")
            .pathsToMatch("/**")
            .packagesToExclude("/error.**")
            .build();
}

}
', '2024-11-14 20:42:46', 0, 0, 19086479),
        (79188899, 79188697, 'There needs to be a mapping from constraint annotation to the validators that are used to enforce the constraint. For out-of-the-box annotations these validators are mapped by the framework implementation (usually Hibernate Validator). For custom annotations that''s usually done through the validatedBy annotation attribute. The only other way is to add this mapping programmatically. I don''t think that can be done with ConstraintValidatorFactory as suggested by Sharad Paul because that already needs the validator class.
I''ve found that Hibernate''s ConstraintDefinitionContext interface has a method to add a validator to a constraint, but I couldn''t find a way to use it without overwriting all of the annotation-based constraint mappings.
I''ve also found ServiceLoaderBasedConstraintMappingContributor that, according to How to register custom ConstraintMapping for validations defined in validation-constraints.xml, should allow you to provide your validators through the ServiceLoader mechanism. Perhaps this is the most flexible you''re going to get.
', '2024-11-14 21:11:52', 0, 0, 1180351),
        (79189051, 79188999, 'In terms of built-in functionality in the Java platform itself, this became slightly less impossible in Java 9 when the standard library was broken into many smaller modules, allowing one to create a smaller runtime environment with only specific modules. (See jlink.)
Unfortunately, the fundamental module that all Java programs require, java.base, is still quite large and contains a lot of functionality that a teacher may want to restrict. (See the JavaDoc for a list of all packages it includes.)
However, for more complex things like "write code to parse this XML", it would allow one to slice away the built-in XML parsing module from the runtime.
', '2024-11-14 21:52:45', 3, 0, 1701776),
        (79189054, 79188940, 'There are many ways to solve this.  I''ll give you the simplest:
Wrap the whole thing in a transaction, and don''t worry about services interacting with each other, that''s normal.  Worry if the number of services one service interacts gets to 10 or so, then it''s probably time for a refactor.
You could expand this by going full DDD and use domain events, but that''s a pretty significant structural change to your app and the juice may not be worth the squeeze.
', '2024-11-14 21:53:21', 0, 0, 229743),
        (79189057, 79188812, 'You can''t call the ''worst matching'' method.
The only way you can achieve your desired outcome, is the one you already described at the end of your code, so yes, you need to create a new array for the method call.
To generalize the solution: You need to adjust the parameter-types you provide when you call a method. This might require creating a new array and sometimes it will be enough to cast your object to another one.
', '2024-11-14 21:54:08', 0, 0, 18497695),
        (79189159, 79189148, 'I think your problem arises where you create a string from a byte array.
String htmlContent = new String(Files.readAllBytes(htmlFile.toPath()));

Since you aren''t passing a charset to the string constructor, the default charset is used (will be different on unix/linux vs windows). See Charset.defaultCharset().
I''m guessing the default charset is not the same as the html file''s encoding which causes issues with special characters.
Option 1 - pass a charset to the string constructor
Charset charset = Charset.forName("UTF-8")); // TODO use the same as the file encoding
byte[] bytes = Files.readAllBytes(htmlFile.toPath());
String htmlContent = new String(bytes, charset);
renderer.setDocumentFromString(htmlContent);

Option 2-  skip the conversion to string and use a reader instead
Charset charset = Charset.forName("UTF-8")); // TODO use the same as the file encoding
try (Reader reader = new InputStreamReader(new FileInputStream(htmlFile), charset) {
   renderer.setDocumentFromReader(reader);
}

', '2024-11-14 22:24:49', 1, 0, 1089967),
        (79189242, 79189148, 'First it is nice to immediately use Unicode. I see two issues here.
As already said, the encoding defaults to the platform encoding. Which is not portible.
    String htmlContent = new String(Files.readAllBytes(htmlFile.toPath(), StandardCharsets.UTF_8));

    String htmlContent = Files.readString(htmlFile.toPath())); // Default UTF-8

And the delivered HTML file should indicate its encoding too - to be consistent.
The actual text encoding must be checked.
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
</head>
<body>
<div>
    <p>
        čččččLorem ipsum dolor šit amet, consečtetur adipisčing elit. Vestibulum acčumsan metuš pharetra urna efficitur, ac congue justo commodo. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed et faucibus lectus. Suspendisse euismod tincidunt pretium. Aliquam porttitor ornare magna. Maecenas eget cursus arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Praesent sodales commodo varius. Maecenas pellentesque velit vitae orci eleifend egestas. Aenean aliquet elit lorem, non maximus sapien efficitur a.
    </p>

</div>
</body>
</html>


Reacting on the comment
The fact that šž are shown but č not rings a bell.

In Latin-1, ISO-8859-1, šžč are not present.
In Windows Latin-1, Code Page 1252, šž are in the added block U+0080 .. U+009F. Here also č goes missing.

This seems to indicate that somewhere Windows Latin-1 is involved, maybe in the font rendering. Inspect the properties of the generated PDF, fonts and such. You already took some care. I know using Unicode for PDF generation needs extra config, but I do not know.
', '2024-11-14 22:44:36', 0, 0, 984823),
        (79189265, 79189220, 'This is because you are not supposed to uncomment the definition of ListNode. It is given to you by the "driver" part of the application (which contains a main function that tests your implementation). The comment is there just for your documentation.
In reality, the ListNode class has some more methods than the ones shown in the comment: the deserialize method is one of them, hence the error you get about the missing method.
The comment shows you only those methods of ListNode that are relevant to you. The rest of the class''s definition is purely for the use of LeetCode.
', '2024-11-14 22:49:11', 2, 0, 13963086),
        (79189352, 79188968, 'You can achieve this with a trick: You generate a key pair and force the key pair generator to use your private key instead of generating a new one. With this procedure, the public key in question is implicitly derived using the built-in EC arithmetic (which you otherwise have no access to, as this is not exposed):
import java.security.KeyPairGenerator;
import java.security.SecureRandom;
import java.security.spec.NamedParameterSpec;
import java.util.Arrays;
...
byte[] rawPrivateKey = {...}; // 32 bytes raw private key
KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("Ed25519");
keyPairGenerator.initialize(new NamedParameterSpec("Ed25519"), new SecureRandom() {
    public void nextBytes(byte[] bytes) {
        System.arraycopy(rawPrivateKey, 0, bytes, 0, rawPrivateKey.length);
    }
});
byte[] spki = keyPairGenerator.generateKeyPair().getPublic().getEncoded(); // public key in SPKI format; the last 32 bytes are the raw public key
byte[] rawPublicKey = Arrays.copyOfRange(spki, spki.length - 32, spki.length); // 32 bytes raw public key

For the key generation to apply the specified private key, a derivation of SecureRandom is required to overwrite nextBytes() in a suitable way, which is implemented in the code above using an anonymous class.
This works on Java 15+ without additional libraries. The approach is based on this post, which describes how to extract a public key from the private key for X25519 in this way.
', '2024-11-14 23:05:59', 1, 1, 9014097),
        (79189374, 79189348, '
        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
            <version>2.6.0</version>
        </dependency>

Use this one. Remove any other configuration you might have added.
Access it on ${baseUrl}/swagger-ui/index.html
', '2024-11-14 23:11:30', 2, 1, 13719128),
        (79189417, 79188963, 'Model classes should generally be final.
Abstract classes are incomplete classes with few method implementations pending.
If you want an Entity which is abstract, you are perhaps trying to implement some feature on top of your entity.
You can do that, but it wouldn''t be advisable.
Those logics you can be put inside a service class which will perform the CRUD operation. This fulfils "Single Responsibility" principle
', '2024-11-14 23:22:28', 0, 0, 13719128),
        (79189467, 79189182, 'You can use compare by ignoring fields from AssertJ library.
var actualList = service.getActualList(...);

assertThat(actualList)
    .usingRecursiveFieldByFieldElementComparatorIgnoringFields("f2")
    .containsExactlyInAnyOrder(
        new MyDto("a1", "", "c1"),
        new MyDto("a2", "", "c2")
    );

Or if you still want to use Hamcrest, then create custom comparator as per your wish and then use
assertTrue(myDto1.customCompareTo(myDto2));

', '2024-11-14 23:38:17', 0, 0, 13719128),
        (79189491, 79189182, 'You can use containsInAnyOrder(Matcher...) and pass a vararg list of Matcher instances instead of a list of MyDto. You may be able to find a suitable Matcher from the Hamcrest library, such as perhaps HasPropertyWithValue or something similar. Otherwise, write your own class implementing Matcher:
class MyMatcher implements Matcher<MyDto> {
    private final MyDto expected;

    public MyMatcher(MyDto expected) { this.actual = expected; }

    @Override
    public boolean matches(MyDto actual) {
        return actual.abc = expected.abc && actual.xyz = expected.xyz;
    }
}
...
assertThat(actualList, containsInAnyOrder(MyMatcher(new MyDto(...)),...));

', '2024-11-14 23:45:17', 2, 1, 13963086),
        (79189497, 79188355, 'Why not use basic HttpClient
<dependency>
    <groupId>org.apache.httpcomponents</groupId>
    <artifactId>httpclient</artifactId>
    <version>4.5.14</version>
</dependency>


or you can use RestTemplate or WebClient depending upon your requirement.
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-web</artifactId>
    <version>3.0.2.RELEASE</version>
</dependency>


Since you are trying to setup headers, you are not testing UI but rather your endpoints.
Selenium is not supposed to be used like this.
Selenium automates actions by a user in browser. Since user doesn''t/cannot specify header, you shouldn''t try that either.
', '2024-11-14 23:47:28', 0, 0, 13719128),
        (79189585, 79189560, 'In this case, perhaps the easiest solution is to remove the old access if any, i.e. int getXyz() and void setXyz(int v), and replace them with a synthetic property of type boolean:
public void setNewProperty(boolean value) {
    this.old = value ? 1:0;
}

public boolean isNewProperty() {
    return old == 1;
}

', '2024-11-15 00:10:11', 1, 0, 306030),
        (79189701, 79188831, 'SELECT new Test(T) FROM Test T

The first results in one query to fetch references and N queries to fetch properties for each entity due to lazy loading (N+1).
SELECT new TEST(T.name, T.city) FROM TEST T

The second retrieves all data in a single query due to eager loading. By specifying the exact fields, you allow JPA to optimize the query.
', '2024-11-15 00:41:49', 0, 0, 27294211),
        (79189752, 79189582, 'Add the parallel thread configuration in maven-surefire-plugin
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-surefire-plugin</artifactId>
            <version>2.22.2</version>
            <configuration>
                <parallel>methods</parallel>
                <threadCount>2</threadCount>
            </configuration>
        </plugin>
    </plugins>
</build>


Also create 2 suites in TestNG file
<!DOCTYPE suite SYSTEM "https://testng.org/testng-1.0.dtd">
<suites>
    <!-- Suite 1 -->
    <suite name="Suite A">
        <test name="Test A1">
            <classes>
                <class name="de.bla.blubb1.RunBlubb1CucumberTest"/>
            </classes>
        </test>
    </suite>

    <!-- Suite 2 -->
    <suite name="Suite B">
        <test name="Test B1">
            <classes>
                <class name="de.bla.blubb2.RunBlubb2CucumberTest"/>
            </classes>
        </test>
    </suite>
</suites>

', '2024-11-15 00:59:35', -1, 0, 24079977),
        (79189925, 79189747, 'I''ve got the same problem after updating my Android Studio to Ladybug (yes, bug)
Try to

download and install JDK 17
set JAVA_HOME environment variable
set GRADLE JDK in Android Studio (Settings -> Build, Ex... -> Build Tools -> Gradle) to that location
and try again.

', '2024-11-15 01:55:48', 0, 0, 518279),
        (79190127, 79189220, 'There are many roads that lead to Rome, surely the one that follows these lines is not the most optimal, but it may serve as a starting point.
ListNode swapPairs( ListNode head ) {
   if( head == null || head.next == null ) {
      return head;
   }

     // the following lines create a list, and load all nodes into it.
   List<ListNode> lista = new ArrayList<>();
   lista.add( head );
   while( head.next != null ) {
      lista.add( head.next );
      head = head.next;
   }

   for( int i = 0; i < lista.size(); i += 2 ) {
        
        // in this line, we assign to the last node of the previous iteration, its new “next”.
      if( i > 1 ) lista.get( i - 2 ).next = lista.get( i + 1 );

        // we proceed to exchange references to “next”.
      ListNode a = lista.get( i );
      ListNode b = lista.get( i + 1 );
      a.next = b.next;
      b.next = a;
   }

     // we return the second member of the list, which now becomes “head”.
   return lista.get( 1 );
}

', '2024-11-15 03:05:54', 0, 0, 20882864),
        (79190171, 79190132, 'Avoid char
The char type has been essentially broken since Java 2, legacy since Java 5. As a 16-bit value, char is physically incapable of representing most of the 154,998 characters defined in Unicode.
Do not use char. Do not call String#length. Do not call charAt.
Code point
Learn to use only code point integer numbers to work with individual characters.
You will find code point related methods on various classes, such as String, StringBuilder, and Character.
int[] codePoints = “😷".codePoints().toArray() ; // One character, one code point. But `String#length` reports `2`. So don’t call `String#length`. 

Be aware that what the human reader perceives as a single character may be composed of multiple code points. In this next example we use a COMBINING ACCENT ACUTE (code point: U+0301 hex, 769 decimal) as the fifth code point.
String x = "cafe\\u0301" ;

Alternate syntax:
String x = new StringBuilder( "cafe" ).appendCodePoint( 769 ).toString() ;

The naïve reader perceives four characters, but the text is actually composed of five code points. Get the count of code points:
long countCodePoints = x.codePoints().count() ; 

See this code run at Ideone.com.

café
5

See each of the code points.
x.codePoints().forEach( System.out :: println ) ;

When run:
99
97
102
101
769

See the name of each code point.
x.codePoints ( ).mapToObj ( Character :: getName ).forEach ( System.out :: println );

LATIN SMALL LETTER C
LATIN SMALL LETTER A
LATIN SMALL LETTER F
LATIN SMALL LETTER E
COMBINING ACUTE ACCENT

', '2024-11-15 03:20:46', 1, 1, 642706),
        (79190204, 79190174, '    BigInteger number = new BigInteger(textField.getText());
    try{
        code.primeDetector(number);

The issue here is that the BigInteger construction is not inside the try block, so it won''t be handled by the corresponding catch block. So it should be moved in.
    try{
        BigInteger number = new BigInteger(textField.getText());
        code.primeDetector(number);

', '2024-11-15 03:42:19', 1, 0, 359035),
        (79190323, 79190292, 'Your''e looking at a class definition, not at an object, i.e. an instance of a class. If Animal is a base class that defines the String name() method, and Cat is a subclass of Animal, a Cat instance (object) will inherit thename() method.
', '2024-11-15 04:25:13', 0, 0, 306030),
        (79190339, 79190292, 'An object is current instance of the class. Here is a simple example:
public class B extends A{
    int getResult() {
        int result = calculate();
        return result;
    }

    public static void main(String[] args) {
        B b = new B();
        System.out.println(b.getResult());
    }
}

class A {
    int calculate() {
        return 2 * 2;
    }
}

Class B extends class A and inherits its method calculate(). Inside its method getResult() we can see calling of latter method without an object. But object is supposed. This is any instance of the class B. In this context calculate() is equivalent to this.calculate().
Inside the main method of the class B an instance of this type is created. And then getResult method called for this object. And inside this method  method calculate() is called for this object too. If you run the program, you can see the output of 4 in the console.
', '2024-11-15 04:31:20', 2, 0, 3298931),
        (79190370, 79190330, 'If you read, for example, this question on a similar topic, you''ll see that there is a problem with TestNG''s policy of creating only one instance per test class, and how to reset state if the test should be run in parallell.
I guess that in your case, you shouldn''t have made the init method @BeforeClass, but rather @BeforeMethod, or perhaps @BeforeTest (don''t remember the exact names).
', '2024-11-15 04:44:42', 1, 1, 306030),
        (79190397, 79190069, 'I think, judging from the JDBC docs that "auto commit" is defaulting to true.

Which given "true autocommit" of false, would result in transactions not being used.
I suspect you need to set "auto commit" to false.
Note that this will require that the tables you''re writing to be journaled.
', '2024-11-15 04:57:20', 0, 0, 2933177),
        (79190408, 79190387, '"https://gorest.co.in/public/v2/posts"
This returns a list of posts. So it doesn''t have id as a parameter.
Try using .body("find { it.id == 167039 }.id", equalTo(167039))
', '2024-11-15 05:00:56', 0, 0, 13719128),
        (79190428, 79190090, 'I know I shouldn''t do this.
Anyways, try below code.
try {
        ResponseEntity<String> exchange = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);
        return PipsUtils.roundToTwo(Float.parseFloat(Objects.requireNonNull(exchange.getBody())));
} catch (ResourceAccessException e) {
       // I don''t know return type of PipsUtils.roundToTwo
        return PipsUtils.roundToTwo(0f); 
}

', '2024-11-15 05:06:43', 0, 0, 13719128),
        (79190713, 79190292, 'I understand about classes, objects, this keyword, constructors, and instantiation.  That''s the reason I''m asking the question.
Without an object, this expression:
ERROR = setParamForNamedCallableStatement(lstSqlParams, inputDataMap, daoInputMapDef, ncs){};
            

Should fail to compile, but it doesn''t.
It''s not a static method.
This is a Struts 2 project.
', '2024-11-15 07:26:59', 0, 0, 28305211),
        (79191049, 79190173, 'You are using sequence. So better annotate with GenerationType.SEQUENCE
@GeneratedValue(strategy = GenerationType.SEQUENCE)

Just make sure your ddl-auto is not set to create table everytime. Else the sequence will not work as expected.
Product class:
@Entity
@Table(name = "product")
public class Product {

    @GeneratedValue(strategy=GenerationType.SEQUENCE)
    @Id
    private String id;
}


I executed save 3 times, below is the result.
https://snipboard.io/ljnsbc.jpg
Infact both identity and sequence works if you don''t do any auto ddl change. Database will take care of this.
', '2024-11-15 11:55:59', 0, 0, 13719128),
        (79191059, 79190892, '
I can write to my Firebase Firestore database, but am unable to read from it.

That is normal behavior because all Firebase Firestore operations are asynchronous. What you are trying to do is to read the data that comes from the addition of two different users, which is not quite possible because both addition operations take time. So by the time you''re trying to read the data, the addition operations are not complete, so the data is not available so it can be read. The solution is always the same. All async operations that should be performed as a result of other async operations, need to be inside the onSuccess/onComplete method or be called from there.
So if you need to read the data of both users, then you have to make sure that both operations of adding the data to Firestore are successful. You can achieve this by using custom callbacks or by nesting the calls:
db.collection("users").add(user).addOnSuccessListener {

    //Add it inside onSuccess
    db.collection("users").add(user).addOnSuccessListener {

        //Add it inside onSuccess
        db.collection("users").get().addOnCompleteListener{
            //Your logic.
        }
    }
}

Because you''re using Java, you might consider using observable objects live LiveData.
If you are considering learning Kotlin at some point in time, which I highly recommend, then you should consider using Kotlin Coroutines. In this way, you''ll be able to wait for the operation to complete in a simpler and more efficient way. Please check below some resources:

How to return a DocumentSnapShot as a result of a method?
How to write a method in Kotlin that will return a string from Firestore?

', '2024-11-15 12:04:00', 0, 1, 5246885),
        (79191111, 79191016, 'There''s no way to have java read and apply the Class-Path entry from the jar classpath while also adding some additional paths to the classpath on top.
Hence, you''d have to reproduce the entire class-path as stated in the jar file, and then run java -cp MyApp.jar:/app/resource:/replicate/all/entries/from/jar/manifest/here com.foo.Main.
Alternatively, ensure the Class-Path entry in the jar lists some jar that doesn''t exist, and then you make it, put it in the right place, and run with java -jar myapp.jar from there.
', '2024-11-15 12:38:00', 0, 0, 768644),
        (79191194, 79191176, 'Don''t use JavaScriptExecutor
public static String blobToBase64(InputStream blobInputStream) throws IOException {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        byte[] buffer = new byte[8192];
        int bytesRead;

        while ((bytesRead = blobInputStream.read(buffer)) != -1) {
            byteArrayOutputStream.write(buffer, 0, bytesRead);
        }
        
        byte[] byteArray = byteArrayOutputStream.toByteArray();
        return Base64.getEncoder().encodeToString(byteArray);
    }

This input stream you can get from http url
HttpURLConnection connection = (HttpURLConnection) url.openConnection();
connection.getInputStream();// this is what you will need to invoke above method

', '2024-11-15 13:32:12', 0, 0, 13719128),
        (79191417, 79191221, 'I would try to use an environment variable first. For instance, set an environment variable ENCRYPTED_KEYSTORE_PASSWORD, decrypt it at runtime, and set the System.setProperty("javax.net.ssl.keyStorePassword", decryptedPassword); before initiating the SSL configuration.
If that doesn''t work, you can also try creating a small Java class that reads an encrypted password, decrypts it, and then sets it as a system property. This can be integrated into the initialization of your webapp-runner.jar.
', '2024-11-15 15:27:12', 0, 0, 28257951),
        (79191532, 79191468, 'Remove android:fillAfter="true" from your animation XML and set android:repeatCount="infinite" in the parent <set> tag instead of repeatCount="3". The fillAfter was keeping each animation in its final state, preventing proper looping.
<?xml version="1.0" encoding="utf-8"?>
<set
   xmlns:android="http://schemas.android.com/apk/res/android"
   android:interpolator="@android:anim/linear_interpolator"
   android:repeatCount="infinite"
   android:repeatMode="restart">
  <!-- move down -->
  <translate
      android:fromYDelta="0%"
      android:toYDelta="50%"
      android:duration="1500"/>

  <!-- move up -->
  <translate
      android:fromYDelta="50%"
      android:startOffset="1500"
      android:toYDelta="-50%"
      android:duration="1500"/>

  <!-- continue to move up -->
  <translate
      android:fromYDelta="-50%"
      android:startOffset="3000"
      android:toYDelta="-20%"
      android:duration="600"/>

  <!-- down to original pos -->
  <translate
      android:fromYDelta="-20%"
      android:startOffset="3600"
      android:toYDelta="0%"
      android:duration="600"/>

</set>

That''s all you need to make it loop infinitely.
', '2024-11-15 16:17:16', 0, 0, 6895166),
        (79191667, 79191438, 'Use
public static <T extends CsvFile> List<T> readCsvFile(Class<T> fileClass, String filePath) throws IOException, ReflectiveOperationException 

Also. Why not use existing library? Your is not proper csv parser.
', '2024-11-15 16:59:27', 0, 0, 3656904),
        (79191700, 79191671, 'Found it!
The problem is both ''alfresco-access'' and ''tagging'' keys are being duplicated and you cannot such situation. Both files are core ones, inside alfresco standard libs.
So I found It had a duplicated library, alfresco-repository-20.X and alfresco-repository-21.Y added with amps and customization to the Alfresco Installation.
I removed the oldest one and the error disappeared
', '2024-11-15 17:11:08', 1, 0, 3699649),
        (79191848, 79191622, 'try update swagger configuration class and swager ui to use the correct https url for api:
@Configuration
public class SwaggerConfig {
@Bean
public OpenAPI customOpenAPI() {
    return new OpenAPI()
            .servers(List.of(new Server().url("https://exciting-wonder-production.up.railway.app")));
}
}

replace .allowedOrigins("*") with your deployed url .allowedOrigins("https://exciting-wonder-production.up.railway.app")
@Configuration
public class WebConfig implements WebMvcConfigurer {
@Override
public void addCorsMappings(CorsRegistry registry) {
    registry.addMapping("/**")
            .allowedOrigins("https://exciting-wonder-production.up.railway.app")
            .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
            .allowedHeaders("*")
            .allowCredentials(true);
}
}

', '2024-11-15 17:51:56', 0, 0, 9215257),
        (79191869, 79191468, 'You should change countRepeat attribute to value infinite. And move it into the first translate tag.
<?xml version="1.0" encoding="utf-8"?>
<set xmlns:android="http://schemas.android.com/apk/res/android">
<!-- move down -->
<translate
    android:fromYDelta="0%"
    android:toYDelta="50%"
    android:duration="1500"
    android:fillAfter="true"
    android:repeatCount="infinite"
    android:interpolator="@android:anim/linear_interpolator"/>

<!-- move up -->
<translate
    android:fromYDelta="0%"
    android:startOffset="1500"
    android:toYDelta="-50%"
    android:duration="1500"
    android:fillAfter="true"/>

<!-- continue to move up -->
<translate
    android:fromYDelta="0%"
    android:startOffset="3000"
    android:toYDelta="-20%"
    android:duration="600"
    android:fillAfter="true"/>

<!-- down to original pos -->
<translate
    android:fromYDelta="0%"
    android:startOffset="3600"
    android:toYDelta="20%"
    android:duration="600"
    android:fillAfter="true"/>

', '2024-11-15 17:58:06', 0, 0, 3298931),
        (79191968, 79191779, 'The FileChannel.map call which creates the mapping has long size but the Javadoc says:

The size of the region to be mapped; must be non-negative and no
greater than Integer.MAX_VALUE

So an int value is sufficent to set the position inside the map.
For Java 22 onwards the Foreign Functions and Memory support adds an alternative version of FileChannel.map which returns a MemorySegment which doesn''t have the size restriction.
', '2024-11-15 18:22:03', 1, 1, 2670892),
        (79192056, 79191954, 'Ok, the problem was this method:
  @GetMapping("/{id}")
  public ResponseEntity<PlanDeEntrenamiento> getPlanes(@PathVariable String id) {
    PlanDeEntrenamiento planDeEntrenamiento = planDeEntrenamientoDAO.findById(id).orElseThrow();
    return ResponseEntity.ok(planDeEntrenamiento);
  }

I have deleted it because I see there is no need for it, I had it because some test I did before and then didn''t delete it. After deleting it, every put or patch to "/{id}" started working again. However, if someone can explain this to me that would be helpful.
', '2024-11-15 18:53:53', 0, 0, 20123929),
        (79192089, 79191715, 'The problem in your case is that the convertCreateTime method expects the entire UndoIssue object.
Instead of passing the entire UndoIssue object to the convertCreateTime method, you must pass the required fields directly.
Here is the solution way shown below
Changed @Mapping(target = "createTime", qualifiedByName = "convertCreateTime") to @Mapping(target = "createTime", source = ".", qualifiedByName = "convertCreateTime")
Here is the updated your code shown below
@Mapper
public interface UndoIssueConvert {
    UndoIssueConvert INSTANCE = Mappers.getMapper(UndoIssueConvert.class);

    @Mappings({
            @Mapping(target = "undoIssueId", source = "id"),
            @Mapping(target = "createTime", source = ".", qualifiedByName = "convertCreateTime")
    })
    UndoIssuePanelRspVO.UndoIssue toUndoIssue(UndoIssue undoIssue);

    List<UndoIssuePanelRspVO.UndoIssue> toUndoIssue(List<UndoIssue> undoIssue);

    @Named("convertCreateTime")
    default Date convertCreateTime(UndoIssue undoIssue) {
        return undoIssue.getUpdateTime() != null ? undoIssue.getUpdateTime() : undoIssue.getCreateTime();
    }

    UndoIssue toUndoIssueEntity(UndoIssueAddUpdateVO addVO);
}

', '2024-11-15 19:03:02', 0, 0, 5719229),
        (79192338, 79192301, 'Since JUnit 5.11, @MethodSource is a repeatable annotation, and @MethodSources is used as backing the container. It seems that JUnit''s annotation processing doesn''t check for @MethodSources but only for its nested elements. Try this instead:
@ParameterizedTest
@MethodSource("testGetIntCommon"),
@MethodSource("testGetIntBroken")
void testGetInt(String givenKey, Integer expected) {
    ...
}

', '2024-11-15 20:14:57', 0, 0, 1180351),
        (79192373, 79192363, 'Java''s @Target annotation cannot be used multiple times on the same annotation. However, you can achieve the desired behavior by defining a meta-annotation to specify the applicable targets for annotations it is applied to and processing these meta-annotations during compile-time or runtime.
import java.lang.annotation.ElementType;
import java.lang.annotation.Target;
@Target(ElementType.ANNOTATION_TYPE)
public @interface MetaAnnotation {
    ElementType[] value(); // Specify the allowed targets
}





@MetaAnnotation({ ElementType.PARAMETER })
public @interface RegularAnnotation {
    // This annotation is implicitly targeted to ElementType.PARAMETER
}

', '2024-11-15 20:25:34', 0, 0, 432657),
        (79192387, 79192301, 'I used this in my pom.xml
    <dependencies>
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-params</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.junit</groupId>
                <artifactId>junit-bom</artifactId>
                <version>5.11.0</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

and it works fine.
BTW MethodSources is unnecessary, you can use multiple MethodSource like this
    @ParameterizedTest
    @MethodSource("testGetIntCommon")
    @MethodSource("testGetIntBroken")
    void testGetInt(String givenKey, Integer expected) {
        // THIS DOESN''T WORK
    }

', '2024-11-15 20:30:31', 0, 0, 3656904),
        (79192578, 79192493, 'The completable future API doesn''t expect you to control the flow of your program using interrupts.
The method CompletableFuture#cancel accepts a mayInterruptIfRunning argument, but the api docs state
mayInterruptIfRunning - this value has no effect in this implementation because interrupts are not used to control processing.
Essentially anything waiting on that future will stop waiting due to an exception. The task itself doesn''t know that though.
', '2024-11-15 21:27:51', 1, 1, 2067492),
        (79192688, 79192590, 'This problem is pretty well-known to be honest, and I can share some experience here.
First, there is no in-built way in java to specify the version of the software, in which the given API would be deleted. The parameter since is merely the version in which the API was marked for deprecation, quote from the doc:

The value of this element indicates the version in which the annotated program element was first deprecated.

I''m a community contributor to spring-data open source projects, and the API deprecation is a common thing. In case we deprecate some API, if we mark that forRemoval = true, it is simply removed in the next major release following the SemVer. I''m just letting you know how it is done by the hegemonies of the industry.  As for this statement:

Also there is a since property, however, since we have multiple versions in parallel this doesn''t seem intuitive. For example we might release a patch for version 4.3, 4.2 and 4.1 so technically on the 4.3 branch it would be marked deprecated since say 4.3.2 and on the 4.2 it would be since 4.2.5 and the 4.1 would be since 4.1.9. This means if you are on 4.3.1, 4.2.4, or 4.1.8 it won''t be marked deprecated.

This is totally fine. This is one of the many reasons why the previous major versions are still supported - because some API that is deleted in the major version 2 is present in the major version 1, and some client is not ready yet to migrate. That is why we''re backporting patches into previous major release minor version, as you described, thats fine. This practice is adopted by JDK, Kotlin, Spring projects etc.

Am I relegated to comments to make this work or is there some way I can do all this with the annotations so it is recognized by the developer''s IDE?

There is no compatible way to do this. You cannot know what IDE the person is using and what plugins or inspections are enabled.
What we can and should do is:

Add Java tag @deprecated and provide the meaningful explanation why the API is deprecated and when it will be removed.
Add Java tag @see to guide the user to the potential replacement for the API
And of course, do not forget to package the sources along with the .jar that contains the bytecode in order for the two suggestions above to work on developer''s IDE, at least IntelliJ can download and parse the source jars.

Caring about users is a great thing, you''re doing the right thing. But you cannot solve everything, so, do the best with what you''ve got.
P.S: Oracle official guide on deprecation of the API, from their perspective.
', '2024-11-15 21:55:37', 2, 0, 16785907),
        (79192936, 79192023, '
Replace

@Entity
@Table(name = "PRODUCTS")

on CommonProduct with
@MappedSuperclass


Remove @Inheritance(strategy = InheritanceType.SINGLE_TABLE)
Put @Table(name = "PRODUCTS") where it belongs. Next to Product
Move productId from CommonProduct to Product

', '2024-11-15 23:09:49', 1, 1, 3656904),
        (79193070, 79192744, 'In log.debug("hello @ debug {}", additional()), the additional() is a method call executed right there, right then. The logger doesn''t magically change the way Java works. The only conditional method calls in logging are calls to toString() if you provide an object as logger argument.
For instance:
// method-local class for demo purposes
class Argument {

    public Argument() {
        log.info("argument created");
    }

    @Override
    public String toString() {
        log.info("toString() invoked");
        return "this is an argument";
    }
}

log.debug("hello @debug {}", new Argument());

With debug logging turned on, you''ll see "argument created" from the constructor followed by "toString() invoked" and "hello @debug this is an argument". With debug logging turned off you''ll only see "argument created" from the constructor. The "toString() invoked" won''t be logged even though the level is info because the method isn''t invoked.
', '2024-11-15 23:45:11', 2, 0, 1180351),
        (79193211, 79192744, 'As Rob Spoor''s answer says, it is impossible for an argument not to be evaluated before being passed to a method, and log.debug gets called only after all its arguments are evaluated. However, most logging libraries (other than Slf4j) allow you to pass lambdas, and the logging method only evaluates the lambda if the level is high enough such that the log would be printed. For example, log4j2 allows this:
log.debug("hello @ debug {}", () -> additional());

or even more succinctly:
log.debug(() -> "hello @ debug " + additional());

Similarly, java.util.logging allows this:
log.log(DEBUG, () -> "hello @ debug " + additional());

Unfortunately, in slf4j the syntax for passing a lambda is very verbose:
log.atDebug().setMessage("hello @ debug {}").addArgument(() -> additional()).log();

Thus, people who don''t want to use this new "fluent" API due to its verbosity would have to use the old-style way (which is still much shorter than the new way):
if (log.isDebugEnabled()) log.debug("hello @ debug {}", additional());

', '2024-11-16 00:27:52', 3, 1, 13963086),
        (79193365, 79193074, 'You should use either of them ...
<uses-permission android:name="android.permission.ACCESS_MEDIA_LOCATION" />

ACCESS_MEDIA_LOCATION is a permission introduced in Android 10 (API level 29) to access the location information embedded in media files (like photos and videos) stored on the device.

Or

<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />

These are the primary permissions that have replaced the older READ_EXTERNAL_STORAGE
android.permission.READ_MEDIA_IMAGES: This permission allows your app to read images and videos from external storage.
android.permission.READ_MEDIA_AUDIO: This permission grants access to audio files on external storage.
android.permission.READ_MEDIA_VIDEO: This permission enables your app to read video files from external storage.
', '2024-11-16 01:13:32', 0, 0, 1567855),
        (79193750, 79190918, 'SQL keywords
You have used names that happen to be keywords in some SQL dialects: USER & ORDER.
Over a thousand distinct words have been reserved by various database products. So it is all too easy to collide with your names.
Solutions:

Use quote marks around the names to prevent the words from being interpreted as keywords.
Use different names.

I recommend adding a trailing underscore to every name. The SQL standard specification explicitly promises to never user a trailing underscore in any keyword.



So: USER_ & ORDER_.
Also, the SQL standard requires an implementation to store names in all-uppercase. But every implementation I know of fails to comply. So for maximum portability, use all-lowercase in your names.
So: user_ & order_.
', '2024-11-16 03:40:07', 1, 0, 642706),
        (79194110, 79192603, '@Node is supposed to be used to annotate a class that represents nodes in the  database, with each node representable as a separate instance of that class. Since an enum just contains a fixed set of constant values (and you can''t create different instances on an enum class), it does not make sense to treat an enum as a node.
To fix your code, you can just remove the @Node annotation from the enum, and remove the @Relationship annotation as well. That would directly store the type as a property of each Variation  node. And, if necessary, you can optimize finding all the Variation nodes of any given type by creating an index on the Variation and type combination.
', '2024-11-16 06:15:11', 1, 1, 974731),
        (79194253, 79189621, 'IBM MQ (aka MQSeries, WebSphere MQ) has been around for 30 years, so part of your problem is that MQ is trying to support backwards compatibility, so that old applications don''t break when a new version of MQ is released. At least that is the thinking at IBM.
Old school code (prior to MQ v6) was that the UserId and Password were taken from the RemoteUserIdentifier and RemotePassword fields of the MQCD structure for authentication.
The MQCSP structure was introduced in MQ v6.0, if I remember correctly. Since then, this is the preferred way of sending UserId and Password to the queue manager for authentication by either a channel security exit or the queue manager itself (queue manager authentication was introduced in MQ v8).
The MQ Java client library prior to MQ v7.1 (I think) sent a blank RemoteUserIdentifier which wasn''t good because of an underlining security hole or feature, depending on your point of view. Since, then the MQ Java client library has made an attempt to determine what is the UserId that the process (aka JVM) is running under and put it in the both the CSPUserId field of the MQCSP structure when the JVM environment variable setUserAuthenticationMQCSP is to true. When setUserAuthenticationMQCSP is to false then the MQ client library is the RemoteUserIdentifier field with the processes'' UserId. Or possibly is is set for both no matter what and the setUserAuthenticationMQCSP setting is set in the CapabilityFlags field of the MQCXP structure.
I''m sure that is clear as mud! Time for an example.
Let''s say your JVM/process is running under UserId ''fred''. Your application wants to authenticate the connection to the queue manager using UserId ''barney'' and Password ''mypwd00''.
When you originally ran your application (before your changes/updates), the queue manager would be using the UserId ''barney'' if the queue manager is configured for authentication and the UserId ''fred'' for authorizations. i.e. can you connect to the queue manager, can you open the queue, etc... Since, UserId ''fred'' does not have permission, your application receives Reason Code of 2035 (not authorized).
As JoshMc pointed out, if you set ADOPTCTX(YES) then the queue manager would adopt/switch to using the authenticated UserId.
The reason setting setUserAuthenticationMQCSP to false did not fix your issue, is because it is only telling the MQ Java client library where (which structure) to put the UserId and Password that you are specifying on your JMS call and not what to use.
By setting System.property("user.name", "barney"), the MQ Java client library puts the specified UserId in the RemoteUserIdendtifier field to be the same UserId as the authenticating UserId, i.e. ''barney'' in both cases, the queue manager will use it to perform authorizations, hence, your application works.
', '2024-11-16 07:47:15', 1, 0, 1431734),
        (79194475, 79190330, 'A couple of things to remember:

TestNG guarantees that two TestNG methods (configuration method and test method) run in the same thread (during parallel execution) only when it involves @BeforeMethod - @Teset - @AfterMethod combination. For no other combination of a configuration method + test method this assurance is provided. So relying on ThreadLocal will work ONLY for this combination.
ITestContext represents a TestNG java object that is associated with the current <test> tag. So you will have only one object for all the @Test methods within a current <test> tag.
You should instead be using an ITestResult object which is unique for every @Test method.

Here''s a cleaned up version of the same sample that shows how to do this.
Base class
import org.testng.ITestNGMethod;
import org.testng.ITestResult;
import org.testng.Reporter;
import org.testng.annotations.BeforeMethod;

import java.util.Optional;
import java.util.UUID;

public class TestBase {

    @BeforeMethod
    public void beforeMethod(ITestResult itrOfTestMethod) {
        String feature = "RestTests-" + UUID.randomUUID();
        itrOfTestMethod.setAttribute("feature", feature);
        ITestResult itrOfConfigMethod = Reporter.getCurrentTestResult();
        log(itrOfTestMethod, methodType(itrOfConfigMethod), name(itrOfConfigMethod));
    }

    protected static String name(ITestResult tr) {
        return tr.getMethod().getMethodName();
    }

    protected static void log(ITestResult tr, String type, String methodName) {
        String feature = Optional.ofNullable(
                        tr.getAttribute("feature")
                ).orElse("undefined")
                .toString();
        String msg = "Feature name in " + type + " annotated " + methodName + "() = " + feature
                + " on thread " + Thread.currentThread().getId();
        System.err.println(msg);
    }

    protected String methodType(ITestResult tr) {
        ITestNGMethod method = tr.getMethod();
        if (method.isBeforeMethodConfiguration()) {
            return "@BeforeMethod";
        }
        if (method.isAfterMethodConfiguration()) {
            return "@AfterMethod";
        }
        // Intentionally ignoring other config types for brevity
        return "@Test";
    }
}

Child class
import org.testng.ITestResult;
import org.testng.Reporter;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.Test;

public class RestTests extends TestBase {

    @Test
    public void testScenario1() {
        ITestResult tr = Reporter.getCurrentTestResult();
        log(tr, methodType(tr), name(tr));
    }

    @Test
    public void testScenario2() {
        ITestResult tr = Reporter.getCurrentTestResult();
        log(tr, methodType(tr), name(tr));
    }

    @AfterMethod(alwaysRun = true)
    public void afterMethod(ITestResult itrOfTestMethod) {
        ITestResult itrOfConfigMethod = Reporter.getCurrentTestResult();
        log(itrOfTestMethod, methodType(itrOfConfigMethod), name(itrOfConfigMethod));
    }
}

Suite file
<!DOCTYPE suite SYSTEM "https://testng.org/testng-1.0.dtd">
<suite name="2980_suite" verbose="2">
    <test name="2980_test" parallel="methods">
        <classes>
            <class name="com.rationaleemotions.so.qn79190330.RestTests"/>
        </classes>
    </test>
</suite>

Execution output
...
... TestNG 7.10.2 by Cédric Beust (cedric@beust.com)
...

Feature name in @BeforeMethod annotated beforeMethod() = RestTests-65023d92-0795-4fd7-a32c-fc965eef66aa on thread 24
Feature name in @BeforeMethod annotated beforeMethod() = RestTests-88ed9611-fcd6-4e50-84fa-1e7f95d3e785 on thread 23
Feature name in @Test annotated testScenario1() = RestTests-88ed9611-fcd6-4e50-84fa-1e7f95d3e785 on thread 23
Feature name in @Test annotated testScenario2() = RestTests-65023d92-0795-4fd7-a32c-fc965eef66aa on thread 24
Feature name in @AfterMethod annotated afterMethod() = RestTests-65023d92-0795-4fd7-a32c-fc965eef66aa on thread 24
Feature name in @AfterMethod annotated afterMethod() = RestTests-88ed9611-fcd6-4e50-84fa-1e7f95d3e785 on thread 23
PASSED: com.rationaleemotions.so.qn79190330.RestTests.testScenario1
PASSED: com.rationaleemotions.so.qn79190330.RestTests.testScenario2

===============================================
    2980_test
    Tests run: 2, Failures: 0, Skips: 0
===============================================


===============================================
2980_suite
Total tests run: 2, Passes: 2, Failures: 0, Skips: 0
===============================================

', '2024-11-16 11:36:12', 0, 0, 679824),
        (79194681, 79193413, 'Do not position individual entities by setting the transform of the SpriteBatch per entity, position individual entities with coordinates that make sense in the projection the batch is setup in.
Setting the transform matrix on a batch needs to flush whatever is already submitted to that batch as everything after will be drawn with another transform.
You can see that in the source code for SpriteBatch.
You should normally not be changing the transform of the batch for each entity drawn using it, position and rotation of each entity is passed in the draw call (otherwise the Batch cannot batch anything).
Often what you want to do is to set the camera view on the SpriteBatch before the begin and then draw all entities that use that projection before calling end.
In the case of a NinePatchDrawable, just use the draw method that allows you to specify the rotation, and if you want the rotation to happen around the center of the `NinePatchDrawable'' adjust the origin by half the width and height:
    ninePatchDrawable.draw(batch,
            0,                      // x
            0,                      // y
            0.5f * entityWidth,     // origin-x (rotation happens around this offset)
            0.5f * entityHeight,    // origin-y (rotation happens around this offset)
            entityWidth,
            entityHeight,
            1.0f,                   // scale-x
            1.0f,                   // scale-y
            angle);

', '2024-11-16 15:26:59', 1, 1, 499837),
        (79194847, 79191071, 'System.setProperty("javax.net.ssl.trustStore", "C:\\Program Files\\Java\\jdk-18.0.2.1\\lib\\security\\cacerts");
System.setProperty("javax.net.ssl.trustStorePassword", "changeit");
i added these lines in my method
it is now working fine
', '2024-11-16 17:27:35', 0, 0, 25342918),
        (79194872, 79193438, 'We should ensure value in map for custom data type''s column should be created be before keeping in map.
test_type t1 = new test_type();
    t1.setValue("planning");
    
    
    Map<String, Object> testRecord = new HashMap<String, Object>() {{
        put("name", "whatever");
        put("type", t1);
    }};

', '2024-11-16 17:41:31', 0, 0, 13200971),
        (79194981, 79192994, 'Its hard to answer on this level of detail.
My best guess is that you''re executing this code outside of any context where the permission checker can retrieve a current user context. "No user" is very likely (technically) different from "guest user".
If this doesn''t help, please add the calling context for this code to your question
', '2024-11-16 18:50:03', 0, 0, 13447),
        (79195077, 79193830, 'What happens
Eclipse sends a request to all configured authorities to find all (trusted) certificates.
One of your trusted authorities seem to accept the connection but doesn''t respond to it (or the connection gets stuck somewhere in the response). Since Eclipse doesn''t have a timeout for collecting all the authority certificates, it waits for the response forever.
I have created an issue for this
How to fix it
In Window > Preferences > Install/Update > Trust, you can find a tab "Authorities". This tab lists all configured authorities.

It seems like one of them doesn''t respond to the request so you would probably need to remove that from the authorities by clicking the "Remove" button after selecting the authority causing the issue. To find that authority, you can run curl --head https://your.authority for all configured authority (obviously replacing the link). If you don''t get a response, remove it from the list of authorities.
', '2024-11-16 19:42:41', 0, 1, 10871900),
        (79195301, 79195089, 'The problem in your project is the following:
As you have declared the SecurityConfig.class, the JwtAuthenticationFilter is invoked before the jwtAuthenticationEntryPoint.
The way to avoid this issue with your current structure is to bypass this JWT functionality from the filter in case the path is for the authentication entry point.
E.g.
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil;
    private final UserDetailsService userDetailsService;
   
    @Value("${auth.entry.point}")
    private String authEntryPoint;


    @Override
    public void doFilterInternal(
            HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain
    ) throws ServletException, IOException {

  if (!request.getRequestURI().equals(authEntryPoint)) {  //<---------

        final String authorizationHeader = request.getHeader("Authorization");
        if (authorizationHeader != null && jwtUtil.isBearer(authorizationHeader)) {
            final String jwtToken = jwtUtil.parseTokenType(authorizationHeader);
            final String username = jwtUtil.extractUsername(jwtToken);

            if(username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                final UserDetails userDetails = userDetailsService.loadUserByUsername(username);

                if(userDetails != null && !jwtUtil.isTokenExpired(jwtToken)) {
                    userDetails.getAuthorities();
                    UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                            userDetails, null, userDetails.getAuthorities()
                    );
                    authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    SecurityContextHolder.getContext().setAuthentication(authenticationToken);
                }
            }
        }
      }
        filterChain.doFilter(request, response);
    }
}

', '2024-11-16 22:07:01', 0, 0, 7237884),
        (79195435, 79195412, 'version not mentioned in the Docs that seems to work
distributionUrl=https\\://services.gradle.org/distributions/gradle-8.5-all.zip

I then opened the android folder of the flutter project in Android Studio and it updated gradle files and built successfully.
', '2024-11-16 23:13:50', 0, 0, 2904786),
        (79195738, 79195686, 'Modify your code like this:
// Product entity
    @Column(name = "name", unique = true)
    private String name;

    @OneToOne(mappedBy = "product", cascade = CascadeType.ALL)
    @JsonManagedReference
    private DisplayName displayName;

// DisplayName entity
    @OneToOne
    @JsonBackReference
    @ToString.Exclude
    @JoinColumn(referencedColumnName = "name")
    private Product product;

public interface ProductRepository extends JpaRepository<Product, UUID> {
    Page<Product> findAllByName(String name);
}

In the database define a constraint similar to this:
alter table display_name add constraint display_name_const_1
foreign key (product_name) references product (name)

', '2024-11-17 01:44:45', 0, 0, 14294053),
        (79195800, 79195263, 'You could try adding an inner Table into the second column of the first row, and then add the two smaller Images as rows to that.

In the example above I''ve added some paddings to the rows to make it clearer, but it works just as well without them.
    stage = new Stage(new ScreenViewport());
    Gdx.input.setInputProcessor(stage);

    Table root = new Table();
    root.setFillParent(true);
    stage.addActor(root);

    Image button = new Image(createTexture(Color.ROYAL, 300,300));
    Image button2 = new Image(createTexture(Color.ROYAL, 200,100));
    Image button3 = new Image(createTexture(Color.ROYAL, 200,100));

    root.row().pad(10);
    root.add(button);

    // This table is only there to hold the two Images on the right,
    // they get one row each.
    Table inner = new Table();
    inner.row().pad(10);
    inner.add(button2).width(200);
    inner.row().pad(10);
    inner.add(button3).width(200);

    root.add(inner);

    root.setDebug(true);

', '2024-11-17 02:19:51', 1, 0, 499837),
        (79196120, 79195854, 'That code you found is an oversimplified version of what an application would need to do.  It’s more like notes on the concept than an actual solution.
The proper way to do this is to create a file in a known, stable location, not just in whatever happens to be the current working directory of the program.  There are a few different ways to let other attempts to open the program instead message the currently running instance.  One of the simplest is a local socket:
import static java.lang.System.Logger.Level;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.IOException;

import java.net.Socket;
import java.net.ServerSocket;
import java.net.InetAddress;

import java.nio.charset.StandardCharsets;

import java.nio.file.Path;
import java.nio.file.Files;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.BorderFactory;

public class SingletonApplication {
    private static final System.Logger logger =
        System.getLogger(SingletonApplication.class.getName());

    private static final int MESSAGE_PORT = 25678;

    private static final Path PID_FILE = Path.of(
        System.getProperty("java.io.tmpdir"),  
        SingletonApplication.class.getName() + ".lock");

    private final JFrame window;

    private void monitorMessages() {
        try (ServerSocket service = new ServerSocket(MESSAGE_PORT)) {
            Files.writeString(PID_FILE,
                String.valueOf(ProcessHandle.current().pid()));

            while (true) {
                try (Socket connection = service.accept();
                     BufferedReader reader = new BufferedReader(
                        new InputStreamReader(
                            connection.getInputStream(),
                            StandardCharsets.UTF_8))) {

                    reader.readLine();
                    EventQueue.invokeLater(() -> show());
                }
            }
        } catch (IOException e) {
            logger.log(Level.WARNING, "Message service failed.", e);
        } finally {
            try {
                Files.deleteIfExists(PID_FILE);
            } catch (IOException e) {
                logger.log(Level.WARNING,
                    "Could not delete file \\"" + PID_FILE + "\\".", e);

            }
        }
    }

    public SingletonApplication() {
        JLabel label = new JLabel(
            String.valueOf(ProcessHandle.current().pid()));
        label.setBorder(BorderFactory.createEmptyBorder(150, 150, 150, 150));

        window = new JFrame("Singleton Application");
        window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        window.getContentPane().add(label);
        window.pack();
        window.setLocationByPlatform(true);
    }

    private void show() {
        window.setVisible(true);
        window.toFront();
        window.requestFocus();
    }

    private static boolean messageExistingInstance() {
        if (Files.isReadable(PID_FILE)) {
            try (Socket messageChannel =
                    new Socket(InetAddress.getLocalHost(), MESSAGE_PORT);
                 BufferedWriter writer = new BufferedWriter(
                    new OutputStreamWriter(
                        messageChannel.getOutputStream(),
                        StandardCharsets.UTF_8))) {

                writer.write("start");
            } catch (IOException e) {
                logger.log(Level.ERROR,
                    "Could not message existing instance.", e);
                return false;
            }

            return true;
        }

        return false;
    }

    public static void main(String[] args) {
        if (!messageExistingInstance())  {
            EventQueue.invokeLater(() -> {
                SingletonApplication application = new SingletonApplication();
                application.show();

                Thread monitorThread =
                    Thread.startVirtualThread(application::monitorMessages);
                Runtime.getRuntime().addShutdownHook(
                    new Thread(monitorThread::interrupt));
            });
        }
    }
}

', '2024-11-17 05:54:49', 4, 0, 1831987),
        (79196242, 79196104, 'Your code works as expected.
I always try to avoid throwing errors, because it''s slow... and ugly.
Here is a version without try/catch:
Scanner scanner = new Scanner( System.in );
String userInput = "";
while( true ) {
   System.out.print( "Enter a positive number: " );
   if( ( userInput = scanner.nextLine() ).matches( "[0-9]{1,9}" ) ) break;
   System.out.println( "Invalid input. Please enter a valid number." );
}
System.out.println( "You entered: " + userInput );
scanner.close();

', '2024-11-17 07:31:05', 1, 0, 20882864),
        (79196652, 79196083, 'Your controller package should be under your base package.
currently controller package is under
java.com.connectingfrontandback.controller it should be java.com.connectingfrontandback.**studentsystem**.controller.
Alternatively can add component scan annotation on StudentsystemApplication.java to consider controller layer without refactoring package.
@ComponentScan(basePackages = "java.com.connectingfrontandback.controller")

', '2024-11-17 15:03:51', 1, 0, 13200971),
        (79196719, 79190261, 'I believe you''re just calling .register rather than .registerItem here in your ModItems.java:
 public static final DeferredItem<Item> BISMUTH = ITEMS.register("bismuth",
 //                                                    ^^^^^^^^^
 //                                                 this should be .registerItem
            () -> new Item(new Item.Properties()));

If you swap that out, I believe it should work.
This is also discussed in the documentation, which also helps explain why you got the error that you got.
When discussing Item.Properties, they say:

setId - Sets the resource key of the item.

This must be set on every item; otherwise, an exception will be thrown.


Then, when discussing registerItem, they say:

Internally, this will simply call ITEMS.register("example_item", registryName -> new Item(new Item.Properties().setId(ResourceKey.create(Registries.ITEM, registryName))))

The error that you''re getting is that it can''t find the ID for the item, because setId hasn''t been called. Calling registerItem instead of register fixes it, because as they show, internally registerItem calls setId for you (it''s just a little helper method). But, in theory, you could also the issue by calling setId on Item.properties() yourself (although I don''t think that''s too useful unless you''re actually wanting to customise more of the properties too).

In general, I think the offical documentation is actually pretty good, at least for most of the common stuff you''ll run into when starting out; I''d highly recommend reading through it when you run into problems, and seeing if your general approach and understanding matches what they describe.
', '2024-11-17 15:44:57', 0, 1, 2691058),
        (79196875, 79196083, 'What does it mean main application package? This is the package where you have the main application class (StudentsystemApplication.java). In your case it is com.connectingfrontandback.studentsystem
Following the best practice in Spring Boot you should move all other packages to be under the above. Like this:
com.connectingfrontandback.studentsystem
com.connectingfrontandback.studentsystem.controller
com.connectingfrontandback.studentsystem.model
com.connectingfrontandback.studentsystem.repository
com.connectingfrontandback.studentsystem.service

Otherwise you would need to manage quite a few annotations manually.
', '2024-11-17 17:20:39', 0, 0, 14294053),
        (79197010, 79196083, 'make sure your main application class (StudentSystemApplication.java) has component scanning enabled for the correct base package. It should look like this:
@SpringBootApplication
@ComponentScan(basePackages = "com.connectingfrontandback")
public class StudentSystemApplication {
 public static void main(String[] args) {
    SpringApplication.run(StudentSystemApplication.class, args);
 }
}

Because @SpringBootApplication includes component scanning functionality that automatically detects annotations like @RestController, @Service, @Repository, and @Component. When these annotations are found, Spring creates and manages those classes as beans. However, this scanning only works within the package containing your main class and its sub-packages.
So if your main application class is in a different package than your components, you need to explicitly add @ComponentScan(basePackages = "com.connectingfrontandback") to ensure Spring finds and manages all your annotated classes correctly.
', '2024-11-17 18:42:53', 0, 0, 20014332),
        (79197067, 79195061, 'I worked around the issue and got it working. It''s not an optimal solution but at least it''s working and leveraging Spring Security for Authentication. The process to decrypt the token and add it to the request is pretty nasty but I struggled to decrypt the accessToken in time and add it to the request before it''s sent (even if i did it in a synchronous way). Also to mention, the first request is always failing since the http-proxy doesn''t recognize it as a websocket request, I don''t really know why but for now it''s not bothering me that much.
I need further testing to check if the solution introduce a memory leak but for now I''m happy that it''s working. I will look into this after I complete other implementations. I would be happy to hear suggestions to improve the code :)
Solution:
import {defineEventHandler} from ''h3'';
import {decryptToken} from "@/node_modules/nuxt-oidc-auth/dist/runtime/server/utils/security";
import {createProxyMiddleware} from ''http-proxy-middleware'';
import {unseal, defaults} from ''iron-webcrypto'';
import {webcrypto} from ''node:crypto'';

const simpleRequestLogger = (proxyServer, options) => {
    proxyServer.on(''open'', (proxySocket) => {
        console.log(''[HPM] WebSocket connection established.'');
    });
    proxyServer.on(''proxyReq'', (proxyReq, req, res) => {
        console.log(`[HPM] [${req.method}] ${req.url}`);
        console.log(''proxyReq'', proxyReq);
    });
    proxyServer.on(''error'', (e) => {
        console.error(''[HPM Error]'', e);
    });
};

export default defineEventHandler(async (event) => {
    const {req, res} = event.node;
    console.log(''[HPM] WebSocket connection detected.'');

    if (req.headers.upgrade?.toLowerCase() === ''websocket'') {
        try {
            const cookies = parseCookies(req.headers.cookie);
            const sessionCookie = cookies[''nuxt-oidc-auth''];

            if (sessionCookie) {
                const unsealedCookie = await unsealCookie(sessionCookie);
                const persistentSession = await useStorage(''oidc'').getItem(unsealedCookie.id);

                if (persistentSession) {
                    const tokenKey = process.env.NUXT_OIDC_TOKEN_KEY;
                    const accessToken = await decryptToken(persistentSession.accessToken, tokenKey!);
                    console.log(''[HPM] Authorization header pre-fetched and added to the request.'');

                    const wsProxy = createProxyMiddleware({
                        target: ''wss://localhost:3001'',
                        ws: true,
                        pathFilter: ''/**'',
                        secure: true,
                        changeOrigin: true,
                        plugins: [simpleRequestLogger],
                        headers: {},
                        on: {
                            proxyReqWs: (proxyReq) => {
                                proxyReq.setHeader(''Authorization'', `Bearer ${accessToken}`);
                                console.log(''[HPM] Authorization header attached to proxyReq.'');
                            },
                            close: (proxyRes, proxySocket, proxyHead) => {
                                proxySocket.removeAllListeners();
                                proxySocket.destroy();
                            }
                        }
                    });

                    await wsProxy(req, res);
                    return;
                } else {
                    console.warn(''[HPM] Persistent session not found for session ID:'', unsealedCookie.id);
                }
            } else {
                console.warn(''[HPM] nuxt-oidc-auth cookie not found.'');
            }
        } catch (err) {
            console.error(''[HPM] Failed to fetch Authorization header:'', err);
            res.statusCode = 500;
            res.end(''Internal Server Error'');
            return;
        }
    }
});

function parseCookies(cookieHeader: string | undefined): Record<string, string> {
    if (!cookieHeader) {
        return {};
    }
    return cookieHeader.split('';'').reduce((cookies, cookie) => {
        const [key, value] = cookie.split(''='').map(part => part.trim());
        cookies[key] = decodeURIComponent(value);
        return cookies;
    }, {} as Record<string, string>);
}

async function unsealCookie(sealedCookie) {
    const password = process.env.NUXT_OIDC_SESSION_SECRET;
    try {
        return await unseal(webcrypto, sealedCookie, password, defaults);
    } catch (err) {
        console.error(''Failed to unseal cookie:'', err);
        throw err;
    }
}

Edit: Just as a side note this code is only fetching accessToken once, it''s never updated. It''s something I need to look further into, I will update the code if I have a solution.
', '2024-11-17 19:26:23', 0, 0, 6512438),
        (79197175, 79197174, 'Usually Android applications follow MVVM design pattern or sometimes MVP pattern, in addition to those sometimes we add Use Case - Repository - Service a typical app using latest technology and built from the ground up in a decent pattern and ready for unit testing would be like this.
Model - View - ViewModel - UseCase - Repository - Service with each one having it''s own unique functionality, and all with a Dependency Injection running as well for testing, something like Dagger or Hilt for larger apps, or maybe Koin for smaller ones
', '2024-11-17 20:25:42', -1, 0, 5958730),
        (79197228, 79197174, 'There are many architecture patterns and you can follow any one that suits your need. By default android follow mvc but most developers prefer mvvm since its also recommended by google itself.
Since you are new to android I would suggest you to follow the default architecture (mvc) you can place the business logic in your activity or fragment (especially if your building a small app).
First get familiar with android eco system by making different small apps then when you are confident move to advance topics. (Its my opinion, others can agree or disagree).
Incase you prefer to follow other architecture patterns like mvvm then you can put your buisness logic in repository or use clean architecture with mvvm and place your business logic in usecases.
', '2024-11-17 20:51:11', -1, 0, 23135065),
        (79197258, 79197232, '"Is there a way preferbly in properties file to instruct spring boot to use it?"
Short answer is NO.
Long answer you need to do it manually for each query you execute.
Also there is no universal way to do it. Solution will be different for different DB.
', '2024-11-17 21:08:51', 0, 0, 3656904),
        (79197283, 79197267, 'Google says you need FlywayMigrationStrategy bean defined.
Example:
@Configuration
public class FlywayConf {
    @Bean
    public FlywayMigrationStrategy clean(){
        return flyway -> {
            flyway.clean();
            flyway.migrate();
        };
     }
}

', '2024-11-17 21:22:25', 0, 0, 3656904),
        (79197307, 79196104, 'Just as a suggestion, just use the Scanner#nextLine() method and compare the User''s input with the String#matches() method and a small Regular Expression, for example:
import java.util.Scanner;

public class ScannerPromptDemo {

    /* Don''t close `System.in` unless you know it will never be
       needed again during this application session otherwise
       you will need to restart your application in order to 
       use it again. The JVM will automatically close this 
       stream and free resources when the application closes.  */
    private final Scanner userInput = new Scanner(System.in);
    private final String ls = System.lineSeparator();
    
    
    public static void main(String[] args) {
        /* App started this way to avoid the need for 
           statics unless we really want them:     */
        new ScannerPromptDemo().startDemo(args);
    }
    
    private void startDemo(String[] args) {
        // Outer loop to keep inner prompt loop cycling until "q" is entered:
        String num = "";
        while (!num.equalsIgnoreCase("q")) {
            while (num.isEmpty()) {
                // Prompt:
                System.out.println("Please enter any legal int, long, float, or double type number:"); 
                System.out.print("Your number (q to quit): -> ");
                num = userInput.nextLine().trim();
                // Is `q` for quit provided?
                if (num.equalsIgnoreCase("q")) {
                    //Yes...
                    System.out.println("quiting - Bye Bye" + ls);
                    break;  // Exit inner `while` loop and effectively, the outer loop as well:
                }

                /* Validate User input. Is it a string representation of 
                   a signed or unsigned Integer or Floating-Point value: */
                if (!num.matches("-?\\\\d+(\\\\.\\\\d+)?")) {
                    // No... inform User and allow to try again:
                    System.out.println("Invalid number supplied (" + num + ")! Try again..." + ls);
                    num = "";  // Empty `num` to ensure re-loop:
                }
            }
            
            if (num.equalsIgnoreCase("q")) {
                break;
            }

            // Validation Passed:
            Double doubleValue = null;
            Integer intValue = null;
            Long longValue = null;

            if (num.contains(".")) {
                doubleValue = Double.valueOf(num);
            }
            else {
                longValue = Long.valueOf(num);
                if (longValue <= Integer.MAX_VALUE) {
                    intValue = Integer.valueOf(num);
                    longValue = null;
                }
            }
            System.out.println("You entered a "
                    + (doubleValue != null ? "`double` type value of: " + doubleValue
                            : (longValue != null ? "`long` type value of: " + longValue
                                    : "`int` type value of: " + intValue)));
            num = "";
            System.out.println();
        }
    }
}

In the example above, the User can enter any number as long as it''s a legal signed or unsigned int, long, float, or double type number. You could take this a little further and add BigInteger and BigDecimal to the mix.
The Regular Expression ("-?\\\\d+(\\\\.\\\\d+)?") supplied to the String#matches() method checks to see if the User supplied numerical value is in fact a signed or unsigned integer or floating-point value.
Checks for data type are done after the inner while loop and nested Ternary Operators are used to display the result within the Console Window.
', '2024-11-17 21:34:03', 0, 1, 4725875),
        (79197446, 79197396, '
You should put ojdbc jar in $CATALINA_HOME/lib.
No

', '2024-11-17 22:54:52', -1, 0, 12768970),
        (79197529, 79197396, 'Fallback to application-scoped resources occurs when an application avoids using the container-managed JNDI datasource and instead relies on resources bundled and loaded within the application itself. This can happen due to explicit configuration or as a backup mechanism when JNDI resources fail to initialise.
If the ojdbc.jar is missing from $CATALINA_HOME/lib, Tomcat cannot initialise the JNDI datasource, however, the application can still function if it directly loads the driver from WEB-INF/lib. Many legacy web applications were not designed to use container-managed JNDI datasources by default. They often have hardcoded connection logic as a fallback.
', '2024-11-17 23:36:50', 0, 0, 23652381),
        (79197548, 79197276, 'add throws NoSuchFieldException, SecurityException to method signature
like below
@Test
public void test() throws NoSuchFieldException, SecurityException{
        Field treeField = RbtMap.class.getDeclaredField("tree");
        System.out.println(treeField.getName());
}

', '2024-11-17 23:46:13', 0, 1, 13719128),
        (79197645, 79197596, 'Here you go.

public class Main {
    private static String outPath = "path";

    public static void main(String[] args) throws Exception{
        SXSSFWorkbook wb = new SXSSFWorkbook();
        Sheet sheet = wb.createSheet("Analysis.xlsx");
        List<String> fooObjectData = Arrays.asList("Obj1","Obj2");
        List<String> fooFieldData = Arrays.asList("F1");
        List<String> fooAppData = Arrays.asList("App1","App2","App3","App4","App5");
        int maxFooRowCount = max(fooObjectData.size(), fooFieldData.size(), fooAppData.size());
        
        List<String> testObjectData = Arrays.asList("");
        List<String> testFieldData = Arrays.asList("F1","F2","F3","F4","F5");
        List<String> testAppData = Arrays.asList("App1");
        int maxTestRowCount = max(testObjectData.size(), testFieldData.size(), testAppData.size());
        
        for(int i=0;i<maxFooRowCount;i++) {
            Row row = sheet.createRow(i);
            row.createCell(0).setCellValue("Foo");
            row.createCell(1).setCellValue(getOrBlank(fooObjectData, i));
            row.createCell(2).setCellValue(getOrBlank(fooFieldData, i));
            row.createCell(3).setCellValue(getOrBlank(fooAppData, i));
        }
        

        for(int i=0;i<maxTestRowCount;i++) {
            Row row = sheet.createRow(i+maxFooRowCount);
            row.createCell(0).setCellValue("Test");
            row.createCell(1).setCellValue(getOrBlank(testObjectData, i));
            row.createCell(2).setCellValue(getOrBlank(testFieldData, i));
            row.createCell(3).setCellValue(getOrBlank(testAppData, i));
        }
        writeToFile(wb);
    }
    
    private static String getOrBlank(List<String> list, int index) {
        if(list.size()<=index) return "";
        return list.get(index);
    }

    private static int max(int size, int... others) {
        if(others==null) return size;
        for(int c: others) if(size<c) size = c;
        return size;
    }

    private static void writeToFile(SXSSFWorkbook wb) throws IOException {
        File f = new File(outPath);
        if (!f.exists()) {
            f.createNewFile();
        }
        FileOutputStream out = new FileOutputStream("foo.xlsx");
        wb.write(out);
        out.close();

        //After everything is written, then we dispose the temp file.
        wb.dispose();
    }
    
   
}

', '2024-11-18 00:34:52', -3, 1, 13719128),
        (79197730, 79197684, 'You think like a new post is created, because you didn''t save any of the properties of the Blog (except id), because they are didn''t map to the database fields. And when you retrieve a saved entity from the /home the empty fields are returned. You should map them in the entity as @Column.
', '2024-11-18 01:15:37', -1, 0, 573032),
        (79197825, 79197819, 'You may want to set dialect for datasource.
spring.datasource.dialect=...

also try
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.DerbyTenSevenDialect

', '2024-11-18 02:02:59', 0, 0, 3656904),
        (79197918, 79197465, 'Adjust the origin when drawing the rotated NinePatchDrawable by half the size of the NinePatchDrawable.
    public void render(SpriteBatch batch) {
        position.set(body.getPosition());
        float angle = body.getAngle() * MathUtils.radiansToDegrees;
        npd.draw(batch,
                position.x - 0.5f * size.x,
                position.y - 0.5f * size.y,
                0.5f * size.x,
                0.5f * size.y,
                size.x,
                size.y,
                1.0f,
                1.0f,
                angle);
    }

That will make sure the rotation is about the center of the NinePatchDrawable whilst still matching the rotation and position of the Box2D Body.
In the example below I am fading out the NinePatchDrawable to show what the Box2DDebugRenderer considers the position to be:

Full source code for the animation above:
    public class SomeCoolGameAboutRotatedBricks extends Game {


        public static class MyEntity {
            private final Vector2 position = new Vector2();
            private final Vector2 size = new Vector2();
            private final NinePatchDrawable npd;
            private final Body body;

            public MyEntity(float px, float py, float w, float h, NinePatchDrawable npd, World world) {
                this.size.set(w, h);
                this.npd = npd;

                var shape = new PolygonShape();
                shape.setAsBox(w / 2.0f, h / 2.0f);

                var fixtureDef = new FixtureDef();
                fixtureDef.shape = shape;

                var bodyDef = new BodyDef();
                bodyDef.type = BodyDef.BodyType.KinematicBody;
                bodyDef.position.set(px, py);

                body = world.createBody(bodyDef);
                body.createFixture(fixtureDef);

                shape.dispose();
            }

            public void spin(float rotation) {
                body.setAngularVelocity(rotation);
            }

            public void render(SpriteBatch batch) {
                position.set(body.getPosition());
                float angle = body.getAngle() * MathUtils.radiansToDegrees;
                npd.draw(batch,
                        position.x - 0.5f * size.x,
                        position.y - 0.5f * size.y,
                        0.5f * size.x,
                        0.5f * size.y,
                        size.x,
                        size.y,
                        1.0f,
                        1.0f,
                        angle);
            }
        }

        private World world;
        private Box2DDebugRenderer box2DDebugRenderer;
        private SpriteBatch batch;
        private OrthographicCamera camera;

        private Array<MyEntity> entities = new Array<>();

        @Override
        public void create() {

            world = new World(new Vector2(0, 0), false);
            box2DDebugRenderer = new Box2DDebugRenderer();

            // Camera setup with fixed world size, aspect-ratio of the window and positioned so that (0, 0) is center screen
            var WORLD_WIDTH = 1000.0f;
            var WORLD_HEIGHT = WORLD_WIDTH * Gdx.graphics.getHeight() / Gdx.graphics.getWidth();
            camera = new OrthographicCamera(WORLD_WIDTH, WORLD_HEIGHT);
            camera.position.set(0, 0, 1);
            camera.update();

            batch = new SpriteBatch();


            var npd = /* Load this somehow */  Assets.instance.ui.buttonBackground;

            entities.add(new MyEntity(-(WORLD_WIDTH * 0.25f), WORLD_HEIGHT * 0.25f, 100, 25.0f, npd, world));
            entities.add(new MyEntity(-(WORLD_WIDTH * 0.00f), WORLD_HEIGHT * 0.25f, 100, 25.0f, npd, world));
            entities.add(new MyEntity((WORLD_WIDTH * 0.25f), WORLD_HEIGHT * 0.25f, 100, 25.0f, npd, world));

            entities.add(new MyEntity(-(WORLD_WIDTH * 0.25f), WORLD_HEIGHT * 0.00f, 100, 25.0f, npd, world));
            entities.add(new MyEntity(-(WORLD_WIDTH * 0.00f), WORLD_HEIGHT * 0.00f, 100, 25.0f, npd, world));
            entities.add(new MyEntity((WORLD_WIDTH * 0.25f), WORLD_HEIGHT * 0.00f, 100, 25.0f, npd, world));

            entities.add(new MyEntity(-(WORLD_WIDTH * 0.25f), -WORLD_HEIGHT * 0.25f, 100, 25.0f, npd, world));
            entities.add(new MyEntity(-(WORLD_WIDTH * 0.00f), -WORLD_HEIGHT * 0.25f, 100, 25.0f, npd, world));
            entities.add(new MyEntity((WORLD_WIDTH * 0.25f), -WORLD_HEIGHT * 0.25f, 100, 25.0f, npd, world));


            for (var entity : entities)
                entity.spin(MathUtils.random(-4, 4));
        }

        float alphaTimer = 0.0f;

        @Override
        public void render() {
            alphaTimer += Gdx.graphics.getDeltaTime();
            float alpha = 0.5f + MathUtils.sin(alphaTimer * 2);
            ScreenUtils.clear(Color.BLACK);
            world.step(Gdx.graphics.getDeltaTime(), 8, 8);
            box2DDebugRenderer.render(world, camera.combined);

            batch.setProjectionMatrix(camera.combined);
            batch.setColor(1, 1, 1, alpha);
            batch.begin();

            for (var entity : entities)
                entity.render(batch);

            batch.end();
        }
    }

', '2024-11-18 02:54:19', 1, 0, 499837),
        (79197987, 79197970, 'Flag
Use a flag to keep track of when you issue the “invalid input” message.
When you go to post the message, check your flag.

If the flag is lowered, then you know the message has not yet been delivered to the user. Deliver the message, and raise the flag.
If the flag is raised, then skip over your message.

In code below we use a boolean variable named issuedInvalidInputMessage as our flag.
    ➡️  boolean issuedInvalidInputMessage = false ;
        while (true) {
            try {
                number = scanner.nextInt();
                if (number > 10) {
                    System.out.println("You entered: " + number);
                    break;
                } else {
                    System.out.println("Please enter a number greater than 10.");
                }
            } catch (Exception e) {
     ➡️         if ( ! issuedInvalidInputMessage ) {
     ➡️             issuedInvalidInputMessage = true ;
                    System.out.println("Invalid input. Please try again.");
                }
                scanner.next(); // Clear the invalid input
            }
        }

', '2024-11-18 03:29:24', 1, 0, 642706),
        (79198165, 79197945, 'It sounds like you''re not looking for SequenceLayout (which, as you''ve observed, is intended for use with fixed-size arrays), but instead you''re looking for arrayElementVarHandle, which is intended for variable-length arrays.  You''d then allocate with arena.allocate(coordinateLayout, count).
This is explicitly addressed in this section of the documentation.
', '2024-11-18 05:06:45', 2, 1, 869736),
        (79198196, 79198159, 'Ok, I figured out the reason this fails.
here is an example test case
nums = {4,1,-4,2,2,2,2,-10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};

k = 8;

for sol = 4 this does work, but for sol = 6 it does not work.
To see why the logic fails, consider the window consisting of 4, 1, -4, 2, 2
at this point the 4 and 1 together are worth keeping, since removing them inorder to remove the -4 is not worth it.
if we move 1 to the left we remove 4 and add another 2 so our window looks like
1, -4, 2, 2, 2
in this case it is worth it to drop the 1 so that we can also drop the -4 to shrink our window and make the sum larger.
However in the code, we only shrink the size of the window if the entire sum is negative, or if the left most element is negative. So my code would not shrink the sliding window in this case.
', '2024-11-18 05:33:09', 1, 0, 7160078),
        (79198442, 79198388, 'OffsetDateTime
The class java.time.OffsetDateTime class represents a moment as seen through a particular offset-from-UTC. An offset is a number of hours-minutes-seconds ahead or behind the temporal meridian of UTC.
Parse:
OffsetDateTime odt = OffsetDateTime.parse ( "2024-11-07T17:33:20+00:00" ) ;

Generate text:
String output = odt.toString() ;

See this code run live at Ideone.com. The Z on the end is a standard abbreviation for +00:00, meaning an offset of zero, pronounced “Zulu”.

odt.toString() = 2024-11-07T17:33:20Z

', '2024-11-18 08:50:20', -1, 1, 642706),
        (79198477, 79193074, 'I found the answer and made it work!!
I didn''t say it in my OP, but I should''ve specified I''m targetting android 12 (api 31), and that demands some legacy-oriented tweaking of the manifest.
In the android developer docs it is specified you have to declare your needed permissions as follows:
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />

That solved the problem and now the permission is both requested at runtime and listed in the app info area in settings.
', '2024-11-18 09:13:56', 1, 0, 8960507),
        (79198544, 79197722, 'In multi-module Spring (Maven or Gradle) you can achieve what you want, but there is a gotcha with the application.properties file... each module has its own and only the "outer" one wins.
So if you have some properties that you want to specify in the library, use a different name.  I suggest you use the convention of Spring (Active) Profiles.
In the Library name the file application-library.properies
Then in the main application specify the Active Profile as library and Spring will load whatever is in the main module''s application.properties AND what is found in application-library.properies.
There are several ways to specify active profiles, one is simply on the execute of the outer application (e.g. in your IDE''s Run configuration), see Set the Active Spring Profiles for many other ways
', '2024-11-18 10:25:01', 0, 0, 1847378),
        (79198546, 79188255, 'While I found another way to avoid this issue,
I still does not find out root cause of above issue Ljava/net/http/HttpClient
Before:

FAIL: I use Junit framework/package

After:

SUCCESS: I use TestNG framework/package
  package ex.jvautotest;

  import org.openqa.selenium.By;
  import org.testng.annotations.AfterMethod;
  import org.testng.annotations.BeforeMethod;
  import org.testng.annotations.Test;

  import java.net.MalformedURLException;
  import java.net.URL;

  import io.appium.java_client.android.AndroidDriver;
  import io.appium.java_client.remote.options.BaseOptions;

  public class FirstTest {

  static AndroidDriver driver;

  @BeforeMethod
  public static void setUp() throws MalformedURLException {
      var options = new BaseOptions()
              .amend("appium:automationName", "UiAutomator2")
              .amend("appium:deviceName", "emulator-5554")
              .amend("appium:platformName", "Android")
              .amend("appium:app", "/Users/.../app-debug.apk")
              .amend("appium:newCommandTimeout", 3600)
              .amend("appium:connectHardwareKeyboard", true);

      driver = new AndroidDriver(new URL("http://127.0.0.1:4723"), options);
  }

  @Test
  public void sampleTest() throws Exception {
      try {
          // 1 - get Email, then input text
          By usernameId = By.id("com.example.autotestsample:id/username");
          // 2 - get Password, then input text
          By passwordId = By.id("com.example.autotestsample:id/password");
          // 3 - click SignIn, then click
          By loginId = By.id("com.example.autotestsample:id/login");

          driver.findElement(usernameId).sendKeys("user@email.com");
          driver.findElement(passwordId).sendKeys("12345");
          driver.findElement(loginId).click();
      } catch (Exception e) {
          throw e;
      }
  }

  @AfterMethod
  public static void tearDown() {
      driver.quit();
  }

}


', '2024-11-18 10:26:29', 0, 0, 2522405),
        (79198766, 79198744, 'In order to print the histogram as columns, with the letters below the columns, you first need to get the frequencies of each letter and also find the maximum frequency. Then you iterate through the letters and if that letter''s frequency is not less than the maximum frequency, print a *, otherwise print a space. Then reduce the maximum by one and repeat – until the maximum reaches zero.
public class Histogram {
    public static void main(String[] args) {
        String text = "I love problem-solving.";
        int[] frequency = new int[26];
        int max = 0;
        for (int i = 0; i < text.length(); i++) {
            if (Character.isLetter(text.charAt(i))) {
                int ndx = Character.getNumericValue(Character.toLowerCase(text.charAt(i))) - 10;
                frequency[ndx] += 1;
                if (frequency[ndx] > max) {
                    max = frequency[ndx];
                }
            }
        }
        for (int i = max; i > 0; i--) {
            for (int j = 0; j < frequency.length; j++) {
                if (frequency[j] >= i) {
                    System.out.print("*");
                }
                else {
                    System.out.print(" ");
                }
                System.out.print(" ");
            }
            System.out.println();
        }
        System.out.println("-".repeat(51));
        System.out.println("a b c d e f g h i j k l m n o p q r s t u v w x y z");
    }
}

Here is the output:
                      *     *                       
        *       *     *     *             *         
  *     *   *   *     * * * * *   * *     *         
---------------------------------------------------
a b c d e f g h i j k l m n o p q r s t u v w x y z

I suggest that you step through the code with a debugger in order to better understand how it works.
', '2024-11-18 13:18:47', 2, 0, 2164365),
        (79198855, 79192927, 'When the build time part of the extension is being run, the recorder is a proxy because at build time the recorders are not actually executed, instead they are used to capture the values of the parameters passed to them - and using proxies is the easiest way to intercept the calls and capture the values
', '2024-11-18 14:19:02', 0, 0, 2504224),
        (79198923, 79198779, 'I think you should change serverTimeZone to Asia/Seoul.
Because LocalDateTime doesn''t include zone information, it will be just translated into unzoned Datetime string when passed into MySQL query.
MySQL will use the difference between serverTimeZone and db time zone as delta value for incoming Datetime.
So if you set serverTimeZone to Asis/Seoul will result your times saved -9 hours.
Or just using ZonedDateTime is an another option.
', '2024-11-18 14:47:17', 0, 0, 7189763),
        (79198940, 79198532, '
server A used rikim user as credentials/ as service account. then user B coming with negotiate token with ticket cache on his local as user ariandop

Avoid using a regular user account as service account – at least not in production. Services (web apps, etc) should have a dedicated account for that purpose.

My problem, when user B ariandop make a request. why my application keep validated as rikim ? instead of ariandop.

Because you actually implemented the "client" side of GSSAPI, not the "server" side.
When you call initSecContext(), you''re telling GSSAPI to act as a client ("initiator" in GSSAPI terminology), and the first call probably just ignores the input token (because Kerberos is a "client first" mechanism).
Instead, the server ("acceptor" in GSSAPI terms) needs to call acceptSecContext() with the received token from client.
The GSSContext itself likely needs to be created using a different constructor: the Java docs list createContext(GSSCredential myCred) for the acceptor.
', '2024-11-18 14:54:28', 0, 0, 49849),
        (79199018, 79190407, 'I found it
exchange.getAttributes().put(ServerWebExchangeUtils.GATEWAY_PREDICATE_MATCHED_PATH_ATTR, newServiceName);
    exchange.getAttributes().put(ServerWebExchangeUtils.GATEWAY_PREDICATE_PATH_CONTAINER_ATTR, newServicePath);
    exchange.getAttributes().put(ServerWebExchangeUtils.GATEWAY_REQUEST_URL_ATTR, newUri);

', '2024-11-18 15:16:51', 0, 1, 15426734),
        (79199181, 79199152, 'Yes. You have to work with CommonUser otherwise hibernate don''t know how to handle this link.
', '2024-11-18 16:22:32', 1, 0, 3656904);