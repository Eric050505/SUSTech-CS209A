insert into JavaProject.Questions (question_id, title, body, tags, creation_date, last_activity_date, view_count, score, answer_count, comment_count, owner_user_id, accepted_answer_id)
values  (79186516, 'Checkmarx flagging JPA repository method with @Query annotation as possible stored XSS attack', 'I have a jpa repository with a method similar to:
@Query("select distinct concat(p.firstName, '' '', p.lastName) as name from PersonEntity p")
public String[] findDistinctNames();

I''m using checkmarx in my pipeline and it flags the use of this (and any similar non-parameterized methods with @Query) as being at risk of a stored XSS attack. For example, in my service class, using the method like:
// MyService.java
public String[] findDistinctNames() {
    return personRepository.findDistinctNames();
}

Will result in checkmarx flagging the repository method.
I''ve tried escaping the returned values with StringEscapeUtils::escapeHtml4, but checkmarx is flagging the method itself, so no amount of post santitization stops it from being flagged.
I''ve read that non-parameterized queries are a danger, but in this case I''m not sure what I can do. I can''t omit the @Query portion because of the need for the concat procedure.
So, is there another way I could go about this, or is this simply a false positive from checkmarx?
', '["java", "spring", "jpa", "checkmarx", "jparepository"]', '2024-11-14 04:13:46', '2024-11-14 04:13:46', 22, 0, 0, 0, 13054601, null),
        (79186629, 'How to Use Awaitility with Authentication Context in Spring Boot Integration Tests?', 'I''m facing an issue with using Awaitility in my Spring Boot integration tests. My setup involves setting an authentication context in the test before executing a piece of code that I want to verify with Awaitility. However, since Awaitility runs the predicate on a different thread, it cannot access the authentication context I have set up, causing my tests to fail.
Here is a simplified version of my code:
@Test
public void testMyServiceWithAuthentication() {
    // Logging in user


    myService.performAction();

    // Use Awaitility to wait for a condition
    await().atMost(10, SECONDS).until(() -> {
        // This predicate runs in a different thread, so it cannot access the authentication context
        return myService.checkCondition();
    });
}

When the Awaitility predicate runs, it does not have access to the authentication context set up in the main test thread, so myService.checkCondition() fails due to missing authentication.
My Question:
Is there a way to ensure that the authentication context is available to the Awaitility predicate when running in a Spring Boot integration test? Or is there an alternative approach for waiting on a condition that relies on authentication within the same thread?
', '["java", "spring", "spring-security", "automated-tests", "awaitility"]', '2024-11-14 04:48:51', '2024-11-14 14:42:23', 22, -1, 1, 0, 1552545, 79187634),
        (79186640, 'IntelliJ Java SQLException (table not found) even if table is there', 'I am studying java and have started learning about database implementation. I have decided to use SQLite and have already downloaded the .jav file, placed it in the classpath and used it in command prompt to create a database with two tables: dept and students.
When I try to run some simple code in java I always get an SQLException saying the students table does not exist despite it defiitely being there. I have checked the path and the tables many times but just can''t see the issue. If I don''t fix this I will not be able to continue learning JDBC so it is very important. Here is the code:
import java.sql.*;

public class Main {
    public static void main(String[] args)  {
        try {
            Class.forName("org.sqlite.JDBC");
            Connection conn = DriverManager.getConnection("jdbc:sqlite:C://sqlite//univ");

            Statement stmt = conn.createStatement();

            ResultSet rs = stmt.executeQuery("select * from students");
            while (rs.next()) {
                System.out.print(rs.getInt("rollno") + " ");
                System.out.print(rs.getString("name") + " ");
                System.out.print(rs.getString("city") + " ");
                System.out.print(rs.getInt("deptno") + " ");
            }
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}

This is the Error:
org.sqlite.SQLiteException: [SQLITE_ERROR] SQL error or missing database (no such table: students)
    at org.sqlite.core.DB.newSQLException(DB.java:1179)
    at org.sqlite.core.DB.newSQLException(DB.java:1190)
    at org.sqlite.core.DB.throwex(DB.java:1150)
    at org.sqlite.core.NativeDB.prepare_utf8(Native Method)
    at org.sqlite.core.NativeDB.prepare(NativeDB.java:135)
    at org.sqlite.core.DB.prepare(DB.java:264)
    at org.sqlite.jdbc3.JDBC3Statement.lambda$executeQuery$1(JDBC3Statement.java:87)
    at org.sqlite.jdbc3.JDBC3Statement.withConnectionTimeout(JDBC3Statement.java:458)
    at org.sqlite.jdbc3.JDBC3Statement.executeQuery(JDBC3Statement.java:85)
    at Main.main(Main.java:13)

Any help would be greatly appreciated.
', '["java", "sql", "sqlite", "intellij-idea", "jdbc"]', '2024-11-14 04:55:36', '2024-11-14 05:35:18', 44, -2, 1, 0, 14993783, null),
        (79186800, 'NullPointerException when building SessionFactory in Hibernate 5 with @Embeddable', 'I am migrating from xml configuration to annotations.
I have Barrier.hbm.xml file which has:
<?xml version="1.0"?>
<!DOCTYPE hibernate-mapping PUBLIC "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
        "http://hibernate.sourceforge.net/hibernate-mapping-3.0.dtd">
<hibernate-mapping schema="inv">
    <class name="Barrier" table="INV_BARRIER" >
        <composite-id access="field">
            <key-many-to-one name="coupon" class="domain.Coupon" column="COUPON_ID"/>
            <key-many-to-one name="underlyingUsage" class="domain.Underlying" column="UNDERLYING_USAGE_ID"/>
        </composite-id>
        <version name="version" type="int" insert="true" access="field">
            <column name="VERSION" default="0" />
        </version>
        <property name="barrierValue" type="big_decimal" column="BARRIER_VALUE"/>      
    </class>
</hibernate-mapping>

when I''m starting application without any annotation in class then I have an exception:
org.hibernate.AnnotationException: No identifier specified for entity: domain.Barrier

so I added annotations:
package domain;

import legacy.HibernatePersistentObject;
import flexjson.JSON;
import java.io.Serializable;
import java.math.BigDecimal;
import javax.persistence.*;
    @Entity
    @Table(name = "INV_BARRIER", schema = "inv")
    public class Barrier extends HibernatePersistentObject implements Serializable {
    
        @Embeddable
        public static class BarrierId implements Serializable {
    
            @ManyToOne
            @JoinColumn(name = "COUPON_ID")
            private Coupon coupon;
    
            @ManyToOne
            @JoinColumn(name = "UNDERLYING_USAGE_ID")
            private UnderlyingUsage underlyingUsage;
    
            //getters/setters/constructor/equals/hashcode
        }
    
        @EmbeddedId
        private BarrierId id;
    
        @Version
        @Column(name = "VERSION", nullable = false, columnDefinition = "int default 0")
        private Integer version;
        @Transient
        private Coupon coupon;
    
        private AbstractUnderlyingUsage underlyingUsage;
    
        @Column(name = "BARRIER_VALUE")
        private BigDecimal barrierValue;
      
    
        public Barrier() {
        }
    
    }

but now it''s worse because I just get:
    java.lang.NullPointerException
        at org.hibernate.boot.internal.InFlightMetadataCollectorImpl.processFkSecondPassesInOrder(InFlightMetadataCollectorImpl.java:1730)
        at org.hibernate.boot.internal.InFlightMetadataCollectorImpl.processSecondPasses(InFlightMetadataCollectorImpl.java:1640)
        at org.hibernate.cfg.Configuration.buildSessionFactory(Configuration.java:709)

without more information. What''s wrong here?
', '["java", "hibernate"]', '2024-11-14 05:52:02', '2024-11-14 19:25:41', 30, -1, 1, 0, 4952262, null),
        (79186853, 'Can Apache fury serialize a Java undirected graph (relations with cycles)?', 'Can Apache fury https://fury.apache.org serialize a Java undirected graph (relations with cycles)? I.e can I use it to replace all Java serialization usage?
', '["java", "serialization"]', '2024-11-14 06:20:48', '2024-11-14 06:20:48', 14, 0, 0, 0, 12081240, null),
        (79186949, 'Spring Framework bean is Null', 'In my spring boot application, I''ve an
 @Autowired ConfigurableEnvironment env;
object in a @RestController class.
When I hit an endpoint that''s calling
env.getPropertySources(); //Just for the sake of testing. not a real use case
the env object is not null.
Whereas I''ve an external dependency I''ve added to build.gradle.
That library has an @Configuration class that has an
@Autowired ConfigurableEnvironment object. This object is null when the library is trying to use it.
How can I force the bean from External library to be loaded in the last.
I''ve tried to create an ApplicationListener in my project, that destroys that bean and recreates it. This ApplicationListener has an @Order(Ordered.LOWEST_PRECEDENCE), to force this external bean to be recreated after all other beans are created.
But this is not working as well.
', '["java", "spring", "spring-boot"]', '2024-11-14 07:16:21', '2024-11-14 15:45:39', 39, 0, 0, 0, 475747, null),
        (79186968, 'Java Treeset not removing duplicate user defined object with custom compareTo', 'I try to remove duplicate object, duplicate when _id is the same or email is the same. I''m trying to eliminate duplicate if ids are the same OR emails are the same then keep the record with the latest Date.
My custom CompareTo:
 @Override
    public int compareTo(Lead other) {
         
        // Compare by ID first
        int idComparison = this._id.compareTo(other._id);
        if (idComparison != 0) {
            return idComparison;
        }
        
        int emailComparison = this.email.compareTo(other.email);
        if (emailComparison != 0) {
                return emailComparison;
       }

        
        // If IDs are the same, compare by date (latest first)
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd''T''HH:mm:ss");
            Date date1 = dateFormat.parse( this.entryDate);
            Date date2 = dateFormat.parse( other.entryDate);

            return date1.compareTo(date2);
        } catch (ParseException e) {

            return 0; // Handle parsing errors appropriately
        }

My declared and initialized
 // convert the JSON data to a Java object
        LeadsData leads = gson.fromJson(reader, LeadsData.class);

        // Remove duplicates using TreeSet
        TreeSet<Lead> uniqueRecords = new TreeSet<>(leads.leads);

I''m not sure where I did wrong. I checked Treeset doc, it seems quite straightforward.
', '["java", "duplicates", "treeset"]', '2024-11-14 07:33:19', '2024-11-15 02:40:39', 74, 0, 1, 0, 5561061, null),
        (79187141, 'If my machine has 10 physical threads then how can my JVM create 100s of threads?', 'I cannot understand how JVM is running 100s of threads on my machine if my machine only has 10 physical threads and JVM threads map to OS threads. Okay, the one answer I thought was time-slicing. But that''s not the case. I created a simple spring boot application which GETs response from another server that produces a 3 seconds delay. I ran the code with server.tomcat.threads.max=10 in application.properties and without it. The difference is day and night.
With server.tomcat.threads.max=10 -
>ab -n 1000 -c 100 http://localhost:8080/block
This is ApacheBench, Version 2.3 <$Revision: 1913912 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)
Completed 100 requests
Completed 200 requests
Completed 300 requests
Completed 400 requests
Completed 500 requests
Completed 600 requests
Completed 700 requests
Completed 800 requests
Completed 900 requests
Completed 1000 requests
Finished 1000 requests


Server Software:        
Server Hostname:        localhost
Server Port:            8080

Document Path:          /block
Document Length:        39 bytes

Concurrency Level:      100
Time taken for tests:   304.367 seconds
Complete requests:      1000
Failed requests:        100
   (Connect: 0, Receive: 0, Length: 100, Exceptions: 0)
Total transferred:      172100 bytes
HTML transferred:       39100 bytes
Requests per second:    3.29 [#/sec] (mean)
Time per request:       30436.732 [ms] (mean)
Time per request:       304.367 [ms] (mean, across all concurrent requests)
Transfer rate:          0.55 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.7      0       7
Processing:  3031 28738 4956.5  30102   30238
Waiting:     3028 28738 4956.8  30101   30238
Total:       3034 28739 4955.9  30102   30239

Percentage of the requests served within a certain time (ms)
  50%  30102
  66%  30112
  75%  30120
  80%  30134
  90%  30174
  95%  30205
  98%  30223
  99%  30230
 100%  30239 (longest request) 

Without server.tomcat.threads.max=10 -
ab -n 1000 -c 100 http://localhost:8080/block
This is ApacheBench, Version 2.3 <$Revision: 1913912 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)
Completed 100 requests
Completed 200 requests
Completed 300 requests
Completed 400 requests
Completed 500 requests
Completed 600 requests
Completed 700 requests
Completed 800 requests
Completed 900 requests
Completed 1000 requests
Finished 1000 requests


Server Software:        
Server Hostname:        localhost
Server Port:            8080

Document Path:          /block
Document Length:        39 bytes

Concurrency Level:      100
Time taken for tests:   33.435 seconds
Complete requests:      1000
Failed requests:        909
   (Connect: 0, Receive: 0, Length: 909, Exceptions: 0)
Total transferred:      173415 bytes
HTML transferred:       40415 bytes
Requests per second:    29.91 [#/sec] (mean)
Time per request:       3343.475 [ms] (mean)
Time per request:       33.435 [ms] (mean, across all concurrent requests)
Transfer rate:          5.07 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   1.0      0      11
Processing:  3002 3023  15.7   3021    3172
Waiting:     3002 3023  15.6   3020    3168
Total:       3002 3024  16.3   3021    3172

Percentage of the requests served within a certain time (ms)
  50%   3021
  66%   3026
  75%   3029
  80%   3031
  90%   3041
  95%   3063
  98%   3075
  99%   3078
 100%   3172 (longest request)

So if JVM threads are not platform threads then where do java virtual threads come into the picture? As I tested with virtual threads enabled also and it gave the same results as platform threads.
-Edit:
I know the application is creating 100s of threads because I am logging the threads. I also read that server.tomcat.threads.max value is 200 by default. But then again, how are these 200 threads running significantly faster if my machine has only 10 physical threads?
', '["java", "multithreading", "jvm", "virtual-threads"]', '2024-11-14 09:37:57', '2024-11-15 04:01:31', 104, -1, 2, 0, 9373771, 79187561),
        (79187538, 'Read gmail using Auth2.0 in Springboot (Java 17)', 'I want to implement google''s auth2.0 for security to read my gmail. So far it works well with the normal email and app password. But I am getting a invalid credentials error when auth2.0 access token is introduced. What am I doing wrong?
Credential credential = gmailOAuth2Config.authorize();
String oauthToken = credential.getAccessToken();

String oauth2Token = "user=" + gmailEmail + "\\u0001auth=Bearer " + oauthToken + "\\u0001\\u0001";
String base64AuthString = Base64.getEncoder().encodeToString(oauth2Token.getBytes(StandardCharsets.UTF_8));
System.out.println("Encoded SASL XOAUTH2 Token: " + base64AuthString);

Properties props = new Properties();
props.put("mail.imap.ssl.enable", "true");
props.put("mail.imap.sasl.enable", "true");
props.put("mail.imap.auth.mechanisms", "XOAUTH2");
props.put("mail.imap.auth.login.disable", "true");
props.put("mail.imap.auth.plain.disable", "true");

Session emailSession = Session.getInstance(props);
Store store = emailSession.getStore("imap");
//Store store = emailSession.getStore("imaps"); works!


try {
    store.connect("imap.gmail.com", gmailEmail, base64AuthString );
    store.connect("imap.gmail.com", gmailEmail, gmailPassword);//works
    System.out.println("Connected successfully to Gmail IMAP.");
} catch (jakarta.mail.AuthenticationFailedException e) {
    System.err.println("Authentication failed: " + e.getMessage());
}

2024-11-14T10:12:19.207+05:30 ERROR 11772 --- [emailservice] [   scheduling-1] c.d.emailservice.service.EmailService    : An error occurred while reading email inbox: Not connected

java.lang.IllegalStateException: Not connected
    at com.sun.mail.imap.IMAPStore.checkConnected(IMAPStore.java:1960) ~[jakarta.mail-2.0.1.jar:2.0.1]
    at com.sun.mail.imap.IMAPStore.getFolder(IMAPStore.java:1737) ~[jakarta.mail-2.0.1.jar:2.0.1]
    at com.doxmate.emailservice.service.EmailService.readEmail(EmailService.java:97) ~[classes/:na]
    at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:na]
    at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77) ~[na:na]
    at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[na:na]
    at java.base/java.lang.reflect.Method.invoke(Method.java:568) ~[na:na]
    at org.springframework.scheduling.support.ScheduledMethodRunnable.runInternal(ScheduledMethodRunnable.java:130) ~[spring-context-6.1.14.jar:6.1.14]
    at 

', '["java", "spring-boot", "oauth-2.0", "java-17", "gmail-imap"]', '2024-11-14 13:50:37', '2024-11-14 13:50:37', 34, 0, 0, 0, 15100297, null),
        (79187623, 'Need help understanding large springboot codebase. Looking for visualising tools', 'Just started my career and i am having a really difficult time understanding the codebase. The problem is there is no documentation of any micro service thats being used so i have to understand the codebase on my own or by asking team mates. is there a better way for this? I am looking for some tools that can help me visualise the architecture of different microservices so i can understand the code better.
Sorry if anything in the question does''t make sense. i don''t really know how to be more specific for now.
', '["java", "spring", "spring-boot", "microservices", "backend"]', '2024-11-14 14:34:41', '2024-11-14 14:34:41', 38, -3, 0, 0, 16962944, null),
        (79187641, 'Login and mongo db error when logging using spring security', 'I am trying to have a local project up and running using mongodb, springboot, spring-security and docker as tech stack. I am facing a couple issues when running the application:

Any url is getting redirected to /login, even though I have configured few urls to bypass authentication.
I am getting this error during start-up (not sure if this is breaking) :com.mongodb.MongoNodeIsRecoveringException: Command failed with error 11600 (InterruptedAtShutdown): ''interrupted at shutdown'' on server mongo:27017. The full response is {"ok": 0.0, "errmsg": "interrupted at shutdown", "code": 11600, "codeName": "InterruptedAtShutdown"}
Also, when I put any username and password to /login page , it sends me this error:

Caused by: com.mongodb.MongoSecurityException: Exception authenticating MongoCredential{mechanism=SCRAM-SHA-1, userName=''encora'', source=''taskmanagement'', password=<hidden>, mechanismProperties=<hidden>}
Below are the concerned classes:
@Configuration
@EnableWebSecurity(debug = true)
public class WebSecurityConfig {
  @Bean
  protected SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    http.csrf()
        .disable()
        .cors()
        .and()
        .authorizeHttpRequests()
        .requestMatchers((request) -> request.getServletPath().startsWith("/api/auth"))
        .permitAll()
        .anyRequest()
        .authenticated()
        .and()
        .formLogin();

    return http.build();
  }

  @Bean
  public PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
  }

I have also tried to use .antMatchers("/api/auth") instead of .requestMatchers and still getting an error.
Below is the controller class:
@RestController
@RequestMapping("/api/auth")
public class UserController {

  @Autowired private UserService userService;

  @PostMapping("/createUser")
  @ResponseStatus(HttpStatus.CREATED)
  public void createUser(@NotNull @RequestBody User user) {
    LOGGER.info("Creating user: {}", user.getUsername());
    userService.saveUser(user);
  }

Below is the service class:
@Service
public class UserService {

  @Autowired private UserRepository userRepository;

  public User saveUser(User user) {
    user.setPassword(
        hashPassword(user.getPassword()));

    return userRepository.save(user);
  }

Below are the concerned dependencies:
<groupId>org.myapp</groupId>
    <artifactId>team-management</artifactId>
    <version>1.0.0.0-SNAPSHOT</version>

    <packaging>jar</packaging>
    <name>team-management</name>
<dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
            <version>3.3.2</version>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
            <version>3.2.1</version>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-mongodb</artifactId>
            <version>2.7.18</version>
        </dependency>

Below are the docker files:
version: ''3.1''

services:
  team-management:
    build:
      context: .
      dockerfile: Dockerfile
    image: team-management
    ports:
      - "8080:8080"
    entrypoint: "java -Djava.security.egd=file:/dev/./urandom -jar /app.jar"

  mongo:
    image: mongo:latest
    volumes:
      - mongodb_data:/data/db
      - ./init-mongo.js:/docker-entrypoint-initdb.d/init-mongo.js
    environment:
      MONGO_INITDB_DATABASE: taskmanagement
      MONGO_INITDB_ROOT_USERNAME: encora
      MONGO_INITDB_ROOT_PASSWORD: training
    ports:
      - 27017:27017
volumes:
  mongodb_data:

Dockerfile
FROM openjdk:8

ARG JAR_FILE=target/team-management.jar

COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java", "-classpath", "app.jar", "org.encora.myapp.TeamManagementApplication"]
ENTRYPOINT ["java","-jar","/app.jar"]

', '["java", "mongodb", "docker", "spring-security"]', '2024-11-14 14:46:30', '2024-11-15 00:56:20', 37, 0, 0, 0, 4464806, null),
        (79187855, 'How to generate a value between min and max by step, but avoid an arithmetic overflow?', 'The difficulty lies in the possibility of overflow when subtracting min from max, but using a for loop to calculate one by one is also time-consuming.
    public static long random(long min, long max, int step) {
        if (step <= 0) {
            throw new IllegalArgumentException("step must > 0");
        }
        if (max < min) {
            throw new IllegalArgumentException("invalid range! min must <= max");
        }

        long range = (max - min) / step + 1;
        long randomIndex = ThreadLocalRandom.current().nextLong(range);
        return min + randomIndex * step;
    }


normal case:
If min=1, max=10, step=2, then the result could be any of them:
1 + 2 * 0 = 1
1 + 2 * 1= 3
1 + 2 * 2 = 5
1 + 2 * 3 = 7
1 + 2 * 4 = 9

edge case:
If min=Long.MIN_VALUE, max=Long.MAX_VALUE, and step=1, then max-min would equals to 0, hence the ThreadLocalRandom.current().nextLong(range) would throw a IllegalArgumentException. This is not I want, the result should range from Long.MIN_VALUE to Long.MAX_VALUE.
', '["java"]', '2024-11-14 16:08:01', '2024-11-14 20:36:48', 110, 2, 2, 0, 11523294, 79187886),
        (79187901, 'Does Tomcat 11 support Spring 6.1?', 'I know that Tomcat 11 supports servlet spec 6.1, but does it support olders as well?
Also, I''m not sure about the relationships between servlet specs and Spring versions. https://github.com/spring-projects/spring-framework/wiki/Spring-Framework-Versions lists something called Jakarta EE versions -- how are these related to servlet specs?
', '["java", "spring", "tomcat", "servlets"]', '2024-11-14 16:28:43', '2024-11-14 18:40:20', 46, -3, 1, 0, 261181, 79188387),
        (79187916, 'ApplicationContext not loading in Junit 4 test case after upgrading to spring-boot v3.2.10', 'This used to work in spring-boot v2 but after upgrading to spring-boot v3 test case gives error. The @Value annotation is not picking the right value from application.properties file because the ApplicationContext is not loading. Other test cases which do not have @Value annotation are working fine after upgrading to spring-boot v3 but only this test case is failing.
This is the test file
package com.booking.test.efs.config;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = RepositoryConfigTest.class)
@TestPropertySource("classpath:config/application-prod.properties")
public class RepositoryConfigTest {

    private static final int MONTH_TO_LIVE = 36;

    @Value("${efs.dynamodb.business.event.ttl.months}")
    private int beTtl;

    @Test
    public void checkProductionConfigHasRetentionProp() {
        assertEquals(beTtl, MONTH_TO_LIVE);
    }
}

This is the error I get when i run the test case
  .   ____          _            __ _ _
 /\\\\ / ___''_ __ _ _(_)_ __  __ _ \\ \\ \\ \\
( ( )\\___ | ''_ | ''_| | ''_ \\/ _` | \\ \\ \\ \\
 \\\\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  ''  |____| .__|_| |_|_| |_\\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::               (v3.2.10)

============================
CONDITIONS EVALUATION REPORT
============================

Positive matches:
----------------
    None

Negative matches:
-----------------
    None

Exclusions:
-----------
    None

Unconditional classes:
----------------------

    None

{"timestamp":"2024-11-14 13:22:12.857","level":"WARN","thread":"Test worker","logger":"org.springframework.test.context.TestContextManager","message":"Caught exception while allowing TestExecutionListener [org.springframework.test.context.web.ServletTestExecutionListener] to prepare test instance [com.booking.test.efs.config.RepositoryConfigTest@1f72fbd1]","context":"default","exception":"java.lang.IllegalStateException: Failed to load ApplicationContext for [WebMergedContextConfiguration@7b0525a8 testClass = com.booking.test.efs.config.RepositoryConfigTest, locations = [], classes = [com.booking.test.efs.config.RepositoryConfigTest], contextInitializerClasses = [], activeProfiles = [], propertySourceDescriptors = [PropertySourceDescriptor[locations=[classpath:config/application-prod.properties], ignoreResourceNotFound=false, name=null, propertySourceFactory=null, encoding=null]], propertySourceProperties = [\\"org.springframework.boot.test.context.SpringBootTestContextBootstrapper=true\\"], contextCustomizers = [org.spockframework.spring.mock.SpockContextCustomizer@0, org.springframework.boot.test.autoconfigure.actuate.observability.ObservabilityContextCustomizerFactory$DisableObservabilityContextCustomizer@1f, org.springframework.boot.test.autoconfigure.properties.PropertyMappingContextCustomizer@0, org.springframework.boot.test.autoconfigure.web.servlet.WebDriverContextCustomizer@5ac7aa18, org.springframework.boot.test.context.filter.ExcludeFilterContextCustomizer@c27d163, org.springframework.boot.test.json.DuplicateJsonObjectContextCustomizerFactory$DuplicateJsonObjectContextCustomizer@325bb9a6, org.springframework.boot.test.mock.mockito.MockitoContextCustomizer@0, org.springframework.boot.test.web.client.TestRestTemplateContextCustomizer@23e44287, org.springframework.boot.test.web.reactor.netty.DisableReactorResourceFactoryGlobalResourcesContextCustomizerFactory$DisableReactorResourceFactoryGlobalResourcesContextCustomizerCustomizer@14fc5d40, org.springframework.test.context.web.socket.MockServerContainerContextCustomizer@3afae281, org.springframework.boot.test.context.SpringBootTestAnnotation@eca5d99e], resourceBasePath = \\"src/main/webapp\\", contextLoader = org.springframework.boot.test.context.SpringBootContextLoader, parent = null]\\n\\tat org.springframework.test.context.cache.DefaultCacheAwareContextLoaderDelegate.loadContext(DefaultCacheAwareContextLoaderDelegate.java:180)\\n\\tat org.springframework.test.context.support.DefaultTestContext.getApplicationContext(DefaultTestContext.java:130)\\n\\tat org.springframework.test.context.web.ServletTestExecutionListener.setUpRequestContextIfNecessary(ServletTestExecutionListener.java:191)\\n\\tat org.springframework.test.context.web.ServletTestExecutionListener.prepareTestInstance(ServletTestExecutionListener.java:130)\\n\\tat org.springframework.test.context.TestContextManager.prepareTestInstance(TestContextManager.java:260)\\n\\tat org.springframework.test.context.junit4.SpringJUnit4ClassRunner.createTest(SpringJUnit4ClassRunner.java:228)\\n\\tat org.springframework.test.context.junit4.SpringJUnit4ClassRunner$1.runReflectiveCall(SpringJUnit4ClassRunner.java:289)\\n\\tat org.junit.internal.runners.model.ReflectiveCallable.run(ReflectiveCallable.java:12)\\n\\tat org.springframework.test.context.junit4.SpringJUnit4ClassRunner.methodBlock(SpringJUnit4ClassRunner.java:291)\\n\\tat org.springframework.test.context.junit4.SpringJUnit4ClassRunner.runChild(SpringJUnit4ClassRunner.java:247)\\n\\tat org.springframework.test.context.junit4.SpringJUnit4ClassRunner.runChild(SpringJUnit4ClassRunner.java:97)\\n\\tat org.junit.runners.ParentRunner$4.run(ParentRunner.java:331)\\n\\tat org.junit.runners.ParentRunner$1.schedule(ParentRunner.java:79)\\n\\tat org.junit.runners.ParentRunner.runChildren(ParentRunner.java:329)\\n\\tat org.junit.runners.ParentRunner.access$100(ParentRunner.java:66)\\n\\tat org.junit.runners.ParentRunner$2.evaluate(ParentRunner.java:293)\\n\\tat org.springframework.test.context.junit4.statements.RunBeforeTestClassCallbacks.evaluate(RunBeforeTestClassCallbacks.java:61)\\n\\tat org.springframework.test.context.junit4.statements.RunAfterTestClassCallbacks.evaluate(RunAfterTestClassCallbacks.java:70)\\n\\tat org.junit.runners.ParentRunner$3.evaluate(ParentRunner.java:306)\\n\\tat org.junit.runners.ParentRunner.run(ParentRunner.java:413)\\n\\tat org.springframework.test.context.junit4.SpringJUnit4ClassRunner.run(SpringJUnit4ClassRunner.java:191)\\n\\tat org.gradle.api.internal.tasks.testing.junit.JUnitTestClassExecutor.runTestClass(JUnitTestClassExecutor.java:108)\\n\\tat org.gradle.api.internal.tasks.testing.junit.JUnitTestClassExecutor.execute(JUnitTestClassExecutor.java:57)\\n\\tat org.gradle.api.internal.tasks.testing.junit.JUnitTestClassExecutor.execute(JUnitTestClassExecutor.java:39)\\n\\tat org.gradle.api.internal.tasks.testing.junit.AbstractJUnitTestClassProcessor.processTestClass(AbstractJUnitTestClassProcessor.java:62)\\n\\tat org.gradle.api.internal.tasks.testing.SuiteTestClassProcessor.processTestClass(SuiteTestClassProcessor.java:52)\\n\\tat java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\\n\\tat java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77)\\n\\tat java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\\n\\tat java.base/java.lang.reflect.Method.invoke(Method.java:568)\\n\\tat org.gradle.internal.dispatch.ReflectionDispatch.dispatch(ReflectionDispatch.java:36)\\n\\tat org.gradle.internal.dispatch.ReflectionDispatch.dispatch(ReflectionDispatch.java:24)\\n\\tat org.gradle.internal.dispatch.ContextClassLoaderDispatch.dispatch(ContextClassLoaderDispatch.java:33)\\n\\tat org.gradle.internal.dispatch.ProxyDispatchAdapter$DispatchingInvocationHandler.invoke(ProxyDispatchAdapter.java:94)\\n\\tat jdk.proxy2/jdk.proxy2.$Proxy5.processTestClass(Unknown Source)\\n\\tat org.gradle.api.internal.tasks.testing.worker.TestWorker$2.run(TestWorker.java:176)\\n\\tat org.gradle.api.internal.tasks.testing.worker.TestWorker.executeAndMaintainThreadName(TestWorker.java:129)\\n\\tat org.gradle.api.internal.tasks.testing.worker.TestWorker.execute(TestWorker.java:100)\\n\\tat org.gradle.api.internal.tasks.testing.worker.TestWorker.execute(TestWorker.java:60)\\n\\tat org.gradle.process.internal.worker.child.ActionExecutionWorker.execute(ActionExecutionWorker.java:56)\\n\\tat org.gradle.process.internal.worker.child.SystemApplicationClassLoaderWorker.call(SystemApplicationClassLoaderWorker.java:113)\\n\\tat org.gradle.process.internal.worker.child.SystemApplicationClassLoaderWorker.call(SystemApplicationClassLoaderWorker.java:65)\\n\\tat worker.org.gradle.process.internal.worker.GradleWorkerMain.run(GradleWorkerMain.java:69)\\n\\tat worker.org.gradle.process.internal.worker.GradleWorkerMain.main(GradleWorkerMain.java:74)\\nCaused by: java.lang.IllegalStateException: java.lang.NoClassDefFoundError: org/springframework/beans/factory/config/InstantiationAwareBeanPostProcessorAdapter\\n\\tat org.springframework.boot.SpringApplication.handleRunFailure(SpringApplication.java:825)\\n\\tat org.springframework.boot.SpringApplication.run(SpringApplication.java:345)\\n\\tat org.springframework.boot.test.context.SpringBootContextLoader.lambda$loadContext$3(SpringBootContextLoader.java:137)\\n\\tat org.springframework.util.function.ThrowingSupplier.get(ThrowingSupplier.java:58)\\n\\tat org.springframework.util.function.ThrowingSupplier.get(ThrowingSupplier.java:46)\\n\\tat org.springframework.boot.SpringApplication.withHook(SpringApplication.java:1463)\\n\\tat org.springframework.boot.test.context.SpringBootContextLoader$ContextLoaderHook.run(SpringBootContextLoader.java:553)\\n\\tat org.springframework.boot.test.context.SpringBootContextLoader.loadContext(SpringBootContextLoader.java:137)\\n\\tat org.springframework.boot.test.context.SpringBootContextLoader.loadContext(SpringBootContextLoader.java:108)\\n\\tat org.springframework.test.context.cache.DefaultCacheAwareContextLoaderDelegate.loadContextInternal(DefaultCacheAwareContextLoaderDelegate.java:225)\\n\\tat org.springframework.test.context.cache.DefaultCacheAwareContextLoaderDelegate.loadContext(DefaultCacheAwareContextLoaderDelegate.java:152)\\n\\t... 43 common frames omitted\\nCaused by: java.lang.NoClassDefFoundError: org/springframework/beans/factory/config/InstantiationAwareBeanPostProcessorAdapter\\n\\tat java.base/java.lang.ClassLoader.defineClass1(Native Method)\\n\\tat java.base/java.lang.ClassLoader.defineClass(ClassLoader.java:1017)\\n\\tat java.base/java.security.SecureClassLoader.defineClass(SecureClassLoader.java:150)\\n\\tat java.base/jdk.internal.loader.BuiltinClassLoader.defineClass(BuiltinClassLoader.java:862)\\n\\tat java.base/jdk.internal.loader.BuiltinClassLoader.findClassOnClassPathOrNull(BuiltinClassLoader.java:760)\\n\\tat java.base/jdk.internal.loader.BuiltinClassLoader.loadClassOrNull(BuiltinClassLoader.java:681)\\n\\tat java.base/jdk.internal.loader.BuiltinClassLoader.loadClass(BuiltinClassLoader.java:639)\\n\\tat java.base/jdk.internal.loader.ClassLoaders$AppClassLoader.loadClass(ClassLoaders.java:188)\\n\\tat java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:525)\\n\\tat org.spockframework.spring.mock.SpockContextCustomizer.customizeContext(SpockContextCustomizer.java:43)\\n\\tat org.springframework.boot.test.context.SpringBootContextLoader$ContextCustomizerAdapter.initialize(SpringBootContextLoader.java:443)\\n\\tat org.springframework.boot.SpringApplication.applyInitializers(SpringApplication.java:627)\\n\\tat org.springframework.boot.SpringApplication.prepareContext(SpringApplication.java:401)\\n\\tat org.springframework.boot.SpringApplication.run(SpringApplication.java:334)\\n\\t... 52 common frames omitted\\nCaused by: java.lang.ClassNotFoundException: org.springframework.beans.factory.config.InstantiationAwareBeanPostProcessorAdapter\\n\\tat java.base/jdk.internal.loader.BuiltinClassLoader.loadClass(BuiltinClassLoader.java:641)\\n\\tat java.base/jdk.internal.loader.ClassLoaders$AppClassLoader.loadClass(ClassLoaders.java:188)\\n\\tat java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:525)\\n\\t... 66 common frames omitted\\n"}

Failed to load ApplicationContext for [WebMergedContextConfiguration@7b0525a8 testClass = com.booking.test.efs.config.RepositoryConfigTest, locations = [], classes = [com.booking.test.efs.config.RepositoryConfigTest], contextInitializerClasses = [], activeProfiles = [], propertySourceDescriptors = [PropertySourceDescriptor[locations=[classpath:config/application-prod.properties], ignoreResourceNotFound=false, name=null, propertySourceFactory=null, encoding=null]], propertySourceProperties = ["org.springframework.boot.test.context.SpringBootTestContextBootstrapper=true"], contextCustomizers = [org.spockframework.spring.mock.SpockContextCustomizer@0, org.springframework.boot.test.autoconfigure.actuate.observability.ObservabilityContextCustomizerFactory$DisableObservabilityContextCustomizer@1f, org.springframework.boot.test.autoconfigure.properties.PropertyMappingContextCustomizer@0, org.springframework.boot.test.autoconfigure.web.servlet.WebDriverContextCustomizer@5ac7aa18, org.springframework.boot.test.context.filter.ExcludeFilterContextCustomizer@c27d163, org.springframework.boot.test.json.DuplicateJsonObjectContextCustomizerFactory$DuplicateJsonObjectContextCustomizer@325bb9a6, org.springframework.boot.test.mock.mockito.MockitoContextCustomizer@0, org.springframework.boot.test.web.client.TestRestTemplateContextCustomizer@23e44287, org.springframework.boot.test.web.reactor.netty.DisableReactorResourceFactoryGlobalResourcesContextCustomizerFactory$DisableReactorResourceFactoryGlobalResourcesContextCustomizerCustomizer@14fc5d40, org.springframework.test.context.web.socket.MockServerContainerContextCustomizer@3afae281, org.springframework.boot.test.context.SpringBootTestAnnotation@eca5d99e], resourceBasePath = "src/main/webapp", contextLoader = org.springframework.boot.test.context.SpringBootContextLoader, parent = null]
java.lang.IllegalStateException: Failed to load ApplicationContext for [WebMergedContextConfiguration@7b0525a8 testClass = com.booking.test.efs.config.RepositoryConfigTest, locations = [], classes = [com.booking.test.efs.config.RepositoryConfigTest], contextInitializerClasses = [], activeProfiles = [], propertySourceDescriptors = [PropertySourceDescriptor[locations=[classpath:config/application-prod.properties], ignoreResourceNotFound=false, name=null, propertySourceFactory=null, encoding=null]], propertySourceProperties = ["org.springframework.boot.test.context.SpringBootTestContextBootstrapper=true"], contextCustomizers = [org.spockframework.spring.mock.SpockContextCustomizer@0, org.springframework.boot.test.autoconfigure.actuate.observability.ObservabilityContextCustomizerFactory$DisableObservabilityContextCustomizer@1f, org.springframework.boot.test.autoconfigure.properties.PropertyMappingContextCustomizer@0, org.springframework.boot.test.autoconfigure.web.servlet.WebDriverContextCustomizer@5ac7aa18, org.springframework.boot.test.context.filter.ExcludeFilterContextCustomizer@c27d163, org.springframework.boot.test.json.DuplicateJsonObjectContextCustomizerFactory$DuplicateJsonObjectContextCustomizer@325bb9a6, org.springframework.boot.test.mock.mockito.MockitoContextCustomizer@0, org.springframework.boot.test.web.client.TestRestTemplateContextCustomizer@23e44287, org.springframework.boot.test.web.reactor.netty.DisableReactorResourceFactoryGlobalResourcesContextCustomizerFactory$DisableReactorResourceFactoryGlobalResourcesContextCustomizerCustomizer@14fc5d40, org.springframework.test.context.web.socket.MockServerContainerContextCustomizer@3afae281, org.springframework.boot.test.context.SpringBootTestAnnotation@eca5d99e], resourceBasePath = "src/main/webapp", contextLoader = org.springframework.boot.test.context.SpringBootContextLoader, parent = null]
        at org.springframework.test.context.cache.DefaultCacheAwareContextLoaderDelegate.loadContext(DefaultCacheAwareContextLoaderDelegate.java:180)
        at org.springframework.test.context.support.DefaultTestContext.getApplicationContext(DefaultTestContext.java:130)
        at org.springframework.test.context.web.ServletTestExecutionListener.setUpRequestContextIfNecessary(ServletTestExecutionListener.java:191)
        at org.springframework.test.context.web.ServletTestExecutionListener.prepareTestInstance(ServletTestExecutionListener.java:130)
        at org.springframework.test.context.TestContextManager.prepareTestInstance(TestContextManager.java:260)
        at org.springframework.test.context.junit4.SpringJUnit4ClassRunner.createTest(SpringJUnit4ClassRunner.java:228)
        at org.springframework.test.context.junit4.SpringJUnit4ClassRunner$1.runReflectiveCall(SpringJUnit4ClassRunner.java:289)
        at org.junit.internal.runners.model.ReflectiveCallable.run(ReflectiveCallable.java:12)
        at org.springframework.test.context.junit4.SpringJUnit4ClassRunner.methodBlock(SpringJUnit4ClassRunner.java:291)
        at org.springframework.test.context.junit4.SpringJUnit4ClassRunner.runChild(SpringJUnit4ClassRunner.java:247)
        at org.springframework.test.context.junit4.SpringJUnit4ClassRunner.runChild(SpringJUnit4ClassRunner.java:97)
        at org.junit.runners.ParentRunner$4.run(ParentRunner.java:331)
        at org.junit.runners.ParentRunner$1.schedule(ParentRunner.java:79)
        at org.junit.runners.ParentRunner.runChildren(ParentRunner.java:329)
        at org.junit.runners.ParentRunner.access$100(ParentRunner.java:66)
        at org.junit.runners.ParentRunner$2.evaluate(ParentRunner.java:293)
        at org.springframework.test.context.junit4.statements.RunBeforeTestClassCallbacks.evaluate(RunBeforeTestClassCallbacks.java:61)
        at org.springframework.test.context.junit4.statements.RunAfterTestClassCallbacks.evaluate(RunAfterTestClassCallbacks.java:70)
        at org.junit.runners.ParentRunner$3.evaluate(ParentRunner.java:306)
        at org.junit.runners.ParentRunner.run(ParentRunner.java:413)
        at org.springframework.test.context.junit4.SpringJUnit4ClassRunner.run(SpringJUnit4ClassRunner.java:191)
        at org.gradle.api.internal.tasks.testing.junit.JUnitTestClassExecutor.runTestClass(JUnitTestClassExecutor.java:108)
        at org.gradle.api.internal.tasks.testing.junit.JUnitTestClassExecutor.execute(JUnitTestClassExecutor.java:57)
        at org.gradle.api.internal.tasks.testing.junit.JUnitTestClassExecutor.execute(JUnitTestClassExecutor.java:39)
        at org.gradle.api.internal.tasks.testing.junit.AbstractJUnitTestClassProcessor.processTestClass(AbstractJUnitTestClassProcessor.java:62)
        at org.gradle.api.internal.tasks.testing.SuiteTestClassProcessor.processTestClass(SuiteTestClassProcessor.java:52)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77)
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.base/java.lang.reflect.Method.invoke(Method.java:568)
        at org.gradle.internal.dispatch.ReflectionDispatch.dispatch(ReflectionDispatch.java:36)
        at org.gradle.internal.dispatch.ReflectionDispatch.dispatch(ReflectionDispatch.java:24)
        at org.gradle.internal.dispatch.ContextClassLoaderDispatch.dispatch(ContextClassLoaderDispatch.java:33)
        at org.gradle.internal.dispatch.ProxyDispatchAdapter$DispatchingInvocationHandler.invoke(ProxyDispatchAdapter.java:94)
        at jdk.proxy2/jdk.proxy2.$Proxy5.processTestClass(Unknown Source)
        at org.gradle.api.internal.tasks.testing.worker.TestWorker$2.run(TestWorker.java:176)
        at org.gradle.api.internal.tasks.testing.worker.TestWorker.executeAndMaintainThreadName(TestWorker.java:129)
        at org.gradle.api.internal.tasks.testing.worker.TestWorker.execute(TestWorker.java:100)
        at org.gradle.api.internal.tasks.testing.worker.TestWorker.execute(TestWorker.java:60)
        at org.gradle.process.internal.worker.child.ActionExecutionWorker.execute(ActionExecutionWorker.java:56)
        at org.gradle.process.internal.worker.child.SystemApplicationClassLoaderWorker.call(SystemApplicationClassLoaderWorker.java:113)
        at org.gradle.process.internal.worker.child.SystemApplicationClassLoaderWorker.call(SystemApplicationClassLoaderWorker.java:65)
        at worker.org.gradle.process.internal.worker.GradleWorkerMain.run(GradleWorkerMain.java:69)
        at worker.org.gradle.process.internal.worker.GradleWorkerMain.main(GradleWorkerMain.java:74)
Caused by: java.lang.IllegalStateException: java.lang.NoClassDefFoundError: org/springframework/beans/factory/config/InstantiationAwareBeanPostProcessorAdapter
        at org.springframework.boot.SpringApplication.handleRunFailure(SpringApplication.java:825)
        at org.springframework.boot.SpringApplication.run(SpringApplication.java:345)
        at org.springframework.boot.test.context.SpringBootContextLoader.lambda$loadContext$3(SpringBootContextLoader.java:137)
        at org.springframework.util.function.ThrowingSupplier.get(ThrowingSupplier.java:58)
        at org.springframework.util.function.ThrowingSupplier.get(ThrowingSupplier.java:46)
        at org.springframework.boot.SpringApplication.withHook(SpringApplication.java:1463)
        at org.springframework.boot.test.context.SpringBootContextLoader$ContextLoaderHook.run(SpringBootContextLoader.java:553)
        at org.springframework.boot.test.context.SpringBootContextLoader.loadContext(SpringBootContextLoader.java:137)
        at org.springframework.boot.test.context.SpringBootContextLoader.loadContext(SpringBootContextLoader.java:108)
        at org.springframework.test.context.cache.DefaultCacheAwareContextLoaderDelegate.loadContextInternal(DefaultCacheAwareContextLoaderDelegate.java:225)
        at org.springframework.test.context.cache.DefaultCacheAwareContextLoaderDelegate.loadContext(DefaultCacheAwareContextLoaderDelegate.java:152)
        ... 43 more
Caused by: java.lang.NoClassDefFoundError: org/springframework/beans/factory/config/InstantiationAwareBeanPostProcessorAdapter
        at java.base/java.lang.ClassLoader.defineClass1(Native Method)
        at java.base/java.lang.ClassLoader.defineClass(ClassLoader.java:1017)
        at java.base/java.security.SecureClassLoader.defineClass(SecureClassLoader.java:150)
        at java.base/jdk.internal.loader.BuiltinClassLoader.defineClass(BuiltinClassLoader.java:862)
        at java.base/jdk.internal.loader.BuiltinClassLoader.findClassOnClassPathOrNull(BuiltinClassLoader.java:760)
        at java.base/jdk.internal.loader.BuiltinClassLoader.loadClassOrNull(BuiltinClassLoader.java:681)
        at java.base/jdk.internal.loader.BuiltinClassLoader.loadClass(BuiltinClassLoader.java:639)
        at java.base/jdk.internal.loader.ClassLoaders$AppClassLoader.loadClass(ClassLoaders.java:188)
        at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:525)
        at org.spockframework.spring.mock.SpockContextCustomizer.customizeContext(SpockContextCustomizer.java:43)
        at org.springframework.boot.test.context.SpringBootContextLoader$ContextCustomizerAdapter.initialize(SpringBootContextLoader.java:443)
        at org.springframework.boot.SpringApplication.applyInitializers(SpringApplication.java:627)
        at org.springframework.boot.SpringApplication.prepareContext(SpringApplication.java:401)
        at org.springframework.boot.SpringApplication.run(SpringApplication.java:334)
        ... 52 more
Caused by: java.lang.ClassNotFoundException: org.springframework.beans.factory.config.InstantiationAwareBeanPostProcessorAdapter
        at java.base/jdk.internal.loader.BuiltinClassLoader.loadClass(BuiltinClassLoader.java:641)
        at java.base/jdk.internal.loader.ClassLoaders$AppClassLoader.loadClass(ClassLoaders.java:188)
        at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:525)
        ... 66 more


com.booking.test.efs.config.RepositoryConfigTest > checkProductionConfigHasRetentionProp FAILED
    java.lang.IllegalStateException at DefaultCacheAwareContextLoaderDelegate.java:180
        Caused by: java.lang.IllegalStateException at SpringApplication.java:825
            Caused by: java.lang.NoClassDefFoundError at ClassLoader.java:-2
                Caused by: java.lang.ClassNotFoundException at BuiltinClassLoader.java:641
1 test completed, 1 failed
FAILURE: Build failed with an exception.
BUILD FAILED in 14s
7 actionable tasks: 3 executed, 4 up-to-date

These are dependencies of the build.gradle file
dependencies {

    implementation ''org.springframework:spring-web''
    implementation ''org.springframework.boot:spring-boot-starter''
    implementation ''org.springframework.boot:spring-boot-starter-actuator''
    implementation ''org.springframework.boot:spring-boot-starter-web''
    implementation ''org.springframework.boot:spring-boot-starter-web-services''
    implementation ''com.github.ulisesbocchio:jasypt-spring-boot''
    implementation ''org.hibernate.validator:hibernate-validator''
    implementation ''org.yaml:snakeyaml:2.0''
    implementation ''org.apache.commons:commons-compress:1.26.0''
    implementation ''com.google.guava:guava:32.0.1-jre''
    implementation ''software.amazon.awssdk:s3''
    implementation ''software.amazon.awssdk:s3-transfer-manager:2.28.0''
    implementation ''software.amazon.awssdk:dynamodb''
    implementation ''software.amazon.awssdk:dynamodb-enhanced:2.28.0''

    implementation ''io.opentracing.contrib:span-reporter-slf4j''
    implementation ''jaxen:jaxen''
    implementation ''joda-time:joda-time''
    implementation ''net.sf.saxon:Saxon-HE:9.9.1-3''
    implementation ''org.apache.commons:commons-collections4:4.4''
    implementation ''xerces:xercesImpl:2.12.2''
    implementation ''com.fasterxml.jackson.core:jackson-databind:2.15.0''
    implementation ''com.fasterxml.jackson.core:jackson-annotations:2.15.0''
    implementation ''com.fasterxml.jackson.core:jackson-core:2.15.0''
    implementation ''com.fasterxml.jackson.dataformat:jackson-dataformat-cbor:2.15.0''
    implementation ''jakarta.xml.bind:jakarta.xml.bind-api:4.0.2''
    implementation ''org.glassfish.jaxb:jaxb-runtime:4.0.2''
    implementation ''org.aspectj:aspectjrt''
    implementation ''org.aspectj:aspectjweaver''
    runtimeOnly ''ch.qos.logback:logback-access''

    testImplementation ''com.amazonaws:DynamoDBLocal:2.5.2''
    testImplementation ''com.almworks.sqlite4java:sqlite4java:1.0.392''
    testImplementation ''com.fasterxml.jackson.module:jackson-module-jaxb-annotations''
    testImplementation ''org.springframework:spring-beans''
    testImplementation ''org.springframework:spring-context''
    testImplementation ''org.springframework:spring-core''
    testImplementation ''org.springframework:spring-aop''
    testImplementation ''org.springframework:spring-context-support''
    testImplementation ''org.springframework:spring-test''
    testImplementation ''org.codehaus.groovy:groovy:3.0.9''
    testImplementation ''org.spockframework:spock-core:2.1-groovy-3.0''
    testImplementation ''org.spockframework:spock-spring:2.1-groovy-3.0''
    testImplementation ''cglib:cglib-nodep''
    testImplementation ''org.mockito:mockito-core''
    testImplementation ''org.unitils:unitils-core''
    testImplementation ''org.springframework.boot:spring-boot-starter-test''
}

', '["java", "gradle", "junit4", "spring-boot-3"]', '2024-11-14 16:34:25', '2024-11-14 16:34:25', 33, 1, 0, 0, 12073566, null),
        (79187994, 'No -nowarn or -Xlint:none option for java command?', 'Javac has an option to suppress warnings by passing option -Xlint:none or -nowarn. I run source code without compiling using java command (JEP-330, JEP-458). Is there an option for suppressing warnings in similar way, without modifying source code?
Example source code:
public class UncheckedWarning {
  public static void main(String[] args) throws Exception {
    System.out.println(Object.class.newInstance());
  }
}

terminal:
$ java UncheckedWarning.java
UncheckedWarning.java:3: warning: [deprecation] newInstance() in Class has been deprecated
    System.out.println(Object.class.newInstance());
                                   ^
  where T is a type-variable:
    T extends Object declared in class Class
1 warning
java.lang.Object@3c0a50da

', '["java"]', '2024-11-14 17:07:30', '2024-11-14 18:07:13', 36, 0, 0, 0, 344847, null),
        (79188028, 'Best way to document API&#39;s in Spring 5 Not Spring Boot', 'Im Trying to add swagger documentation for all the API''s in my Spring 5 project . Im not able to figure out the best way to do it . I see we can use springdoc openapi but most of the documentation and example says how to do it in Spring Boot project . I want to use it in Spring 5 Project . Also is it ok to use Spring Fox ?? which is better option and can u guide me with example links.
', '["java", "spring", "swagger", "springdoc", "springdoc-openapi-ui"]', '2024-11-14 17:17:23', '2024-11-14 18:22:43', 25, 0, 1, 0, 8089743, null),
        (79188255, 'NoClassDefFoundError: Failed resolution of: Ljava/net/http/HttpClient', 'About Automation Testing in android java project, using with Appium framework.
After follow Automation Testing with Appium guideline
I had:

android java project (java programming language)

include: appium framework (implementation appium library)

setup appium method

appium server started

include these testing framework also: testNG, espresso, uiautomator2


After write|run test case, it can not find class|package java.net.http.HttpClient (while other classes must be found from package java.net.http, ex.: URL, ...)

NoClassDefFoundError: Failed resolution of: Ljava/net/http/HttpClient


How to resolve this issue?
package ex.jvautotest;

import android.util.Log;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.openqa.selenium.By;

import java.net.MalformedURLException;
import java.net.URL;
import java.time.Duration;

import io.appium.java_client.android.AndroidDriver;
import io.appium.java_client.remote.options.BaseOptions;

public class FirstTest {
    
static AndroidDriver driver;

    @BeforeClass
    public static void setUp() throws MalformedURLException {
        Log.d("", "SETUP ...");

        var options = new BaseOptions()
                .amend("appium:automationName", "UiAutomator2")
                .amend("appium:deviceName", "emulator-5554")
                .amend("appium:platformName", "Android")
                .amend("appium:app", "/Users/.../Desktop/app-debug.apk")
                .amend("appium:newCommandTimeout", 3600)
                .amend("appium:connectHardwareKeyboard", true);

        /// ERROR IN THIS LINE
        driver = new AndroidDriver(new URL("http://127.0.0.1:4723"), options);

        Log.d("", "SETUP SUCCESS");
    }

    @Test
    public void sampleTest() throws Exception {
        try {
            Duration d = Duration.ofSeconds(10);
            // 1 - get Email, then input text
//            By usernameId = By.id("com.example.autotestsample:id/username");
            By usernameId = By.xpath(
                    "//android.widget.EditText[@resource-id=\\"com.example.autotestsample:id/username\\"]");
            driver.findElement(usernameId).sendKeys("user@email.com");    

        } catch (Exception e) {
            Log.d("", "Login failed");

            throw e;
        }
    }

    @AfterClass
    public static void tearDown() {
        driver.quit();
    }
}

File build.gradle:
plugins {
alias(libs.plugins.android.application)
}

android {
namespace = "ex.jvautotest"
compileSdk = 35

defaultConfig {
    applicationId = "ex.jvautotest"
    minSdk = 33
    targetSdk = 35
    versionCode = 1
    versionName = "1.0"

    testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
}

buildTypes {
    release {
        isMinifyEnabled = false
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }
}
compileOptions {
    sourceCompatibility = JavaVersion.VERSION_21
    targetCompatibility = JavaVersion.VERSION_21
}
packaging {
    resources {
        excludes.add("META-INF/LICENSE.md")
        excludes.add("META-INF/LICENSE-notice.md")
        excludes.add("META-INF/INDEX.LIST")
        excludes.add("META-INF/io.netty.versions.properties")
        excludes.add("META-INF/DEPENDENCIES")
    }
}
}

dependencies {
//    implementation("org.openjdk:java.net:21")

implementation(libs.appcompat)
implementation(libs.material)
implementation(libs.activity)
implementation(libs.constraintlayout)
implementation(libs.androidx.room.rxjava2)
implementation(libs.androidx.room.rxjava3)
implementation(libs.androidx.room.guava)
testImplementation(libs.androidx.room.testing)
implementation(libs.androidx.room.paging)

implementation(libs.ext.appiumJavaClient)
testImplementation(libs.ext.appiumJavaClient)

implementation(libs.ext.appiumSeleniumClient)
testImplementation(libs.ext.appiumSeleniumClient)
implementation(libs.ext.appiumSeleniumHttp)
testImplementation(libs.ext.appiumSeleniumHttp)

testImplementation(libs.junit)
androidTestImplementation(libs.ext.junit)
androidTestImplementation(libs.espresso.core)
androidTestImplementation(libs.junit.jupiter)
androidTestImplementation(libs.testng)
}

libs.versions.toML file:
    [versions]
agp = "8.7.2"
appiumJavaClient = "9.3.0"
#appiumSeleniumClient = "4.26.0"

junit = "4.13.2"
junitVersion = "1.2.1"
junitJupiter = "5.11.3"
roomRuntime = "2.6.1"
testng = "7.10.2"
espressoCore = "3.6.1"

appcompat = "1.7.0"
material = "1.12.0"
activity = "1.9.3"
constraintlayout = "2.2.0"

[libraries]
androidx-room-compiler = { module = "androidx.room:room-compiler", version.ref = "roomRuntime" }
androidx-room-guava = { module = "androidx.room:room-guava", version.ref = "roomRuntime" }
androidx-room-ktx = { module = "androidx.room:room-ktx", version.ref = "roomRuntime" }
androidx-room-paging = { module = "androidx.room:room-paging", version.ref = "roomRuntime" }
androidx-room-runtime = { module = "androidx.room:room-runtime", version.ref = "roomRuntime" }
androidx-room-rxjava2 = { module = "androidx.room:room-rxjava2", version.ref = "roomRuntime" }
androidx-room-rxjava3 = { module = "androidx.room:room-rxjava3", version.ref = "roomRuntime" }
androidx-room-testing = { module = "androidx.room:room-testing", version.ref = "roomRuntime" }

ext-appiumJavaClient = { group = "io.appium", name = "java-client", version.ref = "appiumJavaClient" }

ext-appiumSeleniumClient = { group = "org.seleniumhq.selenium", name = "selenium-java", version.ref = "appiumSeleniumClient" }
ext-appiumSeleniumHttp = { group = "org.seleniumhq.selenium", name = "selenium-http", version.ref = "appiumSeleniumClient" }

junit = { group = "junit", name = "junit", version.ref = "junit" }
ext-junit = { group = "androidx.test.ext", name = "junit", version.ref = "junitVersion" }
junit-jupiter = { group = "org.junit.jupiter", name = "junit-jupiter", version.ref = "junitJupiter" }
testng = { group = "org.testng", name = "testng", version.ref = "testng" }

espresso-core = { group = "androidx.test.espresso", name = "espresso-core", version.ref = "espressoCore" }
appcompat = { group = "androidx.appcompat", name = "appcompat", version.ref = "appcompat" }
material = { group = "com.google.android.material", name = "material", version.ref = "material" }
activity = { group = "androidx.activity", name = "activity", version.ref = "activity" }
constraintlayout = { group = "androidx.constraintlayout", name = "constraintlayout", version.ref = "constraintlayout" }


[plugins]
android-application = { id = "com.android.application", version.ref = "agp" }

Build system:

openjdk@21
Gradle 8.9 && 8.11



', '["java", "android", "appium", "appium-android", "automation-testing"]', '2024-11-14 18:18:04', '2024-11-18 11:50:26', 44, 0, 1, 0, 2522405, null),
        (79188290, 'Java class library to C# DLL', 'There is an open source maven Java project where I need some of the functionality in .NET
The project is this one: https://github.com/ZUGFeRD/mustangproject
My goal is to use the methods of the validator and the library in my .NET Project
I tried using IKVM Tools without success.
Here are the steps I did.

do a mvn clean install in both of the libraries validator and library what gives me the validator-2.15.0-SNAPSHOT.jar and library-2.15.0-SNAPSHOT.jar files
Copy them into the IKVM Tools directory, open console window and execute .\\ikvmc.exe -out:library-2.15.0-SNAPSHOT.dll library-2.15.0-SNAPSHOT.jar

That gives me an error
Core library not found. Make sure the appropriate reference assemblies for the target environment are included.

I am not a Java developer and find interpreting errors difficult.
I even tried contacting the IKVM dev who said IKVM only supports JDK8.
So I changed the pom.xml
<properties>
   <maven.compiler.source>1.8</maven.compiler.source><!-- was 11 before -->
   <maven.compiler.target>1.8</maven.compiler.target><!-- was 11 before -->
</properties>

But this changes nothing on the error I get.
Maybe someone has an idea what I am doing wrong
', '["java", "c#", "maven", "ikvm"]', '2024-11-14 18:22:37', '2024-11-14 21:49:54', 50, -1, 0, 0, 8428634, null),
        (79188308, 'How to replicate the x (Twitter) screen profile using motionlayout or collapsingtoolbarlayout', 'I''m trying to recreate the profile screen effect from the X (Twitter) app, where the profile picture reduces in size while scrolling, and the layout collapses smoothly. Here are the specific features I want to implement:
A circular profile picture that scales down as you scroll.
A TabLayout that stays visible and becomes fixed below the toolbar on scroll.
I''ve attempted to use both CollapsingToolbarLayout and MotionLayout, but I haven''t been able to achieve the same behavior. I’m coding in Java and using the de.hdodenhof:circleimageview:3.1.0 library for the circular profile picture.
Could anyone help me configure MotionLayout or CollapsingToolbarLayout to achieve this effect, or share a code example close to this behavior?
', '["java", "android", "android-collapsingtoolbarlayout", "android-motionlayout"]', '2024-11-14 18:24:31', '2024-11-14 18:24:31', 14, -1, 0, 0, 22356732, null),
        (79188309, 'javax.ws.rs.ProcessingException: RESTEASY004655: Unable to invoke request: org.apache.http.client.ClientProtocolException', 'I am trying to make a Post call to a api using Resteasy version 5.0.4.Final. This is my code below:
package com.jc2.service.rest.contactmoment;
import com.jc2.service.client.domobj.ClientDO;
import com.jc2.service.rest.AbstractRestFacade;
import com.jc2.service.rest.contactmoment.transform.Transformer;
import com.jc2.service.user.McSecurityContext;
import com.jc2.service.user.McUserService;
import com.jc2.service.user.domobj.McUserDO;
import com.jc2.service.webservice.WebServiceFactory;
import lombok.extern.jbosslog.JBossLog;
import nl.lostlemon.mc.contactmoment.gen.ApiException;
import nl.lostlemon.mc.contactmoment.gen.api.DefaultApi;
import nl.lostlemon.mc.contactmoment.gen.model.WsContactMoment;
import nl.lostlemon.mc.contactmoment.gen.model.WsContactMomentResponse;


import javax.ejb.EJB;
import javax.ejb.Stateless;
import java.time.LocalDate;
import java.util.EnumMap;
import java.util.UUID;

@Stateless
@JBossLog
public class ContactMomentFacadeBean extends AbstractRestFacade implements        ContactMomentFacade {

@EJB
private WebServiceFactory webServiceFactory;
@EJB
private McUserService mcUserService;
@EJB
private Transformer transformer;


@Override
public void create(McSecurityContext context, ClientDO clientDO, BaseContactMomentDo contactMoment) {

    if (contactMoment == null) {
        throw new RuntimeException("contactMoment is null");
    }
    if (contactMoment.getUsernameMcUser() == null) {
        throw new RuntimeException("McUser is null");
    }
    if (context.getUsername() == null) {
        throw new RuntimeException("username is null");
    }
    try {
        final DefaultApi api = webServiceFactory.getContactMomentApi(bearerToken(context));
        McUserDO mcUser = mcUserService.findMcUser(context.getUsername());
        if (mcUser == null) {
            mcUser = mcUserService.findMcUser(contactMoment.getUsernameMcUser());
        }
        contactMoment.setUsernameMcUser(context.getUsername());
        //TODO remove this null check if not neccessary anymore
        if (contactMoment.getUsernameMcUser() == null) {
            contactMoment.setUsernameMcUser(mcUser.getUserName());
        }
        WsContactMoment wsContactMoment = new WsContactMoment();
        //TODO fix the getContactMomentType issue. it needs a transformer
        if (contactMoment.getContactMomentType() == null) {
            throw new RuntimeException("contactMomentType is null");
        }

        wsContactMoment.setContactType(transformer.transformContactTypeFromString(contactMoment.getContactMomentType()));
        wsContactMoment.setPublicationType(transformer.transformPublicationType().get(contactMoment.getPublicationType()));
        wsContactMoment.setUsernameMcUser(contactMoment.getUsernameMcUser());
        wsContactMoment.setActive(contactMoment.isActive());
        wsContactMoment.setInfo(contactMoment.getInfo());
        if (contactMoment.getUuid() != null && !contactMoment.getUuid().isEmpty()) {
            wsContactMoment.setUuid(contactMoment.getUuid());
        } else {
            wsContactMoment.setUuid(UUID.randomUUID().toString());
        }
        wsContactMoment.setContactMomentDate(LocalDate.parse(contactMoment.getContactMomentDate().toString()));

        api.createContactMoment(clientDO.getClientNumber(), wsContactMoment);

    } catch (ApiException e) {
        throw new RuntimeException(e.getMessage());
    }

}

The error occurs when trying to post a "contactMoment" in the following line of code.
api.createContactMoment(clientDO.getClientNumber(), wsContactMoment);
and I think the main problem lies in this error. How can I fix this?
Caused by: javax.ws.rs.ProcessingException: RESTEASY004655: Unable to invoke request:     org.apache.http.client.ClientProtocolException
    at org.jboss.resteasy.resteasy-    client@4.7.7.Final//org.jboss.resteasy.client.jaxrs.engines.ManualClosingApacheHttpClient43Engine.invoke(M    anualClosingApacheHttpClient43Engine.java:321)
    at org.jboss.resteasy.resteasy-   client@4.7.7.Final//org.jboss.resteasy.client.jaxrs.internal.ClientInvocation.invoke(ClientInvocation.java   :494)
        at org.jboss.resteasy.resteasy-   client@4.7.7.Final//org.jboss.resteasy.client.jaxrs.internal.ClientInvocation.invoke(ClientInvocation.java:69)
    at org.jboss.resteasy.resteasy-client@4.7.7.Final//org.jboss.resteasy.client.jaxrs.internal.ClientInvocationBuilder.post(ClientInvocationBuilder.java:226)

This is part of the stacktrace, I have searched quite a long time for the solution but couldn''t find much about it. If you guys need the full stacktrace I will try to paste it. but it was considered spam so I deleted some stuff from the stacktrace
09:56:37,529 ERROR [org.jboss.as.ejb3.invocation] (default task-2) WFLYEJB0034: Jakarta Enterprise Beans Invocation failed on component ContactMomentFacadeBean for method public abstract void com.jc2.service.rest.contactmoment.ContactMomentFacade.create(com.jc2.service.user.McSecurityContext,com.jc2.service.client.domobj.ClientDO,com.jc2.service.rest.contactmoment.BaseContactMomentDo): javax.ejb.EJBException: javax.ws.rs.ProcessingException: RESTEASY004655: Unable to invoke request: org.apache.http.client.ClientProtocolException
    at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.tx.CMTTxInterceptor.invokeInOurTx(CMTTxInterceptor.java:268)
    at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.tx.CMTTxInterceptor.required(CMTTxInterceptor.java:390)
    at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.tx.CMTTxInterceptor.processInvocation(CMTTxInterceptor.java:160)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext$Invocation.proceed(InterceptorContext.java:509)
    at org.jboss.weld.core@3.1.9.Final//org.jboss.weld.module.ejb.AbstractEJBRequestScopeActivationInterceptor.aroundInvoke(AbstractEJBRequestScopeActivationInterceptor.java:72)
    at org.jboss.as.weld.common@26.1.2.Final//org.jboss.as.weld.ejb.EjbRequestScopeActivationInterceptor.processInvocation(EjbRequestScopeActivationInterceptor.java:89)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.component.interceptors.CurrentInvocationContextInterceptor.processInvocation(CurrentInvocationContextInterceptor.java:41)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.component.invocationmetrics.WaitTimeInterceptor.processInvocation(WaitTimeInterceptor.java:47)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.security.IdentityOutflowInterceptor.processInvocation(IdentityOutflowInterceptor.java:73)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.security.SecurityDomainInterceptor.processInvocation(SecurityDomainInterceptor.java:44)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.deployment.processors.StartupAwaitInterceptor.processInvocation(StartupAwaitInterceptor.java:22)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.component.interceptors.ShutDownInterceptorFactory$1.processInvocation(ShutDownInterceptorFactory.java:64)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.component.interceptors.LoggingInterceptor.processInvocation(LoggingInterceptor.java:67)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.as.ee@26.1.2.Final//org.jboss.as.ee.component.NamespaceContextInterceptor.processInvocation(NamespaceContextInterceptor.java:50)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.ContextClassLoaderInterceptor.processInvocation(ContextClassLoaderInterceptor.java:60)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.run(InterceptorContext.java:438)
    at org.wildfly.security.elytron-base@1.19.1.Final//org.wildfly.security.manager.WildFlySecurityManager.doChecked(WildFlySecurityManager.java:633)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.AccessCheckingInterceptor.processInvocation(AccessCheckingInterceptor.java:57)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.ChainedInterceptor.processInvocation(ChainedInterceptor.java:53)
    at org.jboss.as.ee@26.1.2.Final//org.jboss.as.ee.component.ViewService$View.invoke(ViewService.java:198)
    at org.jboss.as.ee@26.1.2.Final//org.jboss.as.ee.component.ViewDescription$1.processInvocation(ViewDescription.java:191)
    at org.jboss.as.ee@26.1.2.Final//org.jboss.as.ee.component.ProxyInvocationHandler.invoke(ProxyInvocationHandler.java:81)
    at deployment.JC2EjbEAR-8.3.0-SNAPSHOT.ear.JC2EjbEAR-JC2Service.jar//com.jc2.service.rest.contactmoment.ContactMomentFacade$$$view201.create(Unknown Source)
    at deployment.JC2EjbEAR-8.3.0-SNAPSHOT.ear.JC2Web.war//com.jc2.web.bean.page.client.contact.MaintainContactMomentBean.actionSave(MaintainContactMomentBean.java:178)
    at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
    at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
    at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
    at java.base/java.lang.reflect.Method.invoke(Method.java:566)
    at org.glassfish.jakarta.el@3.0.3.jbossorg-4//com.sun.el.util.ReflectionUtil.invokeMethod(ReflectionUtil.java:153)
    at org.glassfish.jakarta.el@3.0.3.jbossorg-4//com.sun.el.parser.AstValue.invoke(AstValue.java:261)
    at org.glassfish.jakarta.el@3.0.3.jbossorg-4//com.sun.el.MethodExpressionImpl.invoke(MethodExpressionImpl.java:237)
    at org.jboss.weld.core@3.1.9.Final//org.jboss.weld.module.web.util.el.ForwardingMethodExpression.invoke(ForwardingMethodExpression.java:40)
    at org.jboss.weld.core@3.1.9.Final//org.jboss.weld.module.web.el.WeldMethodExpression.invoke(WeldMethodExpression.java:50)
    at org.jboss.weld.core@3.1.9.Final//org.jboss.weld.module.web.util.el.ForwardingMethodExpression.invoke(ForwardingMethodExpression.java:40)
    at org.jboss.weld.core@3.1.9.Final//org.jboss.weld.module.web.el.WeldMethodExpression.invoke(WeldMethodExpression.java:50)
    at com.sun.jsf-impl@2.3.17.SP01//com.sun.faces.facelets.el.TagMethodExpression.invoke(TagMethodExpression.java:65)
    at com.sun.jsf-impl@2.3.17.SP01//com.sun.faces.application.MethodBindingMethodExpressionAdapter.invoke(MethodBindingMethodExpressionAdapter.java:66)
    at com.sun.jsf-impl@2.3.17.SP01//com.sun.faces.application.ActionListenerImpl.getNavigationOutcome(ActionListenerImpl.java:82)
    at com.sun.jsf-impl@2.3.17.SP01//com.sun.faces.application.ActionListenerImpl.processAction(ActionListenerImpl.java:71)
    at javax.faces.api@3.1.0.SP01//javax.faces.component.UICommand.broadcast(UICommand.java:222)
    at javax.faces.api@3.1.0.SP01//javax.faces.component.UIViewRoot.broadcastEvents(UIViewRoot.java:847)
    at javax.faces.api@3.1.0.SP01//javax.faces.component.UIViewRoot.processApplication(UIViewRoot.java:1396)
    at com.sun.jsf-impl@2.3.17.SP01//com.sun.faces.lifecycle.InvokeApplicationPhase.execute(InvokeApplicationPhase.java:58)
    at com.sun.jsf-impl@2.3.17.SP01//com.sun.faces.lifecycle.Phase.doPhase(Phase.java:76)
    at com.sun.jsf-impl@2.3.17.SP01//com.sun.faces.lifecycle.LifecycleImpl.execute(LifecycleImpl.java:177)
    at javax.faces.api@3.1.0.SP01//javax.faces.webapp.FacesServlet.executeLifecyle(FacesServlet.java:707)
    at javax.faces.api@3.1.0.SP01//javax.faces.webapp.FacesServlet.service(FacesServlet.java:451)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.ServletHandler.handleRequest(ServletHandler.java:74)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:129)
    at io.opentracing.contrib.opentracing-jaxrs2//io.opentracing.contrib.jaxrs2.server.SpanFinishingFilter.doFilter(SpanFinishingFilter.java:52)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
    at deployment.JC2EjbEAR-8.3.0-SNAPSHOT.ear.JC2Web.war//com.jc2.web.filter.PDFRendererFilter.doFilter(PDFRendererFilter.java:86)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
    at deployment.JC2EjbEAR-8.3.0-SNAPSHOT.ear.JC2Web.war//com.jc2.web.filter.PDFRendererFilter.doFilter(PDFRendererFilter.java:86)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
    at deployment.JC2EjbEAR-8.3.0-SNAPSHOT.ear.JC2Web.war//com.jc2.web.filter.AggresiveExpiresFilter.doFilter(AggresiveExpiresFilter.java:28)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
    at deployment.JC2EjbEAR-8.3.0-SNAPSHOT.ear.JC2Web.war//com.jc2.web.filter.SameSiteCookieFilter.doFilter(SameSiteCookieFilter.java:35)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
    at deployment.JC2EjbEAR-8.3.0-SNAPSHOT.ear.JC2Web.war//com.jc2.web.filter.SameSiteCookieFilter.doFilter(SameSiteCookieFilter.java:35)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
    at deployment.JC2EjbEAR-8.3.0-SNAPSHOT.ear.JC2Web.war//com.jc2.web.filter.CharacterEncodingFilter.doFilter(CharacterEncodingFilter.java:16)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.FilterHandler.handleRequest(FilterHandler.java:84)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.security.ServletSecurityRoleHandler.handleRequest(ServletSecurityRoleHandler.java:62)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.ServletChain$1.handleRequest(ServletChain.java:68)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.ServletDispatchingHandler.handleRequest(ServletDispatchingHandler.java:36)
    at org.wildfly.security.elytron-web.undertow-server@1.10.1.Final//org.wildfly.elytron.web.undertow.server.ElytronRunAsHandler.lambda$handleRequest$1(ElytronRunAsHandler.java:68)
    at org.wildfly.security.elytron-base@1.19.1.Final//org.wildfly.security.auth.server.FlexibleIdentityAssociation.runAsFunctionEx(FlexibleIdentityAssociation.java:103)
    at org.wildfly.security.elytron-base@1.19.1.Final//org.wildfly.security.auth.server.Scoped.runAsFunctionEx(Scoped.java:161)
    at org.wildfly.security.elytron-base@1.19.1.Final//org.wildfly.security.auth.server.Scoped.runAs(Scoped.java:73)
    at org.wildfly.security.elytron-web.undertow-server@1.10.1.Final//org.wildfly.elytron.web.undertow.server.ElytronRunAsHandler.handleRequest(ElytronRunAsHandler.java:67)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.RedirectDirHandler.handleRequest(RedirectDirHandler.java:68)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.security.SSLInformationAssociationHandler.handleRequest(SSLInformationAssociationHandler.java:117)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.security.ServletAuthenticationCallHandler.handleRequest(ServletAuthenticationCallHandler.java:57)
    at io.undertow.core@2.2.19.Final//io.undertow.server.handlers.DisableCacheHandler.handleRequest(DisableCacheHandler.java:33)
    at io.undertow.core@2.2.19.Final//io.undertow.server.handlers.PredicateHandler.handleRequest(PredicateHandler.java:43)
    at io.undertow.core@2.2.19.Final//io.undertow.security.handlers.AuthenticationConstraintHandler.handleRequest(AuthenticationConstraintHandler.java:53)
    at io.undertow.core@2.2.19.Final//io.undertow.security.handlers.AbstractConfidentialityHandler.handleRequest(AbstractConfidentialityHandler.java:46)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.security.ServletConfidentialityConstraintHandler.handleRequest(ServletConfidentialityConstraintHandler.java:64)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.security.ServletSecurityConstraintHandler.handleRequest(ServletSecurityConstraintHandler.java:59)
    at io.undertow.core@2.2.19.Final//io.undertow.security.handlers.AbstractSecurityContextAssociationHandler.handleRequest(AbstractSecurityContextAssociationHandler.java:43)
    at org.wildfly.security.elytron-web.undertow-server-servlet@1.10.1.Final//org.wildfly.elytron.web.undertow.server.servlet.CleanUpHandler.handleRequest(CleanUpHandler.java:38)
    at io.undertow.core@2.2.19.Final//io.undertow.server.handlers.PredicateHandler.handleRequest(PredicateHandler.java:43)
    at org.wildfly.extension.undertow@26.1.2.Final//org.wildfly.extension.undertow.security.jacc.JACCContextIdHandler.handleRequest(JACCContextIdHandler.java:61)
    at io.undertow.core@2.2.19.Final//io.undertow.server.handlers.PredicateHandler.handleRequest(PredicateHandler.java:43)
    at org.wildfly.extension.undertow@26.1.2.Final//org.wildfly.extension.undertow.deployment.GlobalRequestControllerHandler.handleRequest(GlobalRequestControllerHandler.java:68)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.SendErrorPageHandler.handleRequest(SendErrorPageHandler.java:52)
    at io.undertow.core@2.2.19.Final//io.undertow.server.handlers.PredicateHandler.handleRequest(PredicateHandler.java:43)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.ServletInitialHandler.handleFirstRequest(ServletInitialHandler.java:275)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.ServletInitialHandler.access$100(ServletInitialHandler.java:79)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.ServletInitialHandler$2.call(ServletInitialHandler.java:134)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.ServletInitialHandler$2.call(ServletInitialHandler.java:131)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.core.ServletRequestContextThreadSetupAction$1.call(ServletRequestContextThreadSetupAction.java:48)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.core.ContextClassLoaderSetupAction$1.call(ContextClassLoaderSetupAction.java:43)
    at org.wildfly.extension.undertow@26.1.2.Final//org.wildfly.extension.undertow.deployment.UndertowDeploymentInfoService$UndertowThreadSetupAction.lambda$create$0(UndertowDeploymentInfoService.java:1544)
    at org.wildfly.extension.undertow@26.1.2.Final//org.wildfly.extension.undertow.deployment.UndertowDeploymentInfoService$UndertowThreadSetupAction.lambda$create$0(UndertowDeploymentInfoService.java:1544)
    at org.wildfly.extension.undertow@26.1.2.Final//org.wildfly.extension.undertow.deployment.UndertowDeploymentInfoService$UndertowThreadSetupAction.lambda$create$0(UndertowDeploymentInfoService.java:1544)
    at org.wildfly.extension.undertow@26.1.2.Final//org.wildfly.extension.undertow.deployment.UndertowDeploymentInfoService$UndertowThreadSetupAction.lambda$create$0(UndertowDeploymentInfoService.java:1544)
    at org.wildfly.extension.undertow@26.1.2.Final//org.wildfly.extension.undertow.deployment.UndertowDeploymentInfoService$UndertowThreadSetupAction.lambda$create$0(UndertowDeploymentInfoService.java:1544)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.ServletInitialHandler.dispatchRequest(ServletInitialHandler.java:255)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.ServletInitialHandler.access$000(ServletInitialHandler.java:79)
    at io.undertow.servlet@2.2.19.Final//io.undertow.servlet.handlers.ServletInitialHandler$1.handleRequest(ServletInitialHandler.java:100)
    at io.undertow.core@2.2.19.Final//io.undertow.server.Connectors.executeRootHandler(Connectors.java:387)
    at io.undertow.core@2.2.19.Final//io.undertow.server.HttpServerExchange$1.run(HttpServerExchange.java:852)
    at org.jboss.threads@2.4.0.Final//org.jboss.threads.ContextClassLoaderSavingRunnable.run(ContextClassLoaderSavingRunnable.java:35)
    at org.jboss.threads@2.4.0.Final//org.jboss.threads.EnhancedQueueExecutor.safeRun(EnhancedQueueExecutor.java:1990)
    at org.jboss.threads@2.4.0.Final//org.jboss.threads.EnhancedQueueExecutor$ThreadBody.doRunTask(EnhancedQueueExecutor.java:1486)
    at org.jboss.threads@2.4.0.Final//org.jboss.threads.EnhancedQueueExecutor$ThreadBody.run(EnhancedQueueExecutor.java:1377)
    at org.jboss.xnio@3.8.7.Final//org.xnio.XnioWorker$WorkerThreadFactory$1$1.run(XnioWorker.java:1282)
    at java.base/java.lang.Thread.run(Thread.java:829)
    Suppressed: javax.ejb.EJBTransactionRolledbackException: javax.transaction.RollbackException: WFLYEJB0447: Transaction ''Local transaction (delegate=TransactionImple < ac, BasicAction: 0:ffffc0a801fe:4ee973f3:6735b58f:5dd status: ActionStatus.ABORTED >, owner=Local transaction context for provider JBoss JTA transaction provider)'' was already rolled back
        at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.tx.CMTTxInterceptor.endTransaction(CMTTxInterceptor.java:117)
        at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.tx.CMTTxInterceptor.endTransaction(CMTTxInterceptor.java:126)
        at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.tx.CMTTxInterceptor.invokeInOurTx(CMTTxInterceptor.java:279)
        ... 129 more
    Caused by: javax.transaction.RollbackException: WFLYEJB0447: Transaction ''Local transaction (delegate=TransactionImple < ac, BasicAction: 0:ffffc0a801fe:4ee973f3:6735b58f:5dd status: ActionStatus.ABORTED >, owner=Local transaction context for provider JBoss JTA transaction provider)'' was already rolled back
        at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.tx.CMTTxInterceptor.endTransaction(CMTTxInterceptor.java:98)
        ... 131 more
Caused by: javax.ws.rs.ProcessingException: RESTEASY004655: Unable to invoke request: org.apache.http.client.ClientProtocolException
    at org.jboss.resteasy.resteasy-client@4.7.7.Final//org.jboss.resteasy.client.jaxrs.engines.ManualClosingApacheHttpClient43Engine.invoke(ManualClosingApacheHttpClient43Engine.java:321)
    at org.jboss.resteasy.resteasy-client@4.7.7.Final//org.jboss.resteasy.client.jaxrs.internal.ClientInvocation.invoke(ClientInvocation.java:494)
    at org.jboss.resteasy.resteasy-client@4.7.7.Final//org.jboss.resteasy.client.jaxrs.internal.ClientInvocation.invoke(ClientInvocation.java:69)
    at org.jboss.resteasy.resteasy-client@4.7.7.Final//org.jboss.resteasy.client.jaxrs.internal.ClientInvocationBuilder.post(ClientInvocationBuilder.java:226)
    at deployment.JC2EjbEAR-8.3.0-SNAPSHOT.ear//nl.lostlemon.mc.contactmoment.gen.ApiClient.invokeAPI(ApiClient.java:651)
    at deployment.JC2EjbEAR-8.3.0-SNAPSHOT.ear//nl.lostlemon.mc.contactmoment.gen.api.DefaultApi.createContactMoment(DefaultApi.java:86)
    at deployment.JC2EjbEAR-8.3.0-SNAPSHOT.ear.JC2EjbEAR-JC2Service.jar//com.jc2.service.rest.contactmoment.ContactMomentFacadeBean.create(ContactMomentFacadeBean.java:77)
    at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
    at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
    at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
    at java.base/java.lang.reflect.Method.invoke(Method.java:566)
    at org.jboss.as.ee@26.1.2.Final//org.jboss.as.ee.component.ManagedReferenceMethodInterceptor.processInvocation(ManagedReferenceMethodInterceptor.java:52)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext$Invocation.proceed(InterceptorContext.java:509)
    at org.jboss.as.weld.common@26.1.2.Final//org.jboss.as.weld.interceptors.Jsr299BindingsInterceptor.delegateInterception(Jsr299BindingsInterceptor.java:79)
    at org.jboss.as.weld.common@26.1.2.Final//org.jboss.as.weld.interceptors.Jsr299BindingsInterceptor.doMethodInterception(Jsr299BindingsInterceptor.java:89)
    at org.jboss.as.weld.common@26.1.2.Final//org.jboss.as.weld.interceptors.Jsr299BindingsInterceptor.processInvocation(Jsr299BindingsInterceptor.java:102)
    at org.jboss.as.ee@26.1.2.Final//org.jboss.as.ee.component.interceptors.UserInterceptorFactory$1.processInvocation(UserInterceptorFactory.java:63)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.component.invocationmetrics.ExecutionTimeInterceptor.processInvocation(ExecutionTimeInterceptor.java:43)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.as.jpa@26.1.2.Final//org.jboss.as.jpa.interceptor.SBInvocationInterceptor.processInvocation(SBInvocationInterceptor.java:47)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.as.ee@26.1.2.Final//org.jboss.as.ee.concurrent.ConcurrentContextInterceptor.processInvocation(ConcurrentContextInterceptor.java:45)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InitialInterceptor.processInvocation(InitialInterceptor.java:40)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.ChainedInterceptor.processInvocation(ChainedInterceptor.java:53)
    at org.jboss.as.ee@26.1.2.Final//org.jboss.as.ee.component.interceptors.ComponentDispatcherInterceptor.processInvocation(ComponentDispatcherInterceptor.java:52)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.component.pool.PooledInstanceInterceptor.processInvocation(PooledInstanceInterceptor.java:51)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.component.interceptors.AdditionalSetupInterceptor.processInvocation(AdditionalSetupInterceptor.java:56)
    at org.jboss.invocation@1.7.0.Final//org.jboss.invocation.InterceptorContext.proceed(InterceptorContext.java:422)
    at org.jboss.as.ejb3@26.1.2.Final//org.jboss.as.ejb3.tx.CMTTxInterceptor.invokeInOurTx(CMTTxInterceptor.java:254)
    ... 129 more
Caused by: org.apache.http.client.ClientProtocolException
    at org.apache.httpcomponents.core//org.apache.http.impl.client.InternalHttpClient.doExecute(InternalHttpClient.java:187)
    at org.apache.httpcomponents.core//org.apache.http.impl.client.CloseableHttpClient.execute(CloseableHttpClient.java:83)
    at org.apache.httpcomponents.core//org.apache.http.impl.client.CloseableHttpClient.execute(CloseableHttpClient.java:56)
    at org.jboss.resteasy.resteasy-client@4.7.7.Final//org.jboss.resteasy.client.jaxrs.engines.ManualClosingApacheHttpClient43Engine.invoke(ManualClosingApacheHttpClient43Engine.java:302)
    ... 163 more
Caused by: org.apache.http.ProtocolException: Target host is not specified
    at org.apache.httpcomponents.core//org.apache.http.impl.conn.DefaultRoutePlanner.determineRoute(DefaultRoutePlanner.java:71)
    at org.apache.httpcomponents.core//org.apache.http.impl.client.InternalHttpClient.determineRoute(InternalHttpClient.java:125)
    at org.apache.httpcomponents.core//org.apache.http.impl.client.InternalHttpClient.doExecute(InternalHttpClient.java:184)
    ... 166 more

', '["java", "resteasy"]', '2024-11-14 18:24:36', '2024-11-17 07:32:00', 26, 0, 0, 0, 13329213, null),
        (79188335, 'A very specific spring boot actuator / swagger integration question', 'I''m launching my springboot webapp and navigating to localhost/api/myservice/swagger-ui/index.html, but getting a 401 Unauthorized. I''ve done all the usual things from now countless answers on SO, but none seem to apply specifically to this pairing of spring and spring doc. One limitation I have is Java 1.8, else I would use newer versions of software. Handcuffs.
Short version:
spring-boot: 2.7.18
spring-doc: 1.8.0
pom.xml snippets:
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.7.18</version>
    </parent>

        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-ui</artifactId>
            <version>1.8.0</version>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-jdbc</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>


When I checked, the oldest version of springboot for springdocs was past Java 1.8.
application.yml snippets:
springdoc:
  api-docs:
    path: /api-docs/**
  swagger-ui:
    enabled = true
    path = /swagger-ui.html
    tryItOutEnabled = false
    filter = false
    syntaxHighlight.activated = true
spring:
  mvc:
    pathmatch:
      matching-strategy: ant_path_matcher
server:
  servlet:
    context-path: /api/myservice

SwaggerConfig.java snippets:
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

    @Bean
    public OpenAPI apiInfo() {
        final String securitySchemeName = "bearerAuth";
        return new OpenAPI()
                .addSecurityItem(new SecurityRequirement().addList(securitySchemeName))
                .components(new Components().addSecuritySchemes(
                        securitySchemeName,
                        new SecurityScheme()
                                .name(securitySchemeName)
                                .type(SecurityScheme.Type.HTTP)
                                .in(SecurityScheme.In.HEADER)
                                .scheme("bearer")
                                .bearerFormat("JWT")
                ))
                .info(new Info()
                        .title(title)
                        .version(version)
                        .description("")
                )
                .servers(Collections.singletonList(
                        new Server()
                                .url(contextPath)
                                .description("Default Server URL")
                ));
    }
}

SpringConfiguration.java snippets:
@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SpringConfiguration {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
// I have tried very many things here, but I don''t see how it could get much more permissive than this ;)
        http
                .csrf().disable()
                .authorizeRequests().anyRequest().permitAll();
        return http
                .build();
    }

    @Bean
    public RequestMatcher requestMatcher() {
        this.log.debug("Creating request matcher");
        List<RequestMatcher> requestMatchers = new ArrayList<>();
        requestMatchers.add(new AntPathRequestMatcher("/**"));
        return new OrRequestMatcher(requestMatchers);
    }

    @Bean
    public CustomAuthenticationFilter customAuthenticationFilter(
            RequestMatcher requestMatcher,
            AuthenticationConfiguration authenticationConfiguration)
            throws Exception {
        CustomAuthenticationFilter result = new CustomAuthenticationFilter(requestMatcher);
        result.setAuthenticationManager(authenticationConfiguration.getAuthenticationManager());
        return result;
    }

}

When I uncomment the CustomAuthenticationFilter stuff, I get the 401 Unauthorized hitting localhost/api/myservice/swagger-ui/index.html, because that class is being applied, but when I comment it out, I hit the swagger page just fine.
I''m new to this version of SpringBoot and new to Swagger 3 and new to springdocs. I have this working in other microservices that use a FilterRegistrationBean instead of something like CustomAuthenticationFilter, and I''m not sure why the same configurations don''t work in this repository. Bonus points if this can be done without disabling csrf.
When I navigate to localhost/api/myservice/swagger-ui/index.html I get a 401 Unauthorized. I expect the Swagger page to load without needing authorization.
When I comment out the CustomAuthenticationFilter bean, I get the expected result. I''m not sure why beyond being certain that the CustomAuthenticationFilter is being used to secure Swagger pages when I don''t want it to.
I have also tried
    @Bean
    public WebSecurityCustomizer webSecurityCustomizer(@Value("${server.servlet.context-path}") String contextPath) {
        return web -> web
                .ignoring()
                .antMatchers("/v3/api-docs/**", "/swagger-ui.html", "/swagger-ui/**", contextPath + "/swagger-ui/**");
    }

which issues printed warnings on the console about using authorizeHttpRequests instead. And I''ve tried that as well.
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf().disable()
                .authorizeRequests()
                //.authorizeHttpRequests()
                .antMatchers(
                        "/v2/api-docs",
                        "/v3/api-docs/**",
                        "/swagger-resources/**",
                        "/swagger-ui/**",
                        "/swagger-ui.html",
                        "/swagger-ui/index.html",
                        contextPath + "/swagger-ui/index.html",
                        "/configuration/ui",
                        "/configuration/security",
                        "/webjars/**",
                        "/api/**",
                        contextPath + "/swagger-ui/**"
                ).permitAll()
                .and().authorizeRequests().antMatchers("/api/**").authenticated();
        return http.build();
    }

', '["java", "springdoc", "springdoc-openapi-ui", "swagger-3.0", "spring-boot-security"]', '2024-11-14 18:28:07', '2024-11-14 20:42:46', 22, 1, 1, 0, 28285313, null),
        (79188355, 'Possible to set Request Headers in Selenium?', 'I''m trying to write a test against a site that authenticate''s by checking some headers.
In other frameworks it''s possible to add headers to the driver but I can''t see anything like that in Selenium.
Is there a way to add request headers to selenium webdriver? Ideally on a per-test case so the existing suite doesn''t have to use headers it doesn''t need.
', '["java", "selenium-webdriver", "selenium-chromedriver", "request-headers"]', '2024-11-14 18:31:11', '2024-11-14 23:47:28', 22, 0, 1, 0, 2239784, null),
        (79188363, 'Flink classLoader cannot be null Kryo', 'I work with Flink 1.18.1 Java 11. One of my pipelines after around 30 minutes start getting into crash loop. In the TaskManager i can see log:
Exception in thread "Thread-21" java.lang.IllegalArgumentException: classLoader cannot be null.
        at com.esotericsoftware.kryo.Kryo.setClassLoader(Kryo.java:975)
        at org.apache.flink.api.java.typeutils.runtime.kryo.KryoSerializer.checkKryoInitialized(KryoSerializer.java:553)
        at org.apache.flink.api.java.typeutils.runtime.kryo.KryoSerializer.deserialize(KryoSerializer.java:394)
        at org.apache.flink.api.common.typeutils.CompositeSerializer.deserialize(CompositeSerializer.java:156)
        at org.apache.flink.contrib.streaming.state.ttl.RocksDbTtlCompactFiltersManager$ListElementFilter.nextElementLastAccessTimestamp(RocksDbTtlCompactFiltersManager.java:205)
        at org.apache.flink.contrib.streaming.state.ttl.RocksDbTtlCompactFiltersManager$ListElementFilter.nextUnexpiredOffset(RocksDbTtlCompactFiltersManager.java:191)
#
# A fatal error has been detected by the Java Runtime Environment:
#
#  SIGSEGV (0xb) at pc=0x00007fc338f944bf, pid=1, tid=388
#
# JRE version: OpenJDK Runtime Environment Temurin-11.0.23+9 (11.0.23+9) (build 11.0.23+9)
# Java VM: OpenJDK 64-Bit Server VM Temurin-11.0.23+9 (11.0.23+9, mixed mode, sharing, tiered, compressed oops, g1 gc, linux-amd64)
# Problematic frame:
# V  [libjvm.so+0x7944bf]  Exceptions::_throw_oop(Thread*, char const*, int, oopDesc*)+0x15f
#
# Core dump will be written. Default location: /opt/flink/core.1
#
# An error report file with more information is saved as:
# /opt/flink/hs_err_pid1.log
#
# If you would like to submit a bug report, please visit:
#   https://github.com/adoptium/adoptium-support/issues
#

Can''t find a solution for this, any ideas?
', '["java", "apache-flink", "flink-streaming"]', '2024-11-14 18:32:40', '2024-11-14 18:32:40', 25, 0, 0, 0, 6823114, null),
        (79188417, 'Exception when trying to receive email containing special characters using EWS from Java app', 'We have implemented an automated processor app which is consuming and processing incomming mails from a mailbox on exchange server (ver 2016). For receiving and processing of emails we are using EWS interface and EWS Java library (ver 2.0) in our Java app (running on Java 17). Recently we run into a problem when we got received emails containing special characters such as SOH (ASCII 01), STX (ASCII 02) resulting in the following exception:
microsoft.exchange.webservices.data.core.exception.service.local.ServiceObjectPropertyException: This property was requested, but it wasn''t returned by the server.
    at microsoft.exchange.webservices.data.core.PropertyBag.getPropertyValueOrException(PropertyBag.java:346)
    at microsoft.exchange.webservices.data.core.PropertyBag.getObjectFromPropertyDefinition(PropertyBag.java:760)
    at microsoft.exchange.webservices.data.core.service.item.Item.getDateTimeReceived(Item.java:669)

When we manually replace just these special characters and resend the email to the mailbox then processing of the email works fine.
Our code looks like this:
itemPropertySet = new PropertySet(BasePropertySet.FirstClassProperties);
itemPropertySet.setRequestedBodyType(BodyType.Text);

...

Folder folder = findFolder(queueId);
ItemView view = new ItemView (MESSAGE_VIEW_SIZE);
view.setPropertySet(itemPropertySet);
view.getOrderBy().add(ItemSchema.DateTimeReceived, SortDirection.Ascending);
FindItemsResults<Item> findResults = service.findItems(folder.getId(), view);
messageIterator = findResults.getItems().iterator();

...

while (messageIterator.hasNext()) {
                Item item = messageIterator.next();
                if (item instanceof EmailMessage) {
                    EmailMessage emailMessage = (EmailMessage)item;

                    try {
                        // Load message content
                        emailMessage.load(itemPropertySet);
                        String body = emailMessage.getBody().toString();
                        final String sender = emailMessage.getSender().getAddress();
                        //Further processing of email body

                    } catch (Exception e) {
                           log.error(e.getMessage());
                    }
               }
}

Any help would be very much appreciated as we are a bit stuck on this. :-)
', '["java", "exchangewebservices"]', '2024-11-14 18:47:11', '2024-11-14 20:28:42', 29, 0, 0, 0, 923478, null),
        (79188505, 'Declaring a page object in the test class is throwing below error - Appium', 'I am getting an error when declaring a page object in the test class, as shown in the code below. When I declare the page object in the test method, it works perfectly, which I think is not right.
package test;

import org.junit.jupiter.api.DisplayName;
import org.testng.Assert;
import org.testng.annotations.Test;
import screens.SmlHomeScreen;

public class LoginTest extends BaseTest {
    SmlHomeScreen smlHomeScreen = new SmlHomeScreen();

    @Test
    @DisplayName("Should login to App successfully")
    public void loginTest() throws InterruptedException {
        loginScreen.signIn(configProperty.getUsername(), configProperty.getPassword());
        Assert.assertTrue(smlHomeScreen.getSmlScreenContent().isDisplayed());
    }
}

I am getting this error:
An unknown server-side error occurred while processing the command. Original error: ''POST /element'' cannot be proxied to UiAutomator2 server because the instrumentation process is not running (probably crashed). Check the server log and/or the logcat output for more details.

org.openqa.selenium.WebDriverException: An unknown server-side error occurred while processing the command. Original error: ''POST /element'' cannot be proxied to UiAutomator2 server because the instrumentation process is not running (probably crashed). Check the server log and/or the logcat output for more details
Build info: version: ''4.25.0'', revision: ''8a8aea2337''
System info: os.name: ''Mac OS X'', os.arch: ''aarch64'', os.version: ''14.6'', java.version: ''23''

But if I declare it in the test method like below, it worked perfectly
package test;

import org.junit.jupiter.api.DisplayName;
import org.testng.Assert;
import org.testng.annotations.Test;
import screens.SmlHomeScreen;


public class LoginTest extends BaseTest {


    @Test
    @DisplayName("Should login into App successfully")
    public void loginTest() throws InterruptedException {
        loginScreen.signIn(configProperty.getUsername(), configProperty.getPassword());

        SmlHomeScreen smlHomeScreen = new SmlHomeScreen();
        Assert.assertTrue(smlHomeScreen.getSmlScreenContent().isDisplayed());
    }
}

I also tried to declare all the pages in my BaseTest as below:
package test;

import org.junit.jupiter.api.BeforeAll;
import org.testng.annotations.*;
import screens.HomeScreen;
import screens.LoginScreen;
import screens.SmlHomeScreen;
import utils.ConfigProperty;
import utils.Driver;


public class BaseTest extends Driver {

    protected LoginScreen loginScreen;
    protected ConfigProperty configProperty
    protected HomeScreen homeScreen;
    protected SmlHomeScreen smlHomeScreen;


    @BeforeMethod
    public void preTest() {
        LoginScreen = new LoginScreen()
        homeScreen = new HomeScreen()
        smlHomeScreen = new SmlHomeScreen()
        configProperty = new ConfigurProperty().
    }

I am getting the same error as before. This is a webdriver exception, and I am finding it difficult to fix this. Please help
org.openqa.selenium.WebDriverException: An unknown server-side error occurred while processing the command. Original error: ''POST /element'' cannot be proxied to UiAutomator2 server because the instrumentation process is not running (probably crashed). Check the server log and/or the logcat output for more details
Build info: version: ''4.25.0'', revision: ''8a8aea2337''
System info: os.name: ''Mac OS X'', os.arch: ''aarch64'', os.version: ''14.6'', java.version: ''23''
Driver info: io.appium.java_client.android.AndroidDriver
Command: [084af3d7-627c-40e7-af94-c26e0b032d37, findElement {using=-android uiautomator, value=new UiSelector().text("Login").instance(1)}]

', '["java", "android", "selenium-webdriver", "appium", "appium-android"]', '2024-11-14 19:13:25', '2024-11-14 20:01:46', 29, 0, 0, 0, 7560013, null),
        (79188647, 'Cucumber Runner Class Not Picking Up Tags from Properties File', 'I am trying to execute my Cucumber runner class by accepting tags from a .properties file. However, it seems that Cucumber is not recognizing the tags, as it ends up running all my tests. Below are the Runner class and ConfigurationReader class that reads values from the .properties file. How can I pass the tags from the file so that they are executed?
Runner Class:
import org.junit.runner.RunWith;
import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import //.ConfigurationReader;

@RunWith(Cucumber.class)
@CucumberOptions(
    features = "src/test/resources/features",
    glue = "//my Stepdefenitions",
    dryRun = false
)
public class CukesRunner {
    static {
        String tags = ConfigurationReader.getTags();
        if (tags != null && !tags.isEmpty()) {
            System.setProperty("cucumber.filter.tags", tags);
        }
    }
}

ConfigurationReader Class:
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigurationReader {
    private static Properties properties = new Properties();

    static {
        loadProperties();
    }

    private static void loadProperties() {
        String configFilePath = System.getProperty("config.file", "configuration.properties");
        
        try (InputStream file = new FileInputStream(configFilePath)) {
            properties.load(file);
        } catch (IOException e) {
            System.out.println("Error occurred while reading configuration file: " + configFilePath);
            e.printStackTrace();
        }
    }

    public static String getProperty(String key) {
        return properties.getProperty(key);
    }

    public static String getTags() {
        return properties.getProperty("tags", "@test");
    }
}

', '["java", "selenium-webdriver", "automated-tests", "cucumber"]', '2024-11-14 19:56:12', '2024-11-14 19:56:12', 18, 0, 0, 0, 28297512, null),
        (79188671, 'RestEasy failed to parse eml file', 'In my java jboss project, I use resteasy api to support uploading files, it works fine until someone uploaded an .eml file and triggered NPE.
A more detailed description of the problem is here: https://issues.redhat.com/browse/RESTEASY-1255
The version of Resteasy that I''m using is 3.0.24.final.
The solution I tried:
As I navigated through the related tickets of RESTEASY-1255, I found its related ticket https://issues.redhat.com/browse/RESTEASY-754, indicating the issue is resolved in version 4.0.0.final
so I upgraded resteasy-multipart-provider to 4.0.0.final
<dependency>
      <groupId>org.jboss.resteasy</groupId>
      <artifactId>resteasy-multipart-provider</artifactId>
      <version>4.0.0.CR1</version>
      <scope>provided</scope>
</dependency>

but the problem remains.
I''m very unfamiliar with jboss or resteasy.
Could anyone point me the direction to any possible solution? A detailed instruction would be much appreciated!
Here is the snippet of my code:
Controller interface
import org.jboss.resteasy.annotations.providers.multipart.MultipartForm; 
import org.jboss.resteasy.plugins.providers.multipart.MultipartFormDataInput;     
    
    @POST     
    @GZIP     
    @Produces(MediaType.TEXT_PLAIN)     
    @Consumes(MediaType.MULTIPART_FORM_DATA)     
    @Path("/upload")     
    public Response uploadSomeDocument(@MultipartForm MultipartFormDataInput input);  

Controller interface Implementation
import org.jboss.resteasy.plugins.providers.multipart.InputPart;
import org.jboss.resteasy.plugins.providers.multipart.MultipartFormDataInput;

@Override
public Response uploadSomeDocument(MultipartFormDataInput input) {
    Map<String, List<InputPart>> formDataMap = input.getFormDataMap();
    List<InputPart> inputParts = formDataMap.get("file");
    // here the inputStream is null
    InputStream inputStream = inputPart.getBody(InputStream.class, null);
    // therefore trigger NPE in this step   
    byte[] bytes = IOUtils.toByteArray(inputStream);  
    // operation on bytes
}

pom.xml
<dependencyManagement>
    <dependencies>
      <dependency>
        <groupId>org.jboss.bom</groupId>
        <artifactId>jboss-eap-javaee7-with-tools</artifactId>
        <version>7.1.0.GA</version>
        <type>pom</type>
        <scope>import</scope>
      </dependency>

      <dependency>
        <groupId>org.jboss.spec</groupId>
        <artifactId>jboss-javaee-7.0</artifactId>
        <version>1.1.0.Final-redhat-3</version>
        <type>pom</type>
        <scope>import</scope>
      </dependency>
    </dependencies>
</dependencyManagement>

<dependencies>
    <dependency>
      <groupId>org.jboss.spec.javax.servlet</groupId>
      <artifactId>jboss-servlet-api_3.1_spec</artifactId>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>org.jboss.spec.javax.ws.rs</groupId>
      <artifactId>jboss-jaxrs-api_2.0_spec</artifactId>
      <scope>provided</scope>
    </dependency>
    
    <dependency>
      <groupId>org.jboss.spec.javax.annotation</groupId>
      <artifactId>jboss-annotations-api_1.2_spec</artifactId>
      <scope>provided</scope>
    </dependency>

    <dependency>
      <groupId>org.jboss.resteasy</groupId>
      <artifactId>resteasy-jaxrs</artifactId>
      <scope>provided</scope>
    </dependency>

    <dependency>
      <groupId>org.jboss.logging</groupId>
      <artifactId>jboss-logging</artifactId>
      <scope>provided</scope>
    </dependency>

    <dependency>
      <groupId>org.jboss.resteasy</groupId>
      <artifactId>resteasy-multipart-provider</artifactId>
      <scope>provided</scope>
    </dependency>


  </dependencies>

stack trace
Caused by: java.lang.NullPointerException
    at org.apache.commons.io.IOUtils.copyLarge(IOUtils.java:2314) [commons-io-2.6.jar:2.6]
    at org.apache.commons.io.IOUtils.copy(IOUtils.java:2270) [commons-io-2.6.jar:2.6]
    at org.apache.commons.io.IOUtils.copyLarge(IOUtils.java:2291) [commons-io-2.6.jar:2.6]
    at org.apache.commons.io.IOUtils.copy(IOUtils.java:2246) [commons-io-2.6.jar:2.6]
    at org.apache.commons.io.IOUtils.toByteArray(IOUtils.java:765) [commons-io-2.6.jar:2.6]
    at com.xxx.repository.SOUploadFileRepository.write(SOUploadFileRepository.java:64) [data-scx-2.0.188-SNAPSHOT.jar:]
    at com.xxx.so.SalesOrderServiceImpl.uploadCustomerPoDocument(SalesOrderServiceImpl.java:2179) [data-scx-2.0.188-SNAPSHOT.jar:]
    at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) [rt.jar:1.8.0_362]
    at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) [rt.jar:1.8.0_362]
    at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) [rt.jar:1.8.0_362]
    at java.lang.reflect.Method.invoke(Method.java:498) [rt.jar:1.8.0_362]
    at org.jboss.resteasy.core.MethodInjectorImpl.invoke(MethodInjectorImpl.java:140) [resteasy-jaxrs-3.0.24.Final-redhat-1.jar:3.0.24.Final-redhat-1]
    at org.jboss.resteasy.core.ResourceMethodInvoker.invokeOnTarget(ResourceMethodInvoker.java:295) [resteasy-jaxrs-3.0.24.Final-redhat-1.jar:3.0.24.Final-redhat-1]
    at org.jboss.resteasy.core.ResourceMethodInvoker.invoke(ResourceMethodInvoker.java:249) [resteasy-jaxrs-3.0.24.Final-redhat-1.jar:3.0.24.Final-redhat-1]
    at org.jboss.resteasy.core.ResourceMethodInvoker.invoke(ResourceMethodInvoker.java:236) [resteasy-jaxrs-3.0.24.Final-redhat-1.jar:3.0.24.Final-redhat-1]
    at org.jboss.resteasy.core.SynchronousDispatcher.invoke(SynchronousDispatcher.java:406) [resteasy-jaxrs-3.0.24.Final-redhat-1.jar:3.0.24.Final-redhat-1]
    ... 43 more

run environment
It''s packed as a war file and run under JBoss EAP 7.1
', '["java", "jboss7.x", "resteasy", "mime4j"]', '2024-11-14 20:04:05', '2024-11-18 09:35:55', 16, 0, 0, 0, 28073741, null),
        (79188675, 'Spring Boot Application Context Fails to Load in JUnit Test with IllegalStateException', 'I''m encountering an issue with my Spring Boot application where the application context fails to load during a JUnit test. The error message indicates an IllegalStateException. I''ve provided the details below:
PRIVATE.contextLoads » IllegalState Failed to load ApplicationContext for [WebMergedContextConfiguration@16bee5fe testClass = PRIVATE
', '["java", "database", "spring-boot", "maven", "backend"]', '2024-11-14 20:05:04', '2024-11-14 20:05:22', 28, 1, 0, 0, 25504374, null),
        (79188697, 'Jakarta Custom Validation - How to avoid tight coupling of Annotation and ConstraintValidator', 'I have a project which publishes a service contract, eg endpoints and model classes. I have created a custom Jakarta validation which checks that when a date range is provided, the end date must be later or equal to the start date. Eg:
@Constraint(validatedBy = DateRangeValidator.class)
public @interface DateRangeValid {
   ...
}

public class DateRangeValidator implements ConstraintValidator<DateRangeValid, Object> {
   ...
}

However, this seems like it creates a very tight coupling between the annotation and valid, since both reference each other.
Is there a way to decouple these 2? By, say, having only the Validator reference the annotation, and not the other way round?
When I look at the validations that come as part of Jakarta, eg @Max, I see the annotation does not reference any validator:
@Constraint(
    validatedBy = {}
)
public @interface Max {
   ...
}

But when I try the same on my custom annotation, I get the following error in my tests:
jakarta.validation.UnexpectedTypeException: HV000030: No validator could be found for constraint

Does anyone know an approach to solve this? Ideally I''d like to only publish the Annotation in my service contract, and keep the validation logic internal to my service so that it is easier to change in future if required.
', '["java", "jakarta-validation"]', '2024-11-14 20:14:52', '2024-11-14 21:11:52', 38, 0, 1, 0, 9291680, null),
        (79188812, 'How to force call non-the best match method if multiple methods matched in java', 'I knew that java will call the best match method if there are multiple methods matched. Refer to the code below, is it possible to force call non-the best match method without modifying method signature ?
public static class Example<T> {

    public static <T> Example<T> example(T data) {
        return null;
    }

    public static <T> Example<T> example(String msg) {
        return null;
    }

    public static <T> Example<T> example(String... args) {
        return null;
    }

    public static void example() {
        Example<?> msgExample = example("msg");

        // how to call `result(T data)` instead `result(String msg)` ?
        Example<String> dataExample = example("data");
        // working but required double casting
        Example<String> dataExampleByCasting = (Example<String>) ((Example<?>) example((Object) "data"));

        // how to call `result(String... args)` instead `result(String msg)` ?
        Example<?> argsExample = example("args");
        // working but required new array
        Example<?> argsExampleByNewArray = example(new String[]{"args"});
    }

}

UPDATE
I try to rephrase explain my question, and the fields in Example are omitted.
These methods have different semantics:

example(T data): data means data needs to be returned, but the values ​​of fields such as status and information are fixed, such as request succeed

example(String msg): msg means error message, and no data needs to be returned at this time, such as request failed

example(String... args): args is extended based on the above two cases for additional processing


Now, if data is of type String, example(T data) cannot be called because of the best match rule, it is similar for while the args has only one parameter.
', '["java", "overloading"]', '2024-11-14 20:50:41', '2024-11-16 17:32:26', 55, 0, 1, 0, 7772947, null),
        (79188831, 'Why doesn&#39;t the n+1 problem occur in the constructor passing entity fields?', 'I checked the behavior of SQL when we want to have values mapped immediately from an Entity to a DTO object, for example. If I gave an example in the constructor:
SELECT new Test(T) FROM Test T

I saw 2 queries in the logs.
On the other hand, if I did:
SELECT new TEST(T.name, T.city) FROM TEST T

I saw only one query in the logs.
Why?
', '["java", "sql", "mysql", "jpa"]', '2024-11-14 20:55:04', '2024-11-15 00:41:49', 46, 0, 1, 0, 15361360, null),
        (79188883, 'Spring Boot Exception Handler not detecting Exceptions inside SAMLUserDetailsServiceImpl class', 'I''m having class that implements SAMLUserDetailsService and inside it there''s some business logic of parsing user. Wherever exception is thrown inside that class I get Whitelable error page because my custom exception handler is not detecting, and thus handling, that exception.
It works in other places, on other controllers.
SAMLUserDetailsServiceImpl
@Service
@RequiredArgsConstructor
public class SAMLUserDetailsServiceImpl implements SAMLUserDetailsService {

    @Autowired
    UserDao userDao;
    private final OibService oibService;

    @Override
    public Object loadUserBySAML(SAMLCredential credential) throws UsernameNotFoundException {
    User user;
    //Do some stuff
    if(personIdentifier != null) {
      throw new IllegalArgumentException("Not legal");
    }
    return new Authentication(credential, user);
  }
}

Global exception handler
@ControllerAdvice
public class ApiExceptionHandler {

    @ExceptionHandler(value = { IllegalArgumentException.class, IllegalStateException.class, ParseException.class })
    public ResponseEntity<Object> handleBadRequestExceptions(Exception e) {
        HttpStatus httpStatus = HttpStatus.BAD_REQUEST;
        log.error("BAD_REQUEST", e);
        ApiException apiException = new ApiException(e.getMessage(), httpStatus, ZonedDateTime.now(ZoneId.of("Z")));
        return new ResponseEntity<>(apiException, httpStatus);
    }

    @ExceptionHandler(value = { Exception.class })
    public ResponseEntity<Object> handleAllOtherExceptions(Exception e) {
        HttpStatus httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
        log.error("INTERNAL_SERVER_ERROR:", e);
        ApiException apiException = new ApiException(e.getMessage(), httpStatus, ZonedDateTime.now(ZoneId.of("Z")));
        return new ResponseEntity<>(apiException, httpStatus);
    }
}

', '["java", "spring-boot", "exception", "spring-security", "userdetailsservice"]', '2024-11-14 21:07:34', '2024-11-14 21:07:34', 25, 0, 0, 0, 14572636, null),
        (79188884, 'Is Microsoft Graph sdk for java thread-safe?', 'I am using msgraph sdk to get ''User'' details in an application. Initialized the GraphServiceClient for app-only authentication as specified in the tutorial: https://learn.microsoft.com/en-us/graph/tutorials/java-app-only?tabs=aad&tutorial-step=3.
private static Properties _properties;
private static ClientSecretCredential _clientSecretCredential;
private static GraphServiceClient _appClient;

public static void initializeGraphForAppOnlyAuth(Properties properties) throws Exception {
    // Ensure properties isn''t null
    if (properties == null) {
        throw new Exception("Properties cannot be null");
    }

    _properties = properties;

    if (_clientSecretCredential == null) {
        final String clientId = _properties.getProperty("app.clientId");
        final String tenantId = _properties.getProperty("app.tenantId");
        final String clientSecret = _properties.getProperty("app.clientSecret");

        _clientSecretCredential = new ClientSecretCredentialBuilder()
            .clientId(clientId)
            .tenantId(tenantId)
            .clientSecret(clientSecret)
            .build();
    }

    if (_appClient == null) {
        _appClient = new GraphServiceClient(_clientSecretCredential,
                new String[] { "https://graph.microsoft.com/.default" });
    }
}

I want to query the ''users'' using certain filter and select criteria, e.g.
_appClient.users().get(requestConfig -> {
        requestConfig.queryParameters.filter = "displayName startsWith \\''A\\''";
        requestConfig.queryParameters.select = new String[] { "displayName", "id", "mail" };
        requestConfig.queryParameters.top = 25;
        requestConfig.queryParameters.orderby = new String[] { "displayName" };
    });

However, in my application, this particular request may happen from the context of different threads.
My queries are:

Does each thread need to instantiate GraphServiceClient separately, or, can we initialize once and share across threads?
If the instance (_appClient) can be shared, is it thread-safe to do so or do we need to synchronize access to it?

The following artifact versions are used: microsoft-graph (v 6.20.0) and azure-identity (1.14.1).
', '["java", "multithreading", "microsoft-graph-api"]', '2024-11-14 21:08:30', '2024-11-14 21:08:30', 33, 0, 0, 0, 2682200, null),
        (79188940, 'How to Design a User Registration Process Across Multiple Tables (Member and Auth) While Adhering to SOLID Principles?', 'I am currently developing a registration process using JWT for authentication. In my application, I have two tables: Member (which stores user personal information, owned items, etc.) and Auth (which stores username and password). My current structure involves:
Member: Managed by MemberController, MemberService, and MemberRepository
Auth: Managed by AuthController, AuthService, and AuthRepository
The current folder structure is as follows:
├── Member
│   ├── MemberController
│   ├── MemberService
│   └── Member
│
├── Security
│   ├── AuthController
│   ├── AuthService
│   └── Auth

Since the registration process requires creating records in both Member and Auth tables, what would be the best way to design this to adhere to SOLID principles? Are there any design patterns you recommend for handling this scenario in a clean, modular way?
This question clearly explains your context and requirements while asking for advice on both SOLID principles and design patterns to improve your registration process.
I am also considering building "RegistrationService + Controller"
@Service
public class RegistrationService {
    private final MemberService memberService;
    private final AuthService authService;

    public RegistrationService(MemberService memberService, AuthService authService) {
        this.memberService = memberService;
        this.authService = authService;
    }

    public void register(RegistrationRequest request) {
        // Auth 정보 생성
        Auth auth = new Auth(request.getUsername(), request.getPassword());
        authService.save(auth);

        // Member 정보 생성
        Member member = new Member(request.getEmail(), auth);
        memberService.save(member);
    }
}

I wanted to put the AuthService into MemberService but seems not so right
', '["java", "spring"]', '2024-11-14 21:23:28', '2024-11-14 21:53:21', 15, 0, 1, 0, 18153267, null),
        (79188963, 'Abstract class in a inheritance entity scheme (Spring boot)', 'I have a Many-to-Many relationship between the entities Booking and Resource. Equipment is a child of Resource.
My question is can I declare Resource like abstract?
If I try to insert a new booking row from a request how can be the json?
', '["java", "spring-boot", "inheritance", "polymorphism"]', '2024-11-14 21:29:51', '2024-11-14 23:22:28', 26, 0, 1, 0, 19846498, null),
        (79188968, 'How derive ed25519 public key from private key using Java', 'As indicate in title, how to derive ed25519 public key from private key (byte[]) using Java 15+ (without dependencies like BouncyCastle).
It''s easy with BouncyCastle:
byte[] rawPrivateKey = ...;
Ed25519PrivateKeyParameters privateKeyRebuild = new Ed25519PrivateKeyParameters(rawPrivateKey , 0);
Ed25519PublicKeyParameters publicKeyRebuild = privateKeyRebuild.generatePublicKey();
byte[] rawPublicKey = publicKeyRebuild.getEncoded();

openssl has EVP_PKEY_get_raw_public_key method.
Java 15 support ed25519, but I fail to understand how to use it. Since https://openjdk.org/jeps/396, the ed25519 internals are not accessible, so is there any possibility still ?
', '["java", "ed25519"]', '2024-11-14 21:30:33', '2024-11-15 01:48:40', 70, 1, 1, 0, 1587934, 79189352),
        (79188999, 'Is it possibile to make a &quot;baby&quot; version of java (for students)?', 'I would like to create a custom subset (library?) of the java language and libraries so that my students are restricted to using this custom subset in their assignments.  I know that Dr. Java (a long time ago) accomplished something like this, but that was part of an IDE, whereas I''m hoping I could, say, have a student load the subset in Eclipse (definitely) or other IDEs (possibly) in such a way that using any other parts of Java would require an import.  Is this possible?
', '["java", "eclipse"]', '2024-11-14 21:38:38', '2024-11-15 17:49:23', 80, 1, 1, 0, 11180548, null),
        (79189148, 'HTML to PDF using flying Saucer Caron symbol not appearing', 'i am trying to convert an HTML file into a pdf. my HTML file has special chars like č ž (caron symbols).
the pdf is generated successfully however it seems that only the char ''c'' with the caron symbol is not appearing in the PDF.
if i open the html i can see the text properly.
i am using spring boot to test it, but this can be executed the same way with a simple main in java
here is my simple code
 @GetMapping("/pdf")
    public ResponseEntity<String> generatePdf(@RequestParam("filePath") String filePath) throws IOException, DocumentException {
        File htmlFile = new File(filePath);
        String htmlContent = new String(Files.readAllBytes(htmlFile.toPath()));
        ITextRenderer renderer = new ITextRenderer();

        // Path to a font that supports Central European characters and Unicode
        String fontPath = "c:/temp/poc-pdf/src/main/resources/templates/DejaVuSans.ttf";

        // Adding the font with Unicode encoding
        renderer.getFontResolver().addFont(fontPath, com.lowagie.text.pdf.BaseFont.IDENTITY_H, true);

        // Set the HTML content
        renderer.setDocumentFromString(htmlContent);
        renderer.layout();

        File file = new File("c:/temp/poc-pdf/src/main/resources/templates/pdf.pdf");
        try (OutputStream outputStream = new FileOutputStream(file)) {
            renderer.createPDF(outputStream);
        }

        return ResponseEntity.ok();
    }

HTML code:
<!DOCTYPE html>
<html>
<body>
<div>
    <p>
        čččččLorem ipsum dolor šit amet, consečtetur adipisčing elit. Vestibulum acčumsan metuš pharetra urna efficitur, ac congue justo commodo. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed et faucibus lectus. Suspendisse euismod tincidunt pretium. Aliquam porttitor ornare magna. Maecenas eget cursus arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Praesent sodales commodo varius. Maecenas pellentesque velit vitae orci eleifend egestas. Aenean aliquet elit lorem, non maximus sapien efficitur a.
    </p>

</div>
</body>
</html>

i tried different fonts all of them give the same result of the missing symbol.
', '["java", "html-to-pdf", "flying-saucer"]', '2024-11-14 22:19:56', '2024-11-15 19:20:14', 45, 0, 2, 0, 20038953, null),
        (79189182, 'containsInAnyOrder hamcrest matcher with custom comparator', 'I have a DTO class
class MyDto {
   private String f1;
   private String f2; 
   private String f3;
   // constructor
   // get set equals/hashCode
}

It has equal/hascode pair which takes into account all 3 fields.
Please take a look on test
...
var actualList = service.getActualList(...)
assertThat(actualList, containsInAnyOrder(new MyDto("a1","","c1"), new MyDto("a2","","c2")) )
...

It fails because f2 is generated on database side(so I can''t predict value for that field).
I want to pass custom comparator to make test specific comparison. Is it possible to achieve it in Hamcrest ?
P.S. I don''t want to rewrite equals/hashcode beause it will not be correct from my business logic standpoint
', '["java", "list", "comparator", "hamcrest"]', '2024-11-14 22:31:08', '2024-11-14 23:45:17', 34, 0, 2, 0, 2674303, 79189491),
        (79189194, 'maven-javadoc-plugin does not work correctly in conjunction with hibernate-jpa-modelgen', 'I am faced with the problem that I am getting an error:

Exit code: 1
C:\\Users*\\Desktop***\\target\\delombok\\ru**\\service\\impl*.java:15: error: cannot find symbol
import ru...entity.Balance_;
^
symbol:   class Balance_
location: package ru...entity
1 error
Command line was: cmd.exe /X /C ""C:\\Program Files\\Java\\jdk-17\\bin\\javadoc.exe" @options @argfile"
Refer to the generated Javadoc files in ''C:\\Users*\\Desktop*\\repositories*\\target\\apidocs'' dir.

and here is a description of how to reproduce this problem:

Adding codegen dependencies

<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.32</version>
    <optional>true</optional>
</dependency>
<dependency>
    <groupId>org.mapstruct</groupId>
    <artifactId>mapstruct</artifactId>
    <version>1.5.5.Final</version>
</dependency>
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok-mapstruct-binding</artifactId>
    <version>0.2.0</version>
    <scope>provided</scope>
</dependency>
<dependency>
    <groupId>org.hibernate</groupId>
    <artifactId>hibernate-jpamodelgen</artifactId>
    <version>6.4.4.Final</version>
</dependency>


Adding the maven-javadoc-plugin and maven-compiler-plugin plugins (to add annotationProcessorPaths to it)

<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-javadoc-plugin</artifactId>
    <executions>
        <execution>
            <id>attach-javadocs</id>
            <goals>
                <goal>jar</goal>
            </goals>
        </execution>
    </executions>
</plugin>
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <configuration>
        <annotationProcessorPaths>
            <path>
                <groupId>org.hibernate</groupId>
                <artifactId>hibernate-jpamodelgen</artifactId>
                <version>6.4.4.Final</version>
            </path>
            <path>
                <groupId>org.projectlombok</groupId>
                <artifactId>lombok</artifactId>
                <version>1.18.32</version>
            </path>
            <path>
                <groupId>org.mapstruct</groupId>
                <artifactId>mapstruct-processor</artifactId>
                <version>1.5.5.Final</version>
            </path>
            <path>
                <groupId>org.projectlombok</groupId>
                <artifactId>lombok-mapstruct-binding</artifactId>
                <version>0.2.0</version>
            </path>
        </annotationProcessorPaths>
        <compilerArgs>
            <compilerArg>
                -Amapstruct.defaultComponentModel=spring
            </compilerArg>
        </compilerArgs>
    </configuration>
</plugin>


Done. Next, we use these models anywhere in the code. For example, just output a static model field to the log log.info(String.valueOf(Balance_.id)); and when trying to make mvn clean package, an error will be received. What am I doing wrong?

I''ve tried literally all the tips on the Internet and still can''t figure out how to tie it all together...
', '["java", "spring", "hibernate", "maven", "spring-data-jpa"]', '2024-11-14 22:34:06', '2024-11-14 22:34:06', 17, 0, 0, 0, 27252374, null),
        (79189220, 'Swapping Nodes in Pairs in java', 'I am solving this question on leetcode and i have been having issues: here''s my code:
Definition for singly-linked list:
class ListNode {
    int val;
    ListNode next;
    ListNode() {}
    ListNode(int val) { this.val = val; }
    ListNode(int val, ListNode next) { this.val = val; this.next = next; }  
}
 
class Solution {
    public ListNode swapPairs(ListNode head) {
        if(head == null || head.next == null) {
            return head;
        }
        ListNode temp = new ListNode(0);
        temp.next = head;
        ListNode prev = temp;

        while(head != null && head.next != null) {
            ListNode firstNode = head;
            ListNode secondNode = head.next;

            prev.next = secondNode;
            firstNode.next = secondNode.next;
            secondNode.next = firstNode;

            prev = firstNode;
            head = firstNode.next;
        }
        return temp.next;
    }
}

It shows an error constantly saying:

java.lang.NoSuchMethodError: ''ListNode ListNode.deserialize(java.lang.String)''
at Deserializer.toListNode(Unknown Source)
at line 82, Driver.main

I thought it was because i defined the main function too. But Nope. Help me understand this, how can i solve this issue.
expecting an output for the linked list: 1->2->3->4 as 2->1->4->3
', '["java", "swap"]', '2024-11-14 22:39:25', '2024-11-15 03:05:54', 42, 0, 2, 0, 24031888, null),
        (79189348, 'Springdoc with Boot 3, no explicit OpenAPI bean declaration', 'I have trouble creating Swagger/Open API endpoints for my app. There was a previous app where such an endpoint was created automatically. I want to avoid explicitly declaring an OpenAPI bean. My understanding was I only needed a springdic-openapi-ui dependency and a property for the swagger UI endpoint in case I want to override it (it defaults to /swagger-ui.html). However, in my recent app /swagger-ui.html that is not the case.
In the MRE below, GET /api/hello works as expected. GET /swagger-ui.html returns 404 which suggests the endpoint wasn''t created by Swagger for some reason.
May be version compatibility issues: I now use Boot 3, the earlier app I mentioned used Boot 2.
Here''s the MRE:
package com.example.openapi_demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class OpenapiDemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(OpenapiDemoApplication.class, args);
    }

}

server.port=8080

<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.3.5</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.example</groupId>
    <artifactId>openapi-demo</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>openapi-demo</name>
    <properties>
        <java.version>17</java.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.springdoc</groupId>
            <artifactId>springdoc-openapi-ui</artifactId>
            <version>1.8.0</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

</project>

package com.example.openapi_demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class DemoController {
    @GetMapping("/hello")
    public String getHello() {
        return "hello";
    }
}

', '["java", "spring", "spring-boot", "openapi", "springdoc-openapi-ui"]', '2024-11-14 23:04:10', '2024-11-14 23:11:30', 20, 0, 1, 0, 27261123, 79189374),
        (79189382, 'How to fix classpath not found issue for frodo-plugin in android java', 'Getting following error in Android Studio Logcat.
A problem occurred configuring root project ''MyTestProject''.

Could not resolve all files for configuration '':classpath''.
Could not find com.fernandocejas.frodo:frodo-plugin:0.8.3.
Searched in the following locations:
Searched in the following locations:
- https://dl.google.com/dl/android/maven2/com/fernandocejas/frodo/frodo-plugin/0.8.3/frodo-plugin-0.8.3.pom
- https://repo.maven.apache.org/maven2/com/fernandocejas/frodo/frodo-plugin/0.8.3/frodo-plugin-0.8.3.pom
- https://jcenter.bintray.com/com/fernandocejas/frodo/frodo-plugin/0.8.3/frodo-plugin-0.8.3.pom
- https://maven.google.com/com/fernandocejas/frodo/frodo-plugin/0.8.3/frodo-plugin-0.8.3.pom
- https://dl.google.com/com/fernandocejas/frodo/frodo-plugin/0.8.3/frodo-plugin-0.8.3.pom

', '["java", "android", "observable", "rx-java"]', '2024-11-14 23:13:55', '2024-11-14 23:13:55', 16, 0, 0, 0, 3686398, null),
        (79189470, 'Is concatenating user-controlled input to a JNDI name unsafe?', 'Let''s say we have some code that wants to look up DNS information about a domain. The domain is controlled by a (possibly malicious) user:
String payload = "gmail.com"; // This string is user-controlled
var env = new HashTable<String, String>();
env.put("java.naming.factory.initial", "com.sun.jndi.dns.DnsContextFactory");
// some more env.put probably
var dirContext = new InitialDirContext(env);
var attributes = dirContext.getAttributes("dns:/" + payload);
// Do something with attributes

Is this unsafe? My gut tells me that JDNI is far too powerful to enter user-controlled data without any escaping (SQL injections and Log4Shell come to mind).
I couldn''t find any information on possible vulnerabilities; looking through the code for the DnsContextFactory and DnsContext also makes it look like the user-controlled part is sent directly to the DNS resolver. Since the user technically can control a server that will respond to the DNS query (by hosting the nameserver), my initial thought was that someone could smuggle out information, like ''$superSecretEnvVar.evil-domain.com''. But I couldn''t find any information about additional processing of the string.
Is there anything unsafe about "trusting" the user input using JNDI?
', '["java", "jndi"]', '2024-11-14 23:39:18', '2024-11-14 23:39:18', 37, 2, 0, 0, 1582846, null),
        (79189560, 'How to deserialize Java object when private field type has changed?', 'I have a Java class with fields of different types (serialVersionUID is present among them). One of the fields is of type Integer and it always holds value 0 or 1. When previous version of my app was launched, object of this class was serialized and is stored in DB as text.
Now I have changed my code and this Integer field is of type Boolean. I would like to deserialize "old" object from DB and map 0/1 values to false/true accordingly.
How to achieve that?
I tried to create custom implementation of readObject() method in my class but without success.
What is important is that I need to have the possibility to deserialize both versions of my object - the old one with Integer field and the new one with Boolean field because I do not know which version I would need to restore from DB and deserialize.
', '["java", "serializable"]', '2024-11-15 00:04:00', '2024-11-15 00:10:11', 32, 0, 1, 0, 14786038, null),
        (79189582, 'Running different Junit5 Cucumber tests-suites with duplicate step definitions', 'I have two domain specific junit5 platform cucumber test suites.
A:
@Suite
@IncludeEngines("cucumber")
@SelectPackages("de.bla.blubb1")
@SelectClasspathResource("de/bla/blubb1")
@ConfigurationParameter(key = GLUE_PROPERTY_NAME, value = "de.bla.blubb1")
@ConfigurationParameter(key = PLUGIN_PUBLISH_QUIET_PROPERTY_NAME, value = "true")
@ConfigurationParameter(key = PLUGIN_PROPERTY_NAME, value = "pretty,json:target/blubb1cucumber.json")
public class RunBlubb1CucumberTest
{
    // nichts zu tun
}

and B:
@Suite
@IncludeEngines("cucumber")
@SelectPackages("de.bla.blubb2")
@SelectClasspathResource("de/bla/blubb2")
@ConfigurationParameter(key = GLUE_PROPERTY_NAME, value = "de.bla.blubb2")
@ConfigurationParameter(key = PLUGIN_PUBLISH_QUIET_PROPERTY_NAME, value = "true")
@ConfigurationParameter(key = PLUGIN_PROPERTY_NAME, value = "pretty,json:target/blubb2cucumber.json")
public class RunBlubb2CucumberTest
{
    // nichts zu tun
}

The stepdefiniton classes are in the same package as each of the suite-classes.
In both stepdefintions classes are some duplicate step definitions (just the method body is different) and used in the feature files.
    @Gegebensei("Example")
    public void gegebenSeiExample(Map<String, Map<String, String>> map)
    {
        for (Entry<String, Map<String, String>> e : map.entrySet())
        {
            blabla.put(e.getKey(), new BlaMock(e.getValue()));
        }
    }

If i run both in intellij idea by selecting just both suite classes, all tests run succesful. If i run all tests i get duplicate step execptions. (also in eclipse)
DuplicateStepDefinitionException


io.cucumber.core.runner.DuplicateStepDefinitionException: Duplicate step definitions in de.bla.blubb1.StepDefsEingangsparameter.erstelle() and de.bla.blubb2.StepDefsEingangsparameter.erstelle()

    at io.cucumber.core.runner.CachingGlue.lambda$prepareGlue$3(CachingGlue.java:278)
    at java.base/java.util.ArrayList.forEach(ArrayList.java:1511)
    at io.cucumber.core.runner.CachingGlue.prepareGlue(CachingGlue.java:272)
    at io.cucumber.core.runner.Runner.runPickle(Runner.java:72)
    at io.cucumber.junit.platform.engine.CucumberEngineExecutionContext.lambda$runTestCase$4(CucumberEngineExecutionContext.java:112)
    at io.cucumber.core.runtime.CucumberExecutionContext.lambda$runTestCase$5(CucumberExecutionContext.java:136)
    at io.cucumber.core.runtime.RethrowingThrowableCollector.executeAndThrow(RethrowingThrowableCollector.java:23)
    at io.cucumber.core.runtime.CucumberExecutionContext.runTestCase(CucumberExecutionContext.java:136)
    at io.cucumber.junit.platform.engine.CucumberEngineExecutionContext.runTestCase(CucumberEngineExecutionContext.java:109)
    at io.cucumber.junit.platform.engine.NodeDescriptor$PickleDescriptor.execute(NodeDescriptor.java:168)
    at io.cucumber.junit.platform.engine.NodeDescriptor$PickleDescriptor.execute(NodeDescriptor.java:90)
    at java.base/java.util.ArrayList.forEach(ArrayList.java:1511)
    at java.base/java.util.ArrayList.forEach(ArrayList.java:1511)

I already tried a lot with forking on a class basis (in the run configuration) but this slows the other tests way too much down and other stuff.
The step definitions should stay as they are (requirement). I know i could just rename them.
Is there a way to run those two suites "separately"?
(without to change maven config and run config)
I only want those two cucumber suite-classes to run separately (in diffrent threads? jvms?), preferably defined with an annotation or configuration property somewhere.
', '["java", "unit-testing", "cucumber", "junit5", "cucumber-junit"]', '2024-11-15 00:09:22', '2024-11-18 16:58:20', 31, 0, 1, 0, 1979735, null),
        (79189621, 'How to resolve IBM MQ call failed with compcode &#39;2&#39; (&#39;MQCC_FAILED&#39;) reason &#39;2035&#39; (&#39;MQRC_NOT_AUTHORIZED&#39;)', 'I have a Spring project where I need to connect to IBM MQ to send and receive messages from but I''m getting the below exception:-

IBM MQ call failed with compcode ''2'' (''MQCC_FAILED'') reason ''2035''
(''MQRC_NOT_AUTHORIZED''). JMSWMQ2013: The security authentication was
not valid that was supplied for queue manager ''<queuemanager name''
with connection mode ''Client'' and host name ''()''.

My Config class 
@Bean
public JmsTemplate jmsTemplate() throws JMSException {
    MQQueueConnectionFactory mqQueueConnectionFactory = mqQueueConnectionFactory();
    UserCredentialsConnectionFactoryAdapter userCredentialsConnectionFactoryAdapter =
            getUserCredentialsConnectionFactoryAdapter(mqQueueConnectionFactory);
    JmsTemplate jmsTemplate = new JmsTemplate(userCredentialsConnectionFactoryAdapter);
    jmsTemplate.setReceiveTimeout(Long.parseLong(receiveTimeout));
    return jmsTemplate;
}

@Bean
public MQQueueConnectionFactory mqQueueConnectionFactory() throws JMSException {
    MQQueueConnectionFactory mqQueueConnectionFactory = new MQQueueConnectionFactory();
    mqQueueConnectionFactory.setHostName(hostname);
    mqQueueConnectionFactory.setTransportType(WMQConstants.WMQ_CM_CLIENT);
    mqQueueConnectionFactory.setUserAuthenticationMQCSP(Boolean.parseBoolean(userMQCSPAuthValue));
    mqQueueConnectionFactory.setChannel(channel);
    mqQueueConnectionFactory.setPort(port);
    mqQueueConnectionFactory.setQueueManager(queueManager);
    mqQueueConnectionFactory.setClientReconnectOptions(WMQConstants.WMQ_CLIENT_RECONNECT);
    mqQueueConnectionFactory.setClientReconnectTimeout(Integer.parseInt(reconnectTimeout));
    return mqQueueConnectionFactory;
}

@Bean
public UserCredentialsConnectionFactoryAdapter getUserCredentialsConnectionFactoryAdapter(
        MQQueueConnectionFactory mqQueueConnectionFactory) {
    UserCredentialsConnectionFactoryAdapter userCredentialsConnectionFactoryAdapter =
            new UserCredentialsConnectionFactoryAdapter();
    userCredentialsConnectionFactoryAdapter.setUsername(username);
    userCredentialsConnectionFactoryAdapter.setPassword(password);
    userCredentialsConnectionFactoryAdapter.setTargetConnectionFactory(mqQueueConnectionFactory);
    return userCredentialsConnectionFactoryAdapter;
}

Usage 
TextMessage message = (TextMessage) jmsTemplate.sendAndReceive(destinationMq, session -> {
                TextMessage textMessage = session.createTextMessage(request);
                textMessage.setJMSCorrelationID(correlationId);
                textMessage.setJMSReplyTo(getMQ(replyToQueue));
                return textMessage;
            });

Server Logs 

AMQ9557E: Queue Manager User ID initialization failed for ''my system
user id''. EXPLANATION: The call to initialize the User ID ''my system
user id'' failed with CompCode 2 and Reason 2035. If an MQCSP block
was used, the User ID in the MQCSP block was ''username from property''. If a userID
flow was used, the User ID in the UID header was ''my system user id''
and any CHLAUTH rules applied prior to user adoption were evaluated
case-sensitively against this value. ACTION: Correct the error and try
again.

Facts 
Username and password are correct other applications use the same credentials.
Solution Tried and Worked 
I was able to resolve the issue by using the below two methods:-

Setting the setUserAuthenticationMQCSP value to false

Setting System.property("user.name", "user name from property") at startup


Questions 
The above two solutions seem hacky and don''t actually solve the actual issue.

Why the above two solutions worked?

Why my system user id is being used to authenticate the connection to IBM MQ? How to ensure that connection is authenticated only using the passed credentials?


', '["java", "spring", "jms", "ibm-mq", "mq"]', '2024-11-15 00:19:30', '2024-11-16 07:47:15', 55, 1, 1, 0, 8694640, null),
        (79189673, 'MapStruct&#39;s generated mapper doesn&#39;t map any properties', 'My MapStruct mapper doesn''t work. For some reason, getters/setters are not included in the mapper method bodies (the mapper implementation is generated). It simply calls the no-args and returns the result.
May have to do with Mapstruct for some reason not seeing the generated getters/setters – even though the binding dependency is in place.
I need my mappers to be @Components in production, so I set componentModel to spring.
Here''s an MRE (and a failing test)
package com.example.demo.data;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Cat {
    private String name;
}

package com.example.demo.data;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CatDto {
    private String name;
}

package com.example.demo.mapper;

import com.example.demo.data.Cat;
import com.example.demo.data.CatDto;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface CatMapper {
    Cat toCat(CatDto cat);
}

<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.3.5</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.example</groupId>
    <artifactId>demo</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>demo</name>
    <description>Demo project for MapStruct</description>
    <properties>
        <java.version>17</java.version>
        <mapstruct.version>1.6.3</mapstruct.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter</artifactId>
        </dependency>

        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>


        <dependency>
            <groupId>org.mapstruct</groupId>
            <artifactId>mapstruct</artifactId>
            <version>${mapstruct.version}</version>

        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok-mapstruct-binding</artifactId>
            <version>0.2.0</version>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <annotationProcessorPaths>
                        <path>
                            <groupId>org.mapstruct</groupId>
                            <artifactId>mapstruct-processor</artifactId>
                            <version>${mapstruct.version}</version>
                        </path>
                        <path>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                            <version>${lombok.version}</version>
                        </path>
                    </annotationProcessorPaths>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

</project>

package com.example.demo;

import com.example.demo.data.Cat;
import com.example.demo.data.CatDto;
import com.example.demo.mapper.CatMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
class DemoApplicationTests {
    @Autowired
    private CatMapper catMapper;
    @Test
    void contextLoads() {
        CatDto catDto = new CatDto();
        catDto.setName("Kitty");
        Cat cat = catMapper.toCat(catDto);
        assertEquals(catDto.getName(), cat.getName()); // fails: expected "Kitty", actual null
    }
}

MapStruct''s implementation in full:
package com.example.demo.mapper;

import com.example.demo.data.Cat;
import com.example.demo.data.CatDto;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2024-11-14T19:21:15+0300",
    comments = "version: 1.6.3, compiler: javac, environment: Java 17.0.13 (Amazon.com Inc.)"
)
@Component
public class CatMapperImpl implements CatMapper {

    @Override
    public Cat toCat(CatDto cat) {
        if ( cat == null ) {
            return null;
        }

        Cat cat1 = new Cat();

        return cat1;
    }

    @Override
    public CatDto toDto(Cat cat) {
        if ( cat == null ) {
            return null;
        }

        CatDto catDto = new CatDto();

        return catDto;
    }
}

IntelliJ IDEA Community 2024.2.4. Here are my annotation processor settings (I didn''t manually configure them):

It is very likely to be an IntelliJ issue. I compiled it with Maven (first following talex''s advice in the comments, it''s indeed important), and the generated implementation was generated alright.
It would be hillarious if it turned out to have to do with "p" ("projectlombok") coming after "m" ("mapstruct") in the English alphabet. I guess the annotation processors are applied in the classpath encounter order by default which is, in turn, natural.
This question is different: I have no compilation error. The generated code is wrong.
', '["java", "intellij-idea", "mapstruct"]', '2024-11-15 00:34:33', '2024-11-15 16:36:17', 30, 1, 0, 0, 27261123, null),
        (79189706, 'Host name for LocalStack Redshift for Amazon Redshift JDBC driver', 'I have setup LocalStack in my windows machine and started with redshift and few other services.
Then I created a cluster and a DB.
>awslocal redshift describe-clusters --cluster-identifier my-cluster
{
    "Clusters": [
        {
            "ClusterIdentifier": "my-cluster",
            "NodeType": "n1",
            "ClusterStatus": "available",
            "MasterUsername": "admin",
            "DBName": "my-db",
            "Endpoint": {
                "Address": "my-cluster.cg034hpkmmjt.us-east-1.redshift.amazonaws.com",
                "Port": 5439
            },
            ...
        }
    ]
}

It''s showing my-cluster.cg034hpkmmjt.us-east-1.redshift.amazonaws.com as the address,
So including that, I have tried following URLs but not success so far.
 1. "jdbc:redshift://localhost:4566/my-db"
 2. "jdbc:redshift://localhost:5439/my-db"
 3. "jdbc:redshift://my-cluster.cg034hpkmmjt.us-east-1.redshift.amazonaws.com:5439/my-db"

I also tried all of these URLs in SQL client tools as well (DBeaver & SQL Workbench/J ) but couldn''t connect to the DB.
But I know it''s working with python clients like
AWS.Redshift in aws-sdk and boto3.client with localhost url and localstack running port.
Is there any other URL format or Port that that need to be used? or local stack is simply not supporting JDBC connections?
', '["java", "jdbc", "amazon-redshift", "localstack"]', '2024-11-15 00:45:24', '2024-11-15 00:53:35', 17, 0, 0, 0, 468639, null),
        (79189746, 'Java library to read/write csv files from/into beans?', 'I need a Java library that allows reading/writing a CSV file using a list of Beans. If the file doesn’t exist during reading or writing, it should simply create a new file with the header based on the Bean, maintaining the order in which the attributes were declared in the class. I don''t want to hard-code the header, as this would create coupling between classes. I want something that can automatically recognize the Bean attributes and write them in the correct order. I tried using OpenCSV, but I believe it doesn’t meet my requirements, or I may not have interpreted its features well enough to achieve this.
', '["java", "csv", "file", "javabeans", "opencsv"]', '2024-11-15 00:58:26', '2024-11-15 00:58:26', 29, -2, 0, 0, 19259068, null),
        (79189747, 'Android Studio Ladybug compatibility with AGP 8.7.2', 'I just downloaded the latest version of Android Studio Ladybug.  Looks like this version comes bundled w/ Java 21.  When I open my project the AGP upgrade assistant wants me to upgrade to AGP 8.7.2.  When I try to upgrade with the assitant I get the following error:
No locally installed toolchains match and toolchain download repositories have not been configured.

Current compiler settings

Looking at the compatibility matrix possible that AGP 8.7.x is not compatible w/ Java 21?  If that is really the case and Android Studio Ladybug comes bundled with Java 21 AND, I am running Java 21, why in the world would the AGP assistant want me to upgrade to 8.7.2.
Am I missing something here?  Anyone else running AGP 8.7.2 with Java 21 in ladybug?
', '["java", "android", "android-studio", "gradle", "android-gradle-plugin"]', '2024-11-15 00:58:36', '2024-11-15 01:55:48', 71, 0, 1, 0, 1281501, null),
        (79189862, 'java.lang.NullPointerException: Cannot invoke &quot;javax.persistence.EntityManager.createQuery(String)&quot; because &quot;this.entity&quot; is null?', '[Unable to correctly inject/initialize EntityManger in spring]
I want to GET some records from database after hitting get from frontend in spring but because of entity being null unable to do so.
Error in terminal:
java.lang.NullPointerException: Cannot invoke "javax.persistence.EntityManager.createQuery(String)" because "this.entity" is null
        at com.rupeedock.pet.dao.DaoIMPL.newExpense(DaoIMPL.java:17) ~[main/:na]
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:na]
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77) ~[na:na] 
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~


Below is the DaoIMPL.java file Code.
package com.rupeedock.pet.dao;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import com.rupeedock.pet.entity.*;
import com.rupeedock.pet.model.*;

@Repository
public class DaoIMPL implements RupeedockDAO{
@PersistenceContext
 private EntityManager entity;

@Override
public ExpenseModel newExpense(ExpenseModel expenseModel)
{
    int id = 1;
    ExpenseEntity present = (ExpenseEntity) entity.createQuery("select c from ExpenseEntity c where c.id = :id")
    .setParameter("id", id)
    .getSingleResult();
ExpenseModel model = new ExpenseModel();
model.setId(present.getId());
model.setDescription(present.getDescription());
model.setAmount(present.getAmount());
System.out.println("Retrieved Description: " + model.getDescription());
return model;
    
}
}


Dependencies added in build.gradle file
dependencies {
    implementation ''org.springframework.boot:spring-boot-starter-data-jpa''
    implementation ''org.springframework.boot:spring-boot-starter''
    implementation ''org.springframework.boot:spring-boot-starter-web''
    implementation ''mysql:mysql-connector-java:8.0.32''
    implementation ''org.springframework.session:spring-session-core'' // Optional, if session handling needed
    
    developmentOnly ''org.springframework.boot:spring-boot-devtools''
    testImplementation ''org.springframework.boot:spring-boot-starter-test''
    testRuntimeOnly ''org.junit.platform:junit-platform-launcher''
    
    //implementation ''javax.transaction:javax.transaction-api:1.3'' // Optional, needed for transactions
}

ExpenseEntity.java
package com.rupeedock.pet.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "expenses")
public class ExpenseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String description;
    private String amount;

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getAmount() { return amount; }
    public void setAmount(String amount) { this.amount = amount; }
}

GitHub Repo Link of full project
I want to GET some records from database after hitting get from frontend in spring but because of entity being null unable to do so. If Entity gets instantiated correctly I should  be able to see the SOP prints in terminal.
', '["java", "spring", "spring-boot", "spring-data-jpa", "hibernate-entitymanager"]', '2024-11-15 01:34:58', '2024-11-15 01:43:43', 66, 1, 0, 0, 12942455, null),
        (79190069, 'Transactions on IBM I (AS400) and Spring Boot 3', 'The transaction rollback is not working for me, I am working on an IBM I (AS400), and among the tests I am doing, the rollback has not worked for me, I am generating an intentional error by duplicating the ids in this way:
{
"id": 24,
"name": "Test Activity",
"module": {
"id": 2
},
"submodule": {
"moduleId": 2,
"submoduleId": 2
},
"user": {
"id": "luipena"
},
"admin": {
"id": "luipena"
},
"descrip": "First test having text in all possible fields",
"area": ​​{
"id": 1
},
"main_request_type": {
"id": 1
},
"main_consecutive": 5487965,
"start_date": "2024-10-10",
"finish_date": "2024-10-10",
"status": {
"id": 1
},
"current": "Y",
"subactivities": [
{
"id": 7,
"subactivity": {
"id": 1
},
"user": {
"id": "luipena"
},
"start_date": "2024-10-10",
"finish_date": "2024-10-10",
"progress": 0
}
]
}

This is my main Entity:
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = GlobalVariables.activityTable, schema = GlobalVariables.schemaMain)
public class Activity {

    @Id
    @Column(name = "ID")
    private Integer id;

    @Column(name = "TITLE")
    private String name;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.DETACH, CascadeType.REFRESH })
    @JoinColumn(name = "ID_MOD", insertable = false, updatable = false)
    private Module module;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.DETACH, CascadeType.REFRESH })
    @JoinColumns({
            @JoinColumn(name = "ID_MOD"),
            @JoinColumn(name = "ID_SUBMOD")
    })
    private Submodule submodule;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.DETACH, CascadeType.REFRESH })
    @JoinColumn(name = "ID_USER")
    private User user;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.DETACH, CascadeType.REFRESH })
    @JoinColumn(name = "ID_ADMIN")
    private User admin;

    @Column(name = "DESCRIP")
    private String descrip;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.DETACH, CascadeType.REFRESH })
    @JoinColumn(name = "ID_AREA")
    private Area area;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.DETACH, CascadeType.REFRESH })
    @JoinColumn(name = "FTYPE")
    private RequestType main_request_type;

    @Column(name = "F_CONS", columnDefinition = "bigint")
    private Long main_consecutive;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.DETACH, CascadeType.REFRESH })
    @JoinColumn(name = "STYPE")
    private RequestType secondary_request_type;

    @Column(name = "S_CONS", columnDefinition = "bigint")
    private Long secondary_consecutive;

    @Column(name = "START")
    private LocalDate start_date;

    @Column(name = "FINISH")
    private LocalDate finish_date;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.DETACH, CascadeType.REFRESH })
    @JoinColumn(name = "ID_STATUS")
    private Status status;

    @Column(name = "UP_TO_DATE", columnDefinition = "char")
    private String current;

    @ToString.Exclude
    @OneToMany(mappedBy = "activity", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<SubactivityOfActivity> subactivities;

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o))
            return false;
        Activity activity = (Activity) o;
        return id != null && Objects.equals(id, activity.id);
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }

}

This is my secondary Entity:
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name = GlobalVariables.subactivityOfActivityTable, schema = GlobalVariables.schemaMain)
public class SubactivityOfActivity {

    @Id
    @Column(name = "ID", columnDefinition = "bigint")
    private Long id;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.DETACH, CascadeType.REFRESH })
    @JoinColumn(name = "ID_ACTIVID")
    private Activity activity;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.DETACH, CascadeType.REFRESH })
    @JoinColumn(name = "ID_SUBACT")
    private Subactivity subactivity;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY, cascade = { CascadeType.DETACH, CascadeType.REFRESH } )
    @JoinColumn(name = "ID_USER")
    private User user;
    
    @Column(name = "START")
    private LocalDate start_date;

    @Column(name = "FINISH")
    private LocalDate finish_date;

    @Column(name = "PROGRESS", columnDefinition = "smallint")
    private Short progress;

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o))
            return false;
            SubactivityOfActivity subactivityOfActivity = (SubactivityOfActivity) o;
        return id != null && Objects.equals(id, subactivityOfActivity.id);
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }
}

My implemented service:
@Override
@Transactional
public void save(Activity activity) {
    activityRepository.saveActivity(activity);
}

My repository:
@Override
public void saveActivity(Activity activity) {
   em.persist(activity);
   em.flush();
}

application.properties:
spring.datasource.url=jdbc:as400://ipaddress:port
spring.datasource.username=B
spring.datasource.password=B
spring.datasource.driver-class-name=com.ibm.as400.access.AS400JDBCDriver

spring.jpa.database-platform=org.hibernate.dialect.DB2iDialect
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.DB2iDialect
spring.jpa.properties.hibernate.hbm2ddl.auto=validate
spring.jpa.properties.hibernate.jdbc.batch_size=20
spring.jpa.properties.hibernate.order_inserts=true
spring.jpa.properties.hibernate.order_updates=true
spring.jpa.properties.hibernate.order_deletes=true

The subactivity id is duplicated, but not the activity. It is assumed that in a transaction, everything is done or nothing is done, but when doing this, the activity is saved, the subactivity gives a duplicate error, and the activity is recorded in the database, which should not be the case
I have already tried several things, and I replicated my example in PostgreSQL, and there I see the rollback reflected in the log, and the database works, when doing it here in IBM I (AS400), the rollback doesn''t work
Clarification: I''m using Spring Boot 3.3.5, JPA and I connect to an IBM I using its driver called JTOpen 20.0.7
', '["java", "spring", "spring-boot", "spring-data-jpa", "db2"]', '2024-11-15 02:42:51', '2024-11-15 04:57:20', 39, 1, 1, 0, 19567595, null),
        (79190090, 'Spring Boot with Rest Template, error catching errors', 'I stopped an instance I call using rest template to be able to catch the errors thrown. The errors are:
org.springframework.web.client.ResourceAccessException: I/O error on POST request for
Caused by: java.net.SocketTimeoutException: Connect timed out
I handle the errors in try / catch block, and I log to verify if the ResourceAccessException is caught.
The log was printed, so the error was caught, and return a default value inside that catch block.
But the problem is that the error is still printed in the spring console, and I can''t stop it.
try {
    ResponseEntity<String> exchange = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);

    return PipsUtils.roundToTwo(Float.parseFloat(Objects.requireNonNull(exchange.getBody())));
} catch (ResourceAccessException e) {
    log.error("An error occurred while connecting to instance with port: {}", port, e);
    throw new InstancesException("Connection to instances refused!");
}

I want to catch the error and stop from printing it in the console.
', '["java", "spring-boot", "error-handling", "try-catch", "resttemplate"]', '2024-11-15 02:48:39', '2024-11-17 00:16:27', 26, 0, 1, 0, 28302392, null),
        (79190132, 'Java how to know if char consists of two codepoints?', 'Java stores a character as an UTF-16 encoded codepoint(s). So when a character which needs two codepoints is stored it is split into two characters. So when I print the following string this happens:
(Tested with random two codepoint long character: https://codepoints.net/U+1230D)
String s = "\\uD808\\uDF0D";
System.out.println(s);
System.out.println(s.length());
System.out.println(s.charAt(0));
System.out.println(s.charAt(1));

Output:
𒌍
2
?
?

As expected it prinst garbage when only printing one part of the character.
But how can I now know that a character consists of two codepoints?
I guess by a special bit set in the first or second part?
I think the explanation is somewhere in here (https://en.wikipedia.org/wiki/UTF-16#Code_points_from_U+010000_to_U+10FFFF) but I don''t really understand it.
', '["java", "character-encoding", "utf-16"]', '2024-11-15 03:08:56', '2024-11-15 06:05:54', 65, 1, 1, 0, 22119430, 79190171),
        (79190173, 'Persisting of entities with no id, custom generation strategy', 'Here''s the goal: I need keys to be automatically incremented in the following fashion: "p1", "p2", etc. Postgres can''t have sequences like that, so I set a default value like this (I omit irrelevant columns):
-- schema.sql

CREATE SEQUENCE p_sequence;

CREATE TABLE product
(
    id                      VARCHAR(100) DEFAULT ''p'' || nextval(''p_sequence''),
    PRIMARY KEY (id)
);


package com.example.productapi.data.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Product {
    @Id
    @Column(name = "id")
    private String productId;
}

Here comes the problem: when the user hits the POST endpoint and tries to persist an entity with no id, Hibernate throws IdentifierGenerationException (which is then translated by Spring). It''s because it does''t allow persisting of entities with no ids unless there''s some @GeneratedValue strategy. Which is not SEQUENCE since I don''t relly on a sequence completely. It would be nice if Hibernate relaxed and just trusted in the DB (which would provide a default value). However, it''s not going to happen.
What are the workarounds for this?
', '["java", "hibernate", "spring-data"]', '2024-11-15 03:22:37', '2024-11-15 22:02:50', 33, 0, 1, 0, 27261123, null),
        (79190174, 'Setting Up Java Exception Handling for My Program', 'I was trying to handle some exceptions in my code for the prime number detector I am working on. This is my current code:
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.math.BigInteger;

public class Frame1 {
  private JFrame frame;
  private JPanel panel;
  private JTextField textField;
  private JLabel label;
  private JButton button;
  private JLabel DisplayLabel;
  private JPanel DisplayPanel;

public Frame1() {
    initialize();
}

private void initialize() {
    frame = new JFrame();
    frame.setTitle("Prime Detector");
    frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
    frame.setSize(420, 420);
    frame.setLayout(new BorderLayout(10, 10));
    frame.setLocationRelativeTo(null);

    panel = new JPanel();
    panel.setLayout(new FlowLayout());
    panel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

    label = new JLabel("Enter a number");
    label.setFont(new Font("Times New Roman", Font.BOLD, 20));
    panel.add(label);


    DisplayPanel = new JPanel();
    DisplayPanel.setLayout(new FlowLayout());
    DisplayPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
    DisplayPanel.setVisible(false);

    DisplayLabel = new JLabel();
    DisplayLabel.setFont(new Font("Times New Roman", Font.BOLD, 30));


    textField = createJTextField();
    panel.add(textField);

    button = new JButton("Enter");
    button.setFocusable(false);
    button.setBackground(Color.lightGray);
    button.setBorder(BorderFactory.createEtchedBorder());
    button.setForeground(Color.cyan);
    button.addActionListener(new ActionListener() {
        @Override
        public void actionPerformed(ActionEvent e) {
            TheCode code = new TheCode();
            BigInteger number = new BigInteger(textField.getText());
            try{
            code.primeDetector(number);


            if (TheCode.IsItPrime) {
                DisplayLabel.setText(number + " is prime.");
                DisplayLabel.setVisible(true);
                DisplayPanel.setVisible(true);
                DisplayPanel.add(DisplayLabel);
            } else {
                DisplayLabel.setText(number + " isn''t prime.");
                DisplayLabel.setVisible(true);
                DisplayPanel.setVisible(true);
                DisplayPanel.add(DisplayLabel);
                }
            }catch(Exception exception){
             DisplayLabel.setText("Enter a Valid Number");
            }
        }
    });

    panel.add(button);

    frame.add(panel, BorderLayout.NORTH);
    frame.add(DisplayPanel, BorderLayout.CENTER);
}


public void show() {
    frame.setVisible(true);
}

private JTextField createJTextField() {
    JTextField textField = new JTextField(10);

    return textField;

   }
}

However, when I run this code and try to enter something invalid it still shows the red exception message in the console which is what I am trying to prevent. Can someone help me? (By the way the primeDetector method and TheCode class are well defined and working as should)
', '["java", "exception"]', '2024-11-15 03:23:00', '2024-11-15 03:42:19', 27, 0, 1, 0, 28226740, null),
        (79190236, 'How to Simulate a Sine Wave Workload with YCSB', 'I am trying to simulate a sine wave workload using YCSB. The goal is to have the request rate follow a sine wave pattern over time. However, YCSB does not natively support dynamic throughput adjustments.
How can I do it?
', '["java", "benchmarking", "ycsb"]', '2024-11-15 03:52:29', '2024-11-15 03:52:29', 13, 0, 0, 0, 5499405, null),
        (79190261, 'Item register causes my game to error while loading. [NEOFORGE]', 'I''m new to learning Java and I thought I might start with using NeoForge to make a minecraft mod. At the moment I''m using this tutorial https://www.youtube.com/watch?v=IL7J9ueYRYc&list=PLKGarocXCE1G6CQOoiYdMVx-E1d9F_itF
I noticed that when I add ModItems.register(modEventBus); my game crashes with the following error:
Minecraft Error
Main class:
package net.ohusq.emeraldutils;

import net.minecraft.world.item.CreativeModeTabs;
import net.ohusq.emeraldutils.item.ModItems;
import org.slf4j.Logger;

import com.mojang.logging.LogUtils;

import net.neoforged.api.distmarker.Dist;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.bus.api.SubscribeEvent;
import net.neoforged.fml.ModContainer;
import net.neoforged.fml.common.EventBusSubscriber;
import net.neoforged.fml.common.Mod;
import net.neoforged.fml.config.ModConfig;
import net.neoforged.fml.event.lifecycle.FMLClientSetupEvent;
import net.neoforged.fml.event.lifecycle.FMLCommonSetupEvent;
import net.neoforged.neoforge.common.NeoForge;
import net.neoforged.neoforge.event.BuildCreativeModeTabContentsEvent;
import net.neoforged.neoforge.event.server.ServerStartingEvent;

// The value here should match an entry in the META-INF/neoforge.mods.toml file
@Mod(EmeraldUtils.MOD_ID)
public class EmeraldUtils
{
    public static final String MOD_ID = "emeraldutils";
    private static final Logger LOGGER = LogUtils.getLogger();

    // The constructor for the mod class is the first code that is run when your mod is loaded.
    // FML will recognize some parameter types like IEventBus or ModContainer and pass them in automatically.
    public EmeraldUtils(IEventBus modEventBus, ModContainer modContainer)
    {
        // Register the commonSetup method for modloading
        modEventBus.addListener(this::commonSetup);

        // Register ourselves for server and other game events we are interested in.
        // Note that this is necessary if and only if we want *this* class (ExampleMod) to respond directly to events.
        // Do not add this line if there are no @SubscribeEvent-annotated functions in this class, like onServerStarting() below.
        NeoForge.EVENT_BUS.register(this);

        ModItems.register(modEventBus); // ERROR HERE

        // Register the item to a creative tab
        modEventBus.addListener(this::addCreative);

        // Register our mod''s ModConfigSpec so that FML can create and load the config file for us
        modContainer.registerConfig(ModConfig.Type.COMMON, Config.SPEC);
    }

    private void commonSetup(final FMLCommonSetupEvent event) {

    }

    // Add the example block item to the building blocks tab
    private void addCreative(BuildCreativeModeTabContentsEvent event) {
        if(event.getTabKey() == CreativeModeTabs.INGREDIENTS) {
            event.accept(ModItems.BISMUTH);
        }
    }

    // You can use SubscribeEvent and let the Event Bus discover methods to call
    @SubscribeEvent
    public void onServerStarting(ServerStartingEvent event) {

    }

    // You can use EventBusSubscriber to automatically register all static methods in the class annotated with @SubscribeEvent
    @EventBusSubscriber(modid = MOD_ID, bus = EventBusSubscriber.Bus.MOD, value = Dist.CLIENT)
    public static class ClientModEvents {
        @SubscribeEvent
        public static void onClientSetup(FMLClientSetupEvent event)
        {

        }
    }
}


Which issue could cause this to happen?
My repository: https://github.com/ohusq/NeoForge-Tutorial
I have tried removing some lines to see which part made it error.
', '["java", "minecraft", "minecraft-forge"]', '2024-11-15 03:59:26', '2024-11-17 15:44:57', 30, 0, 1, 0, 17741830, 79196719),
        (79190280, 'How do I fix this &quot;need arm64e or arm64&quot; error in IntelliJ for Minecraft Forge modding? (MacOS)', 'Edit: I have an M1 MacBook Air
I have been following a Kaupenjoe tutorial for making a Minecraft Forge 1.18.2 mod but haven''t been able to run the runClient task as I keep getting an error:
java.lang.ExceptionInInitializerError: Exception java.lang.UnsatisfiedLinkError: /private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib: dlopen(/private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib, 0x0001): tried: ''/private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib'' (mach-o file, but is an incompatible architecture (have ''x86_64'', need ''arm64e'' or ''arm64'')), ''/System/Volumes/Preboot/Cryptexes/OS/private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib'' (no such file), ''/private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib'' (mach-o file, but is an incompatible architecture (have ''x86_64'', need ''arm64e'' or ''arm64'')) [in thread "Render thread"]

I''m not sure where I can access these files to change and replace them with a version that works for my Mac, and I''ve tried changing the project SDK to multiple versions of the same Eclipse Temurin 17 JDK for aarch64 but it still won''t work. I don''t know anything about Java and have limited Minecraft datapack knowledge (not the best for coding in Java but I''m impatient and this was only supposed to be a mod to make some things a little easier in my singleplayer world) so I am clueless and stumped on these errors. It also has been telling me that it can''t "initialize the rendering system":
Caused by: java.lang.NoClassDefFoundError: Could not initialize class com.mojang.blaze3d.systems.RenderSystem

I just recently figured out that the LightWeight Java Game Library is only for x86, which helps me somewhat, but I still don''t know how to replace my current x86 version with one that''s arm64.
Here''s the full lines of error:
Exception in thread "Render thread" java.lang.RuntimeException: java.lang.reflect.InvocationTargetException
    at MC-BOOTSTRAP/cpw.mods.modlauncher@9.1.3/cpw.mods.modlauncher.LaunchServiceHandlerDecorator.launch(LaunchServiceHandlerDecorator.java:39)
    at MC-BOOTSTRAP/cpw.mods.modlauncher@9.1.3/cpw.mods.modlauncher.LaunchServiceHandler.launch(LaunchServiceHandler.java:53)
    at MC-BOOTSTRAP/cpw.mods.modlauncher@9.1.3/cpw.mods.modlauncher.LaunchServiceHandler.launch(LaunchServiceHandler.java:71)
    at MC-BOOTSTRAP/cpw.mods.modlauncher@9.1.3/cpw.mods.modlauncher.Launcher.run(Launcher.java:106)
    at MC-BOOTSTRAP/cpw.mods.modlauncher@9.1.3/cpw.mods.modlauncher.Launcher.main(Launcher.java:77)
    at MC-BOOTSTRAP/cpw.mods.modlauncher@9.1.3/cpw.mods.modlauncher.BootstrapLaunchConsumer.accept(BootstrapLaunchConsumer.java:26)
    at MC-BOOTSTRAP/cpw.mods.modlauncher@9.1.3/cpw.mods.modlauncher.BootstrapLaunchConsumer.accept(BootstrapLaunchConsumer.java:23)
    at cpw.mods.bootstraplauncher@1.0.0/cpw.mods.bootstraplauncher.BootstrapLauncher.main(BootstrapLauncher.java:149)
Caused by: java.lang.reflect.InvocationTargetException
    at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
    at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:77)
    at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
    at java.base/java.lang.reflect.Method.invoke(Method.java:569)
    at MC-BOOTSTRAP/fmlloader@1.18.2-40.2.10/net.minecraftforge.fml.loading.targets.ForgeClientUserdevLaunchHandler.lambda$launchService$0(ForgeClientUserdevLaunchHandler.java:24)
    at MC-BOOTSTRAP/cpw.mods.modlauncher@9.1.3/cpw.mods.modlauncher.LaunchServiceHandlerDecorator.launch(LaunchServiceHandlerDecorator.java:37)
    ... 7 more
Caused by: java.lang.NoClassDefFoundError: Could not initialize class com.mojang.blaze3d.systems.RenderSystem
    at TRANSFORMER/minecraft@1.18.2/net.minecraft.SystemReport.setDetail(SystemReport.java:65)
    at TRANSFORMER/minecraft@1.18.2/net.minecraft.client.Minecraft.fillSystemReport(Minecraft.java:2284)
    at TRANSFORMER/minecraft@1.18.2/net.minecraft.client.Minecraft.fillReport(Minecraft.java:2277)
    at TRANSFORMER/minecraft@1.18.2/net.minecraft.client.main.Main.main(Main.java:178)
    ... 13 more
Caused by: java.lang.ExceptionInInitializerError: Exception java.lang.UnsatisfiedLinkError: /private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib: dlopen(/private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib, 0x0001): tried: ''/private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib'' (mach-o file, but is an incompatible architecture (have ''x86_64'', need ''arm64e'' or ''arm64'')), ''/System/Volumes/Preboot/Cryptexes/OS/private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib'' (no such file), ''/private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib'' (mach-o file, but is an incompatible architecture (have ''x86_64'', need ''arm64e'' or ''arm64'')) [in thread "Render thread"]
    at java.base/jdk.internal.loader.NativeLibraries.load(Native Method)
Caused by: java.lang.reflect.InvocationTargetException

    at java.base/jdk.internal.loader.NativeLibraries$NativeLibraryImpl.open(NativeLibraries.java:388)
    at java.base/jdk.internal.loader.NativeLibraries.loadLibrary(NativeLibraries.java:232)
    at java.base/jdk.internal.loader.NativeLibraries.loadLibrary(NativeLibraries.java:174)
    at java.base/java.lang.ClassLoader.loadLibrary(ClassLoader.java:2394)
    at java.base/java.lang.Runtime.load0(Runtime.java:755)
    at java.base/java.lang.System.load(System.java:1970)
Caused by: java.lang.NoClassDefFoundError: Could not initialize class com.mojang.blaze3d.systems.RenderSystem

    at MC-BOOTSTRAP/org.lwjgl/org.lwjgl.system.Library.loadSystem(Library.java:162)
Caused by: java.lang.ExceptionInInitializerError: Exception java.lang.UnsatisfiedLinkError: /private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib: dlopen(/private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib, 0x0001): tried: ''/private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib'' (mach-o file, but is an incompatible architecture (have ''x86_64'', need ''arm64e'' or ''arm64'')), ''/System/Volumes/Preboot/Cryptexes/OS/private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib'' (no such file), ''/private/var/folders/zs/9xkpdhg532l8zcrkm3sqmf480000gp/T/lwjgleversbergb26/3.2.1-SNAPSHOT/liblwjgl.dylib'' (mach-o file, but is an incompatible architecture (have ''x86_64'', need ''arm64e'' or ''arm64'')) [in thread "Render thread"]

    at MC-BOOTSTRAP/org.lwjgl/org.lwjgl.system.Library.loadSystem(Library.java:152)
    at MC-BOOTSTRAP/org.lwjgl/org.lwjgl.system.Library.loadSystem(Library.java:116)
    at MC-BOOTSTRAP/org.lwjgl/org.lwjgl.system.Library.loadSystem(Library.java:67)
    at MC-BOOTSTRAP/org.lwjgl/org.lwjgl.system.Library.<clinit>(Library.java:50)
    at MC-BOOTSTRAP/org.lwjgl/org.lwjgl.system.MemoryUtil.<clinit>(MemoryUtil.java:97)
    at TRANSFORMER/minecraft@1.18.2/com.mojang.blaze3d.platform.MemoryTracker.<clinit>(MemoryTracker.java:8)
    at TRANSFORMER/minecraft@1.18.2/com.mojang.blaze3d.vertex.BufferBuilder.<init>(BufferBuilder.java:48)
    at TRANSFORMER/minecraft@1.18.2/com.mojang.blaze3d.vertex.Tesselator.<init>(Tesselator.java:19)
    at TRANSFORMER/minecraft@1.18.2/com.mojang.blaze3d.vertex.Tesselator.<init>(Tesselator.java:23)
    at TRANSFORMER/minecraft@1.18.2/com.mojang.blaze3d.vertex.Tesselator.<clinit>(Tesselator.java:11)
    at TRANSFORMER/minecraft@1.18.2/com.mojang.blaze3d.systems.RenderSystem.<clinit>(RenderSystem.java:46)
    at TRANSFORMER/minecraft@1.18.2/net.minecraft.client.main.Main.main(Main.java:167)
    ... 13 more

> Task :runClient FAILED

Execution failed for task '':runClient''.
> Process ''command ''/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home/bin/java'''' finished with non-zero exit value 1

* Try:
> Run with --stacktrace option to get the stack trace.
> Run with --info or --debug option to get more log output.

', '["java", "minecraft", "minecraft-forge"]', '2024-11-15 04:09:27', '2024-11-15 22:20:05', 38, 0, 0, 0, 28305169, null),
        (79190292, 'Java method calling confusion', 'AEDoaBase.java
protected void validateAndSetDBParams(NamedCallableStatement ncs, 
            Map<String, Object> inputDataMap, 
            Map<String,ParamDef> daoInputMapDef,
            Map<String, Object> result)
    {
        List<String> lstSqlParams = ncs.getFields(); //get all parameters required for PL/SQL
        List<String> ERROR = new ArrayList();
        if(isSuccess(result)) //check no errors until now
        {
            ERROR = setParamForNamedCallableStatement(lstSqlParams, inputDataMap, daoInputMapDef, ncs);
            if(ERROR.size() > 0)
            {
                setError(result, ERROR);                
            }               
        }
    }

BaseDao.java
public List<String> setParamForNamedCallableStatement(List<String> lstSqlParams, 
            Map<String, Object> inputDataMap, 
            Map<String,ParamDef> daoInputMapDef,
            NamedCallableStatement ncs)


The setParamForNamedCallableStatement() is a method defined in BaseDao.java
The method is called in AEDaoBase.java (see image)
AEDaoBase.java inherits from BaseDao.java. So...the method is available.

My question is, where is the object?  I thought the method was only available if it is part of an object.  Yet...there is no object, so I am confused.
I understand this would be a valid expression in Javascript, but this is a Java project.  Trying to understand and failing
', '["java"]', '2024-11-15 04:13:58', '2024-11-15 07:26:59', 89, -8, 3, 0, 28305211, null),
        (79190299, 'I’m getting error while adding dependencies in oracle j developer 12.2.1.3', 'enter image description here
Errors log 4j
Adding jars but I don’t think I have enough version so can you please give me some more information on what you want me to do and how much you want me for it and what you need me to do for the jar and what you like to use for your jar
', '["java"]', '2024-11-15 04:18:23', '2024-11-15 04:18:23', 10, -1, 0, 0, 28305357, null),
        (79190330, 'Can we set a Thread Local variable from child class and access it in the parent class in Java?', 'I have an automation project with two Test classes(child classes) and a TestBase (parent class). In the TestBase I have a threadlocal attribute defined as below.
protected ThreadLocal<ITestContext> iTestContextThreadLocal = new ThreadLocal<>();


In each of the child class I''m setting an attribute called ''feature'' into this ThreadLocal attribute. Sample Child class looks like below.
public class RestTests extends TestBase{

    @BeforeClass(alwaysRun = true)
    public void init(ITestContext iTestContext) {
        iTestContext.setAttribute("feature", "Sample - RestTests1");
        iTestContextThreadLocal.set(iTestContext);
        String feature = iTestContextThreadLocal.get().getAttribute("feature").toString();
    }

    @Test
    public void testScenario1(){
        //Automation Code
    }
}

In the TestBase I have an ''AfterMethod'' inside which I try to access this value set in child class''s before Method.
    @AfterMethod(alwaysRun = true)
    public void test() {
        try {
            ITestContext iTestContext = iTestContextThreadLocal.get();
            String feature = iTestContext.getAttribute("feature").toString();
            System.out.println("***** ThreadLocalAttribute: " + feature);

            //Rest of the code
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Clean up the ThreadLocal variables after method execution
            iTestContextThreadLocal.remove();
        }
    }

The Issue I''m facing is - in parallel Test execution (in both classes and methods) feature set in one class is provided as the output.
As an example if I set ''Sample - RestTests1'' and ''Sample - RestTests2'' as features in my child classes, when I try to access them in TestBase afterMethod using the below code, only one class''s feature is given
iTestContext.getAttribute("feature").toString();

How to fix this and get feature set in each class via TestBase''s AfterMethod ?
I have tried changing the order of annotations and trying out the solutions in the internet. But no fix is found yet.
Any help is highly appreciated.
Thanks in Advance.
', '["java", "selenium-webdriver", "testng", "thread-local"]', '2024-11-15 04:28:05', '2024-11-16 11:36:12', 39, 0, 2, 0, 28303654, 79190370),
        (79190387, 'java. lang. AssertionError: 1 expectation failed. JSON path id doesn&#39;t match. Expected: 167039 but actual is an array', 'Hi i have created this function.
@Test
    public void getStatus() {

        given()
                .when()
                .get("https://gorest.co.in/public/v2/posts")
                .then()
                .statusCode(200)
                .body("id",equalTo("167039"))
                .header("User-Agent","application/json");


    }
}

but getting this error
java. lang. AssertionError: 1 expectation failed. JSON path id doesn''t match. Expected: 167039 Actual: <[167452, 167451, 167449, 167448, 167447, 167446, 167417, 167416, 167413, 167412]>
i am trying to access single id record.
', '["java", "automation"]', '2024-11-15 04:52:20', '2024-11-15 05:00:56', 19, 0, 1, 0, 14741354, null),
        (79190407, 'Dynamic Routing in API Gateway with Tenant-Based Service Resolution Using Spring Cloud and Eureka', 'I''m developing an application using the microservices architecture with Spring Boot and Spring Cloud. In this application, I want to use API Gateway and Eureka to enable dynamic routing. My main requirements are as follows:
Dynamic routing in API Gateway: The API Gateway should route incoming requests to services registered in Eureka dynamically. I do not want to define service names or addresses statically; the routing should be dynamic.
JWT authentication with tenant information: Users will log in using a JWT token, which contains tenant information. I want to update the target service of the request based on this tenant information.
I register my services in Eureka with the format "test-tenantId" and want the routing to align with this format. In the future, there may be multiple services with names like test-tenant1, test-tenant2, ..., test-tenantN. Therefore, I plan to apply the update only to requests that begin with /test, while other requests should be routed as-is based on Eureka''s default routing.
I have two specific routing scenarios:
Scenario 1: When a request like /user/{id} is received, it should directly route to the service registered in Eureka with the name user.
Scenario 2: When a request like /test/{page} is received, I want to modify this request to /test-{tenantId}/{page} based on the tenant information provided in the JWT token. For example, if the tenant in the token is tenant1, the request should be routed to /test-tenant1/{page}.
How can I implement this dynamic routing and URL modification with API Gateway and Eureka? Could you provide an example structure or code?
', '["java", "microservices", "spring-cloud", "netflix-eureka", "api-gateway"]', '2024-11-15 04:59:44', '2024-11-18 15:16:51', 19, 0, 1, 0, 15426734, 79199018),
        (79190436, 'Problem deploying a Java Web Project MVC in TomCat server in VSC', 'I have a Java project, in Maven, java 17, Im trying to deploy the .war file using Tomcat Server 9 with Community Server Connetors Extension of VSCode.
First way, a have a Servlet.java class configured, when I deployed in the server works fine and shows the .jsp.
Second way, a have a web.xml and a spring_mvc_servlet.xml for configuration, and a Controlador.java class, but this second way run the server showing 404 error.
---Web.xml:
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="http://xmlns.jcp.org/xml/ns/javaee"
    xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
    id="WebApp_ID" version="4.0">

    <!-- Configuracion del dispatcher servlet -->
    <servlet>
        <servlet-name>dispatcher</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>/WEB-INF/spring_mvc_servlet.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>

    <!-- Ubicacion URL del servlet -->
    <servlet-mapping>
        <servlet-name>dispatcher</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
</web-app>

---spring_mvc_servlet.xml:
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:context="http://www.springframework.org/schema/context"
    xmlns:mvc="http://www.springframework.org/schema/mvc"
    xsi:schemaLocation="
        http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context.xsd
        http://www.springframework.org/schema/mvc
        http://www.springframework.org/schema/mvc/spring-mvc.xsd">

    <!-- Habilitar soporte para anotaciones en los controladores -->
    <context:component-scan base-package="es.pildoras.spring.mvc"/>
    <context:annotation-config/>
    
    <!-- Configuración de los resolutores de vistas -->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/vistas/"/>
        <property name="suffix" value=".jsp"/>
    </bean>

</beans>

---Controlador.java class:
package es.pildoras.spring.mvc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping
public class Controlador {

    @RequestMapping("/")
    public String redirigir(){
        return "index";
    }
}

Also in TomCat log I recived the error:
WARNING [main] org.apache.tomcat.util.descriptor.web.WebXml.setVersion Unknown version string [5.0]. Default version will be used.

I think everything is configured correctly.
I tried run the proyect originally in VScode, then in Net Beans, the same problem; and Eclipse, the same problem.
There is the repository for test:
https://github.com/AlonzoAlex/Spring-MVC-1
Thanks
', '["java", "maven", "visual-studio-code", "spring-mvc", "tomcat9"]', '2024-11-15 05:11:10', '2024-11-15 05:16:35', 37, 0, 0, 0, 27818278, null),
        (79190467, 'Running JavaFX interface on spring project', 'So I have this spring gradle project. Tried to use JavaFX to create interface and now when I start the application Im getting this error:
Error: JavaFX runtime components are missing, and are required to run this application
How can I fix it without creating a new project? Using intellij idea. pls help guys
My build.gradle file looks like this
plugins {
    id ''java''
    id ''org.springframework.boot'' version ''3.3.5''
    id ''io.spring.dependency-management'' version ''1.1.6''
    id ''application''
    id ''org.openjfx.javafxplugin'' version ''0.0.14'' 
}

group = ''com.example.fitnesscentersystem''
version = ''0.0.1-SNAPSHOT''

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)  
    }
}

repositories {
    mavenCentral()
}

dependencies {
    implementation ''org.springframework.boot:spring-boot-starter-data-jpa''
    implementation ''org.springframework.boot:spring-boot-starter-security''
    implementation ''org.springframework.boot:spring-boot-starter-thymeleaf''
    implementation ''org.springframework.boot:spring-boot-starter-web''
    implementation ''org.thymeleaf.extras:thymeleaf-extras-springsecurity6''
    runtimeOnly ''com.mysql:mysql-connector-j''
    testImplementation ''org.springframework.boot:spring-boot-starter-test''
    testImplementation ''org.springframework.security:spring-security-test''
    testRuntimeOnly ''org.junit.platform:junit-platform-launcher''

    // JavaFX зависимости
    implementation ''org.openjfx:javafx-controls:17''
    implementation ''org.openjfx:javafx-fxml:17''

}

tasks.named(''test'') {
    useJUnitPlatform()
}

application {
    mainClass = ''com.example.fitnesscentersystem.YourMainClass''  
}

javafx {
    version = ''17''  
    modules = [''javafx.controls'', ''javafx.fxml'']  
}

My FitnesscentersystemApplication file looks like this:
package com.example.fitnesscentersystem.fitnesscentersystem;
//
//import org.springframework.boot.SpringApplication;
//import org.springframework.boot.autoconfigure.SpringBootApplication;
//
//@SpringBootApplication
//public class FitnesscentersystemApplication {
//
//    public static void main(String[] args) {
//        SpringApplication.run(FitnesscentersystemApplication.class, args);
//    }
//
//}
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = "com.example.fitnesscentersystem")
public class FitnesscentersystemApplication extends Application {

    private static ApplicationContext applicationContext;

    public static void main(String[] args) {
        applicationContext = SpringApplication.run(FitnesscentersystemApplication.class, args);
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) throws Exception {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/fxml/MainPage.fxml"));
        loader.setControllerFactory(applicationContext::getBean);  
        Scene scene = new Scene(loader.load());
        primaryStage.setTitle("Fitness Center");
        primaryStage.setScene(scene);
        primaryStage.show();
    }
}

', '["java", "spring", "spring-boot", "gradle", "javafx"]', '2024-11-15 05:27:59', '2024-11-15 15:30:00', 35, -3, 0, 0, 21691536, null),
        (79190684, 'Using Reflection and Annotations in Java to Automatically Register Class Methods', 'I''m working on a Java project where I need to use reflection and annotations to automatically register specific methods in a class. My goal is to find methods in a class that are annotated with a specific annotation and store them in a map. The map should contain the method name as the key and the corresponding Method object as the value.
I''ve created a custom annotation called @Register, and I only want methods annotated with this annotation to be added to the map. However, I''m running into some issues when using reflection to access and store the methods, especially with method accessibility and dealing with non-static methods.
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

// Custom annotation definition
@Retention(RetentionPolicy.RUNTIME)
@interface Register {}

// Example class with annotated methods
class ExampleService {
    @Register
    public void serviceMethod1() {
        System.out.println("Service Method 1");
    }

    @Register
    public void serviceMethod2() {
        System.out.println("Service Method 2");
    }

    public void nonRegisteredMethod() {
        System.out.println("This method should not be registered.");
    }
}

// Class to register methods
class MethodRegistry {
    private final Map<String, Method> methodMap = new HashMap<>();

    public void registerAnnotatedMethods(Class<?> clazz) {
        for (Method method : clazz.getDeclaredMethods()) {
            if (method.isAnnotationPresent(Register.class)) {
                methodMap.put(method.getName(), method);
            }
        }
    }

    public void invokeMethod(String methodName, Object instance) throws Exception {
        Method method = methodMap.get(methodName);
        if (method != null) {
            method.invoke(instance);
        } else {
            System.out.println("Method not found in the registry.");
        }
    }

    public Map<String, Method> getMethodMap() {
        return methodMap;
    }
}

// Main class to test
public class ReflectionTest {
    public static void main(String[] args) {
        MethodRegistry registry = new MethodRegistry();
        registry.registerAnnotatedMethods(ExampleService.class);

        // Check the registered methods
        System.out.println("Registered methods: " + registry.getMethodMap().keySet());

        // Try invoking a registered method
        try {
            registry.invokeMethod("serviceMethod1", new ExampleService());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

Problem:

When I try to invoke a registered method, it works fine for the annotated methods, but I get an error if the method is private or protected. How can I handle private or protected methods that are annotated?

Is there a better way to manage non-static method invocation with this structure, especially when handling potential IllegalAccessException or InvocationTargetException?


Any insights on improving this approach or handling access issues would be appreciated!
What I tried: I implemented the registerAnnotatedMethods method, which uses reflection to find methods in a given class that are annotated with @Register. I then store these methods in a Map with their names as keys. I also created an invokeMethod method to call these registered methods by name, passing in an instance of the class to invoke non-static methods.
What I expected: I expected registerAnnotatedMethods to find all methods annotated with @Register, regardless of their access modifiers (public, private, or protected), and add them to the map. When I used invokeMethod, I expected it to invoke the method on the provided instance without any access issues.
What actually happened: The code works for public methods, but it fails with IllegalAccessException for private and protected methods when trying to invoke them. Also, I’m having trouble managing non-static method invocations without explicitly creating an instance each time.
Further Clarification: I’d like to know how to handle private and protected methods annotated with @Register and whether there’s a more efficient way to handle non-static invocations.
', '["java", "reflection", "annotations", "method-invocation", "illegalaccessexception"]', '2024-11-15 07:11:37', '2024-11-15 07:11:37', 54, -1, 0, 0, 18430921, null),
        (79190791, 'Elasticache Redis (Unexpected end of stream)', 'I have a redis Elasticache in AWS and I''m trying to connect to this cache via Java code from a container that is deployed to AWS Kubernetes. But the connection is failing with this exception Unexpected end of stream .
I tried removing redis: from the url, it didn''t work and it gave a different exception saying that Cannot open Redis connection due invalid URI.
Configuration endpoint from AWS:
elsticache.abc.cache.amazonaws.com:6379
Java code:
JedisPoolConfig poolConfig = new JedisPoolConfig();
String url = "redis://elsticache.abc.cache.amazonaws.com:6379";
JedisPool jedisPool = new JedisPool(poolConfig, url);
Jedis jedis = jedisPool.getResource();

pom.xml:
    <dependency>
        <groupId>redis.clients</groupId>
        <artifactId>jedis</artifactId>
        <version>5.2.0</version>
    </dependency>

I also tried a different JedisPool constructor, but it didn''t work.
JedisPool jedisPool = new JedisPool(poolConfig, "elsticache.abc.cache.amazonaws.com:6379", 6379, timeout, true);
I also tried the code below, but I got this exception Remote host terminated the handshake:
    String stringUrl = "https://elsticache.abc.cache.amazonaws.com:6379";
    try {
        URL url = new URL(stringUrl);

        HttpURLConnection connection = (HttpURLConnection) url.openConnection();

        connection.setRequestMethod("HEAD");
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(5000);
        int responseCode = connection.getResponseCode();
        log.info("{}. responseCode: {}", PRE_FEX, responseCode);
    } catch (Exception e) {
        log.error("{}, exception: {}", PRE_FEX, e.getMessage());
    }

', '["java", "redis", "amazon-elasticache", "jedis"]', '2024-11-15 08:26:15', '2024-11-15 11:00:46', 34, 0, 0, 0, 9053712, null),
        (79190892, 'I can write to my Firebase Firestore database, but am unable to read from it (Android Studio using Java)', 'I am trying to connect my Android app to my Firestore database. I can write to my database from my app, but I am unable to read from it.
AndroidManifest:
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">

    <uses-permission android:name="android.permission.INTERNET" />

    <application
        android:allowBackup="true"
        android:dataExtractionRules="@xml/data_extraction_rules"
        android:fullBackupContent="@xml/backup_rules"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.Cerebrospinal"
        tools:targetApi="31">
        <activity
            android:name=".SudokuActivity"
            android:exported="false" />
        <activity
            android:name=".Activity2048"
            android:exported="false" />
        <activity
            android:name=".WordleActivity"
            android:exported="false" />
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>

App level build.gradle
plugins {
    alias(libs.plugins.android.application)
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.cerebrospinal"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.cerebrospinal"
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
}

dependencies {

    implementation(platform("com.google.firebase:firebase-bom:33.5.1"))
    implementation("com.google.firebase:firebase-analytics")

    // Firestore
    implementation("com.google.firebase:firebase-firestore:25.1.1")

    // Other Firebase/Play services deps
    implementation("com.google.firebase:firebase-auth:21.0.1")
    implementation("com.google.android.gms:play-services-auth:21.2.0")

    // FirebaseUI (for authentication)
    implementation("com.firebaseui:firebase-ui-auth:8.0.0")

    implementation(libs.appcompat)
    implementation(libs.material)
    implementation(libs.activity)
    implementation(libs.constraintlayout)
    testImplementation(libs.junit)
    androidTestImplementation(libs.ext.junit)
    androidTestImplementation(libs.espresso.core)
}

Project level build.gradle:
// Top-level build file where you can add configuration options common to all sub-projects/modules.
plugins {
    alias(libs.plugins.android.application) apply false
    id("com.google.gms.google-services") version "4.4.2" apply false
}

Test code I am using to access my database:
oneButton = findViewById(R.id.button1);
        oneButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (sudokuController.getPencilMode() && sudokuController.getSelectedRow() > 0
                        && sudokuController.getSelectedColumn() > 0) {
                    sudokuController.setSelectedNumber(1);
                    sudokuController.setBoardTile();
                    sudokuBoard.invalidate();
                }
                FirebaseFirestore db = FirebaseFirestore.getInstance();
                // Create a new user with a first and last name
                Map<String, Object> user = new HashMap<>();
                user.put("first", "Ada");
                user.put("last", "Lovelace");
                user.put("born", 1815);

                // Add a new document with a generated ID
                db.collection("users")
                        .add(user)
                        .addOnSuccessListener(new OnSuccessListener<DocumentReference>() {
                            @Override
                            public void onSuccess(DocumentReference documentReference) {
                                Log.d(TAG, "DocumentSnapshot added with ID: " + documentReference.getId());
                            }
                        })
                        .addOnFailureListener(new OnFailureListener() {
                            @Override
                            public void onFailure(@NonNull Exception e) {
                                Log.w(TAG, "Error adding document", e);
                            }
                        });

                // Create a new user with a first, middle, and last name
                user = new HashMap<>();
                user.put("first", "Alan");
                user.put("middle", "Mathison");
                user.put("last", "Turing");
                user.put("born", 1912);

                // Add a new document with a generated ID
                db.collection("users")
                        .add(user)
                        .addOnSuccessListener(new OnSuccessListener<DocumentReference>() {
                            @Override
                            public void onSuccess(DocumentReference documentReference) {
                                Log.d(TAG, "DocumentSnapshot added with ID: " + documentReference.getId());
                            }
                        })
                        .addOnFailureListener(new OnFailureListener() {
                            @Override
                            public void onFailure(@NonNull Exception e) {
                                Log.w(TAG, "Error adding document", e);
                            }
                        });

                db.collection("users")
                        .get()
                        .addOnCompleteListener(new OnCompleteListener<QuerySnapshot>() {
                            @Override
                            public void onComplete(@NonNull Task<QuerySnapshot> task) {
                                if (task.isSuccessful()) {
                                    for (QueryDocumentSnapshot document : task.getResult()) {
                                        Log.d(TAG, document.getId() + " => " + document.getData());
                                    }
                                } else {
                                    Log.w(TAG, "Error getting documents.", task.getException());
                                }
                            }
                        });
            }
        });

Logcat output after pressing the "oneButton":
2024-11-14 19:37:17.284  9790-9849  ProfileInstaller        com.example.cerebrospinal            D  Installing profile for com.example.cerebrospinal
2024-11-14 19:37:19.383  9790-9809  EGL_emulation           com.example.cerebrospinal            D  app_time_stats: avg=304.30ms min=13.14ms max=3634.54ms count=13
2024-11-14 19:37:19.620  9790-9790  ContentValues           com.example.cerebrospinal            D  ArTLEmYycQ7AkM3Autjg => {middle=Mathison, last=Turing, born=1912, first=Alan}
2024-11-14 19:37:19.620  9790-9790  ContentValues           com.example.cerebrospinal            D  JUIWkKMuC3wWTimIDdmP => {last=Lovelace, born=1815, first=Ada}
2024-11-14 19:37:19.620  9790-9790  ContentValues           com.example.cerebrospinal            D  LQ1tECj91ivvL7ZhF7i8 => {last=Lovelace, born=1815, first=Ada}
2024-11-14 19:37:19.620  9790-9790  ContentValues           com.example.cerebrospinal            D  xAmdrpHnykJarOA4ibt0 => {middle=Mathison, last=Turing, born=1912, first=Alan}
2024-11-14 19:37:19.724  9790-9790  ContentValues           com.example.cerebrospinal            D  DocumentSnapshot added with ID: LQ1tECj91ivvL7ZhF7i8
2024-11-14 19:37:19.756  9790-9790  ContentValues           com.example.cerebrospinal            D  DocumentSnapshot added with ID: xAmdrpHnykJarOA4ibt0
2024-11-14 19:37:25.332  9790-9840  GoogleApiManager        com.example.cerebrospinal            E  Failed to get service from broker.  (Ask Gemini)
                                                                                                    java.lang.SecurityException: Unknown calling package name ''com.google.android.gms''.
                                                                                                        at android.os.Parcel.createExceptionOrNull(Parcel.java:3242)
                                                                                                        at android.os.Parcel.createException(Parcel.java:3226)
                                                                                                        at android.os.Parcel.readException(Parcel.java:3209)
                                                                                                        at android.os.Parcel.readException(Parcel.java:3151)
                                                                                                        at amxe.a(:com.google.android.gms@244337038@24.43.37 (260800-693941914):36)
                                                                                                        at amvl.z(:com.google.android.gms@244337038@24.43.37 (260800-693941914):143)
                                                                                                        at amcs.run(:com.google.android.gms@244337038@24.43.37 (260800-693941914):54)
                                                                                                        at android.os.Handler.handleCallback(Handler.java:959)
                                                                                                        at android.os.Handler.dispatchMessage(Handler.java:100)
                                                                                                        at bskq.mC(:com.google.android.gms@244337038@24.43.37 (260800-693941914):1)
                                                                                                        at bskq.dispatchMessage(:com.google.android.gms@244337038@24.43.37 (260800-693941914):5)
                                                                                                        at android.os.Looper.loopOnce(Looper.java:232)
                                                                                                        at android.os.Looper.loop(Looper.java:317)
                                                                                                        at android.os.HandlerThread.run(HandlerThread.java:85)
2024-11-14 19:42:19.801  9790-9867  TrafficStats            com.example.cerebrospinal            D  tagSocket(136) with statsTag=0xffffffff, statsUid=-1
2024-11-14 19:42:19.881  9790-9867  TrafficStats            com.example.cerebrospinal            D  tagSocket(5) with statsTag=0xffffffff, statsUid=-1


I followed Android documentation to use the database in my app, and am using their example code to test it. I expected to be able to both read and write from/to my database but am unable to read from it.
', '["java", "android", "firebase", "google-cloud-platform", "google-cloud-firestore"]', '2024-11-15 09:49:13', '2024-11-15 12:04:32', 50, 0, 1, 0, 21646492, 79191059),
        (79190907, 'FAILURE: Build failed with an exception.Execution failed for task &#39;:app:mapDebugSourceSetPaths&#39;', 'Launching lib\\main.dart on Infinix X6711 in debug mode...
Warning: SDK processing. This version only understands SDK XML versions up to 3 but an SDK XML file of version 4 was encountered. This can happen if you use versions of Android Studio and the command-line tools that were released at different times.
FAILURE: Build failed with an exception.

What went wrong:
Execution failed for task '':app:mapDebugSourceSetPaths''.


Error while evaluating property ''extraGeneratedResDir'' of task '':app:mapDebugSourceSetPaths''.
Failed to calculate the value of task '':app:mapDebugSourceSetPaths'' property ''extraGeneratedResDir''.
> Querying the mapped value of provider(java.util.Set) before task '':app:processDebugGoogleServices'' has completed is not supported


Try:


Run with --stacktrace option to get the stack trace.
Run with --info or --debug option to get more log output.
Run with --scan to get full insights.


Get more help at https://help.gradle.org

BUILD FAILED in 41s
Running Gradle task ''assembleDebug''...                             44.3s
Error: Gradle task assembleDebug failed with exit code 1
I can''t run my project.
', '["java", "flutter", "dart", "gradle"]', '2024-11-15 09:59:07', '2024-11-15 23:21:23', 21, 0, 0, 0, 14769267, null),
        (79190910, 'Change the Shadow color of BottomAppBar and FloatingActionButton', 'I tried to change the shadow color of BottomAppBar and FloatingActionButton but failed. I want to adjust it like the photo below

Here is the code
<com.google.android.material.bottomappbar.BottomAppBar
        android:id="@+id/bab_main"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_gravity="bottom"
        app:background="?attr/selectableItemBackgroundBorderless"
        app:elevation="@dimen/_5sdp"
        app:contentInsetStart="0dp"
        app:contentInsetEnd="0dp"
        app:fabCradleMargin="@dimen/_8sdp"
        app:fabCradleRoundedCornerRadius="@dimen/_25sdp"
        app:fabAlignmentMode="center"
        android:outlineProvider="background"
        android:outlineSpotShadowColor="@color/color_button_main"
        android:outlineAmbientShadowColor="@color/color_button_main"
        tools:targetApi="p">

        <com.google.android.material.bottomnavigation.BottomNavigationView
            android:id="@+id/bnv_main"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            app:layout_constraintBottom_toBottomOf="parent"
            app:labelVisibilityMode="labeled"
            android:background="@color/transparent"
            app:elevation="0dp"
            android:paddingTop="@dimen/_2sdp"
            android:paddingBottom="@dimen/_10sdp"
            app:itemIconSize="@dimen/_20sdp"
            style="@style/MyBottomNavigationView"
            app:itemPaddingBottom="@dimen/_2sdp"
            app:menu="@menu/bottom_menu"/>

    </com.google.android.material.bottomappbar.BottomAppBar>

    <com.google.android.material.floatingactionbutton.FloatingActionButton
        android:id="@+id/flb_add"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        app:layout_anchor="@id/bab_main"
        app:backgroundTint="?color_button_main"
        android:src="@drawable/ic_add"
        app:maxImageSize="35dp"
        app:fabCustomSize="65dp"
        app:tint="?color_text_main_inverse"
        app:elevation="5dp"
        app:borderWidth="0dp"
        android:outlineSpotShadowColor="?color_button_main"
        android:outlineAmbientShadowColor="?color_button_main"
        android:contentDescription="@string/text_add_diary"
        tools:targetApi="p" />

I can''t change the Shadow color of the BottomAppBar, it''s still a gray color
As for FloatingActionButton, the Shadow will point downward, but I want it to spread around
Here is the resulting code

', '["java", "android", "kotlin"]', '2024-11-15 09:59:56', '2024-11-15 09:59:56', 23, 0, 0, 0, 21905524, null),
        (79190914, 'Oracle SQL Developer not opening on mac: &quot;Module javafx.base not found&quot;', 'I''ve just installed Oracle SQL Developer on my Mac, but I''m unable to open it. It just bounces on the task bar and won''t open. When I try to run it through the Terminal, I get the following error:

Error occurred during initialization of boot layer
java.lang.module.FindException: Module javafx.base not found

I downloaded the SQLDeveloper version "Mac OSX with JDK 17 included," so I assumed JDK 17 would be bundled with it. I can see a JDK folder located at:
/Applications/SQLDeveloper.app/Contents/Resources/sqldeveloper/jdk
Does anyone know how to resolve this issue?
', '["java", "macos", "oracle-sqldeveloper"]', '2024-11-15 10:05:09', '2024-11-15 15:32:01', 29, 0, 0, 0, 28305084, null),
        (79190918, 'java.sql.SQLSyntaxErrorException: Error de sintaxis: Encountered &quot;USER&quot; and &quot;ORDER&quot;', 'I was doing a project on NetBeans, using GlassFish and JDBC. I was working on some views using JSP and my project suddenly crashed. I tried searching for a solution but can''t get to solve it. This is the error that I get:
EclipseLink, version: Eclipse Persistence Services - 4.0.2.v202306161219|#]
Local Exception Stack: 
Exception [EclipseLink-4002] (Eclipse Persistence Services - 4.0.2.v202306161219): org.eclipse.persistence.exceptions.DatabaseException
Internal Exception: java.sql.SQLSyntaxErrorException: Error de sintaxis: Encountered "USER" at line 1, column 14.
Error Code: 30000
Call: CREATE TABLE USER (IDUSER BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL, ADDRESS VARCHAR(255), EMAIL VARCHAR(255), NAME VARCHAR(255), PASSWORD VARCHAR(255), PHONE INTEGER, ROL VARCHAR(255), USERNAME VARCHAR(255), PRIMARY KEY (IDUSER))
Query: DataModifyQuery(sql="CREATE TABLE USER (IDUSER BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL, ADDRESS VARCHAR(255), EMAIL VARCHAR(255), NAME VARCHAR(255), PASSWORD VARCHAR(255), PHONE INTEGER, ROL VARCHAR(255), USERNAME VARCHAR(255), PRIMARY KEY (IDUSER))")
    at org.eclipse.persistence.exceptions.DatabaseException.sqlException(DatabaseException.java:343)
    at org.eclipse.persistence.internal.databaseaccess.DatabaseAccessor.basicExecuteCall(DatabaseAccessor.java:702)
    at org.eclipse.persistence.internal.databaseaccess.DatabaseAccessor.executeCall(DatabaseAccessor.java:569)
    at org.eclipse.persistence.internal.sessions.AbstractSession.basicExecuteCall(AbstractSession.java:2048)
    at org.eclipse.persistence.sessions.server.ServerSession.executeCall(ServerSession.java:611)
    at org.eclipse.persistence.internal.queries.DatasourceCallQueryMechanism.executeCall(DatasourceCallQueryMechanism.java:280)
    at org.eclipse.persistence.internal.queries.DatasourceCallQueryMechanism.executeCall(DatasourceCallQueryMechanism.java:266)
    at org.eclipse.persistence.internal.queries.DatasourceCallQueryMechanism.executeNoSelectCall(DatasourceCallQueryMechanism.java:323)
    at org.eclipse.persistence.internal.queries.DatasourceCallQueryMechanism.executeNoSelect(DatasourceCallQueryMechanism.java:294)
    at org.eclipse.persistence.queries.DataModifyQuery.executeDatabaseQuery(DataModifyQuery.java:88)
    at org.eclipse.persistence.queries.DatabaseQuery.execute(DatabaseQuery.java:913)
    at org.eclipse.persistence.internal.sessions.AbstractSession.internalExecuteQuery(AbstractSession.java:3308)
    at org.eclipse.persistence.internal.sessions.AbstractSession.executeQuery(AbstractSession.java:1841)
    at org.eclipse.persistence.internal.sessions.AbstractSession.executeQuery(AbstractSession.java:1823)
    at org.eclipse.persistence.internal.sessions.AbstractSession.executeQuery(AbstractSession.java:1773)
    at org.eclipse.persistence.internal.sessions.AbstractSession.priviledgedExecuteNonSelectingCall(AbstractSession.java:5055)
    at org.eclipse.persistence.tools.schemaframework.DatabaseObjectDefinition.createOnDatabase(DatabaseObjectDefinition.java:205)
    at org.eclipse.persistence.tools.schemaframework.SchemaManager.createObject(SchemaManager.java:224)
    at org.eclipse.persistence.tools.schemaframework.TableCreator.createTables(TableCreator.java:189)
    at org.eclipse.persistence.tools.schemaframework.TableCreator.createTables(TableCreator.java:159)
    at org.eclipse.persistence.tools.schemaframework.TableCreator.createTables(TableCreator.java:151)
    at org.eclipse.persistence.tools.schemaframework.SchemaManager.createDefaultTables(SchemaManager.java:1034)
    at org.eclipse.persistence.internal.jpa.EntityManagerFactoryProvider.generateDefaultTables(EntityManagerFactoryProvider.java:116)
    at org.eclipse.persistence.internal.jpa.EntityManagerSetupImpl.writeDDLToDatabase(EntityManagerSetupImpl.java:4731)
    at org.eclipse.persistence.internal.jpa.EntityManagerSetupImpl.writeMetadataDDLToDatabase(EntityManagerSetupImpl.java:4798)
    at org.eclipse.persistence.internal.jpa.EntityManagerSetupImpl.writeDDL(EntityManagerSetupImpl.java:4697)
    at org.eclipse.persistence.internal.jpa.EntityManagerSetupImpl.writeDDL(EntityManagerSetupImpl.java:4570)
    at org.eclipse.persistence.internal.jpa.EntityManagerSetupImpl.deploy(EntityManagerSetupImpl.java:816)
    at org.eclipse.persistence.internal.jpa.EntityManagerFactoryDelegate.getAbstractSession(EntityManagerFactoryDelegate.java:221)
    at org.eclipse.persistence.internal.jpa.EntityManagerFactoryDelegate.getDatabaseSession(EntityManagerFactoryDelegate.java:199)
    at org.eclipse.persistence.internal.jpa.EntityManagerFactoryImpl.getDatabaseSession(EntityManagerFactoryImpl.java:534)
    at org.eclipse.persistence.jpa.PersistenceProvider.createContainerEntityManagerFactoryImpl(PersistenceProvider.java:385)
    at org.eclipse.persistence.jpa.PersistenceProvider.createContainerEntityManagerFactory(PersistenceProvider.java:313)
    at org.glassfish.persistence.jpa.PersistenceUnitLoader.loadPU(PersistenceUnitLoader.java:222)
    at org.glassfish.persistence.jpa.PersistenceUnitLoader.<init>(PersistenceUnitLoader.java:126)
    at org.glassfish.persistence.jpa.JPADeployer$1.visitPUD(JPADeployer.java:318)
    at org.glassfish.persistence.jpa.JPADeployer$PersistenceUnitDescriptorIterator.iteratePUDs(JPADeployer.java:545)
    at org.glassfish.persistence.jpa.JPADeployer.createEMFs(JPADeployer.java:325)
    at org.glassfish.persistence.jpa.JPADeployer.prepare(JPADeployer.java:168)
    at com.sun.enterprise.v3.server.ApplicationLifecycle.prepareModule(ApplicationLifecycle.java:984)
    at com.sun.enterprise.v3.server.ApplicationLifecycle.deploy(ApplicationLifecycle.java:467)
    at com.sun.enterprise.v3.server.ApplicationLifecycle.deploy(ApplicationLifecycle.java:257)
    at org.glassfish.deployment.admin.DeployCommand.execute(DeployCommand.java:471)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$2$1.run(CommandRunnerImpl.java:569)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$2$1.run(CommandRunnerImpl.java:565)
    at java.base/java.security.AccessController.doPrivileged(AccessController.java:400)
    at java.base/javax.security.auth.Subject.doAs(Subject.java:453)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$2.execute(CommandRunnerImpl.java:564)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$3.run(CommandRunnerImpl.java:595)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$3.run(CommandRunnerImpl.java:587)
    at java.base/java.security.AccessController.doPrivileged(AccessController.java:400)
    at java.base/javax.security.auth.Subject.doAs(Subject.java:453)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl.doCommand(CommandRunnerImpl.java:586)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl.doCommand(CommandRunnerImpl.java:1477)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$ExecutionContext.execute(CommandRunnerImpl.java:1846)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$ExecutionContext.execute(CommandRunnerImpl.java:1722)
    at com.sun.enterprise.v3.admin.AdminAdapter.doCommand(AdminAdapter.java:536)
    at com.sun.enterprise.v3.admin.AdminAdapter.onMissingResource(AdminAdapter.java:223)
    at org.glassfish.grizzly.http.server.StaticHttpHandlerBase.service(StaticHttpHandlerBase.java:150)
    at com.sun.enterprise.v3.services.impl.ContainerMapper$HttpHandlerCallable.call(ContainerMapper.java:425)
    at com.sun.enterprise.v3.services.impl.ContainerMapper.service(ContainerMapper.java:144)
    at org.glassfish.grizzly.http.server.HttpHandler.runService(HttpHandler.java:174)
    at org.glassfish.grizzly.http.server.HttpHandler.doHandle(HttpHandler.java:153)
    at org.glassfish.grizzly.http.server.HttpServerFilter.handleRead(HttpServerFilter.java:196)
    at org.glassfish.grizzly.filterchain.ExecutorResolver$9.execute(ExecutorResolver.java:88)
    at org.glassfish.grizzly.filterchain.DefaultFilterChain.executeFilter(DefaultFilterChain.java:246)
    at org.glassfish.grizzly.filterchain.DefaultFilterChain.executeChainPart(DefaultFilterChain.java:178)
    at org.glassfish.grizzly.filterchain.DefaultFilterChain.execute(DefaultFilterChain.java:118)
    at org.glassfish.grizzly.filterchain.DefaultFilterChain.process(DefaultFilterChain.java:96)
    at org.glassfish.grizzly.ProcessorExecutor.execute(ProcessorExecutor.java:51)
    at org.glassfish.grizzly.nio.transport.TCPNIOTransport.fireIOEvent(TCPNIOTransport.java:510)
    at org.glassfish.grizzly.strategies.AbstractIOStrategy.fireIOEvent(AbstractIOStrategy.java:82)
    at org.glassfish.grizzly.strategies.WorkerThreadIOStrategy.run0(WorkerThreadIOStrategy.java:83)
    at org.glassfish.grizzly.strategies.WorkerThreadIOStrategy$WorkerThreadRunnable.run(WorkerThreadIOStrategy.java:101)
    at org.glassfish.grizzly.threadpool.AbstractThreadPool$Worker.doWork(AbstractThreadPool.java:535)
    at org.glassfish.grizzly.threadpool.AbstractThreadPool$Worker.run(AbstractThreadPool.java:515)
    at java.base/java.lang.Thread.run(Thread.java:1583)
Caused by: java.sql.SQLSyntaxErrorException: Error de sintaxis: Encountered "USER" at line 1, column 14.
    at org.apache.derby.client.am.SQLExceptionFactory.getSQLException(SQLExceptionFactory.java:94)
    at org.apache.derby.client.am.SqlException.getSQLException(SqlException.java:325)
    at org.apache.derby.client.am.ClientConnection.prepareStatement(ClientConnection.java:448)
    at com.sun.gjc.spi.base.ConnectionHolder.prepareStatement(ConnectionHolder.java:497)
    at org.eclipse.persistence.internal.databaseaccess.DatabaseAccessor.prepareStatement(DatabaseAccessor.java:1750)
    at org.eclipse.persistence.internal.databaseaccess.DatabaseAccessor.prepareStatement(DatabaseAccessor.java:1697)
    at org.eclipse.persistence.internal.databaseaccess.DatabaseCall.prepareStatement(DatabaseCall.java:770)
    at org.eclipse.persistence.internal.databaseaccess.DatabaseAccessor.basicExecuteCall(DatabaseAccessor.java:630)
    ... 75 more
Caused by: ERROR 42X01: Error de sintaxis: Encountered "USER" at line 1, column 14.
    at org.apache.derby.client.am.ClientStatement.completeSqlca(ClientStatement.java:2116)
    at org.apache.derby.client.net.NetStatementReply.parsePrepareError(NetStatementReply.java:579)
    at org.apache.derby.client.net.NetStatementReply.parsePRPSQLSTTreply(NetStatementReply.java:145)
    at org.apache.derby.client.net.NetStatementReply.readPrepareDescribeOutput(NetStatementReply.java:54)
    at org.apache.derby.client.net.StatementReply.readPrepareDescribeOutput(StatementReply.java:41)
    at org.apache.derby.client.net.NetStatement.readPrepareDescribeOutput_(NetStatement.java:156)
    at org.apache.derby.client.am.ClientStatement.readPrepareDescribeOutput(ClientStatement.java:1702)
    at org.apache.derby.client.am.ClientPreparedStatement.readPrepareDescribeInputOutput(ClientPreparedStatement.java:1914)
    at org.apache.derby.client.am.ClientPreparedStatement.flowPrepareDescribeInputOutput(ClientPreparedStatement.java:1977)
    at org.apache.derby.client.am.ClientPreparedStatement.prepare(ClientPreparedStatement.java:315)
    at org.apache.derby.client.am.ClientConnection.prepareStatementX(ClientConnection.java:1956)
    at org.apache.derby.client.am.ClientConnection.prepareStatement(ClientConnection.java:435)
    ... 80 more
|#]
  Local Exception Stack: 
Exception [EclipseLink-4002] (Eclipse Persistence Services - 4.0.2.v202306161219): org.eclipse.persistence.exceptions.DatabaseException
Internal Exception: java.sql.SQLSyntaxErrorException: Error de sintaxis: Encountered "ORDER" at line 1, column 14.
Error Code: 30000
Call: CREATE TABLE ORDER (IDORDER BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL, DATE TIMESTAMP, STATE VARCHAR(255), TOTAL FLOAT, idUser BIGINT, PRIMARY KEY (IDORDER))
Query: DataModifyQuery(sql="CREATE TABLE ORDER (IDORDER BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL, DATE TIMESTAMP, STATE VARCHAR(255), TOTAL FLOAT, idUser BIGINT, PRIMARY KEY (IDORDER))")
    at org.eclipse.persistence.exceptions.DatabaseException.sqlException(DatabaseException.java:343)
    at org.eclipse.persistence.internal.databaseaccess.DatabaseAccessor.basicExecuteCall(DatabaseAccessor.java:702)
    at org.eclipse.persistence.internal.databaseaccess.DatabaseAccessor.executeCall(DatabaseAccessor.java:569)
    at org.eclipse.persistence.internal.sessions.AbstractSession.basicExecuteCall(AbstractSession.java:2048)
    at org.eclipse.persistence.sessions.server.ServerSession.executeCall(ServerSession.java:611)
    at org.eclipse.persistence.internal.queries.DatasourceCallQueryMechanism.executeCall(DatasourceCallQueryMechanism.java:280)
    at org.eclipse.persistence.internal.queries.DatasourceCallQueryMechanism.executeCall(DatasourceCallQueryMechanism.java:266)
    at org.eclipse.persistence.internal.queries.DatasourceCallQueryMechanism.executeNoSelectCall(DatasourceCallQueryMechanism.java:323)
    at org.eclipse.persistence.internal.queries.DatasourceCallQueryMechanism.executeNoSelect(DatasourceCallQueryMechanism.java:294)
    at org.eclipse.persistence.queries.DataModifyQuery.executeDatabaseQuery(DataModifyQuery.java:88)
    at org.eclipse.persistence.queries.DatabaseQuery.execute(DatabaseQuery.java:913)
    at org.eclipse.persistence.internal.sessions.AbstractSession.internalExecuteQuery(AbstractSession.java:3308)
    at org.eclipse.persistence.internal.sessions.AbstractSession.executeQuery(AbstractSession.java:1841)
    at org.eclipse.persistence.internal.sessions.AbstractSession.executeQuery(AbstractSession.java:1823)
    at org.eclipse.persistence.internal.sessions.AbstractSession.executeQuery(AbstractSession.java:1773)
    at org.eclipse.persistence.internal.sessions.AbstractSession.priviledgedExecuteNonSelectingCall(AbstractSession.java:5055)
    at org.eclipse.persistence.tools.schemaframework.DatabaseObjectDefinition.createOnDatabase(DatabaseObjectDefinition.java:205)
    at org.eclipse.persistence.tools.schemaframework.SchemaManager.createObject(SchemaManager.java:224)
    at org.eclipse.persistence.tools.schemaframework.TableCreator.createTables(TableCreator.java:189)
    at org.eclipse.persistence.tools.schemaframework.TableCreator.createTables(TableCreator.java:159)
    at org.eclipse.persistence.tools.schemaframework.TableCreator.createTables(TableCreator.java:151)
    at org.eclipse.persistence.tools.schemaframework.SchemaManager.createDefaultTables(SchemaManager.java:1034)
    at org.eclipse.persistence.internal.jpa.EntityManagerFactoryProvider.generateDefaultTables(EntityManagerFactoryProvider.java:116)
    at org.eclipse.persistence.internal.jpa.EntityManagerSetupImpl.writeDDLToDatabase(EntityManagerSetupImpl.java:4731)
    at org.eclipse.persistence.internal.jpa.EntityManagerSetupImpl.writeMetadataDDLToDatabase(EntityManagerSetupImpl.java:4798)
    at org.eclipse.persistence.internal.jpa.EntityManagerSetupImpl.writeDDL(EntityManagerSetupImpl.java:4697)
    at org.eclipse.persistence.internal.jpa.EntityManagerSetupImpl.writeDDL(EntityManagerSetupImpl.java:4570)
    at org.eclipse.persistence.internal.jpa.EntityManagerSetupImpl.deploy(EntityManagerSetupImpl.java:816)
    at org.eclipse.persistence.internal.jpa.EntityManagerFactoryDelegate.getAbstractSession(EntityManagerFactoryDelegate.java:221)
    at org.eclipse.persistence.internal.jpa.EntityManagerFactoryDelegate.getDatabaseSession(EntityManagerFactoryDelegate.java:199)
    at org.eclipse.persistence.internal.jpa.EntityManagerFactoryImpl.getDatabaseSession(EntityManagerFactoryImpl.java:534)
    at org.eclipse.persistence.jpa.PersistenceProvider.createContainerEntityManagerFactoryImpl(PersistenceProvider.java:385)
    at org.eclipse.persistence.jpa.PersistenceProvider.createContainerEntityManagerFactory(PersistenceProvider.java:313)
    at org.glassfish.persistence.jpa.PersistenceUnitLoader.loadPU(PersistenceUnitLoader.java:222)
    at org.glassfish.persistence.jpa.PersistenceUnitLoader.<init>(PersistenceUnitLoader.java:126)
    at org.glassfish.persistence.jpa.JPADeployer$1.visitPUD(JPADeployer.java:318)
    at org.glassfish.persistence.jpa.JPADeployer$PersistenceUnitDescriptorIterator.iteratePUDs(JPADeployer.java:545)
    at org.glassfish.persistence.jpa.JPADeployer.createEMFs(JPADeployer.java:325)
    at org.glassfish.persistence.jpa.JPADeployer.prepare(JPADeployer.java:168)
    at com.sun.enterprise.v3.server.ApplicationLifecycle.prepareModule(ApplicationLifecycle.java:984)
    at com.sun.enterprise.v3.server.ApplicationLifecycle.deploy(ApplicationLifecycle.java:467)
    at com.sun.enterprise.v3.server.ApplicationLifecycle.deploy(ApplicationLifecycle.java:257)
    at org.glassfish.deployment.admin.DeployCommand.execute(DeployCommand.java:471)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$2$1.run(CommandRunnerImpl.java:569)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$2$1.run(CommandRunnerImpl.java:565)
    at java.base/java.security.AccessController.doPrivileged(AccessController.java:400)
    at java.base/javax.security.auth.Subject.doAs(Subject.java:453)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$2.execute(CommandRunnerImpl.java:564)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$3.run(CommandRunnerImpl.java:595)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$3.run(CommandRunnerImpl.java:587)
    at java.base/java.security.AccessController.doPrivileged(AccessController.java:400)
    at java.base/javax.security.auth.Subject.doAs(Subject.java:453)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl.doCommand(CommandRunnerImpl.java:586)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl.doCommand(CommandRunnerImpl.java:1477)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$ExecutionContext.execute(CommandRunnerImpl.java:1846)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$ExecutionContext.execute(CommandRunnerImpl.java:1722)
    at com.sun.enterprise.v3.admin.AdminAdapter.doCommand(AdminAdapter.java:536)
    at com.sun.enterprise.v3.admin.AdminAdapter.onMissingResource(AdminAdapter.java:223)
    at org.glassfish.grizzly.http.server.StaticHttpHandlerBase.service(StaticHttpHandlerBase.java:150)
    at com.sun.enterprise.v3.services.impl.ContainerMapper$HttpHandlerCallable.call(ContainerMapper.java:425)
    at com.sun.enterprise.v3.services.impl.ContainerMapper.service(ContainerMapper.java:144)
    at org.glassfish.grizzly.http.server.HttpHandler.runService(HttpHandler.java:174)
    at org.glassfish.grizzly.http.server.HttpHandler.doHandle(HttpHandler.java:153)
    at org.glassfish.grizzly.http.server.HttpServerFilter.handleRead(HttpServerFilter.java:196)
    at org.glassfish.grizzly.filterchain.ExecutorResolver$9.execute(ExecutorResolver.java:88)
    at org.glassfish.grizzly.filterchain.DefaultFilterChain.executeFilter(DefaultFilterChain.java:246)
    at org.glassfish.grizzly.filterchain.DefaultFilterChain.executeChainPart(DefaultFilterChain.java:178)
    at org.glassfish.grizzly.filterchain.DefaultFilterChain.execute(DefaultFilterChain.java:118)
    at org.glassfish.grizzly.filterchain.DefaultFilterChain.process(DefaultFilterChain.java:96)
    at org.glassfish.grizzly.ProcessorExecutor.execute(ProcessorExecutor.java:51)
    at org.glassfish.grizzly.nio.transport.TCPNIOTransport.fireIOEvent(TCPNIOTransport.java:510)
    at org.glassfish.grizzly.strategies.AbstractIOStrategy.fireIOEvent(AbstractIOStrategy.java:82)
    at org.glassfish.grizzly.strategies.WorkerThreadIOStrategy.run0(WorkerThreadIOStrategy.java:83)
    at org.glassfish.grizzly.strategies.WorkerThreadIOStrategy$WorkerThreadRunnable.run(WorkerThreadIOStrategy.java:101)
    at org.glassfish.grizzly.threadpool.AbstractThreadPool$Worker.doWork(AbstractThreadPool.java:535)
    at org.glassfish.grizzly.threadpool.AbstractThreadPool$Worker.run(AbstractThreadPool.java:515)
    at java.base/java.lang.Thread.run(Thread.java:1583)
Caused by: java.sql.SQLSyntaxErrorException: Error de sintaxis: Encountered "ORDER" at line 1, column 14.
    at org.apache.derby.client.am.SQLExceptionFactory.getSQLException(SQLExceptionFactory.java:94)
    at org.apache.derby.client.am.SqlException.getSQLException(SqlException.java:325)
    at org.apache.derby.client.am.ClientConnection.prepareStatement(ClientConnection.java:448)
    at com.sun.gjc.spi.base.ConnectionHolder.prepareStatement(ConnectionHolder.java:497)
    at org.eclipse.persistence.internal.databaseaccess.DatabaseAccessor.prepareStatement(DatabaseAccessor.java:1750)
    at org.eclipse.persistence.internal.databaseaccess.DatabaseAccessor.prepareStatement(DatabaseAccessor.java:1697)
    at org.eclipse.persistence.internal.databaseaccess.DatabaseCall.prepareStatement(DatabaseCall.java:770)
    at org.eclipse.persistence.internal.databaseaccess.DatabaseAccessor.basicExecuteCall(DatabaseAccessor.java:630)
    ... 75 more
Caused by: ERROR 42X01: Error de sintaxis: Encountered "ORDER" at line 1, column 14.
    at org.apache.derby.client.am.ClientStatement.completeSqlca(ClientStatement.java:2116)
    at org.apache.derby.client.net.NetStatementReply.parsePrepareError(NetStatementReply.java:579)
    at org.apache.derby.client.net.NetStatementReply.parsePRPSQLSTTreply(NetStatementReply.java:145)
    at org.apache.derby.client.net.NetStatementReply.readPrepareDescribeOutput(NetStatementReply.java:54)
    at org.apache.derby.client.net.StatementReply.readPrepareDescribeOutput(StatementReply.java:41)
    at org.apache.derby.client.net.NetStatement.readPrepareDescribeOutput_(NetStatement.java:156)
    at org.apache.derby.client.am.ClientStatement.readPrepareDescribeOutput(ClientStatement.java:1702)
    at org.apache.derby.client.am.ClientPreparedStatement.readPrepareDescribeInputOutput(ClientPreparedStatement.java:1914)
    at org.apache.derby.client.am.ClientPreparedStatement.flowPrepareDescribeInputOutput(ClientPreparedStatement.java:1977)
    at org.apache.derby.client.am.ClientPreparedStatement.prepare(ClientPreparedStatement.java:315)
    at org.apache.derby.client.am.ClientConnection.prepareStatementX(ClientConnection.java:1956)
    at org.apache.derby.client.am.ClientConnection.prepareStatement(ClientConnection.java:435)
    ... 80 more
|#]
  Local Exception Stack: 
Exception [EclipseLink-4002] (Eclipse Persistence Services - 4.0.2.v202306161219): org.eclipse.persistence.exceptions.DatabaseException
Internal Exception: java.sql.SQLSyntaxErrorException: Error de sintaxis: Encountered "ORDER" at line 1, column 13.
Error Code: 30000
Call: ALTER TABLE ORDER ADD CONSTRAINT FK_ORDER_idUser FOREIGN KEY (idUser) REFERENCES USER (IDUSER)
Query: DataModifyQuery(sql="ALTER TABLE ORDER ADD CONSTRAINT FK_ORDER_idUser FOREIGN KEY (idUser) REFERENCES USER (IDUSER)")
    at org.eclipse.persistence.exceptions.DatabaseException.sqlException(DatabaseException.java:343)
    at org.eclipse.persistence.internal.databaseaccess.DatabaseAccessor.basicExecuteCall(DatabaseAccessor.java:702)
    at org.eclipse.persistence.internal.databaseaccess.DatabaseAccessor.executeCall(DatabaseAccessor.java:569)
    at 

And then
Exception while invoking class com.sun.enterprise.web.WebApplication start method
java.lang.Exception: java.lang.IllegalStateException: ContainerBase.addChild: start: org.apache.catalina.LifecycleException: java.lang.IllegalStateException: CDI is not available
    at com.sun.enterprise.web.WebApplication.start(WebApplication.java:116)
    at org.glassfish.internal.data.EngineRef.start(EngineRef.java:97)
    at org.glassfish.internal.data.ModuleInfo.start(ModuleInfo.java:262)
    at org.glassfish.internal.data.ApplicationInfo.start(ApplicationInfo.java:353)
    at com.sun.enterprise.v3.server.ApplicationLifecycle.deploy(ApplicationLifecycle.java:533)
    at com.sun.enterprise.v3.server.ApplicationLifecycle.deploy(ApplicationLifecycle.java:257)
    at org.glassfish.deployment.admin.DeployCommand.execute(DeployCommand.java:471)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$2$1.run(CommandRunnerImpl.java:569)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$2$1.run(CommandRunnerImpl.java:565)
    at java.base/java.security.AccessController.doPrivileged(AccessController.java:400)
    at java.base/javax.security.auth.Subject.doAs(Subject.java:453)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$2.execute(CommandRunnerImpl.java:564)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$3.run(CommandRunnerImpl.java:595)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$3.run(CommandRunnerImpl.java:587)
    at java.base/java.security.AccessController.doPrivileged(AccessController.java:400)
    at java.base/javax.security.auth.Subject.doAs(Subject.java:453)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl.doCommand(CommandRunnerImpl.java:586)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl.doCommand(CommandRunnerImpl.java:1477)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$ExecutionContext.execute(CommandRunnerImpl.java:1846)
    at com.sun.enterprise.v3.admin.CommandRunnerImpl$ExecutionContext.execute(CommandRunnerImpl.java:1722)
    at org.glassfish.grizzly.http.server.HttpHandler.runService(HttpHandler.java:174)
    at org.glassfish.grizzly.http.server.HttpHandler.doHandle(HttpHandler.java:153)
    at org.glassfish.grizzly.http.server.HttpServerFilter.handleRead(HttpServerFilter.java:196)
    at org.glassfish.grizzly.filterchain.ExecutorResolver$9.execute(ExecutorResolver.java:88)
    at org.glassfish.grizzly.filterchain.DefaultFilterChain.executeFilter(DefaultFilterChain.java:246)
    at org.glassfish.grizzly.filterchain.DefaultFilterChain.executeChainPart(DefaultFilterChain.java:178)
    at org.glassfish.grizzly.filterchain.DefaultFilterChain.execute(DefaultFilterChain.java:118)
    at org.glassfish.grizzly.filterchain.DefaultFilterChain.process(DefaultFilterChain.java:96)
    at org.glassfish.grizzly.ProcessorExecutor.execute(ProcessorExecutor.java:51)
    at org.glassfish.grizzly.nio.transport.TCPNIOTransport.fireIOEvent(TCPNIOTransport.java:510)
    at org.glassfish.grizzly.strategies.AbstractIOStrategy.fireIOEvent(AbstractIOStrategy.java:82)
    at org.glassfish.grizzly.strategies.WorkerThreadIOStrategy.run0(WorkerThreadIOStrategy.java:83)
    at org.glassfish.grizzly.strategies.WorkerThreadIOStrategy$WorkerThreadRunnable.run(WorkerThreadIOStrategy.java:101)
    at org.glassfish.grizzly.threadpool.AbstractThreadPool$Worker.doWork(AbstractThreadPool.java:535)

Keep in mind, I''m a first year college student so I''m not experienced at all.
Now I get this error:

/index.xhtml Not Found in ExternalContext as a Resource

I looked it up and some people said it was because of the structure of the project, here''s mine:

C:.
│   build.xml
│
├───build
│   ├───empty
│   ├───generated-sources
│   │   └───ap-source-output
│   └───web
│       │   gfv700ee10.dpf
│       │   index.html
│       │
│       ├───css
│       │       main.css
│       │
│       ├───js
│       │       functions.js
│       │
│       ├───META-INF
│       │       MANIFEST.MF
│       │
│       └───WEB-INF
│           │   glassfish-web.xml
│           │
│           ├───classes
│           │   │   .netbeans_automatic_build
│           │   │   .netbeans_update_resources
│           │   │
│           │   ├───daw
│           │   │   ├───controllers
│           │   │   │       ProductController.class
│           │   │   │
│           │   │   └───model
│           │   │           Product.class
│           │   │
│           │   └───META-INF
│           │           persistence.xml
│           │
│           └───views
│                   error.jsp
│                   formProduct.jsp
│                   products.jsp
│
├───nbproject
│   │   ant-deploy.xml
│   │   build-impl.xml
│   │   genfiles.properties
│   │   project.properties
│   │   project.xml
│   │
│   └───private
│           private.properties
│           private.xml
│
├───setup
│       glassfish-resources.xml
│
├───src
│   ├───conf
│   │       MANIFEST.MF
│   │       persistence.xml
│   │
│   └───java
│       └───daw
│           ├───controllers
│           │       ProductController.java
│           │
│           └───model
│                   Product.java
│
├───test
└───web
    │   index.html
    │
    ├───css
    │       main.css
    │
    ├───js
    │       functions.js
    │
    └───WEB-INF
        │   glassfish-web.xml
        │
        └───views
                error.jsp
                formProduct.jsp

', '["java", "sql", "jdbc", "derby"]', '2024-11-15 10:08:58', '2024-11-16 19:11:31', 39, 0, 1, 0, 18568045, null),
        (79190927, 'Getting Object does not exist at location. Code: -13010 HttpResult: 404 Error trying to add an image to Firebase Storage', 'I''m using Android Studio with Java to make an android app, I''m trying to let the user pick an image from their gallery then upload that to firebase but I keep getting this error. I''ve already configured by rules properly from the console. I suspect it may have to do with permissions, I''ve put ACCES_NETWORK_STATE in my manifest but still getting this error. I''ve used the Android Studio debugger and both the reference and URI are defined and seem to look as expected.
This is the relevant code from the activity that I''m trying to upload from

private ActivityResultLauncher<Intent> resultLauncher;
private ActivityResultLauncher<PickVisualMediaRequest> pickMedia;
...
@Override
protected void onCreate(Bundle savedInstanceState) {
    ...
    imageUri = null;
    ...
    storage = FirebaseStorage.getInstance();
    storageReference = storage.getReference(Listing.LISTING_PATH);
    //The picker for photos
    pickMedia = registerForActivityResult(new ActivityResultContracts.PickVisualMedia(), uri -> {
        // Callback is invoked after the user selects a media item or closes the
        // photo picker.
        if (uri != null) {
            imageUri = uri;
            if(imageView!= null) imageView.setImageURI(uri);
        } else {
            Log.d("PhotoPicker", "No media selected");
            Toast.makeText(getApplicationContext(), "No media selected", Toast.LENGTH_SHORT).show();
        }
    });
...
}
//Method that shows a dialog which the user picks an image from
private void showAddListingDialog() {
    ...

    final Button chooseImage = dialogView.findViewById(R.id.chooseImageButton);
    imageView = dialogView.findViewById(R.id.image);
    ...
    final AlertDialog dialog = dialogBuilder.create();
    dialog.show();

    chooseImage.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View view) {

            pickMedia.launch(new PickVisualMediaRequest.Builder()
                    .setMediaType(ActivityResultContracts.PickVisualMedia.ImageOnly.INSTANCE)
                    .build());
        }
    });

    buttonAdd.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            ...
                if(imageUri != null) uploadPicture();
                dialog.dismiss();
            } else {
                Toast.makeText(ListingActivity.this, "Please fill out all fields", Toast.LENGTH_SHORT).show();
            }
        }
    });
}

//Method that adds picture to storage
private void uploadPicture(){
    StorageReference pictureReference = storageReference.child(category.getId()+".jpg");

    pictureReference.putFile(imageUri).addOnFailureListener(new OnFailureListener() {
        @Override
        public void onFailure(@NonNull Exception exception) {
            // Handle unsuccessful uploads
            Toast.makeText(ListingActivity.this, "Could not store image", Toast.LENGTH_LONG).show();
            System.out.println(exception.getMessage());

        }
    }).addOnSuccessListener(new OnSuccessListener<UploadTask.TaskSnapshot>() {
        @Override
        public void onSuccess(UploadTask.TaskSnapshot taskSnapshot) {
            // taskSnapshot.getMetadata() contains file metadata such as size, content-type, etc.
            Toast.makeText(ListingActivity.this, "Successfully stored image", Toast.LENGTH_SHORT).show();
        }
    });
}

My manifest permission
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
', '["java", "firebase"]', '2024-11-15 10:13:07', '2024-11-15 10:13:07', 21, 0, 0, 0, 28308244, null),
        (79190949, 'Rogue-like game: Why aren&#39;t my Hero and Enemy attacking in turns and inflicting damage into one another when they collide?', 'I''m developing a Rogue-like game in Java and I''m having trouble with the attack feature. Hero and enemies should attack in turns but the enemy moves at the same time I move my Hero and when the hero tries to attack the enemy (by going in his direction) it''s the Hero that takes the damage. I''m posting the classes that are associated with this logic.
public class Engine {
    private Hero hero;
    private StatusBar statusBar;
    private int BOARD_HEIGHT = 10;
    private int BOARD_WIDTH = 10;
    private List<List<GameObject>> allRooms;
    private List<GameObject> gameObjects;
    private int currentRoomIndex = 0;

    public Engine() {
        this.statusBar = new StatusBar();
        List<String> roomPaths = Arrays.asList("rooms/room0.txt", "rooms/room1.txt", "rooms/room2.txt");
        allRooms = new ArrayList<>();

        for (String path : roomPaths) {
            allRooms.add(Room.loadRoom(path));
        }
    }

    private void loadRoom(List<GameObject> roomObjects) {
        ImageMatrixGUI.getInstance().clearImages();
        ImageMatrixGUI.getInstance().newImages(roomObjects);
        this.gameObjects = roomObjects;
    }

    public void removeObject(GameObject obj) {
        gameObjects.remove(obj);
        ImageMatrixGUI.getInstance().removeImage(obj);
        System.out.println(obj.getName() + " was removed from the game.");
    }

    public void notify(int keyPressed) {
        Direction direction = null;
        switch (keyPressed) {
            case KeyEvent.VK_UP:
                direction = Direction.UP;
                break;
            case KeyEvent.VK_DOWN:
                direction = Direction.DOWN;
                break;
            case KeyEvent.VK_LEFT:
                direction = Direction.LEFT;
                break;
            case KeyEvent.VK_RIGHT:
                direction = Direction.RIGHT;
                break;
        }

        if (direction != null) {
            Position newHeroPosition = hero.move(direction, this);
            if (isValidMove(newHeroPosition)) {
                hero.setPosition(newHeroPosition);
            }

            for (GameObject obj : new ArrayList<>(gameObjects)) {
                if (obj instanceof MovingObject && obj != hero) {
                    MovingObject enemy = (MovingObject) obj;
                    Position enemyNewPosition = enemy.move(this);

                    if (enemyNewPosition.equals(hero.getPosition())) {
                        enemy.attack(hero);
                    }
                }
            }
        }
    }

    public boolean isValidMove(Position newPosition) {
        for (GameObject obj : gameObjects) {
            if (obj.getPosition().equals(newPosition) && !obj.isTransposable()) {
                return false;
            }
        }
        return true;
    }

    public GameObject getObjectAtPosition(Position position) {
        for (GameObject obj : gameObjects) {
            if (obj.getPosition().equals(position)) {
                return obj;
            }
        }
        return null;
    }

    public Hero getHero() {
        return hero;
    }

    public void init() {
        ImageMatrixGUI gui = ImageMatrixGUI.getInstance();

        gameObjects = allRooms.get(currentRoomIndex);
        loadRoom(gameObjects);

        hero = new Hero(new Position(5, 3), 1, statusBar);
        gameObjects.add(hero);

        statusBar = new StatusBar();
        List<ImageTile> bar = statusBar.getBarTiles();

        gui.setEngine(this);
        gui.newStatusImages(bar);
        gui.newImages(gameObjects);
        gui.go();

        gui.setStatus("Game has started");

        while (true) {
            gui.update();
        }
    }

    public static void main(String[] args) {
        Engine engine = new Engine();
        engine.init();
    }
}

public abstract class MovingObject extends GameObject {
    protected static final List<Direction> DIRECTIONS = Arrays.asList(Direction.UP, Direction.DOWN, Direction.LEFT, Direction.RIGHT);
    protected static final Random RANDOM = new Random();
    private int damage;
    private int health;

    public MovingObject(Position position, int damage, int health) {
        super(position);
        this.damage = damage;
        this.health = health;
    }

    public MovingObject(Position position) {
        this(position, 1, 100);
    }

    public Position move(Engine engine) {
        Hero hero = engine.getHero();
        Position heroPosition = hero.getPosition();

        if (isNearHero(heroPosition)) {
            moveTowardsHero(heroPosition, engine);
        } else {
            moveRandomly(engine);
        }
        return getPosition();
    }

    private boolean isNearHero(Position heroPosition) {
        int distanceX = Math.abs(getPosition().getX() - heroPosition.getX());
        int distanceY = Math.abs(getPosition().getY() - heroPosition.getY());
        return distanceX <= 2 && distanceY <= 2;
    }

    private void moveRandomly(Engine engine) {
        Collections.shuffle(DIRECTIONS, RANDOM);
        for (Direction direction : DIRECTIONS) {
            Position newPosition = getPosition().plus(direction.asVector());
            if (engine.isValidMove(newPosition)) {
                setPosition(newPosition);
                break;
            }
        }
    }

    private void moveTowardsHero(Position heroPosition, Engine engine) {
        Direction moveDirection = calculateDirectionToHero(heroPosition);
        Position newPosition = getPosition().plus(moveDirection.asVector());
        if (newPosition.equals(heroPosition)) {
            attack(engine.getHero());
        } else if (engine.isValidMove(newPosition)) {
            setPosition(newPosition);
        }
    }

    private Direction calculateDirectionToHero(Position heroPosition) {
        int deltaX = heroPosition.getX() - getPosition().getX();
        int deltaY = heroPosition.getY() - getPosition().getY();

        if (Math.abs(deltaX) > Math.abs(deltaY)) {
            return deltaX > 0 ? Direction.RIGHT : Direction.LEFT;
        } else {
            return deltaY > 0 ? Direction.DOWN : Direction.UP;
        }
    }

    public void attack(Hero hero) {
        System.out.println("Enemy attacks Hero!");
        hero.takeDamage(damage);
    }

    public void takeDamage(int damage, Engine engine) {
        health -= damage;
        System.out.println(getName() + " took " + damage + " damage. Health remaining: " + health);
        if (health <= 0) {
            System.out.println(getName() + " died!");
            engine.removeObject(this); 
        }
    }

    public abstract boolean isTransposable();
    public abstract String getName();
}

public class Hero extends GameObject {
    private StatusBar statusBar;
    private int health;
    private int maxHealth = 4;
    private int damage;

    public Hero(Position position, int damage, StatusBar statusBar) {
        super(position);
        this.health = maxHealth;
        this.damage = damage;
        this.statusBar = statusBar;
    }

    public void takeDamage(int damage) {
        health -= damage;
        System.out.println(getName() + " took " + damage + " damage. Health remaining: " + health);
        if (health <= 0) {
            this.health = 0;
            System.out.println(getName() + " died!");
        }
        statusBar.updateHealth(health);
    }

    @Override
    public boolean isTransposable() {
        return false;
    }

    @Override
    public String getName() {
        return "Hero";
    }

    public Position move(Direction direction, Engine engine) {
        Position newPosition = super.getPosition().plus(direction.asVector());

        GameObject objAtNewPosition = engine.getObjectAtPosition(newPosition);
        if (objAtNewPosition instanceof MovingObject) {
            MovingObject enemy = (MovingObject) objAtNewPosition;
            System.out.println("Hero attacks the enemy!");
            enemy.takeDamage(damage, engine);
            return this.position;
        }

        return newPosition;
    }

    public int getHealth() {
        return health;
    }

    public int getDamage() {
        return damage;
    }
}

public class StatusBar {
    private final int maxHealth = 4;
    private int health = 4;
    private final List<ImageTile> bar = new ArrayList<>();


    public StatusBar() {
        initializeBar();
    }

    private void initializeBar() {

        for (int x = 0; x < 10; x++) {
            bar.add(new BlackTile(new Position(x, 0)));
        }

        for (int x = 0; x < 3; x++) {
            bar.add(new FireBall(new Position(x, 0)));
        }

        for (int x = 3; x < 7; x++) {
            bar.add(new GreenTile(new Position(x, 0)));
        }
    }

    public List<ImageTile> getBarTiles() {
        return bar;
    }

    public void updateHealth(int health) {
        bar.clear();
        initializeBar();
        for (int i = 0; i < maxHealth; i++) {
            if (i < health) {
                bar.add(new GreenTile(new Position(i + 3, 0)));
            } else {
                bar.add(new RedTile(new Position(i + 3, 0)));
            }
        }
        ImageMatrixGUI.getInstance().clearStatus();
        ImageMatrixGUI.getInstance().newStatusImages(bar);
    }
}

public abstract class GameObject implements ImageTile {
    protected Position position;

    public GameObject(Position position) {
        this.position = position;
    }

    public Position getPosition() {
        return position;
    }

    public void setPosition(Position position) {
        this.position = position;
    }

    public abstract boolean isTransposable();


    public abstract String getName();

    public void takeDamage(int damage) {
        // Logic will be handled in subclasses Hero and MovingObject
    }
}

', '["java", "oop", "game-development", "roguelike"]', '2024-11-15 10:24:07', '2024-11-15 11:05:30', 25, -3, 0, 0, 23216369, null),
        (79190985, 'Spring batching not allowing large document: &quot;Tokens in a single document exceeds the maximum number of allowed input tokens&quot;', 'I have a bunch of documents that I would like to embed as vectors and store in my postgres db. Some of these documents are very long, so I am using Spring''s BatchingStrategy to split them up. I am getting an error from the batcher that there are too many tokens in the input document... The whole point of the batcher is to split it up so there will be a usable amount of tokens in each document, how come it is erroring when it has a lot of tokens input?
import org.springframework.ai.document.Document;
import org.springframework.ai.embedding.BatchingStrategy;
import org.springframework.ai.reader.tika.TikaDocumentReader;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

@Component
public class VectorInit {

    @Autowired
    VectorStore vectorStore;

    @Autowired
    BatchingStrategy batchingStrategy;

    public void loadVectors(String folderPath) throws IOException {
        List<Document> d = new ArrayList<>();
        File folder = new File(folderPath);
        if (!folder.isDirectory()) {
            throw new IllegalArgumentException("Provided path is not a directory: " + folderPath);
        }


        Files.walk(folder.toPath())
                .filter(Files::isRegularFile)
                .forEach(f -> {
                    System.out.println("Reading file: " + f);
                    TikaDocumentReader reader = new TikaDocumentReader(new FileSystemResource(f.toFile()));
                    List<Document> readDocs = reader.read();
                    readDocs.forEach(
                            doc -> {
                                System.out.println("Read doc: " + doc.getId() + "; size: " + doc.getContent().length());
                                batchingStrategy.batch(readDocs).forEach(batch -> { // This is the line with the error
                                    System.out.println("Adding batch of size: " + batch.size());
                                    d.addAll(batch);
                                });
                            }
                    );

                });
        vectorStore.add(d);
    }
}

import com.knuddels.jtokkit.api.EncodingType;
import org.springframework.ai.embedding.BatchingStrategy;
import org.springframework.ai.embedding.TokenCountBatchingStrategy;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class EmbeddingConfig {
    @Bean
    public BatchingStrategy customTokenCountBatchingStrategy() {

        return new TokenCountBatchingStrategy(
                EncodingType.CL100K_BASE,
                8000,
                .1
        );
    }
}

Reading file: ***************.html
Read doc: ***************; size: 189772
java.lang.IllegalArgumentException: Tokens in a single document exceeds the maximum number of allowed input tokens
    at org.springframework.ai.embedding.TokenCountBatchingStrategy.batch(TokenCountBatchingStrategy.java:148)
    at ***************.vector.VectorInit.lambda$loadVectors$2(VectorInit.java:44)
    at java.base/java.lang.Iterable.forEach(Iterable.java:75)
    at ***************.vector.VectorInit.lambda$loadVectors$3(VectorInit.java:41)
    at java.base/java.util.stream.ForEachOps$ForEachOp$OfRef.accept(ForEachOps.java:184)
    at java.base/java.util.stream.ReferencePipeline$2$1.accept(ReferencePipeline.java:179)
    at java.base/java.util.stream.ReferencePipeline$3$1.accept(ReferencePipeline.java:197)
    at java.base/java.util.Iterator.forEachRemaining(Iterator.java:133)
    at java.base/java.util.Spliterators$IteratorSpliterator.forEachRemaining(Spliterators.java:1939)
    at java.base/java.util.stream.AbstractPipeline.copyInto(AbstractPipeline.java:509)
    at java.base/java.util.stream.AbstractPipeline.wrapAndCopyInto(AbstractPipeline.java:499)
    at java.base/java.util.stream.ForEachOps$ForEachOp.evaluateSequential(ForEachOps.java:151)
    at java.base/java.util.stream.ForEachOps$ForEachOp$OfRef.evaluateSequential(ForEachOps.java:174)
    at java.base/java.util.stream.AbstractPipeline.evaluate(AbstractPipeline.java:234)
    at java.base/java.util.stream.ReferencePipeline.forEach(ReferencePipeline.java:596)
    at ***************.vector.VectorInit.loadVectors(VectorInit.java:37)
...

', '["java", "spring", "openaiembeddings", "pgvector", "spring-ai"]', '2024-11-15 10:48:37', '2024-11-15 10:48:37', 16, 0, 0, 0, 14688726, null),
        (79191016, 'Referring external classpath resource files for running executable jar in java', 'I am running java application in docker container as executable jar. For example
$ java -jar MyApp.jar
This application refers the application resource files from class path. Since application resource files different for each environment, I am mounting the application resource files to the Kubernates pod for each environment separately. My application needs to refer this external mounted path for the application resources during the run time.
After googling I found that -cp  is ignored when we run as executable jar. For Example,
$ java -cp /app/resource -jar MyApp.jar
This does not work as -cp is ignored for the executable jar.
Please let me know if we have any other option. Thanks
Note: Though this is Spring Boot application, this app does not support profile based running due to framework used in the application. Application resource files I am referring are not spring boot related resource files.
', '["java", "spring"]', '2024-11-15 11:17:39', '2024-11-15 12:38:00', 21, 1, 1, 0, 14986268, null),
        (79191071, 'PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException unable to find valid certification path to requested target', 'i''m trying to get a orderId from Razorpay api through java but ended up with this error.RazorpayException: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
i have also set the razorpay.crt in my lib/security path of my jdk-18 still getting this error
', '["java", "java-8", "flutter-razorpay"]', '2024-11-15 12:09:24', '2024-11-15 12:09:24', 20, 0, 0, 0, 25342918, null),
        (79191148, 'Android - File Metadata Missing on Server during OkHttp Multipart Upload', 'I’m using OkHttp to upload an audio file from my Android app to a server. Before uploading, I verify that the file exists, is valid, and is readable. While the server seems to receive the file object, I’m getting an error that metadata like fileName and fileSize is missing.
Client Code
Here’s the code I’m using on the client side to validate the file and send it to the server as a multipart request.
  private boolean sendFileDataToServer(JSONObject sendInfoData) throws IOException, JSONException {
    Log.d(TAG, "sendFileDataToServer called");

   

    // Initialize OkHttpClient and add logging interceptor
    HttpLoggingInterceptor loggingInterceptor = new HttpLoggingInterceptor();
    loggingInterceptor.setLevel(HttpLoggingInterceptor.Level.BODY);

    OkHttpClient client = new OkHttpClient.Builder()
            .addInterceptor(loggingInterceptor)
            .build();
    Log.d(TAG, "OkHttpClient initialized with NetworkInterceptor and logging");

    // Extract file path from JSON data
    String filePath = sendInfoData.optString("audio");
    Log.d(TAG, "Extracted file path: " + filePath);
    File file = new File(filePath);

    // Initialize request body
    RequestBody requestBody;

    // If file path is "empty" or file does not exist, switch to a standard form request
    if ("empty".equals(filePath) || !file.exists() || !file.isFile() || file.length() <= 0 || !file.canRead()) {
        Log.d(TAG, "File is missing or path is ''empty''. Switching to standard form data request");

        // Set is_audio to 0 if file is missing
        sendInfoData.put("is_audio", 0);

        // Create request as form data
        FormBody.Builder formBuilder = new FormBody.Builder()
                .add("mode", "my_app")
                .add("token", "my_app");
        Log.d(TAG, "Added basic form data (mode, token)");

        // Add JSON data (excluding task_id and audio)
        Iterator<String> keys = sendInfoData.keys();
        while (keys.hasNext()) {
            String key = keys.next();
            if (!key.equals("audio") && !key.equals("task_id")) {
                formBuilder.add(key, sendInfoData.optString(key));
                Log.d(TAG, "Form data added: " + key + " = " + sendInfoData.optString(key));
            } else if (key.equals("audio")) {
                Log.d(TAG, "Skipping ''audio'' field as file is missing");
            }
        }
        requestBody = formBuilder.build();

    } else {
        Log.d(TAG, "File is valid. Preparing multipart request");

        MultipartBody.Builder formBuilder = new MultipartBody.Builder()
                .setType(MultipartBody.FORM)
                .addFormDataPart("mode", "my_app")
                .addFormDataPart("token", "my_app");
        Log.d(TAG, "Added basic form data (mode, token)");

        // Add JSON data (excluding task_id)
        Iterator<String> keys = sendInfoData.keys();
        while (keys.hasNext()) {
            String key = keys.next();
            if (!key.equals("audio") && !key.equals("task_id")) {
                formBuilder.addFormDataPart(key, sendInfoData.optString(key));
                Log.d(TAG, "Form data added: " + key + " = " + sendInfoData.optString(key));
            }
        }

        // Add file
        String fileType = URLConnection.guessContentTypeFromName(file.getName());
        Log.d(TAG, "File type: " + fileType);

        if (fileType != null) { // Add file if file type is detected
            formBuilder.addFormDataPart("audio", file.getName(),
                    RequestBody.create(file, MediaType.parse(fileType)));
            Log.d(TAG, "File added: " + file.getName() + " (" + fileType + ")");
        }

        requestBody = formBuilder.build();
    }

    // Build and send request
    Request request = new Request.Builder()
            .url("https://my_app/call_record.api")
            .post(requestBody)
            .build();
    Log.d(TAG, "Prepared server request");

    // Send request and handle response
    try (Response response = client.newCall(request).execute()) {
        Log.d(TAG, "Request sent to server");

        // Handle response
        String responseData = response.body().string();
        JSONObject result = new JSONObject(responseData);
        Log.d(TAG, "Response received from server");

        // Handle result
        if ("N".equals(result.optString("error")) && "OK".equals(result.optString("result"))) {
            Log.d(TAG, "Server operation successful: Result OK");
            return true;
        } else {
            String errorMessage = result.optString("error_msg", "Unknown error");
            Log.e(TAG, "TaskProcessor: Work failed with error: " + errorMessage);
            return false;
        }

    } catch (IOException e) {
        Log.e(TAG, "Network request failed: " + e.getMessage(), e);
        return false;

    } catch (JSONException e) {
        Log.e(TAG, "Failed to parse JSON response: " + e.getMessage(), e);
        return false;
    }
}

`
HTTP Log from the Client Side
Below is the HTTP log captured on the client side when sending the file to the server. The log suggests that metadata like the file name, type, and size were included in the request:
{
    "Request Type": "Multipart",
    "File Data Included": "Yes",
    "File Details": {
        "File Name": "audio_241106_172456.m4a",
        "File Type": "audio/mpeg",
        "File Size": "1380662 bytes"
    }
}

Server Log (Error Message)
However, on the server side, I’m seeing the following error log. It indicates that while the file object is not null, metadata like file_name and file_size is missing:
# Error saving audio file to the server. (use php)

file_name: , file_size: ,
Error_msg: File object is not null but values missing - tmp_name: , type: , size: 0,
name: audio_241106_172456.m4a

Problem Description
Client File Validation: The client validates that the file exists, is valid, and readable before uploading it to the server.
HTTP Request Log: The HTTP request log on the client side shows that file metadata is included in the request.
Server-Side Error: Despite this, the server logs indicate that file_name and file_size are empty.
Questions
Is there any possible reason why metadata could be missing when uploading a file as a multipart request using OkHttp?
Are there additional settings or steps to ensure the metadata is fully received on the server?
Any suggestions for alternative approaches to ensure the metadata is not missing?
Thank you for any help you can provide!
What I Tried
I verified the file''s existence, readability, and size before sending it. I expected the file''s metadata (such as fileName, fileSize) to be transmitted accurately to the server.
Expected Outcome
I expected the server to receive the file and all its metadata properly without any missing fields, so it could be saved successfully.
Actual Outcome
The server received the file object, but key metadata fields like file_name, file_size, and type were missing, resulting in an error indicating that these values were not included in the request.
', '["java", "android", "okhttp"]', '2024-11-15 12:54:13', '2024-11-15 18:29:46', 17, -1, 0, 0, 28295997, null),
        (79191176, 'trying to get blob image from a url using selenium and java', 'I''m trying to download an image blob from a web page. Blob url looks like : blob:https://example.com/43bdcaf9-7d30-4b80-9306-7e411533b960
The image can be downloaded and converted to base64 text if I use javascript like below (in Chrome browser and running code as a browser extension):
async function blobToBase64(blobUrl) {
    console.log(blobUrl);
    const response = await fetch(blobUrl);
    const blob = await response.blob();
    const arrayBuffer = await blob.arrayBuffer();
    const base64String = btoa(String.fromCharCode(...new Uint8Array(arrayBuffer)));
    return base64String;
}

I need the same thing to be done in Java using Selenium Chrome driver, but not able to achieve it. I have tried below code:
                    String blob = "";
                    if (driver instanceof JavascriptExecutor) {
                        blob = ((JavascriptExecutor) driver).executeScript("const response = await fetch(''" + baseUrl
                                + "'');" + "const blob = await response.blob();"
                                + "const arrayBuffer = await blob.arrayBuffer();"
                                + "const base64String = btoa(String.fromCharCode(...new Uint8Array(arrayBuffer)));"
                                + "return base64String;").toString();

                        System.out.println(blob);
                    }

but I get failed to fetch url error.
Please help to fetch the image blob and convert to base64 String
org.openqa.selenium.JavascriptException: javascript error: Failed to fetch
  (Session info: chrome=130.0.6723.91)
Build info: version: ''4.18.1'', revision: ''b1d3319b48''
System info: os.name: ''Windows 11'', os.arch: ''amd64'', os.version: ''10.0'', java.version: ''23''
Driver info: org.openqa.selenium.remote.RemoteWebDriver

Thanks in advance.
', '["javascript", "java", "selenium-webdriver"]', '2024-11-15 13:19:22', '2024-11-15 13:32:12', 20, 0, 1, 0, 1338746, null),
        (79191221, 'How to configure encrypted SSL keystore password in webapp-runner.jar (embedded tomcat)', 'I have a Java web application developed using JSP and Servlet, which I run via webapp-runner.jar to launch the WAR file. The webapp-runner.jar provides an option to enable SSL using the --enable-ssl argument, requiring -Djavax.net.ssl.keyStore and -Djavax.net.ssl.keyStorePassword parameters.
However, I want to pass an encrypted value for javax.net.ssl.keyStorePassword rather than a plain text password. It appears that webapp-runner.jar doesn’t support encrypted passwords directly.
Is there any way to achieve this? Any suggestions or workarounds to securely handle the password for SSL configuration would be greatly appreciated.
', '["java", "ssl", "embedded-tomcat-8", "embedded-tomcat", "webapp-runner"]', '2024-11-15 13:48:50', '2024-11-15 15:27:12', 22, 0, 1, 0, 10842627, null),
        (79191332, 'Junit test cases failing for static method with java.lang.NoSuchFieldError: PASCAL_CASE_TO_CAMEL_CASE error', '
creating the sqs object to publish message to sqs queue.

public final class ClientFactory {

    private SqsClientFactory() {
        throw new ConstructorCallForbiddenException();
    }
    
  
    public static AmazonSQS buildSqs(String awsRegion) {
        String regionName = Optional.ofNullable(awsRegion).filter(StringUtils::isNotBlank).orElseGet(() -> {
            var region = Regions.getCurrentRegion();
            if (region != null) {
                return region.getName();
            }
            throw SqsClientException.regionNotAvailable();
        });

        return AmazonSQSClientBuilder.standard().withRegion(regionName).build();
    }
}


This is our main class there we are sending the message to amazon sqs and method first line we are trying to set sqs mock object from UT.

@Component
@Slf4j
public class Publisher {

    public void sendMessageToSqs(String eventPayload) {
        AmazonSQS sqs = SqsClientFactory.buildSqsClient(awsRegion);
        try {
            Optional<String> eventAsJsonOpt = formatErrorEventAsJson(eventPayload);
            eventAsJsonOpt.ifPresent(eventJson -> {
                var smr = sqs.sendMessage(new SendMessageRequest()
                        .withQueueUrl(queueUrl));
                log.info("successfully published to SQS");
            });
        } catch (Exception e) {
            log.error("Message failed to post into SQS queue : {} ", e);
        }
    }
    }


there when we tried to set static method return to mock Amazon sqs then returning the error. even we tried with static approach as well then it saying return type should be MockitoStatic.Verification not Amazon sqs

@ExtendWith(MockitoExtension.class)
public class SqsPublisherTest { 

    @Mock
    private AmazonSQS sqs;

    @InjectMocks
    private Publisher publisher;

    @Test
    public void testSQSClientBuilder() {
        try (MockedStatic<AmazonSQSClientBuilder> mockedBuilder = mockStatic(AmazonSQSClientBuilder.class)) {
            AmazonSQSClientBuilder mockBuilder = mock(AmazonSQSClientBuilder.class);
            mockedBuilder.when(AmazonSQSClientBuilder::standard).thenReturn(mockBuilder);

            when(mockBuilder.withRegion("us-east-1")).thenReturn(mockBuilder);
            when(mockBuilder.build()).thenReturn(sqs);

            when(SqsClientFactory.buildSqsClient("us-east-1")).thenReturn(sqs);

            publisher.sendMessageToSqs(Mockito.anyString());
        }   
}


maven pom dependencies for junit test cases

pom.xml

        <dependency>
            <groupId>org.mockito</groupId>
            <artifactId>mockito-junit-jupiter</artifactId>
            <version>5.14.1</version>
            <scope>test</scope>
        </dependency>
        
            <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>

', '["java", "unit-testing", "junit", "mockito", "aws-sqs-fifo"]', '2024-11-15 14:48:41', '2024-11-15 14:48:41', 36, 0, 0, 0, 5132905, null),
        (79191338, 'Consumer seek resetting to latest intermediately', 'we are having a consumer logic as below. We are trying to consume multiple messages at a time , with a limitation of one message per partition.
 void consumerMessage(){
 while (!consumerService.isStopped(topic, server)) {
                processBatch(consumer,connection,topic,server);
            }}

}

 private void processBatch(Consumer<String, String> consumer, Connection connection, String topic,String server) throws Exception {
        Instant pollStartTime = Instant.now();
        Map<String,List<Integer>> topicPartitionMap = new HashMap<>();
        Map<TopicPartition, OffsetAndMetadata> partitionOffsetMap = new HashMap<>();
        boolean isSuccess;
        int messageCount = 0;
        while (Duration.between(pollStartTime, Instant.now()).compareTo(Duration.ofMinutes(MAX_POLL_DURATION)) < 0 && MAX_BATCH_SIZE > messageCount) {
            ConsumerRecords<String, String> consumerRecords = consumer.poll(10000);
            if (consumerRecords.isEmpty()) {
                continue; // Skip the iteration if there are no records
            }
            List<Integer> consumedPartition;
            for (ConsumerRecord<String, String> record : consumerRecords) {
                if (topicPartitionMap.containsKey(record.topic()) && topicPartitionMap.get(record.topic()).contains(record.partition())) {
                    continue;
                }
                consumedPartition = topicPartitionMap.containsKey(record.topic()) ? topicPartitionMap.get(record.topic()):new ArrayList<>();
                messages.add(objectMapper.readValue(record.value(), X.class));
                messageCount++;
                consumedPartition.add(record.partition());
                topicPartitionMap.put(record.topic(),consumedPartition);
                partitionOffsetMap.put(new TopicPartition(record.topic(), record.partition()),
                        new OffsetAndMetadata(record.offset()+1, "processed"));
                log.info("partition {}, offset{} , topic {}",record.partition(),record.offset(),record.topic());
                
            }
        }
        if (messageCount > 0) {
            isSuccess= upload(messages,connection,topic,server);
            if(isSuccess) {
                log.info("Consumer commit for topic  {} and size {}",topic,messages.size());
                consumer.commitSync(partitionOffsetMap);
                resetOffset(partitionOffsetMap,consumer,0);
            }else{
                resetOffset(partitionOffsetMap,consumer,-1);
            }
        } else {
            log.info("No messages received in the last 1 minute.");
        }
    }



private void resetOffset(Map<TopicPartition,OffsetAndMetadata> partitionOffsetMap, Consumer<String, String> consumer,int offsetAddition){
        Set<TopicPartition> partitions = partitionOffsetMap.keySet();
        Map<TopicPartition, Long> endOffsets = consumer.endOffsets(partitions);

        for (Map.Entry<TopicPartition, OffsetAndMetadata> entry : partitionOffsetMap.entrySet()) {
            TopicPartition partition = entry.getKey();
            OffsetAndMetadata minOffset = entry.getValue();
            long newOffset = minOffset.offset() + offsetAddition;
            long lastOffset = endOffsets.get(partition);
            log.info("consumer manifest partition -{} seek to--- {} and end is {}",partition,newOffset,lastOffset);
            if(lastOffset>=newOffset) consumer.seek(partition, newOffset);
        }
    }

At times, post successful message consumption the seek pointer is moving to latest message although the seek log prints correct in logs.
Am I doing something wrong here ?
', '["java", "apache-kafka"]', '2024-11-15 14:50:37', '2024-11-15 16:39:21', 24, 0, 0, 0, 6515403, null),
        (79191380, 'Spring Framework componentscan cannot resolve package', 'A rather strange mistake. In Intellij Idea, the string "@ComponentScan("ru.kasatchikov.test")" is highlighted in red in the Spring Config file with the inscription "componentscan cannot resolve package", while everything works correctly and when I press ctrl on "ru.kasatchikov.test", I get to the right directory. At the same time, if I change "ru.kasatchikov.test" to "test", it will no longer be highlighted in red, but the web application will not working.
maven file:
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>ru.kasatchikov.test</groupId>
  <artifactId>java-k8s-test</artifactId>
  <version>1.0-SNAPSHOT</version>
  <name>java-k8s-test Maven Webapp</name>
  <url>http://maven.apache.org</url>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <spring.version>6.1.13</spring.version>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
  </properties>

  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>

    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-core</artifactId>
      <version>${spring.version}</version>
    </dependency>

    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-context</artifactId>
      <version>${spring.version}</version>
    </dependency>

    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-web</artifactId>
      <version>${spring.version}</version>
    </dependency>

    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-webmvc</artifactId>
      <version>${spring.version}</version>
    </dependency>

    <dependency>
      <groupId>jakarta.servlet</groupId>
      <artifactId>jakarta.servlet-api</artifactId>
      <version>6.0.0</version>
      <scope>provided</scope>
    </dependency>


    <dependency>
      <groupId>org.thymeleaf</groupId>
      <artifactId>thymeleaf-spring6</artifactId>
      <version>3.1.1.RELEASE</version>
    </dependency>
  </dependencies>
  <build>
    <finalName>java-k8s-test</finalName>
  </build>
</project>

SpringConfig file:
@Configuration
@ComponentScan("ru.kasatchikov.test")
@EnableWebMvc //обеспечивает поддержку аннотаций @GetMapping и т.д.
public class SpringConfig implements WebMvcConfigurer {
    private final ApplicationContext applicationContext;
    @Autowired
    public SpringConfig(ApplicationContext applicationContext) {
        this.applicationContext = applicationContext;
    }
    @Bean
    public SpringResourceTemplateResolver templateResolver() {
        SpringResourceTemplateResolver templateResolver = new SpringResourceTemplateResolver();
        templateResolver.setApplicationContext(applicationContext);
        templateResolver.setPrefix("/WEB-INF/views");
        templateResolver.setSuffix(".html");
        templateResolver.setCharacterEncoding("UTF-8");
        return templateResolver;
    }
    @Bean
    public SpringTemplateEngine templateEngine() {
        SpringTemplateEngine templateEngine = new SpringTemplateEngine();
        templateEngine.setTemplateResolver(templateResolver());
        templateEngine.setEnableSpringELCompiler(true);
        return templateEngine;
    }
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        ThymeleafViewResolver resolver = new ThymeleafViewResolver();
        resolver.setTemplateEngine(templateEngine());
        resolver.setCharacterEncoding("UTF-8");
        registry.viewResolver(resolver);
    }
}

DispatcherServletInitializer file:
public class DispatcherServletInitializer
        extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override
    // Этот метод использовать не будем
    protected Class<?>[] getRootConfigClasses() {
        return null;
    }

    @Override
    /* Равносильно тому, как мы указывали в web.xml путь к
       ApplicationContextMVC.xml, здесь мы должны указать
       путь к SpringConfig классу
    */
    protected Class<?>[] getServletConfigClasses() {
        return new Class[] {SpringConfig.class};
    }

    @Override
    /* "/" - эквивалентно тому, что мы все запросы отправляем
       на DispatcherServlet
     */
    protected String[] getServletMappings() {
        return new String[] {"/"};
    }

    @Override // метод запускается на старте приложения, здесь мы выполняем приватный метод
    public void onStartup(ServletContext aServletContext) throws ServletException {
        super.onStartup(aServletContext);
        registerHiddenFieldFilter(aServletContext);
        registerCharacterEncodingFilter(aServletContext);
    }
    // в этом методе мы вызываем фильтр
    private void registerHiddenFieldFilter(ServletContext aContext) {
        aContext.addFilter("hiddenHttpMethodFilter",
                new HiddenHttpMethodFilter()).addMappingForUrlPatterns(null ,true, "/*");
    }
    private void registerCharacterEncodingFilter(ServletContext aContext) {
        EnumSet<DispatcherType> dispatcherTypes = EnumSet.of(DispatcherType.REQUEST, DispatcherType.FORWARD);

        CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
        characterEncodingFilter.setEncoding("UTF-8");
        characterEncodingFilter.setForceEncoding(true);

        FilterRegistration.Dynamic characterEncoding = aContext.addFilter("characterEncoding", characterEncodingFilter);
        characterEncoding.addMappingForUrlPatterns(dispatcherTypes, true, "/*");
    }
}


', '["java", "spring", "maven", "intellij-idea", "web"]', '2024-11-15 15:09:27', '2024-11-15 20:11:18', 24, 0, 0, 0, 23079649, null),
        (79191392, 'javac --patch-module doesn&#39;t work as expected at compile time', 'I want to compile my program with the use of the internal API of a modular java library which in addition is package-private. In the future I also want to fine-tune the package access at runtime to not export to all unnamed.
The library:
module com.jcraft.jsch {
  exports com.jcraft.jsch;
  ...
}
...
package com.jcraft.jsch.jzlib;
final class Deflater extends ZStream {
...
}

My sources:
module com.jcraft.jsch {
}
...
package com.jcraft.jsch.jzlib;
public class JUZJZLIBDeflater extends java.util.zip.Deflater {
    com.jcraft.jsch.jzlib.Deflater delegate;
}

As long as I try to compile a named module compilation fails. I see that --add-exports is useless in case of package-private elements, but I hoped that --patch-module would help. It also fails and I don''t understand why.
>javac  --class-path C:\\Users\\basin\\.m2\\repository\\com\\github\\mwiede\\jsch\\0.2.21\\jsch-0.2.21.jar -d target/classes src/main/java/com/jcraft/jsch/jzlib/*.java
(ok)

>javac --module-path C:\\Users\\basin\\.m2\\repository\\com\\github\\mwiede\\jsch\\0.2.21\\jsch-0.2.21.jar -d target/classes src/main/java/com/jcraft/jsch/jzlib/*.java
src\\main\\java\\com\\jcraft\\jsch\\jzlib\\JUZJZLIBDeflater.java:3: error: cannot find symbol
    com.jcraft.jsch.jzlib.Deflater delegate;
                         ^
  symbol:   class Deflater
  location: package com.jcraft.jsch.jzlib
1 error

>javac --module-path C:\\Users\\basin\\.m2\\repository\\com\\github\\mwiede\\jsch\\0.2.21\\jsch-0.2.21.jar -d target/classes --patch-module com.jcraft.jsch=src/main/java src/main/java/module-info.java src/main/java/com/jcraft/jsch/jzlib/*.java
src\\main\\java\\com\\jcraft\\jsch\\jzlib\\JUZJZLIBDeflater.java:3: error: cannot find symbol
    com.jcraft.jsch.jzlib.Deflater delegate;
                         ^
  symbol:   class Deflater
  location: package com.jcraft.jsch.jzlib
1 error

', '["java", "java-module"]', '2024-11-15 15:15:26', '2024-11-15 15:15:26', 16, 0, 0, 0, 447503, null),
        (79191438, 'Java read several kinds of csv file into list', 'I''ve written below codes. I am wondering if there is better way of doing this.
My abstract class to read csv file.
public abstract class CsvFile {

public void readCsv(String csvString) throws IllegalAccessException {

    String[] csv = csvString.split(",");
    List<Field> fields = Arrays.stream(getClass().getDeclaredFields())
            .filter(f -> f.isAnnotationPresent(CsvProp.class))
            .sorted(Comparator.comparing(o -> Integer.parseInt(o.getName().replaceAll("[^0-9]", ""))))
            .collect(Collectors.toList());

    for (int i = 0; i < fields.size(); i++) {
        Field field = fields.get(i);
        try {
            field.set(this, csv[i]);
        } catch (IndexOutOfBoundsException e) {
            field.set(this, "");
        }
    }
}

And classes that extends it.
    public class CsvType1 extends CsvFile {

    @CsvProp(name = "csvItem1")
    public String item1;

    @CsvProp(name = "csvItem2")
    public String item2;
}

public class CsvType2 extends CsvFile {

    @CsvProp(name = "csvItem1")
    public String item1;

    @CsvProp(name = "csvItem2")
    public String item2;

    @CsvProp(name = "csvItem3")
    public String item3;
}

And utility class to read file.
public class CsvUtils {
    public static List<CsvFile> readCsvFile(Class<? extends CsvFile> fileClass, String filePath) throws IOException, ReflectiveOperationException {
    List<CsvFile> list = new ArrayList<>();
    try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
        String line;
        while ((line = br.readLine()) != null) {
            CsvFile csvFile = fileClass.getConstructor().newInstance();
            csvFile.readCsv(line);
            list.add(csvFile);
        }
        return list;
    }
}

Usage:
    public static void main(String[] args) throws IOException, ReflectiveOperationException {
    List<CsvFile> f1 = CsvUtils.readCsvFile(CsvType1.class, "C:/csvfile1.csv");
    List<CsvFile> f2 = CsvUtils.readCsvFile(CsvType2.class, "C:/csvfile2.csv");

    for (CsvFile f : f1) {
        CsvType1 castedF = (CsvType1) f;
        System.out.println(castedF.item1);
    }
}

Is there a way to use it without casting by changing return type? I want use like this:
    List<CsvType1> f1 = CsvUtils.readCsvFile(CsvType1.class, "C:/csvfile1.csv");

for (CsvType1 noCastF : f1) {
    System.out.println(noCastF.item1);
}

', '["java", "list"]', '2024-11-15 15:33:58', '2024-11-15 16:59:27', 32, 0, 1, 0, 23267850, null),
        (79191468, 'Repeat android animation with multiple translations and durations offsets', 'I want to an animation that infinitely moves images up and down. However when I run my code, the animation only happens once. This is the animation xml:
<?xml version="1.0" encoding="utf-8"?>
<set
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:interpolator="@android:anim/linear_interpolator"
    android:repeatCount="3"
    android:repeatMode="restart">
   <!-- move down -->
   <translate
       android:fromYDelta="0%"
       android:toYDelta="50%"
       android:duration="1500"
       android:fillAfter="true"/>

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

</set>



This is my java code:
public class MainActivity extends AppCompatActivity {

    Animation move1, move2, move3, move4, move5;
    Button login;
    ImageView bar1, bar2, bar3, bar4, bar5;
    int delay1 = 500;
    int delay2 = 1560;
    int delay3 = 2300;
    int delay4 = 3065;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);

        login = findViewById(R.id.btLogin);
        bar1 =  findViewById(R.id.ivBar1);
        bar2 =  findViewById(R.id.ivBar2);
        bar3 =  findViewById(R.id.ivBar3);
        bar4 =  findViewById(R.id.ivBar4);
        bar5 =  findViewById(R.id.ivBar5);

        move1= AnimationUtils.loadAnimation(getApplicationContext(),R.anim.move);
        move2= AnimationUtils.loadAnimation(getApplicationContext(),R.anim.move);
        move3= AnimationUtils.loadAnimation(getApplicationContext(),R.anim.move);
        move4= AnimationUtils.loadAnimation(getApplicationContext(),R.anim.move);
        move5= AnimationUtils.loadAnimation(getApplicationContext(),R.anim.move);

        bar1.startAnimation(move1);

        Handler handler = new Handler();
        handler.postDelayed(() -> bar2.startAnimation(move2), delay1);
        handler.postDelayed(() -> bar3.startAnimation(move3), delay2);
        handler.postDelayed(() -> bar4.startAnimation(move4), delay3);
        handler.postDelayed(() -> bar5.startAnimation(move5), delay4);


        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }
}

Why doesn''t it repeat infinelty? Does it have something to do with the fill-after attribute in xml? Help would be greatly appreciated, its for a class project.
', '["java", "xml", "android-studio", "mobile"]', '2024-11-15 15:46:12', '2024-11-15 17:58:06', 17, 0, 2, 0, 21961773, null),
        (79191469, 'How can I include a WAR and read it in a runnable JAR?', 'I have a runnable JAR that contains a Java program that runs an embedded Jetty.  The Jetty loads a WAR file as a WebApp and exposes the servlets in the WAR.  This works as intended.
The WAR file is read from a local directory on my test machine.  I want instead to include the WAR file in the runnable JAR and read it with the Java program''s setWar() method  so the JAR can be run elsewhere. I have been fiddling with the JAR project''s build path and also looking at the maven-assembly-plugin, but so far I have not found a way to do this.  Any suggestions?  Thanks very much.

import org.eclipse.jetty.webapp.WebAppContext;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.ServerConnector;

public class Main {
    public static void main(String[] args) {
        Server server = new Server();
        ServerConnector connector = new ServerConnector(server);
        connector.setPort(8088);
        server.addConnector(connector);
        WebAppContext context = new WebAppContext();
        server.setHandler(context);

        context.setWar("/home/dan/jersey-servlet.war");

        try {
            server.start();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}

', '["java", "jar", "jetty", "war"]', '2024-11-15 15:46:34', '2024-11-15 16:42:10', 26, 0, 0, 0, 5846431, null),
        (79191616, 'Gradle Build Error: Unable to Run Gradle Build: Missing init.gradle File', 'I''m encountering a Gradle issue when building my Java project, the error message I get is the following:
Could not run phased build action using connection to Gradle distribution 
''https://services.gradle.org/distributions/gradle-7.2-bin.zip''.
The specified initialization script 
''C:\\Users\\bchafi\\AppData\\Roaming\\Code\\User\\globalStorage\\redhat.java\\1.35.1\\config_win\\org.eclipse.osgi\\57\\0\\.cp\\gradle\\init\\init.gradle''
does not exist.

In an attempt to resolve this, I tried to manually create the necessary folder structure where the init.gradle file would be located, but I realized that I do not have the init.gradle file available.
Additionally, I attempted to install Gradle manually by downloading it and placing it in C:\\Gradle. After unzipping the distribution ZIP file, I made sure to set the GRADLE_HOME environment variable and added C:\\Gradle\\gradle-7.2\\bin to my system''s PATH.
Unfortunately, this did not resolve the issue, and I am still unable to run my Gradle build.
', '["java", "gradle"]', '2024-11-15 16:42:02', '2024-11-15 18:05:35', 14, 0, 0, 0, 28312374, null),
        (79191622, 'Sring Boot. Failed to fetch. Possible Reasons: CORS Network Failure URL scheme must be &quot;http&quot; or &quot;https&quot; for CORS request', 'when i try swagger on my local host the app works correctly(the api works), but i have done a deploy on railway and when i try to test an API from the swagger i get this error:
Failed to fetch.
Possible Reasons:
CORS
Network Failure
URL scheme must be "http" or "https" for CORS request.
I think it occur cause in the local app i do a request with a http link but in deploy version on railway it automaticaly was set to https, can this cause the erorr ?
I try to add to my application a WebConfig :
@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("*")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*");
    }
}

But this didn''t help i still get the same error
!!!!! When i make a request from the postman i get a right response with this link(this is a get request): https://exciting-wonder-production.up.railway.app/country, but from the swagger i get the error :
Failed to fetch.
Possible Reasons:
CORS
Network Failure
URL scheme must be "http" or "https" for CORS request.
', '["java", "spring-boot", "http-redirect", "https", "railway"]', '2024-11-15 16:43:46', '2024-11-15 17:51:56', 17, 0, 1, 0, 23825234, null),
        (79191654, 'displaying continuously updating data on opengl', 'I''m trying to display a chronometer and also continuously updated data such as distance travelled on OpenGL. There are also buttons to control the chronometer. I''m planning to draw text to a texture and then add the texture to a rectangular shape. (if there''s a better way, please tell me)
I already have my code for my chronometer and other data, but how do I pass this data to OpenGL?
(Using Android Studio, OpenGL ES 2.0)
my java code;
package com.example.code;

import android.content.Context;
import android.content.Intent;
import android.content.res.ColorStateList;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.os.SystemClock;
import android.util.Log;
import android.widget.Chronometer;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import com.google.android.material.floatingactionbutton.FloatingActionButton;
import java.util.Locale;

public class Activity extends AppCompatActivity implements LocationListener {
    private static final String TAG = "SpeedMeasurementActivity";

    private LocationManager locationManager;
    //private TextView currentSpeedTextView;
    //private TextView distanceTextView;
    private Chronometer chronometer;
    private FloatingActionButton startStopButton;
    private boolean isRunning = false;
    private double totalDistance = 0;
    private Location lastLocation;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_no_ar);

        // Initialize views
        //currentSpeedTextView = findViewById(R.id.speed_text_view);
        //distanceTextView = findViewById(R.id.distance_text_view);
        chronometer = findViewById(R.id.time_text_view);
        startStopButton = findViewById(R.id.fab_startstop);
        FloatingActionButton back = findViewById(R.id.fab_back);

        // Initialize location manager
        locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);

        startStopButton.setOnClickListener(v -> {
            if (!isRunning) {
                startMeasurement();
            } else {
                stopMeasurement();
            }
        });

        // Set up back button
        back.setOnClickListener(v -> {
            Intent intent1 = new Intent(getApplication(), ActivityMain.class);
            startActivity(intent1);
            finish();
        });
    }

    private void startMeasurement() {
        isRunning = true;
        startStopButton.setImageResource(R.drawable.ic_action_stop);
        startStopButton.setBackgroundTintList(ColorStateList.valueOf(ContextCompat.getColor(code.this, R.color.red)));
        chronometer.setBase(SystemClock.elapsedRealtime());
        chronometer.start();

        try {
            locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 1000, 0, this);
        } catch (SecurityException e) {
            Log.e(TAG, "request Location Updates error.", e);
        }
    }

    private void stopMeasurement() {
        isRunning = false;
        startStopButton.setImageResource(R.drawable.ic_action_play);
        startStopButton.setBackgroundTintList(ColorStateList.valueOf(ContextCompat.getColor(code.this, R.color.green)));
        chronometer.stop();
        locationManager.removeUpdates(this);
    }

    @Override
    public void onLocationChanged(@NonNull Location location) {
        if (isRunning) {
            double speed = location.getSpeed() * 3.6; // Convert m/s to km/h
            currentSpeedTextView.setText(String.format(Locale.getDefault(), "%.1f km/h", speed));

            if (lastLocation != null) {
                float distance = lastLocation.distanceTo(location);
                totalDistance += distance;
                distanceTextView.setText(String.format(Locale.getDefault(), "%.2f m", totalDistance));
            }
            lastLocation = location;
        }
    }


    @Override
    protected void onDestroy() {
        super.onDestroy();
        locationManager.removeUpdates(this);
    }

    // Implement other LocationListener methods (onStatusChanged, onProviderEnabled, onProviderDisabled)
    @Override
    public void onStatusChanged(String provider, int status, Bundle extras) {}

    @Override
    public void onProviderEnabled(@NonNull String provider) {}

    @Override
    public void onProviderDisabled(@NonNull String provider) {}
}

MyGlSurfaceView.java;
package com.example.code;

import android.content.Context;
import android.opengl.GLSurfaceView;

public class MyGLSurfaceView extends GLSurfaceView {
    private final Context mContext;
    public GLRenderer renderer;
    private static final String TAG = "MyGLSurfaceView";

    public MyGLSurfaceView(Context context) {
        super(context);
        mContext=context;
        setEGLContextClientVersion(2);
        setEGLConfigChooser(8, 8, 8, 8, 16, 0);
        renderer = new GLRenderer(context);
        setRenderer(renderer);
    }
}

TexRectangular.java;
package com.example.code;

import android.opengl.GLES20;

import java.nio.ByteBuffer;
import java.nio.FloatBuffer;

public class TexRectangular {
    private FloatBuffer vertexBuffer;
    private ByteBuffer indexBuffer;
    private FloatBuffer normalBuffer;
    private FloatBuffer texcoordBuffer;

    private float[] vertexs= new float[4*3];

    private byte[] indexs= {
            0,2,1,3
    };

    private float[] normals= {
            0f,0f,1f,
            0f,0f,1f,
            0f,0f,1f,
            0f,0f,1f
    };
    float textcoords[] = {
            0f, 0f, 
            1f, 0f, 
            0f, 1f, 
            1f, 1f  
    };

    TexRectangular() {
        setRectangular(1f, 1f);
    }
    TexRectangular(float width, float height) {
        setRectangular(width, height);
    }

    public void setRectangular(float width, float height) {
        float top=height*.5f;
        float bottom=-top;
        float right=width*.5f;
        float left=-right;

        float[] vertexs= {
                left, top, 0f,     
                right, top, 0f,    
                left, bottom, 0f,  
                right, bottom, 0f  
        };
        vertexBuffer=BufferUtil.makeFloatBuffer(vertexs);
        indexBuffer=BufferUtil.makeByteBuffer(indexs);
        normalBuffer=BufferUtil.makeFloatBuffer(normals);
        texcoordBuffer = BufferUtil.makeFloatBuffer(textcoords);
    }

    public void draw(float r,float g,float b,float a, float shininess) {
     
        GLES20.glVertexAttribPointer(GLES.texcoordHandle, 2,
                GLES20.GL_FLOAT, false, 0, texcoordBuffer);

     
        GLES20.glVertexAttribPointer(GLES.positionHandle, 3,
                GLES20.GL_FLOAT, false, 0, vertexBuffer);

       
        GLES20.glVertexAttribPointer(GLES.normalHandle, 3,
                GLES20.GL_FLOAT, false, 0, normalBuffer);

        GLES20.glUniform4f(GLES.materialAmbientHandle, r, g, b, a);

        GLES20.glUniform4f(GLES.materialDiffuseHandle, r, g, b, a);

        GLES20.glUniform4f(GLES.materialSpecularHandle, 1f, 1f, 1f, a);
        GLES20.glUniform1f(GLES.materialShininessHandle, shininess);

        GLES20.glUniform4f(GLES.objectColorHandle, r, g, b, a);

        //
        indexBuffer.position(0);
        GLES20.glDrawElements(GLES20.GL_TRIANGLE_STRIP,
                4, GLES20.GL_UNSIGNED_BYTE, indexBuffer);
    }
}

StringTexture.java;
package com.example.code;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.opengl.GLES20;
import android.opengl.GLUtils;

import javax.microedition.khronos.opengles.GL10;

public class StringTexture {
    private int TextureId=-1;
    private int TextureUnitNumber=0;
    StringTexture(String text, float textSize, int txtcolor, int bkcolor, int textureidnumber) {
        TextureUnitNumber = textureidnumber;
        makeStringTexture(text, textSize, txtcolor, bkcolor);
    }
    StringTexture(String text, float textSize, int txtcolor, int bkcolor) {
        makeStringTexture(text, textSize, txtcolor, bkcolor);
    }
    public void makeStringTexture(String text, float textSize, int txtcolor, int bkcolor) {
        Paint paint = new Paint();
        paint.setTextSize(textSize);
        paint.setAntiAlias(true);
        Paint.FontMetrics fontMetrics = paint.getFontMetrics();
        paint.getTextBounds(text, 0, text.length(), new Rect(0, 0, (int) textSize * text.length(), (int) textSize));

        int textWidth = (int) paint.measureText(text);
        int textHeight = (int) (Math.abs(fontMetrics.top) + fontMetrics.bottom);

        if (textWidth == 0) textWidth = 10;
        if (textHeight == 0) textHeight = 10;

        int bitmapsize = 2; 
        while (bitmapsize < textWidth) bitmapsize *= 2;
        while (bitmapsize < textHeight) bitmapsize *= 2;

        Bitmap bitmap = Bitmap.createBitmap(bitmapsize, bitmapsize, Bitmap.Config.ARGB_8888);

        Canvas canvas = new Canvas(bitmap);
        paint.setColor(bkcolor);
        canvas.drawRect(new Rect(0, 0, bitmapsize, bitmapsize), paint);
        paint.setColor(txtcolor);
        canvas.drawText(text, bitmapsize / 2 - textWidth / 2, bitmapsize / 2 - (fontMetrics.ascent + fontMetrics.descent) / 2, paint);

        int FIRST_INDEX = 0;
        final int DEFAULT_OFFSET = 0;
        final int[] textures = new int[1];
        if (TextureId!=-1) {
            textures[FIRST_INDEX]=TextureId;
            GLES20.glDeleteTextures(1, textures, DEFAULT_OFFSET);
        }
        GLES20.glGenTextures(1, textures, DEFAULT_OFFSET);
        TextureId = textures[FIRST_INDEX];
//        GLES20.glActiveTexture(GLES20.GL_TEXTURE0+TextureUnitNumber);
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, TextureId);
        GLUtils.texImage2D(GL10.GL_TEXTURE_2D, 0, bitmap, 0);
        bitmap.recycle();
        GLES20.glTexParameterf(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MIN_FILTER, GLES20.GL_NEAREST);
        GLES20.glTexParameterf(GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MAG_FILTER, GLES20.GL_NEAREST);
    }
    public void setTexture() {
        GLES20.glActiveTexture(GLES20.GL_TEXTURE0+TextureUnitNumber);
        GLES20.glBindTexture(GLES20.GL_TEXTURE_2D, TextureId);
        GLES20.glUniform1i(GLES.textureHandle, TextureUnitNumber); 
    }

}

MyGLRenderer.java;
package com.example.code;

import android.content.Context;
import android.graphics.Color;
import android.opengl.GLES20;
import android.opengl.GLSurfaceView;
import android.opengl.Matrix;

import java.nio.FloatBuffer;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class MyGLRenderer implements GLSurfaceView.Renderer {
    private final Context mContext;
    private boolean validProgram=false;

    private float aspect;
    private float viewingangle = 45f;

    private  float[] LightPos={0f,0f,3f,0f};//x,y,z,1

    private  float[] pMatrix=new float[16];
    private  float[] mMatrix=new float[16];
    private  float[] cMatrix=new float[16];

    private TexRectangular MyTexRectangular = new TexRectangular();
    private StringTexture Speed;
    private StringTexture Distance;
    private StringTexture Time;

    private static float[] DummyFloat= new float[1];
    private static final FloatBuffer DummyBuffer=BufferUtil.makeFloatBuffer(DummyFloat);

    MyGLRenderer(final Context context) {
        mContext = context;
    }

    private String speedText = "";
    private String distanceText = "";
    private String timeText = "";

    @Override
    public void onSurfaceCreated(GL10 gl10,EGLConfig eglConfig) {
        validProgram = GLES.makeProgram();

        GLES20.glEnableVertexAttribArray(GLES.positionHandle);
        GLES20.glEnableVertexAttribArray(GLES.normalHandle);
        GLES20.glEnableVertexAttribArray(GLES.texcoordHandle);

        GLES20.glEnable(GLES20.GL_DEPTH_TEST);

        GLES20.glEnable(GLES20.GL_CULL_FACE);

        GLES20.glFrontFace(GLES20.GL_CCW);
        GLES20.glCullFace(GLES20.GL_BACK);

        GLES20.glUniform4f(GLES.lightAmbientHandle, 0.5f, 0.5f, 0.5f, 1.0f);
        GLES20.glUniform4f(GLES.lightDiffuseHandle, 1f, 1f, 1f, 1.0f);
        GLES20.glUniform4f(GLES.lightSpecularHandle, 0f, 0f, 0f, 0f);
        GLES20.glClearColor(0f, 0f, 0f, 1.0f);

        GLES20.glEnable(GLES20.GL_TEXTURE_2D);

        GLES20.glEnable(GLES20.GL_BLEND);
        GLES20.glBlendFunc(GLES20.GL_SRC_ALPHA, GLES20.GL_ONE_MINUS_SRC_ALPHA);
    }

    //set speed text
    public void setSpeedText(float f){
        //int speedInt;
        String str;
        //speed = f;
        str = String.valueOf(f);

        speedText = str + "km/h";
    }

    // set distance text
    public void setDistanceText(float f){
        //int distanceInt;
        String str;
        //distance = f;
        str = String.valueOf(f);

        distanceText = str + "m";
    }

    // set timer text
    public void setTimeText(float f){
        //int timeInt;
        String str;
        //time = f;
        str = String.valueOf(f);

        timeText = str;
    }
    
    @Override
    public void onSurfaceChanged(GL10 gl10,int w,int h) {
        GLES20.glViewport(0,0,w,h);
        aspect=(float)w/(float)h;
    }
    
    @Override
    public void onDrawFrame(GL10 glUnused) {
        if (!validProgram) return;

        GLES20.glVertexAttribPointer(GLES.positionHandle, 3, GLES20.GL_FLOAT, false, 0, DummyBuffer);
        GLES20.glVertexAttribPointer(GLES.normalHandle, 3, GLES20.GL_FLOAT, false, 0, DummyBuffer);
        GLES20.glVertexAttribPointer(GLES.texcoordHandle, 2, GLES20.GL_FLOAT, false, 0, DummyBuffer);

        Speed = new StringTexture(speedText,16, Color.WHITE, Color.BLACK);
        Distance = new StringTexture(distanceText,16, Color.WHITE, Color.BLACK);
        Time = new StringTexture(timeText,16, Color.WHITE, Color.BLACK);

        GLES.disableTexture();
        GLES.enableShading();

        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT |
                GLES20.GL_DEPTH_BUFFER_BIT);

        GLES.gluPerspective(pMatrix,
                viewingangle,
                aspect,
                .01f,
                120.0f);
        GLES.setPMatrix(pMatrix);

        float[] c1Matrix=new float[16];
        float[] c2Matrix=new float[16];
        Matrix.setLookAtM(c1Matrix, 0,
                0f,0f,0f,
                0.0f, 0.0f, -1.0f,
                0.0f, 1.0f, 0.0f);

        Matrix.multiplyMM(cMatrix, 0, c1Matrix, 0, c2Matrix, 0); //cMatrix = c1Matrix * c2Matrix

        GLES.setCMatrix(cMatrix);

        GLES.setLightPosition(LightPos);

        GLES.disableShading();

        GLES.enableShading();

        GLES.enableTexture();

        // Draw speed text
        Matrix.setIdentityM(mMatrix, 0);
        Matrix.translateM(mMatrix, 0, 0f, 1.0f, 0f); // Position for speed text
        Matrix.scaleM(mMatrix, 0, 0.4f, 0.01f, 0.4f);
        GLES.updateMatrix(mMatrix);
        Speed.setTexture();

        MyTexRectangular.draw(1f, 1f, 1f, 1f, 20.f);

        // Draw distance text
        Matrix.setIdentityM(mMatrix, 0);
        Matrix.translateM(mMatrix, 0, 0f, 2.0f, 0f); // Position for distance text
        Matrix.scaleM(mMatrix, 0, 0.4f, 0.01f, 0.4f);
        GLES.updateMatrix(mMatrix);
        Distance.setTexture();

        MyTexRectangular.draw(1f, 1f, 1f, 1f, 20.f);


        // Draw time text
        Matrix.setIdentityM(mMatrix, 0);
        Matrix.translateM(mMatrix, 0, 0f, 3.0f, 0f); // Position for time text
        Matrix.scaleM(mMatrix, 0, 0.4f, 0.01f, 0.4f);
        GLES.updateMatrix(mMatrix);
        Time.setTexture();

        MyTexRectangular.draw(1f, 1f, 1f, 1f, 20.f);

        GLES.disableTexture();
    }
}

p/s: if there''s something wrong with my code, please tell me! i''m still struggling especially with MyGLRenderer.java
', '["java", "android", "opengl-es"]', '2024-11-15 16:54:12', '2024-11-15 16:54:12', 15, 0, 0, 0, 25459667, null),
        (79191671, 'Error on AuditModule during Alfresco startup', 'I''m upgrading an Alfresco CE 5.x to 7.4.2. It has the AuditModule enabled in the properties but now, after the upgrade, I receive this error when Alfresco boots up:
2024-11-14T17:52:57,305 [] ERROR [audit.model.AuditModelRegistryImpl] [main] Failed to load audit model: jar:file:/opt/alfresco-cdr/tomcat/webapps/alfresco/WEB-INF/lib/alfresco-repository-21.14.jar!/alfresco/audit/alfresco-audit-access.xml
org.alfresco.repo.audit.model.AuditModelException: 10140000 Audit application key ''alfresco-access'' is used by: AuditApplication[ name=alfresco-access, id=2, disabledPathsId=3094]
        at org.alfresco.repo.audit.model.AuditModelRegistryImpl$AuditModelRegistryState.cacheAuditElements(AuditModelRegistryImpl.java:646) ~[alfresco-repository-20.164.jar:20.164]
.....
2024-11-14T17:52:57,314 [] ERROR [audit.model.AuditModelRegistryImpl] [main] Failed to load audit model: jar:file:/opt/alfresco-cdr/tomcat/webapps/alfresco/WEB-INF/lib/alfresco-repository-21.14.jar!/alfresco/audit/alfresco-audit-tagging.xml
org.alfresco.repo.audit.model.AuditModelException: 10140001 Audit application key ''tagging'' is used by: AuditApplication[ name=Alfresco Tagging Service, id=1, disabledPathsId=2]
        at org.alfresco.repo.audit.model.AuditModelRegistryImpl$AuditModelRegistryState.cacheAuditElements(AuditModelRegistryImpl.java:646) ~[alfresco-repository-20.164.jar:20.164]
.....

this are the properties on alfresco-global.properties
# Enable the alfresco-access audit application

audit.alfresco-access.enabled=true
audit.cdr-audit.enabled=true
audit.cdr-audit.sub-actions.enabled=true
audit.cdr-audit.sub-events.enabled=true
audit.filter.cdr-audit.transaction.type=cm:content;st:site;cm:folder;cm:person;

# Audit map filter for AccessAuditor - restricts recorded events to user driven events
audit.filter.alfresco-access.default.enabled=false
audit.filter.alfresco-access.transaction.user=.*
audit.filter.alfresco-access.transaction.path=~/sys:archivedItem;~/ver:;/app:company_home/st:sites/.*
audit.filter.alfresco-access.transaction.type=cm:content;cm:folder;st:site;cm:person

Can anyone help me finding out what is the problem? I''m thinking about there is something wrong in my DB
', '["java", "alfresco"]', '2024-11-15 17:01:37', '2024-11-15 17:11:08', 11, 1, 1, 0, 3699649, null),
        (79191715, 'When I use MapStruct&#39;s qualifiedByName and @Named doesn&#39;t take effect', 'MapStruct version is 1.5.5.Final,JDK is 17,Here is my code
@Mapper
public interface UndoIssueConvert {
    UndoIssueConvert INSTANCE = Mappers.getMapper(UndoIssueConvert.class);

    @Mappings({
            @Mapping(target = "undoIssueId", source = "id"),
//          @Mapping(target = "createTime", expression = ("java(undoIssue.getUpdateTime() != null ? undoIssue.getUpdateTime() : undoIssue.getCreateTime())"))
            @Mapping(target = "createTime", qualifiedByName = "convertCreateTime")
    })
    UndoIssuePanelRspVO.UndoIssue toUndoIssue(UndoIssue undoIssue);

    List<UndoIssuePanelRspVO.UndoIssue> toUndoIssue(List<UndoIssue> undoIssue);

    @Named("convertCreateTime")
    default Date convertCreateTime(UndoIssue undoIssue) {
        return undoIssue.getUpdateTime() != null ? undoIssue.getUpdateTime() : undoIssue.getCreateTime();
    }

    UndoIssue toUndoIssueEntity(UndoIssueAddUpdateVO addVO);
}

But I get the following exception
java: Qualifier error. No method found annotated with @Named#value: [ convertCreateTime ]

I confirmed the annotation path is correct
', '["java", "mapstruct"]', '2024-11-15 17:16:06', '2024-11-15 19:03:02', 14, 0, 1, 0, 22793923, null),
        (79191779, 'Type of position in RandomAccessFile is long but it is int in MappedByteBuffer', 'The RandomAccessFile class in Java uses type long in methods getFilePointer(), length(), seek(), and setLength().
However, if I want to manipulate this file via MappedByteBuffer, I can only specify the Buffer''s position as an int.
Is this a feature or an API shortcoming in JDK? (Very likely, it''s the former but not sure why.)
Is downcasting the file pointer from long to an int Buffer position the only way around?
', '["java", "nio", "randomaccessfile", "mappedbytebuffer"]', '2024-11-15 17:35:18', '2024-11-15 18:28:35', 23, 0, 1, 0, 125540, 79191968),
        (79191789, 'Azure Key Vault signing fails when signing BouncyCastle generated signed attributes of PDF document', 'We''re trying to use Azure Key Value private key to sign BouncyCastle generated signed attributes (embeds PDF hashable content digest) for a PDF document to allow for PDF signing.
However, the signing process with Azure Key Vault is failing because the BouncyCastle generated signed attributes to sign is not equal to 32 bytes in length with the following error message:
com.azure.security.keyvault.keys.implementation.models.KeyVaultErrorException: Status code 400, "{"error":{"code":"BadParameter","message":"Invalid length of ''value'': 153 bytes. RS256 requires 32 bytes, encoded with base64url."}}"
    at java.base/java.lang.invoke.MethodHandle.invokeWithArguments(MethodHandle.java:733) ~[na:na]
    at com.azure.core.implementation.MethodHandleReflectiveInvoker.invokeStatic(MethodHandleReflectiveInvoker.java:26) ~[azure-core-1.51.0.jar:1.51.0]
    at com.azure.core.implementation.http.rest.ResponseExceptionConstructorCache.invoke(ResponseExceptionConstructorCache.java:53) ~[azure-core-1.51.0.jar:1.51.0]
    at com.azure.core.implementation.http.rest.RestProxyBase.instantiateUnexpectedException(RestProxyBase.java:407) ~[azure-core-1.51.0.jar:1.51.0]
    at com.azure.core.implementation.http.rest.SyncRestProxy.ensureExpectedStatus(SyncRestProxy.java:133) ~[azure-core-1.51.0.jar:1.51.0]
    at com.azure.core.implementation.http.rest.SyncRestProxy.handleRestReturnType(SyncRestProxy.java:211) ~[azure-core-1.51.0.jar:1.51.0]
    at com.azure.core.implementation.http.rest.SyncRestProxy.invoke(SyncRestProxy.java:86) ~[azure-core-1.51.0.jar:1.51.0]
    at com.azure.core.implementation.http.rest.RestProxyBase.invoke(RestProxyBase.java:124) ~[azure-core-1.51.0.jar:1.51.0]
    at com.azure.core.http.rest.RestProxy.invoke(RestProxy.java:95) ~[azure-core-1.51.0.jar:1.51.0]
    at jdk.proxy2/jdk.proxy2.$Proxy94.signSync(Unknown Source) ~[na:na]
    at com.azure.security.keyvault.keys.implementation.KeyClientImpl.signWithResponse(KeyClientImpl.java:3286) ~[azure-security-keyvault-keys-4.8.7.jar:4.8.7]
    at com.azure.security.keyvault.keys.cryptography.implementation.CryptographyClientImpl.sign(CryptographyClientImpl.java:248) ~[azure-security-keyvault-keys-4.8.7.jar:4.8.7]
    at com.azure.security.keyvault.keys.cryptography.implementation.RsaKeyCryptographyClient.sign(RsaKeyCryptographyClient.java:230) ~[azure-security-keyvault-keys-4.8.7.jar:4.8.7]
    at com.azure.security.keyvault.keys.cryptography.CryptographyClient.sign(CryptographyClient.java:699) ~[azure-security-keyvault-keys-4.8.7.jar:4.8.7]
    at com.azure.security.keyvault.keys.cryptography.CryptographyClient.sign(CryptographyClient.java:651) ~[azure-security-keyvault-keys-4.8.7.jar:4.8.7]
    at com.stackoverflow.keyvault.service.impl.AzureKeyVaultServiceImpl.signBytes(AzureKeyVaultServiceImpl.java:26) ~[classes/:na]
    at com.stackoverflow.keyvault.controller.KeyVaultController.signMoreByte32(KeyVaultController.java:51) ~[classes/:na]
    at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103) ~[na:na]
    at java.base/java.lang.reflect.Method.invoke(Method.java:580) ~[na:na]
    at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:255) ~[spring-web-6.1.12.jar:6.1.12]
    at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:188) ~[spring-web-6.1.12.jar:6.1.12]
    at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:118) ~[spring-webmvc-6.1.12.jar:6.1.12]
    at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:926) ~[spring-webmvc-6.1.12.jar:6.1.12]
    at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:831) ~[spring-webmvc-6.1.12.jar:6.1.12]
    at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87) ~[spring-webmvc-6.1.12.jar:6.1.12]
    at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1089) ~[spring-webmvc-6.1.12.jar:6.1.12]
    at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:979) ~[spring-webmvc-6.1.12.jar:6.1.12]
    at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1014) ~[spring-webmvc-6.1.12.jar:6.1.12]
    at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:903) ~[spring-webmvc-6.1.12.jar:6.1.12]
    at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:564) ~[tomcat-embed-core-10.1.28.jar:6.0]
    at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:885) ~[spring-webmvc-6.1.12.jar:6.1.12]
    at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:658) ~[tomcat-embed-core-10.1.28.jar:6.0]
    at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:195) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:140) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:51) ~[tomcat-embed-websocket-10.1.28.jar:10.1.28]
    at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:164) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:140) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100) ~[spring-web-6.1.12.jar:6.1.12]
    at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116) ~[spring-web-6.1.12.jar:6.1.12]
    at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:164) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:140) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93) ~[spring-web-6.1.12.jar:6.1.12]
    at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116) ~[spring-web-6.1.12.jar:6.1.12]
    at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:164) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:140) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201) ~[spring-web-6.1.12.jar:6.1.12]
    at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116) ~[spring-web-6.1.12.jar:6.1.12]
    at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:164) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:140) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:167) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:90) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:483) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:115) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:93) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:344) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:384) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:63) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:904) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1741) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:52) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.tomcat.util.threads.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1190) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.tomcat.util.threads.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:659) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:63) ~[tomcat-embed-core-10.1.28.jar:10.1.28]
    at java.base/java.lang.Thread.run(Thread.java:1583) ~[na:na]
Azure Key Vault should not tell me what content to sign, should it?

The same signing process works perfectly with a local self-generated private key. However such a private key is not stored in an HSM (Hardware Security Module) and may be revoked by Adobe.
We tried the Azure Spring Boot library leveraging CryptoClient instance to attempt the signing process.
application.yml
server:
    port: 8080
spring:
    application:
        name: Stackoverflow Key Vault
    cloud:
        azure:
            keyVault:
                url: https://my-vault.vault.azure.net/
                keyID: https://my-vault.vault.azure.net/keys/my-key

signature:
    algorithm: SHA256withRSA

KeyVaultController.java
@RestController
@RequestMapping("/api/vault")
@RequiredArgsConstructor
@Slf4j
public class KeyVaultController {
    private final KeyVaultService keyVaultService;

    @Value("${signature.algorithm}")
    private String signAlgo;

    @GetMapping("/sign-digest")
    public String signByte32() {
        // SHA-256 digest
        byte[] bytes = { -10, -106, 74, -128, 121, -80, 90, -100, 115, 82, -61, 120, -84, 23, 7, 5, 7, 96, -38, 95, -13, -46, 33, 70, -127, -66, 57, -31, 52, 123, -26, -109 };
        return Base64.getEncoder().encodeToString(keyVaultService.signBytes(signAlgo, bytes));
    }

    @GetMapping("/sign-pdf-digest")
    public String signMoreByte32() {
        // BouncyCastle signed attributes for PDF signing
        byte[] bytes = { 49, -127, -106, 48, 24, 6, 9, 42, -122, 72, -122, -9, 13, 1, 9, 3, 49, 11, 6, 9, 42, -122, 72, -122, -9, 13, 1, 7, 1, 48, 28, 6, 9, 42, -122, 72, -122, -9, 13, 1, 9, 5, 49, 15, 23, 13, 50, 52, 49, 49, 49, 52, 49, 48, 53, 57, 49, 51, 90, 48, 43, 6, 9, 42, -122, 72, -122, -9, 13, 1, 9, 52, 49, 30, 48, 28, 48, 11, 6, 9, 96, -122, 72, 1, 101, 3, 4, 2, 1, -95, 13, 6, 9, 42, -122, 72, -122, -9, 13, 1, 1, 11, 5, 0, 48, 47, 6, 9, 42, -122, 72, -122, -9, 13, 1, 9, 4, 49, 34, 4, 32, -29, -80, -60, 66, -104, -4, 28, 20, -102, -5, -12, -56, -103, 111, -71, 36, 39, -82, 65, -28, 100, -101, -109, 76, -92, -107, -103, 27, 120, 82, -72, 85 };
        return Base64.getEncoder().encodeToString(keyVaultService.signBytes(signAlgo, bytes));
    }

AzureKeyVaultServiceImpl.java
@Service
@RequiredArgsConstructor
public class AzureKeyVaultServiceImpl implements KeyVaultService {
    private final static Map<String, SignatureAlgorithm> ALGO_SIGNATURE_MAP = new HashMap<>();

    private final CryptographyClient cryptoClient;

    static {
        ALGO_SIGNATURE_MAP.put("SHA256withRSA", SignatureAlgorithm.RS256);
        ALGO_SIGNATURE_MAP.put("SHA384withRSA", SignatureAlgorithm.RS384);
        ALGO_SIGNATURE_MAP.put("SHA512withRSA", SignatureAlgorithm.RS512);
    }

    @Override
    public byte[] signBytes(String signAlgo, byte[] bytesToSign) {
        return cryptoClient.sign(ALGO_SIGNATURE_MAP.get(signAlgo), bytesToSign)
                .getSignature();
    }
}

', '["java", "azure", "pdf", "digital-signature", "vault"]', '2024-11-15 17:38:25', '2024-11-15 17:38:25', 24, 0, 0, 0, 28276222, null),
        (79191954, 'Method not supported execption just with one controller Spring', 'Good morning every one, I''m having a hard time with this issue. I could work around but I want to understand why this is happening. So far I''m working with Spring, Spring Security, Data Rest and Data Mongo DB.
Until now, there has been no issue with DAO and controllers, everything seems to work fine. I''ve added a new Document:
@Document
public class PlanDeEntrenamiento {
  @Id
  private String id;
  private String nombre;
  private String objetivo;
  private String descripcion;
  private List<SesionDePlan> sesiones;
  private String autor;
}

This one is the DAO:
@RepositoryRestResource(path = "planes", itemResourceRel = "plan",
    collectionResourceRel = "planes")
public interface PlanDeEntrenamientoDAO extends MongoRepository<PlanDeEntrenamiento, String> {
  List<PlanDeEntrenamiento> findByNombre(String nombre);
  List<PlanDeEntrenamiento> findByObjetivo(String objetivo);
}

And this the Security Configuration:
@Bean
  public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    return http.csrf(csrf -> csrf.disable())
        .authorizeHttpRequests(authRequest -> authRequest
            .requestMatchers("/api/autenticacion/cambioPassword").authenticated()
            .requestMatchers("/api/autenticacion/login",
                "/api/autenticacion/registro/**",
                "/api/autenticacion/reset-password").permitAll()
            .requestMatchers(HttpMethod.GET, "/api/invitaciones").authenticated()
            .requestMatchers(HttpMethod.GET,"/api/invitaciones/**").permitAll()
            .requestMatchers("/api/fichas/aprobado").permitAll()
            .requestMatchers(HttpMethod.GET, "/api/fichas/**").permitAll()
            .requestMatchers(HttpMethod.GET, "/api/ejercicios").permitAll()
            .requestMatchers(HttpMethod.GET, "/api/planes").permitAll()
            .requestMatchers(HttpMethod.GET, "/api/planes/**").permitAll()
            .requestMatchers(HttpMethod.GET, "/api/ejercicios/**").permitAll()
            .requestMatchers(HttpMethod.GET, "/api/equipamientos").permitAll()
            .requestMatchers(HttpMethod.GET, "/api/usuarios/existe-email").permitAll()
            .requestMatchers(HttpMethod.GET, "/api/usuarios/search/existsByNombre").permitAll()
            .anyRequest().authenticated())
        .sessionManagement(sessionManager ->
            sessionManager.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
        .authenticationProvider(this.PROVIDER)
        .addFilterBefore(this.FILTER, UsernamePasswordAuthenticationFilter.class)
        .build();
  }

Now, I create a controller:
@RestController
@RequestMapping("api/planes")
public class PlanDeEntrenamientoController {
  @Autowired
  PlanDeEntrenamientoDAO planDeEntrenamientoDAO;
  @Autowired
  SesionDAO sesionDAO;

  @GetMapping
  public ResponseEntity<List<PlanDeEntrenamientoResponse>> getPlanes() {
    List<PlanDeEntrenamiento> planes = planDeEntrenamientoDAO.findAll();
    List<PlanDeEntrenamientoResponse> planesResponse = new ArrayList<>();
    planesResponse = planes.stream().map(plan -> {
      PlanDeEntrenamientoResponse planResponse = new PlanDeEntrenamientoResponse();
      planResponse.setId(plan.getId());
      planResponse.setNombre(plan.getNombre());
      planResponse.setObjetivo(plan.getObjetivo());
      planResponse.setDescripcion(plan.getDescripcion());
      planResponse.setAutor(plan.getAutor() != null ? plan.getAutor() : null);
      return  planResponse;
    }).collect(Collectors.toList());
    return ResponseEntity.ok(planesResponse);
  }
  @GetMapping("/{id}")
  public ResponseEntity<PlanDeEntrenamiento> getPlanes(@PathVariable String id) {
    PlanDeEntrenamiento planDeEntrenamiento = planDeEntrenamientoDAO.findById(id).orElseThrow();
    return ResponseEntity.ok(planDeEntrenamiento);
  }
  @PostMapping("/{id}/agregarSesiones")
  public ResponseEntity<Boolean> getPlanes(@PathVariable String id, @RequestBody
  AgregarSesionesRequest request) {
    PlanDeEntrenamiento plan = planDeEntrenamientoDAO.findById(id).orElseThrow();
    plan.getSesiones().forEach(sesion -> {
      Sesion nuevaSesion = new Sesion();
      nuevaSesion.setNombre(sesion.getNombre());
      nuevaSesion.setFichas(sesion.getFichas());
      nuevaSesion.setGrupo(request.getGrupo());
      LocalDate fechaSesion = request.getFecha().plusDays(sesion.getDia() - 1);
      nuevaSesion.setFecha(fechaSesion);
      nuevaSesion.setUnidad(request.getUnidad());
      sesionDAO.save(nuevaSesion);
    });
    return ResponseEntity.ok(true);
  }
}

And after that, when I want to post, put or patch something with the endpoints provided by data rest, the log is this one:
Resolved [org.springframework.web.HttpRequestMethodNotSupportedException: Request method ''PUT'' is not supported] 
Of course I can manually define the endopoints but the point using data rest is not having to do that and I''ve done nothing different from others Controllers, where I have no problems at all. Any tip would be appreciated.
Thanks.
', '["java", "spring", "rest", "security"]', '2024-11-15 18:19:39', '2024-11-15 18:53:53', 15, 0, 1, 0, 20123929, null),
        (79191972, 'How to make transparent Scene with visible Stage in JavaFX', 'I need to create a visible Stage with transparent Scene. This is my code:
public class Test10 extends Application {

    @Override
    public void start(Stage primaryStage) {
        StackPane root = new StackPane();
        Scene scene = new Scene(root, 400, 300, Color.TRANSPARENT);
        scene.setFill(Color.TRANSPARENT);
        var css = Test10.class.getResource("test.css").toExternalForm();
        scene.getStylesheets().add(css);
        primaryStage.setScene(scene);
        primaryStage.setTitle("Transparent Scene");
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}

And CSS:
.root { -fx-background-color: transparent; }

This is what I get:

and this is what I need:

Could anyone say how to do it?
', '["java", "javafx"]', '2024-11-15 18:23:31', '2024-11-15 18:23:31', 12, 0, 0, 0, 26656564, null),
        (79192023, 'org.hibernate.mapping.SingleTableSubclass cannot be cast to org.hibernate.mapping.RootClass 2 tables, 3 classes', 'I have an error:
java.lang.ClassCastException: org.hibernate.mapping.SingleTableSubclass cannot be cast to org.hibernate.mapping.RootClass

It''s thrown because I have two @Id annotations.
I have abstract class:
@Entity
@Table(name = "PRODUCTS")
public abstract class CommonProduct<Type extends AbstractProductUnderlying> extends HibernatePersistentObject implements Serializable, UniqueObject {
    @Ignore
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "products_seq")
    @SequenceGenerator(name = "products_seq", sequenceName = "products_seq")
    @Column(name = "productId")
    protected Integer productId;

I have second class without @Id which extends the one above and it''s the same table:
@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
public class Product extends CommonProduct<ProductUnderlying> {

and there is third table which has different Id as CommonProduct:
@Entity(name = "viewProductHistory")
@Table(name = "PRODUCT_HISTORY")
public class ProductHistory extends CommonProduct<ProductUnderlyingHistory> {

    @Id
    @Column(name = "PRODUCT_HISTORY_ID")
    private int ProductHistoryId;

How can I solve it if two classes extends the one with @Id but one of them has different Id?
', '["java", "hibernate"]', '2024-11-15 18:41:05', '2024-11-15 18:46:17', 12, 0, 0, 0, 4952262, null),
        (79192090, 'Change wsconnection from websphere to jboss', 'we need to change a project from websphere to jboss.
We have no knowledge about jboss. Please, can someone help me to change this?
        WSConnection conn = (WSConnection) this.connect_to;
        Properties props = new Properties();
    
        String hostname = "";
        String ipAddress = "";
        try {
            InetAddress addr = InetAddress.getLocalHost();
            ipAddress = addr.getHostAddress();
            hostname = addr.getHostName();
        } catch (UnknownHostException e) {
        }

        props.setProperty(WSConnection.CLIENT_ID, hostname);
        props.setProperty(WSConnection.CLIENT_LOCATION, ipAddress);
        props.setProperty(WSConnection.CLIENT_ACCOUNTING_INFO, this.getNomeDataSource());

', '["java", "websocket", "jboss", "migration", "websphere"]', '2024-11-15 19:03:08', '2024-11-15 19:04:29', 7, 0, 0, 0, 10932180, null),
        (79192155, 'Unable to download any plugins in Jenkins', 'Problem: I m getting an error when I navigate to manage plugin

There were errors checking the update sites: FileNotFoundException: http://updates.jenkins.io/update-center.json?id=default&version=2.319.3

Available Plugins are showing as empty
HTTP Proxy Configuration
Update Site
I tried to search some plugin as "Maven, git", But I can''t able to find any.
Expected Result: I want to see the list of plugins when I search.
', '["java", "selenium-webdriver", "jenkins", "jenkins-pipeline", "jenkins-plugins"]', '2024-11-15 19:24:40', '2024-11-15 19:43:05', 13, 0, 0, 0, 18015406, null),
        (79192301, 'How to setup Junit5 @Methodsources?', 'I''m trying to use the @MethodSources introduced in version 5.11.
Javadoc
class MapFieldsTest {
    static Stream<Arguments> testGetIntCommon() {
        return Stream.of(
            Arguments.of("a", 10),
            Arguments.of("b", 20)
        );
    }

    static Stream<Arguments> testGetIntBroken() {
        return Stream.of(
            Arguments.of("c", null),
            Arguments.of("d", null)
        );
    }

    @ParameterizedTest
    @MethodSources({
        @MethodSource("testGetIntCommon"),
        @MethodSource("testGetIntBroken")
    })
    void testGetInt(String givenKey, Integer expected) {
        // THIS DOESN''T WORK
    }

    @ParameterizedTest
    @MethodSource("testGetIntCommon")
    void testGetIntCommon(String givenKey, Integer expected) {
        // THIS WORKS
    }
    
    @ParameterizedTest
    @MethodSource("testGetIntBroken")
    void testGetIntBroken(String givenKey, Integer expected) {
        // THIS WORKS
    }
}

But I get an error:
MapFieldsTest.testGetInt(String, Integer) » PreconditionViolation Configuration error: You must configure at least one set of arguments for this @ParameterizedTest

What can be an issue with the @MethodSources setup?
', '["java", "unit-testing", "junit5"]', '2024-11-15 20:04:22', '2024-11-15 20:30:31', 15, 0, 2, 0, 658801, null),
        (79192327, 'how to upgrade java version on cassandra 4.0.5', 'I want upgrade java version from 8 to 11 on my cassandra cluster cluster. How better to do this? Can I upgrade java version node by node. For example:

stop 1 node
upgrade java
start 1 node

And repeat for another nodes those steps, or will I need repair nodes after upgrede
Now nodes:

Cassandra 4.0.5
Java 8

I will glad to your advices. Thanks
', '["java", "cassandra", "datastax", "datastax-java-driver", "cassandra-4.0"]', '2024-11-15 20:11:47', '2024-11-15 20:11:47', 3, 0, 0, 0, 23808405, null),
        (79192363, 'How can I define a Java meta annotation that specifies the @Target of annotations it&#39;s applied to?', 'How can I define a Java meta annotation that specifies the @Target of annotations it''s applied to? In code it could look something like:
// The current target
@Target({ ElementType.ANNOTATION_TYPE })
// The target of the annotation this is applied to
@Target({ ElementType.PARAMETER })
public @interface MetaAnnotation {
}

@MetaAnnotation
// No @Target needed, targets ElementType.PARAMETER
public @interface RegularAnnotation {

}

But that''s not possible since @Target can only be supplied once.
', '["java"]', '2024-11-15 20:21:54', '2024-11-15 20:25:34', 12, 0, 1, 0, 93197, null),
        (79192493, 'Interrupting a thread that&#39;s running a CompletableFuture', 'Consider I have an ExecutorService operating on top of a pool of daemon threads (so that I don''t need to explicitly shut it down):
final var executor = Executors.newFixedThreadPool(
        Runtime.getRuntime().availableProcessors(),
        r -> {
            final var t = new Thread(r);
            t.setDaemon(true);
            return t;
        }
);

— and I want to cancel a long-running Future task after a certain time-out:
final var future = executor.submit(() -> {
    try {
        TimeUnit.SECONDS.sleep(Long.MAX_VALUE);
        return "42";
    } catch (final InterruptedException ie) {
        System.out.println("Task cancelled.");
        throw ie;
    }
});

try {
    System.out.println(future.get(5L, TimeUnit.SECONDS));
} catch (final TimeoutException ignored) {
    System.out.println("Timed out, cancelling...");
    future.cancel(true);
}

When run, this code will produce the following output within about 5 seconds:
Timed out, cancelling...
Task cancelled.

This means that the thread currently running the task will indeed be interrupted, and the Thread.sleep() will throw an InterruptedException. Now, consider I want to use the CompletableFuture API instead. Here''s the semantically identical code:
final var future = CompletableFuture.supplyAsync(() -> {
    try {
        TimeUnit.SECONDS.sleep(Long.MAX_VALUE);
        return "42";
    } catch (final InterruptedException ie) {
        System.out.println("Task cancelled.");
        throw new RuntimeException(ie);
    }
}, executor);

Or so I thought. The 2nd version of the code, however, will only produce the following output:
Timed out, cancelling...

The background executor thread will continue running Thread.sleep(), without ever being interrupted, so these two versions of the code are not semantically the same.
Similarly, if I invoke future.orTimeout(timeout, unit) instead of future.get(timeout, unit), the background thread will not get interrupted, either. Background threads will continue running (potentially) computationally expensive tasks till the JVM is shut down, and there seems no way to interrupt them.
The only way to interrupt background threads is to call executor.shutdownNow() (mere executor.shutdown() is insufficient), but of course this is not a solution, as I want to reuse the executor after task cancellation.
Questions:

How do I cancel a CompletableFuture and interrupt the corresponding worker thread, and
is this behaviour documented anywhere?

Edit: there''s a similar question: How to cancel Java 8 completable future?
', '["java", "multithreading", "future", "executorservice", "completable-future"]', '2024-11-15 21:04:34', '2024-11-15 21:28:15', 47, 1, 1, 0, 1343979, 79192578),
        (79192563, 'Run Eclipse Scout Project without Intellij or Eclipse?', 'Is there a way to run an Eclipse Scout project without Intellij or Eclipse?
If you create the JAR files with mvn install, there should be a way to run these JARs in the Windows CMD console. Unfortunately the usual method with jar -cp does not work.
', '["java", "eclipse-scout"]', '2024-11-15 21:23:19', '2024-11-15 21:23:19', 10, 0, 0, 0, 20621559, null),
        (79192590, 'What is the proper way to mark the removal version using @Deprecated?', 'I was asked to deprecate a couple classes to be deprecated and removed in a future release. Given the Javadocs there are 2 properties, the version it was deprecated in and whether or not it will be removed. So I ended up with a tag like this
@Deprecated(forRemoval = true)

I was then asked to add 2 things, first the version it will be removed. Now of course I could use comments or something along those lines but it doesn''t seem like there is anything formal so are comments just the way to go or is there something I am missing? In this example the removal version is 4.5.0.
Also there is a since property, however, since we have multiple versions in parallel this doesn''t seem intuitive. For example we might release a patch for version 4.3, 4.2 and 4.1 so technically on the 4.3 branch it would be marked deprecated since say 4.3.2 and on the 4.2 it would be since 4.2.5 and the 4.1 would be since 4.1.9. This means if you are on 4.3.1, 4.2.4, or 4.1.8 it won''t be marked deprecated.
Am I relegated to comments to make this work or is there some way I can do all this with the annotations so it is recognized by the developer''s IDE?
', '["java", "deprecated"]', '2024-11-15 21:31:07', '2024-11-15 21:55:37', 39, 1, 1, 0, 9335205, null),
        (79192603, 'Spring Data Neo4j: findAll fails with &quot;Required property $enum$name not found&quot; when using enum as a @Node', 'I am using Spring Data Neo4j to work with my Neo4j database. My application includes a Variation node entity that has a relationship with an enum called Type. Here is a simplified version of my code:
@Node
public class Variation extends BaseEntity {
    private String title;

    @Relationship(type = "HAS_ATTRIBUTE", direction = Relationship.Direction.OUTGOING)
    private Type type;

    // Other fields and relationships...
}
@Node
public enum Type {
    CUSTOM(0),
    FIX(1),
    // Other constants...

    @Id
    private final int id;

    Type(int id) {
        this.id = id;
    }
}

Here is my build.gradle dependencies:
dependencies {
    implementation ''org.springframework.boot:spring-boot-starter-data-neo4j''
    implementation ''org.springframework.boot:spring-boot-starter-web''
    testImplementation ''org.springframework.boot:spring-boot-starter-test''
    testRuntimeOnly ''org.junit.platform:junit-platform-launcher''

    implementation ''org.projectlombok:lombok''
    annotationProcessor ''org.projectlombok:lombok''
}

I am also using a VariationService to create nodes and relationships. The findAll method on the VariationRepository fails with the following error:
java.lang.IllegalStateException: Required property $enum$name not found for class org.com.example.node.Type
    at org.springframework.data.mapping.PersistentEntity.getRequiredPersistentProperty
    ...


The error seems to indicate an issue with the Type enum mapping.
My question is:

How can I configure Spring Data Neo4j to correctly map enums like
Type as nodes?
Is there a specific way to handle enum
properties in Neo4j when using Spring Data?

', '["java", "spring", "neo4j", "enums"]', '2024-11-15 21:34:12', '2024-11-16 06:15:11', 22, 0, 1, 0, 17017525, 79194110),
        (79192744, 'SonarQube: Invoke method(s) only conditionally - logger executes not needed functions', 'Aren''t loggers in Java supposed to execute functions in the arguments only if the log level is reached?
So here in my example I would have assumed that "Did additional work" would only appear once. What am I missing here?
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;

@Slf4j
public class LogTest {

    @Test
    void test() {
        runDebug();
        runInfo();
    }

    private void runInfo() {
        log.info("hi @ info {}", additional());
    }

    public void runDebug() {
        log.debug("hello @ debug {}", additional());
    }

    private String additional() {
        log.info("Did additional work...");
        return "sup";
    }
}

Console output:
15:10:28.249 [main] INFO test.LogTest -- Did additional work...
15:10:28.252 [main] INFO test.LogTest -- Did additional work...
15:10:28.252 [main] INFO test.LogTest -- hi @ info sup

PS. I read SonarQube: Invoke method(s) only conditionally and SonarQube: "Invoke method(s) only conditionally". I think I understood those, but in my case it doesn''t seem to work correctly. In my work project I have a similar case and SonarQube is saying it''s an issue.
', '["java", "performance", "logging", "sonarqube"]', '2024-11-15 22:15:23', '2024-11-16 00:27:52', 28, 0, 2, 0, 7625197, 79193211),
        (79192831, 'Unable to inject service into ConstraintValidator: jakarta.validation.ValidationException HV000064', 'I''m trying to set up a custom ConstraintValidator to check if a LocalDate is valid by delegating the validation logic to a service.
The validator is applied to a field in an @Entity. My goal is for the validation to execute during Hibernate''s lifecycle events, such as before persisting or removing the entity.
However, when Hibernate attempts to execute the validation, the following exception occurs:

jakarta.validation.ValidationException: HV000064: Unable to instantiate ConstraintValidator: x.xx.xxx.util.validator.DateIsOpenValidator.

Here is the implementation of the validator:
@RequiredArgsConstructor
public class DateIsOpenValidator implements ConstraintValidator<DateIsOpen, LocalDate> {
  private final EntryService entryService;

  @Override
  public boolean isValid(LocalDate date, ConstraintValidatorContext context) {
    return entryService.validateDateIsOpen(date);
  }
}

The exception suggests that the validator cannot be instantiated. My understanding is that using dependency injection for a ConstraintValidator is possible, as explained in the following sources:

Injecting Spring Dependencies into ConstrantValidator
Spring-Boot How to properly inject javax.validation.Validator

Additionally, the Spring Framework documentation indicates that configuring a Bean Validation Provider should suffice for enabling dependency injection in validators.
Am I missing a configuration step or misusing the approach in some way? How can I resolve this issue to allow entryService to be properly injected into the ConstraintValidator?
I have tested many approaches, but these are the most relevant.
Configuring the Validator with LocalValidatorFactoryBean
I have configured the default Validator bean using LocalValidatorFactoryBean:
@Bean
public LocalValidatorFactoryBean validator() {
    return new LocalValidatorFactoryBean();
}

Adding a No-Args Constructor
I attempted to add a no-args constructor to the ConstraintValidator implementation. However, this approach predictably resulted in a null EntryService:
public class DateIsOpenValidator implements ConstraintValidator<DateIsOpen, LocalDate> {

    private EntryService entryService;

    public DateIsOpenValidator() {}

    public DateIsOpenValidator(EntryService entryService) {
        this.entryService = entryService;
    }

    @Override
    public boolean isValid(LocalDate date, ConstraintValidatorContext context) {
        if (entryService == null) {
            throw new IllegalStateException("EntryService has not been initialized");
        }
        return entryService.validateDateIsOpen(date);
    }
}

UPDATE:
Tell Hibernate to match the validator
As stated in this stack overflow question, we can tell Hibernate which Validator to use like so:
  @Bean
  @Lazy
  public HibernatePropertiesCustomizer hibernatePropertiesCustomizer(final Validator validator) {
    return hibernateProperties ->
        hibernateProperties.put("jakarta.persistence.validation.factory", validator);
  }


Observations:

The LocalValidatorFactoryBean configuration alone does not resolve the issue.
Adding a no-args constructor "works around" the ConstraintValidator instantiation exception, but fails to inject dependencies.
This works in the surface; I''m almost tempted to respond to my own question and accept the answer, but I suspect I''m missing something due to the lack of information online.

', '["java", "spring-boot", "validation", "hibernate-validator"]', '2024-11-15 22:41:48', '2024-11-15 22:46:29', 38, 0, 0, 0, 18382345, null),
        (79192844, 'How to unit test a QuerydslBinderCustomizer with Mockito in Spring Data JPA?', 'I''m trying to write a unit test for a QuerydslBinderCustomizer method in a Spring Data JPA repository. Here''s the code I''m working with:
    @Override
    default void customize(QuerydslBindings bindings, QGenericClass root) {
        bindings.bind(String.class)
                .first((SingleValueBinding<StringPath, String>) StringExpression::containsIgnoreCase);
    }

My goal is to test that the customize method correctly configures the binding for String fields with a containsIgnoreCase condition. I have written the following test using Mockito:
       @Test
        void testCustomize() {
                QuerydslBindings bindings = mock(QuerydslBindings.class);
                QGenericClass qGenericClass = mock(QGenericClass .class);

                genericClassRepository.customize(bindings, qGenericClass);

                ArgumentCaptor<SingleValueBinding> captor = ArgumentCaptor.forClass(SingleValueBinding.class);
                verify(bindings).bind(eq(String.class), captor.capture());

                SingleValueBinding<StringPath, String> binding = captor.getValue();
                assertNotNull(binding);

                StringPath stringPath = mock(StringPath.class);
                when(stringPath.containsIgnoreCase(any())).thenReturn(mock(StringExpression.class));

                binding.bind(stringPath, () -> "testValue");
                verify(stringPath).containsIgnoreCase("testValue");
        }

Is there a better way to write this test, or am I missing something?
', '["java", "spring", "unit-testing", "mockito", "querydsl"]', '2024-11-15 22:47:10', '2024-11-15 22:56:33', 17, 1, 0, 0, 20315750, null),
        (79192876, 'How to solve Unrecognized VM option &#39;UseConcMarkSweepGC&#39; in tryuing to install Apache Hbase', 'When i try to run ./start-hbase.cmd i get the following error:
PS C:\\hbasesetup\\hbase-2.6.1\\bin> ./start-hbase.cmd
Unrecognized VM option ''UseConcMarkSweepGC''
Error: Could not create the Java Virtual Machine.
Error: A fatal exception has occurred. Program will exit.
ERROR: Could not determine the startup mode.
Please help me !!!
HERE BELOW THERE''S THE PROPERTY THAT I HAVE SETTED FOLLOWING THIS VIDEO https://youtube.com/watch?v=oTAhcXRIDfA&t=183s
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
-->
<property>
  <name>hbase.rootdir</name>
  <value>C:\\Hfile</value>
</property>

<property>
  <name>hbase.zookeeper.property.dataDir</name>
  <value>C:\\zookeeper</value>
</property>

<property>
  <name>hbase.cluster.distributed</name>
  <value>false</value>
</property>

<property>
  <name>hbase.rootdir</name>
  <value>hdfs://localhost:9820/hbase</value>
</property>

NOTICE THAT: I HAVE REMOVED THIS PIECE FROM THE ORIGINAL FILE ABOVE (can be it the problem ?)
<!--
    The following properties are set for running HBase as a single process on a
    developer workstation. With this configuration, HBase is running in
    "stand-alone" mode and without a distributed file system. In this mode, and
    without further configuration, HBase and ZooKeeper data are stored on the
    local filesystem, in a path under the value configured for `hbase.tmp.dir`.
    This value is overridden from its default value of `/tmp` because many
    systems clean `/tmp` on a regular basis. Instead, it points to a path within
    this HBase installation directory.

    Running against the `LocalFileSystem`, as opposed to a distributed
    filesystem, runs the risk of data integrity issues and data loss. Normally
    HBase will refuse to run in such an environment. Setting
    `hbase.unsafe.stream.capability.enforce` to `false` overrides this behavior,
    permitting operation. This configuration is for the developer workstation
    only and __should not be used in production!__

    See also https://hbase.apache.org/book.html#standalone_dist
  -->
  <property>
    <name>hbase.cluster.distributed</name>
    <value>false</value>
  </property>
  <property>
    <name>hbase.tmp.dir</name>
    <value>./tmp</value>
  </property>
  <property>
    <name>hbase.unsafe.stream.capability.enforce</name>
    <value>false</value>
  </property>
</configuration>

', '["java", "hadoop", "hbase"]', '2024-11-15 22:57:39', '2024-11-16 18:44:58', 9, 0, 0, 0, 23020335, null),
        (79192927, 'Why is my @Recorder, use in a custum Quarkus Extension, a proxy?', 'Im unable run testet in Intellij, using kotlin, the @Recoder is not registering as a @Recorder in quarkus-core-deployment. The when I take a look in the debugger i can se that the recorder is a Proxy object. Why dos this happen? When do Quarkus create proxy objects and can i disable it for å class?

This is not a problem when running form command line. This line is the problem in quarkus-core-development that dosent work with a Proxy class:
@SuppressWarnings("deprecation")
private static boolean isRecorder(AnnotatedElement element) {
    return element.isAnnotationPresent(Recorder.class);
}

I want to able to run testes in Intellij without a problem and not get this stacktrace:
Failed to load steps from class [hidden]
java.lang.RuntimeException: Failed to load steps from class [hidden]
    at io.quarkus.deployment.ExtensionLoader.loadStepsFrom(ExtensionLoader.java:169)
    at io.quarkus.deployment.QuarkusAugmentor.run(QuarkusAugmentor.java:107)
    at io.quarkus.runner.bootstrap.AugmentActionImpl.runAugment(AugmentActionImpl.java:350)
    at io.quarkus.runner.bootstrap.AugmentActionImpl.createInitialRuntimeApplication(AugmentActionImpl.java:272)
    at io.quarkus.runner.bootstrap.AugmentActionImpl.createInitialRuntimeApplication(AugmentActionImpl.java:62)
    at io.quarkus.test.junit.QuarkusTestExtension.doJavaStart(QuarkusTestExtension.java:219)
    at io.quarkus.test.junit.QuarkusTestExtension.ensureStarted(QuarkusTestExtension.java:601)
    at io.quarkus.test.junit.QuarkusTestExtension.beforeAll(QuarkusTestExtension.java:651)
    at java.base/java.util.ArrayList.forEach(ArrayList.java:1596)
Caused by: java.lang.RuntimeException: public void [hidden],[hidden].BeanContainerBuildItem,[hidden]) is marked @Record but does not inject an @Recorder object
    at io.quarkus.deployment.ExtensionLoader.loadStepsFromClass(ExtensionLoader.java:467)
    at io.quarkus.deployment.ExtensionLoader.loadStepsFrom(ExtensionLoader.java:167)
    ... 8 more

', '["java", "kotlin", "intellij-idea", "quarkus"]', '2024-11-15 23:07:57', '2024-11-18 15:37:51', 21, 0, 1, 0, 13833816, null),
        (79192950, 'zookeeper SSL Client Authentication with ./zkCli.sh : Certificate chain is empty', 'Why im working on on premise zookeeper node on version 3.8.4 with java 11
Here is my `zoo.cfg` :
tickTime=2000
dataDir=/var/lib/zookeeper
clientPort=2181
#admin.enableServer=false
metricsProvider.className=org.apache.zookeeper.metrics.impl.NullMetricsProvider
# Standard ZooKeeper ports
secureClientPort=2281
ssl.protocol=TLSv1.2

ssl.clientAuth=need

And im launching it with the following command:
sudo JVMFLAGS=''
-Dzookeeper.serverCnxnFactory=org.apache.zookeeper.server.NettyServerCnxnFactory
-Dzookeeper.ssl.keyStore.location=/etc/zookeeper/ssl/zookeeper.keystore.jks
-Dzookeeper.ssl.keyStore.password=password
-Dzookeeper.ssl.trustStore.location=/etc/zookeeper/ssl/zookeeper.truststore.jks
-Dzookeeper.ssl.trustStore.password=password'' /opt/zookeeper/apache-zookeeper-3.8.4-bin/bin/zkServer.sh start

Now when i try testing ssl connection with client auth im using the following
sudo CLIENT_JVMFLAGS=''
-Dzookeeper.clientCnxnSocket=org.apache.zookeeper.ClientCnxnSocketNetty
-Dzookeeper.client.secure=true
-Dzookeeper.ssl.trustStore.location=/etc/zookeeper/ssl/zookeeper.truststore.jks
-Dzookeeper.ssl.trustStore.password=password
-Dzookeeper.ssl.keyStore.location=/etc/zookeeper/ssl/zookeeper.keystore.jks
-Dzookeeper.ssl.keyStore.password=password
-Dzookeeper.ssl.clientAuth=need
-Dzookeeper.ssl.endpoint.identification.algorithm='' ./zkCli.sh -server hostname:2281

Then I can see on zookeepeer server logs the famous SSLHandShakeException: Empty server certificate chain
I well understand it but when launching my zkCli with -Djavax.net.debug=all I can see the following in the logs :
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.330 CET|X509KeyManagerImpl.java:772|Ignore alias 83fec6f7-564d-4126-93b1-43e3fea2e983: key algorithm does not match
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.330 CET|X509KeyManagerImpl.java:405|KeyMgr: no matching key found
javax.net.ssl|ALL|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.330 CET|X509Authentication.java:246|No X.509 cert selected for EC
javax.net.ssl|WARNING|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.330 CET|CertificateRequest.java:809|Unavailable authentication scheme: ecdsa_secp256r1_sha256
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.330 CET|X509KeyManagerImpl.java:772|Ignore alias 83fec6f7-564d-4126-93b1-43e3fea2e983: key algorithm does not match
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.330 CET|X509KeyManagerImpl.java:405|KeyMgr: no matching key found
javax.net.ssl|ALL|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.331 CET|X509Authentication.java:246|No X.509 cert selected for EC
javax.net.ssl|WARNING|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.331 CET|CertificateRequest.java:809|Unavailable authentication scheme: ecdsa_secp384r1_sha384
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.331 CET|X509KeyManagerImpl.java:772|Ignore alias 83fec6f7-564d-4126-93b1-43e3fea2e983: key algorithm does not match
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.331 CET|X509KeyManagerImpl.java:405|KeyMgr: no matching key found
javax.net.ssl|ALL|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.331 CET|X509Authentication.java:246|No X.509 cert selected for EC
javax.net.ssl|WARNING|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.331 CET|CertificateRequest.java:809|Unavailable authentication scheme: ecdsa_secp521r1_sha512
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.331 CET|X509KeyManagerImpl.java:789|Ignore alias 83fec6f7-564d-4126-93b1-43e3fea2e983: issuers do not match
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.331 CET|X509KeyManagerImpl.java:405|KeyMgr: no matching key found
javax.net.ssl|ALL|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.331 CET|X509Authentication.java:246|No X.509 cert selected for RSA
javax.net.ssl|WARNING|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.333 CET|CertificateRequest.java:809|Unavailable authentication scheme: rsa_pss_rsae_sha256
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.334 CET|X509KeyManagerImpl.java:789|Ignore alias 83fec6f7-564d-4126-93b1-43e3fea2e983: issuers do not match
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.334 CET|X509KeyManagerImpl.java:405|KeyMgr: no matching key found
javax.net.ssl|ALL|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.334 CET|X509Authentication.java:246|No X.509 cert selected for RSA
javax.net.ssl|WARNING|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.335 CET|CertificateRequest.java:809|Unavailable authentication scheme: rsa_pss_rsae_sha384
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.335 CET|X509KeyManagerImpl.java:789|Ignore alias 83fec6f7-564d-4126-93b1-43e3fea2e983: issuers do not match
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.335 CET|X509KeyManagerImpl.java:405|KeyMgr: no matching key found
javax.net.ssl|ALL|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.335 CET|X509Authentication.java:246|No X.509 cert selected for RSA
javax.net.ssl|WARNING|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.335 CET|CertificateRequest.java:809|Unavailable authentication scheme: rsa_pss_rsae_sha512
javax.net.ssl|WARNING|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.335 CET|CertificateRequest.java:796|Unsupported authentication scheme: rsa_pss_pss_sha256
javax.net.ssl|WARNING|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.335 CET|CertificateRequest.java:753|Unsupported authentication scheme: rsa_pss_pss_sha384
javax.net.ssl|WARNING|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.335 CET|CertificateRequest.java:753|Unsupported authentication scheme: rsa_pss_pss_sha512
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.336 CET|X509KeyManagerImpl.java:789|Ignore alias 83fec6f7-564d-4126-93b1-43e3fea2e983: issuers do not match
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.336 CET|X509KeyManagerImpl.java:405|KeyMgr: no matching key found
javax.net.ssl|ALL|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.336 CET|X509Authentication.java:246|No X.509 cert selected for RSA
javax.net.ssl|WARNING|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.336 CET|CertificateRequest.java:809|Unavailable authentication scheme: rsa_pkcs1_sha256
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.336 CET|X509KeyManagerImpl.java:789|Ignore alias 83fec6f7-564d-4126-93b1-43e3fea2e983: issuers do not match
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.336 CET|X509KeyManagerImpl.java:405|KeyMgr: no matching key found
javax.net.ssl|ALL|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.336 CET|X509Authentication.java:246|No X.509 cert selected for RSA
javax.net.ssl|WARNING|0E|nioEventLoopGroup-2-1|2024-11-15 10:56:35.336 CET|CertificateRequest.java:809|Unavailable authentication scheme: rsa_pkcs1_sha384
javax.net.ssl|DEBUG|0E|nioEventLoopGroup-2-1|2024

I do not understand why he doesn''t find compatible entry from keystore here :/
Here is how i create my keystore and truststore
sudo keytool -importkeystore \\
         -srckeystore "$PFX_FILE_PATH" \\
         -srcstoretype pkcs12 \\
         -destkeystore zookeeper.keystore.jks \\
         -deststoretype JKS
         
sudo keytool -exportcert \\
  -alias 83fec6f7-564d-4126-93b1-43e3fea2e983 \\
  -file my-ca.cer \\
  -keystore "$PFX_FILE_PATH" \\
  -storetype PKCS12
 
sudo keytool -import \\
         -alias 83fec6f7-564d-4126-93b1-43e3fea2e983 \\
         -file my-ca.cer \\
         -keystore zookeeper.truststore.jks

I was expecting a succesful 2 way mutual ssl
', '["java", "ssl", "apache-zookeeper", "keystore", "truststore"]', '2024-11-15 23:11:49', '2024-11-15 23:11:49', 15, 0, 0, 0, 19222339, null),
        (79192994, 'Question about liferay category viewing permissions', 'I have a question about liferay''s premission checks (i think). I am working in liferay 7.3.5.
I have a bit of java code that retrieves a list of categories and I then wish to display this list to users. But I noticed that my code is unable to retrieve anything when the user isn''t logged in, when logged in it does work however(so i know the problem isn''t in the display). I would like that to be possible, for a guest to view this list.
I have checked and double checked the permissions on the vocabulary and the categories themselves but viewing rights for guests are enabled for everything.
This is my getter code:
public List<AssetCategory> getSiteCategories(long vocabId) throws PortalException {
    List<AssetCategory> categories = new ArrayList<>();
    categories = AssetCategoryServiceUtil.getVocabularyCategories(vocabId, -1, -1, null);
    
    return categories.stream()
        .sorted(Comparator.comparing(AssetCategory::getName, String.CASE_INSENSITIVE_ORDER))
        .collect(Collectors.toList());
}

Any ideas why this wouldn''t be able to retrieve anything for a guest?
If more code needed or context I will happily provide it.
', '["java", "liferay", "liferay-7"]', '2024-11-15 23:22:58', '2024-11-16 18:50:03', 30, -3, 1, 0, 15196570, null),
        (79193034, 'VSCode Java Autocomplete Not Working After Line Break Comment in Method Chaining with Lambdas', 'I’m experiencing an issue with Visual Studio Code when writing Java code. Specifically, when I add // at the end of a line to force a line break for formatting purposes, the autocomplete feature of the Extension Pack for Java stops working properly.
Details:

Java Version: OpenJDK 17
Extension Pack for Java: v0.29.0

My settings.json configuration for Java:
{
  ...
  "[java]": {
    "editor.defaultFormatter": "redhat.java"
    },
  "java.format.settings.profile": "GoogleStyle",
  ...
}

Example Code
basecode
interface InterfaceSomething {
    void doSomething();
}

class Something {
    private InterfaceSomething inter1;
    private InterfaceSomething inter2;

    public Something setInter1(InterfaceSomething inter1) {
        this.inter1 = inter1;
        return this;
    }

    public Something setInter2(InterfaceSomething inter2) {
        this.inter2 = inter2;
        return this;
    }
}

Example without "//"
new Something()
  .setInter1(() -> {
    System.out.println("doSomething1");
  })
  .set// Autocomplete suggests methods after typing ''.'' ("setInter1" or "setInter2")
                .

Example with "//" (Autocomplete does not work):
new Something()
  .setInter1(() -> {
    System.out.println("doSomething1"); // Adding ''//'' here to force a line break
  })
  .set// Autocomplete does not suggest methods after typing ''.'' or "Trigger Suggest" Command 

Question:

Why does adding // at the end of a line affect the autocomplete functionality in VSCode when writing Java code with method chaining and lambda functions?
Is there a way to fix this issue or an alternative method to enforce line breaks without disrupting autocomplete?

Any insights or suggestions would be greatly appreciated.
What I’ve Tried but not work

Restarting VSCode.
Reinstalling the Extension Pack for Java.
"Language Support for Java(TM) by Red" Command "Java: Clean Java Language Server Workspace"

', '["java", "spring-boot", "visual-studio-code", "autocomplete", "autosuggest"]', '2024-11-15 23:33:17', '2024-11-15 23:33:17', 15, 0, 0, 0, 28318429, null),
        (79193074, 'Permissions in manifest don&#39;t show up in app info', 'I have specified the needed app''s permissions, but they don''t show up in the app info area in Settings, and of course the permission request call doesn''t produce any request pop-up.
Manifest merge doesn''t show any conflicts. I have invalidated caches and Sync''d gradle files many times already.
I don''t know what else to do to get this working.
enter image description here
I have tried to invalidate cache, re-sync gradle files and add tags to the uses-permission xml entries, and was expecting the permissions to show up on the app''s info area in Settings, but didn''t get it.
I''ll add the whole manifest below:
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.SET_WALLPAPER"/>


    <application
        android:allowBackup="true"
        android:dataExtractionRules="@xml/data_extraction_rules"
        android:fullBackupContent="@xml/backup_rules"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.FondoFinal"
        tools:targetApi="31">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>

', '["java", "android"]', '2024-11-15 23:46:13', '2024-11-18 09:13:56', 25, 1, 2, 0, 8960507, null),
        (79193118, 'Why is the snapshot retrieval returning null even though the image appears to be successfully cached?', 'I''m trying to implement image caching in my Android app using Coil. The goal is to ensure images are cached in both memory and disk, and then retrieve the cached image as a Uri. However, I''m encountering an issue where the path is null when attempting to retrieve the cached image snapshot.
Here’s my getImage function:
private suspend fun getImage(imageUri: String, force: Boolean): String {
        Log.d("TAG", "getImage: $imageUri")

        // Explicitly set a custom cache key
        val cacheKey = imageUri.hashCode().toString()

        // Create the ImageRequest
        val request = ImageRequest.Builder(context).diskCachePolicy(CachePolicy.ENABLED)
            .memoryCachePolicy(CachePolicy.ENABLED)
            .data(imageUri)
            .diskCacheKey(cacheKey).memoryCacheKey(cacheKey) // Ensure the key is not null
            .build()

        // Ensure the image is cached
        with(context.imageLoader) {
            if (force) {
                diskCache?.remove(cacheKey)
                memoryCache?.remove(MemoryCache.Key(cacheKey))
                Log.d("TAG", "Cache cleared for key: $cacheKey")
            }

            val result = execute(request)
            if (result is ErrorResult) {
                Log.e("TAG", "Image caching failed: ${result.throwable}")
                throw result.throwable
            } else {
                Log.d("TAG", "Image successfully cached with key: $cacheKey")
            }
        }

        // Retrieve the cached image
        val path = try {
            context.imageLoader.diskCache?.openSnapshot(cacheKey)?.use { snapshot ->
                val imageFile = snapshot.data.toFile()
                Log.d("TAG", "Image file created: ${imageFile.absolutePath}")

                val contentUri = getUriForFile(
                    context,
                    "dev.jay.momentbox.widget.fileprovider",
                    imageFile
                )
                Log.d("TAG", "Content URI created: $contentUri")

                contentUri.toString()
            }
        } catch (e: Exception) {
            Log.e("TAG", "Error retrieving image from cache: $imageUri", e)
            null
        }

        // Log and return result
        if (path == null) {
            Log.e("TAG", "Path is null; image not found in cache.")
            throw IllegalArgumentException("Couldn''t find cached file for the provided URI")
        } else {
            Log.d("TAG", "Retrieved image path: $path")
        }

        return path
    }

Here’s the log output:
2024-11-15 21:24:10.216  9155-9227  TAG                     dev.jay.momentbox                    D  getImage: content://media/picker_get_content/0/com.android.providers.media.photopicker/media/1000015329
2024-11-15 21:24:10.217  9155-9198  WM-Processor            dev.jay.momentbox                    D  Work WorkGenerationalId(workSpecId=8c15c3a4-df4b-4828-9429-79f8d50901f5, generation=0) is already enqueued for processing
2024-11-15 21:24:10.505  9155-9227  TAG                     dev.jay.momentbox                    D  Image successfully cached with key: -614239324
2024-11-15 21:24:10.512  9155-9227  TAG                     dev.jay.momentbox                    E  Path is null; image not found in cache.

', '["java", "android", "kotlin", "android-studio", "coil"]', '2024-11-16 00:00:53', '2024-11-16 00:00:53', 35, 0, 0, 0, 15808334, null),
        (79193241, 'Throw exception when trying to put a number on a float that will be rounded and lose precision', 'I need to process a CSV. The users define if a column has floats or doubles. The thing is, sometimes they put doubles in a float column, and after it rounds the values and the users only find out later.
I''d like to not let this behaviour happen if it''s at all possible.
So, if we try to store a number too big on a float, it doesn''t round it but instead throws an exception.
I''m aware that there are some numbers that cannot be represented correctly like when we do 0.1 + 0.2, this is not what I''m trying to avoid.
I''ve considered storing everything on a BigDecimal, but currently that has too much impact on the codebase so I''d prefer to avoid it for now.
', '["java", "ieee-754"]', '2024-11-16 00:37:25', '2024-11-16 00:37:25', 45, 0, 0, 0, 1013, null),
        (79193311, 'JavaFX extruding shape', 'I''m trying to extrude this shape down.
So far I was able to draw a simple shape made of lines. (I''m planning to also use polylines and arcs in contour) , connect all the contour lines in path and translate down. Next step should be to draw walls of my shape. but I''m not sure how it should look like. Any help will be really appreciated

public void addCustomPart(DXFPart part) {
    double partThickness = 20.0;
    addCustomPartFlat(part);
    ArrayList<DXFLayer> partLayers = part.getDxfLayerArr();
    for (DXFLayer dxfLayer:partLayers) {
        if (dxfLayer.getName().equals(DataMgr.getLayerContour().getLayerName())) {
            Path contourPath = ContourPathBuilder.buildContourPath(dxfLayer);
            contourPath.setFill(null); 
            contourPath.setStroke(DataMgr.getLayerContour().getLayerPaint()); 
            contourPath.getTransforms().add(new Rotate(90, 0, 0, 0, Rotate.X_AXIS));
            contourPath.setTranslateY(partThickness);
            contentGroup.getChildren().add(contourPath);
            extrudeContourPath(contourPath, partThickness);
        }
    }
}

I''m expecting to draw a whole 3d shape extruded from a path.
', '["java", "javafx", "3d"]', '2024-11-16 00:57:44', '2024-11-16 02:31:11', 35, 0, 0, 0, 16834087, null),
        (79193413, '&quot;Possible flush inside a loop&quot; warning in Android Studio', 'I''m using Android Studio with Java and LibGDX.
Android studio warns the draw line with "Possible flush inside a loop", with this detailed description:

Inspection info: Looks for the possibility of a flush of a batch or renderer occuring
inside a loop, either directly or indirectly. For performance reasons
care should be taken to not cause unnecessary flushes, and to limit
the number of flushes per frame as much as possible.

DelayedRemovalArray<MyEntity> myEntities = ...;

bricks.begin();
for(MyEntity myEntity : myEntities) {
    myEntity.draw(game.getBatch()); // warning: Possible flush inside a loop
}
bricks.end();

the MyEntity.draw method:
Matrix4 tempMatrix = new Matrix4();
Matrix4 originalMatrix = new Matrix4();

NinePatchDrawable ninePatchDrawable = ...;

public void draw(SpriteBatch batch) {
    originalMatrix.set(batch.getTransformMatrix());

    tempMatrix.set(originalMatrix);
    
    tempMatrix
        .translate(myEntity.width/2, myEntity.height/2, 0)
        .rotate(0, 0, myEntity.angle, 10)
        .translate(-myEntity.width/2, -myEntity.height/2, 0);
    batch.setTransformMatrix(tempMatrix);

    ninePatchDrawable.draw(batch, ...);

    batch.setTransformMatrix(originalMatrix); 
}

If I remove the two batch.setTransformMatrix calls, the warning goes away but I need to do that otherwise the ninepatch will not be draw at the right position, due to the fact that the ninepatch.draw method does not consider the body center when applying the rotation... About this issue with ninepatches I opened a dedicated SO question here
So, how to do it without receiving that warning? Is there a better way to do this?
Thanks
', '["java", "libgdx"]', '2024-11-16 01:29:21', '2024-11-17 23:07:39', 39, 1, 1, 0, 2342558, 79194681),
        (79193438, 'How to do an insert with a column of an enum type with SimpleJdbcInsert?', 'I have to insert some records into my db using Jdbc. One of the columns, "type" is of a custom data type (let''s call it "test_type") and that''s making the insert fail.
Currently, I have this code (simplified):
    Map<String, Object> testRecord = new HashMap<String, Object>() {{
        put("name", "whatever");
        put("type", "planning");
    }};

    SimpleJdbcInsert insertTest = new SimpleJdbcInsert(jdbcTemplate)
        .withTableName("test_table")
        .usingColumns(testRecord.keySet().toArray(new String[0]))
        .usingGeneratedKeyColumns("id");

    Number testId = insertTest.executeAndReturnKey(testRecord);

that gives this error:
PreparedStatementCallback; bad SQL grammar []; nested exception is org.postgresql.util.PSQLException: ERROR: column "type" is of type test_type but expression is of type character varying
  Hint: You will need to rewrite or cast the expression.

The query in SQL works fine, even when passing it simply as a string, so I thought it would work here too. It doesn''t, obviously.
Does anyone know how I could fix this? I tried appending "::test_type" to the string but that does not seem to work either.
', '["java", "jdbc", "simplejdbcinsert"]', '2024-11-16 01:38:27', '2024-11-16 17:41:31', 24, 0, 1, 0, 4165652, null),
        (79193441, 'How does one resolve an issue regarding creating a task to handle Node project files in &#39;build.gradle&#39;?', 'While trying to create a task to handle Node project files, one  currently has the following:
tasks.register(''buildUi'', Exec) { task ->
    task.workingDir = uiProjectDir
    task.inputs.dir("${uiProjectDir}/src")
    task.inputs.dir("${uiProjectDir}/node_modules")
    task.outputs.dir(uiDistDir)
    task.dependsOn tasks.named(''npmInstall'')

    // Use bash directly when in WSL
    task.commandLine ''bash'', ''-c'', ''npm run build''
}

Having seen two warnings - first is on the first line

''register'' cannot be applied to ''(java.lang.String, java.lang.Class<org.gradle.api.tasks.Exec>, groovy.lang.Closure)''

The second is on task.dependsOn tasks.named(''npmInstall'')

''named'' cannot be applied to ''(java.lang.String)''

Asking CoPilot, it just went back and forth between
task.dependsOn tasks.getByName(''npmInstall'') and tasks.register(''buildUi'', Exec).configure { task ->
But they all seemed to have the same warning. What is the proper way to do this to avoid the warnings?
Update
This was another suggestion....
tasks.register(''buildUi'', Exec) {
    workingDir = uiProjectDir
    inputs.dir("${uiProjectDir}/src")
    inputs.dir("${uiProjectDir}/node_modules")
    outputs.dir(uiDistDir)
    dependsOn tasks.named(''npmInstall'')

    // Use bash directly when in WSL
    commandLine ''bash'', ''-c'', ''npm run build''
}

Which is the functional equivalent without the lambda expression? However, the warnings still persisted...

''register'' cannot be applied to ''(java. lang. String, java. lang. Class<org. gradle. api. tasks. Exec>, groovy. lang. Closure)''


''named'' cannot be applied to ''(java. lang. String)''


------------------------------------------------------------
Gradle 8.10.2
------------------------------------------------------------

Build time:    2024-09-23 21:28:39 UTC
Revision:      415adb9e06a516c44b391edff552fd42139443f7

Kotlin:        1.9.24
Groovy:        3.0.22
Ant:           Apache Ant(TM) version 1.10.14 compiled on August 16 2023
Launcher JVM:  23 (Oracle Corporation 23+37-2369)
Daemon JVM:    /home/jgleason/lib/java/jdk-23 (no JDK specified, using current Java home)
OS:            Linux 5.15.153.1-microsoft-standard-WSL2 amd64

', '["java", "gradle", "gradle-task"]', '2024-11-16 01:38:50', '2024-11-17 20:40:59', 48, 1, 0, 0, 125212, null),
        (79193562, 'I face the Java Problem MY program gave me error .UnsatisfiedLinkError but the file is they', 'I have a Java program that uses a native DLL file. It works perfectly on my development machine but fails with a UnsatisfiedLinkError or a "file not found" error when I run it on another device.
I already set all the settings for the dll and intelliJ and it still gave this error and I also checked dll and java is 64 bit.
The file is in the correct location.
My Questions:

What are other potential reasons the DLL cannot be found, even if it
exists at the specified path?
Are there any additional system or Java configurations required to load native libraries on a new device?
Could this be related to dependencies in the DLL itself, and if so,    how can I debug this?


#Exception in thread "main" java.lang.UnsatisfiedLinkError: Can''t load library:
C:\\Users\\foru\\CLionProjects\\CheckerGameLibrary\\cmake-build-debug\\libCheckerGameLibrary.dll
at java.base/java.lang.ClassLoader.loadLibrary(ClassLoader.java:2422)
at java.base/java.lang.Runtime.load0(Runtime.java:852)
at java.base/java.lang.System.load(System.java:2025)
at main.Main.(Main.java:156)
Process finished with exit code 1#

    package main;
    
    import javax.swing.*;
    import java.awt.*;
    import java.awt.event.MouseAdapter;
    import java.awt.event.MouseEvent;
    //i send you complete file just unzip that and i set the setting in the code so set the run into Current file like that
    public class Main {
        private static final int BOARD_SIZE = 8;
        private long gamePtr; // Pointer to the C++ game instance
        private int[][] boardState; // 2D array to hold board state
        private JButton[][] buttons; // To keep track of buttons for painting
        private JLabel turnLabel; // Label to show which player''s turn it is
        private int selectedRow = -1; // No piece selected initially
        private int selectedCol = -1; // No piece selected initially
    
        public Main() {
            // Initialize the game and fetch the initial board state
            gamePtr = nativeCreate();
            boardState = fetchBoardState();
    
            // Set up GUI
            JFrame frame = new JFrame("Checker Game");
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            frame.setSize(600, 600); // Increased size for better visual
            frame.setLayout(new BorderLayout()); // Use BorderLayout for the frame
    
            // Create the turn label
            turnLabel = new JLabel("Current Turn: Player " + getCurrentPlayer(gamePtr));
            turnLabel.setHorizontalAlignment(SwingConstants.CENTER);
            frame.add(turnLabel, BorderLayout.NORTH); // Add label at the top
    
            JPanel boardPanel = new JPanel(new GridLayout(BOARD_SIZE, BOARD_SIZE));
            buttons = new JButton[BOARD_SIZE][BOARD_SIZE];
    
            initializeBoard(boardPanel);
            frame.add(boardPanel, BorderLayout.CENTER); // Add board panel to the center
    
            frame.setVisible(true);
        }
    
        public void initializeBoard(JPanel boardPanel) {
            for (int row = 0; row < BOARD_SIZE; row++) {
                for (int col = 0; col < BOARD_SIZE; col++) {
                    final int finalRow = row; // Declare final variable for row
                    final int finalCol = col; // Declare final variable for col
    
                    JButton button = new JButton() {
                        @Override
                        protected void paintComponent(Graphics g) {
                            super.paintComponent(g);
                            drawPiece(g, finalRow, finalCol); // Use finalRow and finalCol
                        }
                    };
    
                    // Set button background color based on the position
                    if ((row + col) % 2 == 0) {
                        button.setBackground(new Color(255, 206, 158)); // Light color
                    } else {
                        button.setBackground(new Color(186, 120, 49)); // Dark color
                    }
                    button.setOpaque(true);
                    button.setBorderPainted(false); // Remove button border
                    buttons[row][col] = button; // Store button reference
    
                    button.addMouseListener(new MouseAdapter() {
                        @Override
                        public void mouseClicked(MouseEvent e) {
                            if (selectedRow == -1) { // No piece selected
                                if (boardState[finalRow][finalCol] == getCurrentPlayer(gamePtr)) {
                                    selectedRow = finalRow;
                                    selectedCol = finalCol;
                                    button.setBackground(Color.YELLOW); // Highlight selected piece
                                }
                            } else { // Piece has been selected
                                if (movePiece(gamePtr, selectedRow, selectedCol, finalRow, finalCol)) {
                                    boardState = fetchBoardState(); // Refresh board state after move
                                    updateTurnLabel(); // Update turn label after a successful move
                                    checkGameOver(); // Check if game is over
                                }
                                resetSelection(); // Clear selection regardless of move success
                            }
                            updateBoard(); // Update the visual board
                        }
                    });
    
                    boardPanel.add(button); // Add button to the board panel
                }
            }
        }
    
        public void drawPiece(Graphics g, int row, int col) {
            if (boardState != null && boardState[row][col] != 0) {
                int pieceColor = boardState[row][col];
                g.setColor(pieceColor == 1 ? Color.BLACK : Color.WHITE);
                g.fillOval(10, 10, 50, 50); // Adjusted size of pieces
            }
        }
    
        public int[][] fetchBoardState() {
            int[] array = getBoardState(gamePtr); // Replace jintArray with int[]
            int[][] state = new int[BOARD_SIZE][BOARD_SIZE];
    
            for (int row = 0; row < BOARD_SIZE; row++) {
                for (int col = 0; col < BOARD_SIZE; col++) {
                    state[row][col] = array[row * BOARD_SIZE + col]; // Adjust for 1D indexing
                }
            }
            return state;
        }
    
        public void updateBoard() {
            for (int row = 0; row < BOARD_SIZE; row++) {
                for (int col = 0; col < BOARD_SIZE; col++) {
                    buttons[row][col].repaint(); // Repaint each button
                }
            }
        }
    
        public void updateTurnLabel() {
            int currentPlayer = getCurrentPlayer(gamePtr); // Get the current player
            turnLabel.setText("Current Turn: Player " + currentPlayer); // Update label text
        }
    
        public void checkGameOver() {
            int winner = checkWinner(gamePtr);
            if (winner != 0) {
                JOptionPane.showMessageDialog(null, "Player " + winner + " wins!");
                int response = JOptionPane.showConfirmDialog(null, "Play again?", "Game Over", JOptionPane.YES_NO_OPTION);
                if (response == JOptionPane.YES_OPTION) {
                    resetGame();
                } else {
                    System.exit(0);
                }
            }
        }
    
        public void resetGame() {
            resetGameNative(gamePtr); // Reset the game on the native side
            boardState = fetchBoardState(); // Refresh the board state
            updateBoard(); // Repaint the board
            updateTurnLabel(); // Update the turn label for a fresh start
        }
    
        public void resetSelection() {
            if (selectedRow != -1 && selectedCol != -1) {
                buttons[selectedRow][selectedCol].setBackground((selectedRow + selectedCol) % 2 == 0 ? new Color(255, 206, 158) : new Color(186, 120, 49));
            }
            selectedRow = -1;
            selectedCol = -1;
        }
    
        static {
            //here in main function paste that
          //  System.out.println("Loading library from: " + System.getProperty("java.library.path"));// donot change that because we both have same name just change
            System.load("C:/Users/foru/CLionProjects/CheckerGameLibrary/cmake-build-debug/libCheckerGameLibrary.dll");
            // Correct way to load
        }
        public native long nativeCreate();
        public native int[] getBoardState(long ptr); // Change jintArray to int[]
        public native boolean movePiece(long ptr, int fromRow, int fromCol, int toRow, int toCol); // Native method to move pieces
        public native int getCurrentPlayer(long ptr); // Get the current player''s ID
        public native int checkWinner(long ptr); // Native method to check for winner
        public native void resetGameNative(long ptr); // Native method to reset the game
    
        public static void main(String[] args) {
            SwingUtilities.invokeLater(Main::new);
        }
    }

', '["java", "dll", "java-native-interface"]', '2024-11-16 02:25:39', '2024-11-16 02:46:30', 44, 0, 0, 0, 23528664, null),
        (79193576, 'What is the compiler doing, Begginer Java code', 'public class Main {

    public static void main (String[] args) {
        int a = 2, z;
        z= ++a + a++;
        System.out.println("z is " + z);
        System.out.println("a is " + a);
    }

}

Output is
z is 6
a is 4

I am confused about why z is not 5, It looks like I am misunderstanding the excution order due to the operator precedence, is a++ done first then we use the new a value to do ++a? so it is 4+2? or what is going on?
', '["java", "operator-precedence"]', '2024-11-16 02:33:06', '2024-11-16 16:15:41', 52, -6, 0, 0, 16539601, null),
        (79193631, 'Setting width for TRANSPARENT Stage -&gt; gtk_window_resize: assertion &#39;height &gt; 0&#39; failed', 'I am trying to use transparent Stage. However, I can''t set its width/height. When I set the width I get error about height, and if I try to set the height I get error about width.
This is my code
public class Test11 extends Application {

    @Override
    public void start(Stage primaryStage) {

        var button = new Button("Test");
        button.setOnAction(e -> primaryStage.setWidth(primaryStage.getWidth() - 10));
        var vBox = new VBox(button);
        vBox.setStyle("-fx-background-color: yellow");
        var scene = new Scene(vBox, 400, 300);
        primaryStage.initStyle(StageStyle.TRANSPARENT);
        primaryStage.setScene(scene);
        primaryStage.show();

    }

    public static void main(String[] args) {
        launch(args);
    }
}

And if you click the button you will get
(java:61615): Gtk-CRITICAL **: 20:46:53.565: gtk_window_resize: assertion ''height > 0'' failed

I use JavaFX 23, Java 22.0.1, Ubuntu 20.04. Could anyone say if it is a bug or I am doing something wrong?
', '["java", "javafx"]', '2024-11-16 02:53:04', '2024-11-16 02:53:04', 29, 0, 0, 0, 26656564, null),
        (79193710, 'How can I show list of users in Magnolia using a Custom Content App using [mgnl:user]', 'I can only manage to show the users lists but when I''m trying to filter it by "email" property it doesn''t get reflected
This is the yaml file along with my implementationClass java file:
subApps: 
    browser: 
        subAppClass: info.magnolia.ui.contentapp.browser.BrowserSubApp 
        class: info.magnolia.ui.contentapp.browser.ConfiguredBrowserSubAppDescriptor

        contentConnector:
          implementationClass: my.company.CompanyEmailJcr
          defaultOrder: jcrName
          includeProperties: false
          rootPath: /
          workspace: users
          nodeTypes:
            - name: mgnl:user
        
        workbench:
          editable: false
          contentViews:
            - name: list
              class: info.magnolia.ui.workbench.list.ListPresenterDefinition
              columns:
                - name: id
                  class: info.magnolia.ui.workbench.column.definition.PropertyColumnDefinition
                  propertyName: id
                - name: email
                  class: info.magnolia.ui.workbench.column.definition.PropertyColumnDefinition
                  propertyName: email
                - name: lastLogin
                  class: info.magnolia.ui.workbench.column.definition.PropertyColumnDefinition
                  propertyName: lastLogin

CompanyEmailJcr.java file 

public class CompanyEmailJcr extends JcrContentConnector {
    private static final Logger log = LoggerFactory.getLogger(CompanyEmailJcr.class);
    
    public CompanyEmailJcr (VersionManager versionManager, JcrContentConnectorDefinition definition) {
        super(versionManager, definition);
        log.info("Initializing CompanyEmailJcr ...");
        fetchUsers();
    }
    
    public void fetchUsers() {
        try {
            // Get the JCR session for the "users" workspace
            Session session = MgnlContext.getJCRSession("users");
    
            // Create the query manager to execute the query
            QueryManager queryManager = session.getWorkspace().getQueryManager();
            String queryStr = "SELECT * FROM [mgnl:user] WHERE email IS NOT NULL";
            log.info("Executing query: {}", queryStr);
            Query query = queryManager.createQuery(queryStr, Query.JCR_SQL2);
    
            // Execute the query
            QueryResult queryResult = query.execute();
            NodeIterator nodeIterator = queryResult.getNodes();
    
            // Iterate through the results and log information
            if (!nodeIterator.hasNext()) {
                log.info("No nodes found matching the query.");
            }
    
            while (nodeIterator.hasNext()) {
                Node node = nodeIterator.nextNode();
                log.info("Found node at path: {}", node.getPath());
    
                // Log the properties of each node
                PropertyIterator propertyIterator = node.getProperties();
                while (propertyIterator.hasNext()) {
                    Property property = propertyIterator.nextProperty();
                    log.info("Property name: {}, Property value: {}", property.getName(), property.getValue().getString());
                }
    
                // Check if ''email'' property is available
                if (node.hasProperty("email")) {
                    String webmail = node.getProperty("webmail").getString();
                    log.info("Email: {}", email);
                } else {
                    log.warn("Emailproperty not found for node: {}", node.getPath());
                }
            }
        } catch (Exception e) {
            log.error("Error executing query: {}", e.getMessage(), e);
        }
    }
}

I was expecting that the list of users will be updated and only show users that has email, but it still show users that doesn''t have email on it.
', '["java", "yaml", "jcr", "magnolia", "jcr-sql2"]', '2024-11-16 03:23:21', '2024-11-16 03:23:21', 13, 0, 0, 0, 15022974, null),
        (79193830, 'Not Able to Install Plugins Eclipse', 'I am currently configuring my Eclipse IDE (2024-09, Windows OS) for a java course. It requires me to install several plugins (Checkstyle, SpotBugs, SubEclipse, Eclipse Web Developer Tools) but all of my tries get stuck at some random location in the process of installing. (Specifically, it shows that it is fetching something, as the images show) Some of the "fetching" processes are smooth, and then it gets stuck at one "fetching" process, different for each try, never switching to the next process.
I install through Help -> Install New Software... -> Add... (Name, Location from the Internet) -> Next> / Finish.
The issue may be because I did not trust all authorities. However, the installation process actually did not show me any page or choice to trust all. My Eclipse 2024-06 met the same problem when installing the plugins before, and I do not remember how I solved this problem. But now when I need to switch to Eclipse 2024-09 due to JUnit compatibility problems, I have the same problem.
I did not receive any error, just got stuck.
I have tried several times, selecting "Trust all content" in preferences but still fail to install any of the plugins.
The Installation Page (Options are default selected)

Stuck when installing CheckStyle

Another try, stuck when installing:

In a third try, it got stuck in another place:

When going to Preferences -> Install/Update -> Available Software Sites, it shows me the following:

This is the content of the "Error Log" view:

Eclipse log:
!SESSION 2024-11-15 14:47:07.473 -----------------------------------------------
eclipse.buildId=4.33.0.20240905-0613
java.version=21.0.4
java.vendor=Eclipse Adoptium
BootLoader constants: OS=win32, ARCH=x86_64, WS=win32, NL=zh_CN
Framework arguments:  -product org.eclipse.epp.package.java.product
Command-line arguments:  -os win32 -ws win32 -arch x86_64 -product org.eclipse.epp.package.java.product

!ENTRY ch.qos.logback.classic 1 0 2024-11-15 14:47:10.082
!MESSAGE Activated before the state location was initialized. Retry after the state location is initialized.

!ENTRY ch.qos.logback.classic 1 0 2024-11-15 14:47:11.196
!MESSAGE Logback config file: D:\\Desktop\\landepen\\OSU-CSE-2221\\workspace\\.metadata\\.plugins\\org.eclipse.m2e.logback\\logback.2.6.1.20240411-1122.xml

!ENTRY org.eclipse.egit.ui 2 0 2024-11-15 14:47:16.167
!MESSAGE Warning: The environment variable HOME is not set. The following directory will be used to store the Git
user global configuration and to define the default location to store repositories: ''C:\\Users\\123''. If this is
not correct please set the HOME environment variable and restart Eclipse. Otherwise Git for Windows and
EGit might behave differently since they see different configuration options.
This warning can be switched off on the Team > Git > Confirmations and Warnings preference page.

!ENTRY org.eclipse.core.jobs 2 2 2024-11-15 14:52:13.623
!MESSAGE Job found still running after platform shutdown.  Jobs should be canceled by the plugin that scheduled them during shutdown: org.eclipse.equinox.p2.operations.ProfileModificationJob RUNNING
     at java.base/jdk.internal.misc.Unsafe.park(Native Method)
     at java.base/java.util.concurrent.locks.LockSupport.park(LockSupport.java:221)
     at java.base/java.util.concurrent.CompletableFuture$Signaller.block(CompletableFuture.java:1864)
     at java.base/java.util.concurrent.ForkJoinPool.unmanagedBlock(ForkJoinPool.java:3780)
     at java.base/java.util.concurrent.ForkJoinPool.managedBlock(ForkJoinPool.java:3725)
     at java.base/java.util.concurrent.CompletableFuture.waitingGet(CompletableFuture.java:1898)
     at java.base/java.util.concurrent.CompletableFuture.get(CompletableFuture.java:2072)
     at org.eclipse.equinox.internal.p2.engine.phases.AuthorityChecker.lambda$10(AuthorityChecker.java:268)
     at java.base/java.util.Optional.ifPresent(Optional.java:178)
     at org.eclipse.equinox.internal.p2.engine.phases.AuthorityChecker.gatherCertificates(AuthorityChecker.java:266)
     at org.eclipse.equinox.internal.p2.engine.phases.AuthorityChecker.getCertificates(AuthorityChecker.java:246)
     at org.eclipse.equinox.internal.p2.engine.phases.AuthorityChecker.start(AuthorityChecker.java:125)
     at org.eclipse.equinox.internal.p2.engine.phases.Collect.completePhase(Collect.java:97)
     at org.eclipse.equinox.internal.p2.engine.Phase.postPerform(Phase.java:254)
     at org.eclipse.equinox.internal.p2.engine.Phase.perform(Phase.java:105)
     at org.eclipse.equinox.internal.p2.engine.PhaseSet.perform(PhaseSet.java:65)
     at org.eclipse.equinox.internal.p2.engine.Engine.perform(Engine.java:95)
     at org.eclipse.equinox.internal.p2.engine.Engine.perform(Engine.java:49)
     at org.eclipse.equinox.p2.operations.ProvisioningSession.performProvisioningPlan(ProvisioningSession.java:175)
     at org.eclipse.equinox.p2.operations.ProfileModificationJob.runModal(ProfileModificationJob.java:76)
     at org.eclipse.equinox.p2.operations.ProvisioningJob.run(ProvisioningJob.java:187)
     at org.eclipse.core.internal.jobs.Worker.run(Worker.java:63)

Here is some information that may be useful from jcmd:
"Worker-1: Installing Software" #74 [19812] prio=5 os_prio=0 cpu=468.75ms elapsed=452.35s tid=0x00000298917e9110 nid=19812 waiting on condition  [0x000000a64083e000]
   java.lang.Thread.State: WAITING (parking)
        at jdk.internal.misc.Unsafe.park(java.base@21.0.4/Native Method)
        - parking to wait for  <0x00000000c7700090> (a java.util.concurrent.CompletableFuture$Signaller)
        at java.util.concurrent.locks.LockSupport.park(java.base@21.0.4/LockSupport.java:221)
        at java.util.concurrent.CompletableFuture$Signaller.block(java.base@21.0.4/CompletableFuture.java:1864)
        at java.util.concurrent.ForkJoinPool.unmanagedBlock(java.base@21.0.4/ForkJoinPool.java:3780)
        at java.util.concurrent.ForkJoinPool.managedBlock(java.base@21.0.4/ForkJoinPool.java:3725)
        at java.util.concurrent.CompletableFuture.waitingGet(java.base@21.0.4/CompletableFuture.java:1898)
        at java.util.concurrent.CompletableFuture.get(java.base@21.0.4/CompletableFuture.java:2072)
        at org.eclipse.equinox.internal.p2.engine.phases.AuthorityChecker.lambda$10(AuthorityChecker.java:268)
        at org.eclipse.equinox.internal.p2.engine.phases.AuthorityChecker$$Lambda/0x0000000100fb28b8.accept(Unknown Source)
        at java.util.Optional.ifPresent(java.base@21.0.4/Optional.java:178)
        at org.eclipse.equinox.internal.p2.engine.phases.AuthorityChecker.gatherCertificates(AuthorityChecker.java:266)
        at org.eclipse.equinox.internal.p2.engine.phases.AuthorityChecker.getCertificates(AuthorityChecker.java:246)
        at org.eclipse.equinox.internal.p2.engine.phases.AuthorityChecker.start(AuthorityChecker.java:125)
        at org.eclipse.equinox.internal.p2.engine.phases.Collect.completePhase(Collect.java:97)
        at org.eclipse.equinox.internal.p2.engine.Phase.postPerform(Phase.java:254)
        at org.eclipse.equinox.internal.p2.engine.Phase.perform(Phase.java:105)
        at org.eclipse.equinox.internal.p2.engine.PhaseSet.perform(PhaseSet.java:65)
        at org.eclipse.equinox.internal.p2.engine.Engine.perform(Engine.java:95)
        at org.eclipse.equinox.internal.p2.engine.Engine.perform(Engine.java:49)
        at org.eclipse.equinox.p2.operations.ProvisioningSession.performProvisioningPlan(ProvisioningSession.java:175)
        at org.eclipse.equinox.p2.operations.ProfileModificationJob.runModal(ProfileModificationJob.java:76)
        at org.eclipse.equinox.p2.operations.ProvisioningJob.run(ProvisioningJob.java:187)
        at org.eclipse.core.internal.jobs.Worker.run(Worker.java:63)

', '["java", "eclipse"]', '2024-11-16 04:13:33', '2024-11-16 19:42:41', 47, 0, 1, 0, 28096814, 79195077),
        (79194027, 'Why does canceling a CompletableFuture not actually interrupt the underlying task?', 'Here''s a simple example:
public static void main(String[] args) throws Exception {
    ExecutorService executorService = Executors.newCachedThreadPool();
    CompletableFuture<Void> callbackHook = new CompletableFuture<>();
    CompletableFuture<Void> future = CompletableFuture.runAsync(() -> {
        try {
            System.out.println("Starting Runnable");
            while (true) {
                System.out.println("still running");
                Thread.sleep(1000);
            }
        } catch (InterruptedException e) {
            // why is this code never getting hit?
            System.err.println("InterruptedException caught in Runnable!");
            callbackHook.complete(null);
        }
    }, executorService);
    future.cancel(true);
    callbackHook.get(); // this hangs forever...
    System.out.println("*** DONE ***"); // this line is never reached
}

Output:
Starting Runnable
still running
still running
still running
still running
...(this continues forever)

Why so why does calling cancel(true) on the CompletableFuture not cause it to trigger an interrupt in the underlying task even though the true parameter in cancel(true) is supposed to cause it to interrupt the task?
And yes, I know this example is a bit contrived, since there''s no reason why you''d necessarily want to be waiting on callbackHook instead of on future, but there are more complex cases where this sort of logic would be used - this is just a simplified example.
', '["java", "completable-future"]', '2024-11-16 05:40:29', '2024-11-16 05:40:29', 45, 3, 0, 0, 367544, null),
        (79194187, 'Unirest doesn&#39;t return content-encoding gzip header', 'I am using Unirest in java app for API call.
The API server is a spring-boot app with the compression enabled
server.compression.enabled=true
server.compression.mime-types=application/json
server.compression.min-response-size=1

This is my api call
HttpResponse<String> response = Unirest.post(url)
                .header("Accept-Encoding", "gzip")
                .header("Content-Type", "application/json")
                .body(request)
                .asString();

However response header "Content-Type" is always "application/json"
Unirest version
<dependency>
  <groupId>com.konghq</groupId>
  <artifactId>unirest-java</artifactId>
  <version>3.14.5</version>
 </dependency>

I am using it with SSL connection from Spring boot app v.3.3.5.
I tried the same call with curl
curl --request POST --url ''myurl'' --header ''Accept-Encoding: gzip'' --header ''Content-Type: application/json'' --data ''jsonData'' -i | less

Response
...
HTTP/1.1 200
vary: accept-encoding
Content-Encoding: gzip
Content-Type: application/json 
...

I tried the same API call from Insomnia client
> POST 
...
> User-Agent: insomnia/2021.4.1
> Content-Type: application/json
> Accept-Encoding: gzip

Response:
< HTTP/1.1 200 
< vary: accept-encoding
< Content-Encoding: gzip
< Content-Type: application/json
...

I also checked request headers in APi server and they all have "Accept-Encoding: gzip". It looks like it doesn''t work only with Unirest.
', '["java", "spring-boot", "rest", "unirest", "http-compression"]', '2024-11-16 07:01:13', '2024-11-16 07:01:13', 18, 0, 0, 0, 3256568, null),
        (79194273, 'Can not load the safetensors huggingface model in DJL in Java', 'I tried a lot, but I want to read embeddings from the jina embeddings
this is my java code:
public static float[] getTextEmbedding(String text) throws ModelNotFoundException, MalformedModelException, IOException, TranslateException {
        Criteria<String, float[]> criteria = Criteria.builder()
                .setTypes(String.class, float[].class)
                .optEngine("PyTorch")
                .optModelPath(Paths.get("/jina-embeddings-v2-base-de"))
                .optTranslator(
                    TextEmbeddingTranslator
                        .builder(HuggingFaceTokenizer.newInstance(Paths.get("/jina-embeddings-v2-base-de")))
                        .build()
                )
                .optProgress(new ProgressBar())
                .optOption("trust_remote_code", "true")
                .build();

        try (Predictor<String, float[]> predictor = ModelZoo.loadModel(criteria).newPredictor()) {
            return predictor.predict(text);
        }
    }

but I keept getting this error:
java.io.FileNotFoundException: jina-embeddings-v2-base-de.pt file not found in: /jina-embeddings-v2-base-de

', '["java", "huggingface-transformers", "word-embedding", "huggingface-tokenizers", "djl"]', '2024-11-16 08:04:27', '2024-11-16 08:04:27', 21, 0, 0, 0, 2013856, null),
        (79194349, 'VS Code src/main/resources not included in the class path', 'Using VS Code I am trying to access the file application.conf located in the resources folder of a java maven project:

In the projects setting I have src/main/resources in the classpath:

Unfortunately running maven lifecyles the resources folder is not available in the target/classes folder:

Hence the java program with VS Code cannot access any file in the resources folder, how can I add src/main/resources to the class path? (right click folder -> add "Add Folder to Java Source Path" does not work with maven in VS Code)
', '["java", "maven", "visual-studio-code"]', '2024-11-16 09:12:31', '2024-11-16 09:12:31', 38, 0, 0, 0, 16665585, null),
        (79194363, 'Wanted but not invoked: vidaria.services.SerieService#0 bean.getSeriesById(1L );', 'My unit test getSerieByIdSimplifiedTest in Spring boot with J unit 5 doesn''t work, my controller and service are perfectly implemented, if I delete the verify from my test everything works fine... I don''t understand the problem and how to solve it!
I get an error in serieService when I''m perfectly implementing the @MockBean for this, I hope for your help
package com.garmanaz.vidaria.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.garmanaz.vidaria.entities.Serie;
import com.garmanaz.vidaria.services.SerieService;
import com.garmanaz.vidaria.utils.JWT.JwtRequestFilter;
import com.garmanaz.vidaria.utils.JWT.JwtTokenUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.test.web.servlet.MockMvc;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(controllers = SerieController.class)
@WithMockUser(username = "john", roles = {"USER"})
public class SerieControllerTest {

@Autowired
private MockMvc mockMvc;

@Autowired
private ObjectMapper objectMapper;

@MockBean
private SerieService serieService;

@MockBean
private JwtTokenUtil jwtTokenUtil;

@MockBean
private JwtRequestFilter jwtRequestFilter;

@Autowired
private SerieController serieController;

@MockBean
private RestTemplateBuilder restTemplateBuilder;

@BeforeEach
void setUp() {
    ReflectionTestUtils.setField(serieController, "serieService", serieService);
}

@Test
void verifyMockInjection() {
    SerieService injectedService = (SerieService) ReflectionTestUtils.getField(serieController, "serieService");
    System.out.println("Injected SerieService: " + injectedService);
    assertSame(injectedService, serieService, "The injected service is not the mock");
}

@Test
void getSerieByIdSimplifiedTest() throws Exception {
    long serieId = 1L;
    Serie mockSerie = Serie.builder()
            .id(serieId)
            .title("Test Serie")
            .build();

    when(serieService.getSeriesById(serieId)).thenReturn(mockSerie);

    mockMvc.perform(get("/series/{serieId}", serieId)
                    .contentType("application/json"))
            .andDo(print())
            .andExpect(status().isOk());

    verify(serieService, times(1)).getSeriesById(1L);
}

}

', '["java", "spring", "testing", "junit", "mockito"]', '2024-11-16 09:35:02', '2024-11-16 09:35:02', 30, 0, 0, 0, 17131207, null),
        (79194381, 'In Spring Boot Web, Is it safe to share AnnotationConfigWebApplicationContext between multiple Web Contexts', 'I am using Spring Boot 3.3.5 and I create custom contexts by overriding tomcatFactory.
As all our custom contexts share similar behavior (same REST Controller, same behavior) and is only differentiated by their Context Path to help us differentiate which custom Data Source to access, is it OK for all the web contexts to use the same AnnotationConfigWebApplicationContext and DispatcherServlet?
My only concern is the AnnotationConfigWebApplicationContext.setServletContext which is required by some Spring Boot web autoconfiguration, and I only call this once by setting the ServletContext of the first custom Context created.
', '["java", "spring-boot", "spring-boot-3", "embedded-tomcat-10"]', '2024-11-16 09:56:14', '2024-11-18 00:14:36', 20, 0, 0, 0, 2829734, null),
        (79194519, 'redis.clients.jedis.exceptions.JedisConnectionException: javax.net.ssl.SSLHandshakeException: Remote host terminated the handshake', 'I''m getting the exception below when trying to connect to AWS elasticache Redis server from a container that is deployed to AWS Kubernetes.
Error:
nested exception is redis.clients.jedis.exceptions.JedisConnectionException: javax.net.ssl.SSLHandshakeException: Remote host terminated the handshake

Java code:
JedisPoolConfig poolConfig = new JedisPoolConfig();
String url = "rediss://elsticache.abc.cache.amazonaws.com:6379";//Note rediss with "ss"
JedisPool jedisPool = new JedisPool(poolConfig, url); 
Jedis jedis = jedisPool.getResource();

pom.xml:
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>5.2.0</version>
</dependency>

', '["java", "amazon-elasticache", "jedis"]', '2024-11-16 12:24:42', '2024-11-16 12:24:42', 14, 0, 0, 0, 9053712, null),
        (79194800, 'How do I fix the &quot;No window was shown&quot; error in uispecj4?', 'I''ve been trying to get tests running for my project but every time I run it it gives me an error
    protected void setUp() throws Exception {
        super.setUp();
        setAdapter(new MainClassAdapter(Login.class));

        Window window = getMainWindow();
    }

This is the code for my setup, it has an error when it tries to getMainWindow(). It''s a maven project, the login class is setup and is running, here is the code that displays the window:
    public static void main(String[] args) {
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Login().setVisible(true); System.out.println("window showingg");
            }
        });
    }

Could anyone help me figure out what''s going on? Thanks
', '["java", "maven", "jpanel", "uispec4j"]', '2024-11-16 16:55:26', '2024-11-16 16:55:26', 21, 0, 0, 0, 28328239, null),
        (79194846, 'Domino java agent connecting to SMTP server with TLS1.2', 'We have a specific use case where we have certain emails need to be sent direct from a Domino java agent (using mailapi-1.6.2.jar) to a remote SMTP server where TLS1.2 is required.  Depending on business logic, different user names and passwords are used when authenticating with the remote server.  TLS 1.0 and TLS 1.1 has been disabled on the remote server.
The error received is:
javax.mail.MessagingException: Can''t send command to SMTP host;   nested exception is:  javax.net.ssl.SSLHandshakeException: No appropriate protocol, may be no appropriate cipher suite specified or protocols are deactivated
We have used WireShark to confirm TLS1.2 is being used.
Assuming the issue is:
the cipher being used by Domino is incorrect?   We are unsure how to verify which cipher suite is missing\\attempting to be used.
Any and all suggestions or pointers  would be greatly appreciated as we are struggling with this one.
Thanks in advance.
We have tried the following on a v9 Domino server and a v14 Domino server.
Ciphers in Domino 9 Server document
RC4 encryption with 128-bit key and MD5 MAC
RC4 encryption with 128-bit key and SHA-1 MAC
Triple DES encryption with 168-bit key and SHA-1 MAC
DES encryption with 56-bit key and SHA-1 MAC
RC4 encryption with 40-bit key and MD5 MAC
 
Ciphers on Domino 14 server document and website
ECDHE_RSA_WITH_AES_256_GCM_SHA384 [C030]
DHE_RSA_WITH_AES_256_GCM_SHA384 [9F]
ECDHE_RSA_WITH_AES_128_GCM_SHA256 [C02F]
DHE_RSA_WITH_AES_128_GCM_SHA256 [9E]

Domino 9 specific settings...start
Java version:
java version "1.8.0_151"
 
 
In the notes.ini:

DISABLE_SSLV3=1
SSL_DISABLE_TLS_10=1
JavaUserOptionsFile=C:\\Progra~1\\IBM\\Lotus\\Domino\\jvm\\jvmoptions.txt
 
In the ....\\IBM\\Lotus\\Domino\\jvm\\jvmoptions.txt:
 
https.protocols=TLSv1.2
-Dcom.ibm.jsse2.overrideDefaultTLS=true

Domino v14 java version:
openjdk version "17.0.8.1" 2023-08-24
N.B. The Domino server was upgraded from v9, so maybe inherited some cipher suites that need disabling?
In the java.security file we have the following disabled.  It''s this setting that actually forced the java agent to use TLS1.2
 
jdk.tls.disabledAlgorithms=SSLv3, SHA-0, SHA-1, TLSv1, TLSv1.1, RC4, DES, MD5withRSA, DH keySize < 1024, \\
    DH keySize < 1024, EC keySize < 224, 3DES_EDE_CBC, anon, NULL, \\
    EC keySize < 224, 3DES_EDE_CBC, anon, NULL, \\
    include jdk.disabled.namedCurves

We have created a test agent (we have replaced the host, credentials, etc. with our own):
String smtpHost = "smtp.example.com"; // Replace with your SMTP server
    int smtpPort = 587; // Typically 587 for STARTTLS
    String username = "your_email@example.com"; // Replace with your email
    String password = "your_password"; // Replace with your password
     
    // Recipient and email content
    String toEmail = "recipient@example.com"; // Replace with recipient''s email
    String subject = "Test Email with TLS 1.2";
    String body = "This is a test email sent using JavaMail 1.5 enforcing TLS 1.2.";
     
    // Set email properties
    Properties props = new Properties();
    props.put("mail.smtp.host", smtpHost);
    props.put("mail.smtp.port", smtpPort);
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true"); // Enable STARTTLS
    props.put("mail.smtp.debug", "true");
     
    // Force TLS 1.2
    props.put("mail.smtp.ssl.protocols", "TLSv1.2");
     
    // Create session
    Session session = Session.getInstance(props, new Authenticator() {
    protected PasswordAuthentication getPasswordAuthentication() {
    return new PasswordAuthentication(username, password);
    }
    });
     
    session.setDebug(true);
     
     
    // Create a message
    Message message = new MimeMessage(session);
    message.setFrom(new InternetAddress(username));
    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
    message.setSubject(subject);
    message.setText(body);
     
    // Send email
    Transport.send(message);
    System.out.println("Email sent successfully with TLS 1.2!");


TLSv1.3    <---printing out versions java mail has available
    TLSv1.2
    TLSv1.1
    TLSv1
    SSLv3
    SSLv2Hello
    NHSNetSMTPClientClass.send()
    DEBUG: setDebug: JavaMail version 1.4ea  <-----version of java mail api we are using
    NHSNetSMTPClientClass.send()
    DEBUG: getProvider() returning javax.mail.Provider[TRANSPORT,smtp,com.sun.mail.smtp.SMTPTransport,Sun Microsystems, Inc]
    DEBUG SMTP: useEhlo true, useAuth true
    DEBUG SMTP: useEhlo true, useAuth true
    DEBUG SMTP: trying to connect to host "send.nhs.net", port 587, isSSL false
    220 send.nhs.net ESMTP
    DEBUG SMTP: connected to host "XXXX_HOST_WE_ARE_CONNECTING_TO_XXXX", port: 587 
    EHLO ash-tst-domino
    250-send.nhs.net  250-PIPELINING  250-SIZE 52428800  250-ETRN  250-STARTTLS  250-ENHANCEDSTATUSCODES  250-8BITMIME  250 DSN
    DEBUG SMTP: Found extension "PIPELINING", arg ""
    DEBUG SMTP: Found extension "SIZE", arg "52428800"
    DEBUG SMTP: Found extension "ETRN", arg ""
    DEBUG SMTP: Found extension "STARTTLS", arg ""
    DEBUG SMTP: Found extension "ENHANCEDSTATUSCODES", arg ""
    DEBUG SMTP: Found extension "8BITMIME", arg ""
    DEBUG SMTP: Found extension "DSN", arg ""
    STARTTLS
    220 2.0.0 Ready to start TLS
    EHLO ash-tst-domino
    javax.mail.MessagingException: Can''t send command to SMTP host;   nested exception is:  javax.net.ssl.SSLHandshakeException: No appropriate protocol (protocol is disabled or cipher suites are inappropriate)

', '["java", "tls1.2", "lotus-domino"]', '2024-11-16 17:27:06', '2024-11-16 17:27:06', 28, 0, 0, 0, 1269019, null),
        (79195061, 'Properly proxy WebSocket connection through Nuxt 3 Server', 'I want to proxy WebSocket Connections through a Nuxt 3 Nitro Server to enrich it with Session information for authentication. I managed to get it working to a point, where the server intercepts the request, enriches it with an Authorization-Header and proxies it to a Spring Boot Backend. But the Backend is not able to process the request properly. At least thats my interpretation. In my Backend logs I have the following Log entries:
2024-11-16T12:06:31.433+01:00 DEBUG 10368 --- [nio-3001-exec-1] o.s.web.servlet.DispatcherServlet        : GET "/ws", parameters={}
2024-11-16T12:06:31.436+01:00 DEBUG 10368 --- [nio-3001-exec-1] o.s.w.s.s.s.WebSocketHandlerMapping      : Mapped to org.springframework.web.socket.server.support.WebSocketHttpRequestHandler@3d20e575
2024-11-16T12:06:31.441+01:00 DEBUG 10368 --- [nio-3001-exec-1] o.s.w.s.s.s.WebSocketHttpRequestHandler  : GET /ws
2024-11-16T12:06:31.454+01:00 DEBUG 10368 --- [nio-3001-exec-1] o.s.web.servlet.DispatcherServlet        : Completed 101 SWITCHING_PROTOCOLS
2024-11-16T12:06:31.461+01:00 DEBUG 10368 --- [nio-3001-exec-1] s.w.s.h.LoggingWebSocketHandlerDecorator : New StandardWebSocketSession[id=29da51eb-03a2-0697-900f-278000eff67a, uri=ws://localhost:3001/ws]
2024-11-16T12:06:31.463+01:00 DEBUG 10368 --- [nio-3001-exec-1] s.w.s.h.LoggingWebSocketHandlerDecorator : Transport error in StandardWebSocketSession[id=29da51eb-03a2-0697-900f-278000eff67a, uri=ws://localhost:3001/ws]

java.io.EOFException: null
    at org.apache.tomcat.util.net.NioEndpoint$NioSocketWrapper.fillReadBuffer(NioEndpoint.java:1296) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
    at org.apache.tomcat.util.net.NioEndpoint$NioSocketWrapper.read(NioEndpoint.java:1184) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
    at org.apache.tomcat.websocket.server.WsFrameServer.onDataAvailable(WsFrameServer.java:74) ~[tomcat-embed-websocket-10.1.19.jar:10.1.19]
    at org.apache.tomcat.websocket.server.WsFrameServer.doOnDataAvailable(WsFrameServer.java:184) ~[tomcat-embed-websocket-10.1.19.jar:10.1.19]
    at org.apache.tomcat.websocket.server.WsFrameServer.notifyDataAvailable(WsFrameServer.java:164) ~[tomcat-embed-websocket-10.1.19.jar:10.1.19]
    at org.apache.tomcat.websocket.server.WsHttpUpgradeHandler.upgradeDispatch(WsHttpUpgradeHandler.java:152) ~[tomcat-embed-websocket-10.1.19.jar:10.1.19]
    at org.apache.coyote.http11.upgrade.UpgradeProcessorInternal.dispatch(UpgradeProcessorInternal.java:60) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
    at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:57) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
    at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:896) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
    at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1744) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
    at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:52) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
    at org.apache.tomcat.util.threads.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1191) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
    at org.apache.tomcat.util.threads.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:659) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
    at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:63) ~[tomcat-embed-core-10.1.19.jar:10.1.19]
    at java.base/java.lang.Thread.run(Thread.java:1570) ~[na:na]

2024-11-16T12:06:31.467+01:00 DEBUG 10368 --- [nio-3001-exec-1] s.w.s.h.LoggingWebSocketHandlerDecorator : StandardWebSocketSession[id=29da51eb-03a2-0697-900f-278000eff67a, uri=ws://localhost:3001/ws] closed with CloseStatus[code=1006, reason=null]
2024-11-16T12:06:31.467+01:00 DEBUG 10368 --- [nio-3001-exec-1] o.s.w.s.m.SubProtocolWebSocketHandler    : Clearing session 29da51eb-03a2-0697-900f-278000eff67a
2024-11-16T12:06:31.470+01:00 DEBUG 10368 --- [nboundChannel-2] org.springframework.web.SimpLogging      : Processing DISCONNECT session=29da51eb-03a2-0697-900f-278000eff67a
2024-11-16T12:06:31.470+01:00 DEBUG 10368 --- [tboundChannel-1] o.s.w.s.m.SubProtocolWebSocketHandler    : No session for GenericMessage [payload=byte[0], headers={simpMessageType=DISCONNECT_ACK, simpDisconnectMessage=GenericMessage [payload=byte[0], headers={simpMessageType=DISCONNECT, stompCommand=DISCONNECT, simpSessionAttributes={org.springframework.messaging.simp.SimpAttributes.COMPLETED=true}, simpSessionId=29da51eb-03a2-0697-900f-278000eff67a}], simpSessionId=29da51eb-03a2-0697-900f-278000eff67a}]
2024-11-16T12:07:25.523+01:00  INFO 10368 --- [MessageBroker-1] o.s.w.s.c.WebSocketMessageBrokerStats    : WebSocketSession[0 current WS(0)-HttpStream(0)-HttpPoll(0), 1 total, 0 closed abnormally (0 connect failure, 0 send limit, 1 transport error)], stompSubProtocol[processed CONNECT(0)-CONNECTED(0)-DISCONNECT(0)], stompBrokerRelay[null], inboundChannel[pool size = 3, active threads = 0, queued tasks = 0, completed tasks = 3], outboundChannel[pool size = 1, active threads = 0, queued tasks = 0, completed tasks = 1], sockJsScheduler[pool size = 1, active threads = 1, queued tasks = 0, completed tasks = 0]

I created a minimal reproducible sample here: https://github.com/r4id4h/ws-repro.git
Why is the connection not established? In the sample there are two buttons. One is establishing the connection using the proxy and the other one directly. The direct connection is working but the proxy is not. What am I missing here?
', '["java", "spring-boot", "vuejs3", "nuxt3.js"]', '2024-11-16 19:33:19', '2024-11-17 20:10:54', 29, 0, 1, 0, 6512438, null),
        (79195089, 'Spring Security returns 403 despite successful JWT authentication in custom filter', 'I am using Spring Security with JWT authentication for my application. I''ve implemented a custom filter to validate the JWT and set the authentication in the security context. However, even though the JWT is valid and the authentication is set correctly, I keep getting a 403 Forbidden response when accessing secured endpoints.
Here’s my setup:
Security Configuration:
@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final UserDetailsService userDetailsService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(
            HttpSecurity http,
            PasswordEncoder passwordEncoder
    ) throws Exception {
        AuthenticationManagerBuilder auth = http.getSharedObject(AuthenticationManagerBuilder.class);
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
        return auth.build();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(
            HttpSecurity http,
            JwtAuthenticationFilter jwtAuthenticationFilter,
            AuthenticationEntryPoint jwtAuthenticationEntryPoint
    ) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/api/auth/**").permitAll()
                        .anyRequest().authenticated()
                )
                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
                .exceptionHandling(exception -> exception.authenticationEntryPoint(jwtAuthenticationEntryPoint));

        return http.build();
    }
}

Jwt authentication filter:
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtil jwtUtil;
    private final UserDetailsService userDetailsService;


    @Override
    public void doFilterInternal(
            HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain
    ) throws ServletException, IOException {
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
        filterChain.doFilter(request, response);
    }
}


In this filter, the line SecurityContextHolder.getContext().setAuthentication(authenticationToken); is executed and SecurityContextHolder.getContext().getAuthentication() results in
UsernamePasswordAuthenticationToken [Principal=UserEntity(id=fb94c680-6376-4d90-a82d-6120280f5595, username=some_user, password=some_password, roles=[RoleEntity(id=6ccd6fe2-b23c-4179-b738-6516aed4f14d, name=OWNER)]), Credentials=[PROTECTED], Authenticated=true, Details=WebAuthenticationDetails [RemoteIpAddress=0:0:0:0:0:0:0:1, SessionId=null], Granted Authorities=[ROLE_OWNER]]
JWT Utility Class:
@Component
public class JwtUtil {
    @Value("${jwt.secret-key}")
    private String SECRET_KEY;

    @Value("${jwt.expiration-in-ms}")
    private long TOKEN_VALIDITY;

    public boolean isBearer(String token) {
        return token.startsWith("Bearer ");
    }

    public String parseTokenType(String token) {
        return token.substring("Bearer ".length());
    }

    public String generateToken(String username) {
        Map<String, Object> claims = new HashMap<>();
        return createToken(claims, username);
    }

    public boolean isTokenExpired(String token) {
        return extractAllClaims(token).getExpiration().before(new Date());
    }

    public String extractUsername(String token) {
        return extractAllClaims(token).getSubject();
    }

    private String createToken(Map<String, Object> claims, String subject) {
        return Jwts.builder()
                .addClaims(claims)
                .setSubject(subject)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + TOKEN_VALIDITY))
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    private Claims extractAllClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getSigningKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    private SecretKey getSigningKey() {
        return Keys.hmacShaKeyFor(Decoders.BASE64.decode(SECRET_KEY));
    }
}

When I make a request to /api/question with a valid JWT:
curl --location --request POST ''http://localhost:8081/api/question'' \\ --header ''Authorization: Bearer <valid-token>''

The JwtAuthenticationFilter successfully validates the token and sets the authentication in the SecurityContextHolder
I can see the authentication object in the logs, and it is marked as authenticated:

UsernamePasswordAuthenticationToken [Authenticated=true, Granted Authorities=[]]


Despite this, the request ends up returning a 403 Forbidden with the error:
org.springframework.security.authentication.InsufficientAuthenticationException: Full authentication is required to access this resource.

Questions:

Why does Spring Security still reject the request with a 403, even though the SecurityContextHolder contains a valid authentication object?

I tried to implement a custom JwtAuthenticationFilter to validate JWT tokens and set the SecurityContext. I expected authenticated requests with valid tokens to access protected endpoints without issues. However, I am receiving a 403 Forbidden error with an InsufficientAuthenticationException. The authentication object seems to be set correctly in the filter, but it doesn''t work as expected for accessing secured resources.
UPD:
Added a trace
2024-11-16T12:38:53.358+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Trying to match request against DefaultSecurityFilterChain [RequestMatcher=any request, Filters=[org.springframework.security.web.session.DisableEncodeUrlFilter@1dfcb546, org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter@2b5b96af, org.springframework.security.web.context.SecurityContextHolderFilter@23b62cc3, org.springframework.security.web.header.HeaderWriterFilter@695f382c, org.springframework.security.web.authentication.logout.LogoutFilter@17c7cc93, com.arutyun.quiz_server.auth.security.filter.JwtAuthenticationFilter@73ba3c4b, org.springframework.security.web.savedrequest.RequestCacheAwareFilter@a589070, org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter@745c25ed, org.springframework.security.web.authentication.AnonymousAuthenticationFilter@575822e7, org.springframework.security.web.session.SessionManagementFilter@2aec09a3, org.springframework.security.web.access.ExceptionTranslationFilter@1dbe592f, org.springframework.security.web.access.intercept.AuthorizationFilter@18b8518b]] (1/1)
2024-11-16T12:38:53.358+05:00 DEBUG 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Securing POST /api/question
2024-11-16T12:38:53.358+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking DisableEncodeUrlFilter (1/12)
2024-11-16T12:38:53.359+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking WebAsyncManagerIntegrationFilter (2/12)
2024-11-16T12:38:53.359+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking SecurityContextHolderFilter (3/12)
2024-11-16T12:38:53.359+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking HeaderWriterFilter (4/12)
2024-11-16T12:38:53.359+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking LogoutFilter (5/12)
2024-11-16T12:38:53.359+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.s.w.a.logout.LogoutFilter            : Did not match request to Or [Ant [pattern=''/logout'', GET], Ant [pattern=''/logout'', POST], Ant [pattern=''/logout'', PUT], Ant [pattern=''/logout'', DELETE]]
2024-11-16T12:38:53.359+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking JwtAuthenticationFilter (6/12)
2024-11-16T12:38:53.361+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] .s.s.w.c.SupplierDeferredSecurityContext : Created SecurityContextImpl [Null authentication]
2024-11-16T12:38:53.372+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking RequestCacheAwareFilter (7/12)
2024-11-16T12:38:53.372+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking SecurityContextHolderAwareRequestFilter (8/12)
2024-11-16T12:38:53.373+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking AnonymousAuthenticationFilter (9/12)
2024-11-16T12:38:53.373+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking SessionManagementFilter (10/12)
2024-11-16T12:38:53.373+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.s.w.a.AnonymousAuthenticationFilter  : Did not set SecurityContextHolder since already authenticated UsernamePasswordAuthenticationToken [Principal=UserEntity(id=21ad81c1-5820-4fa0-ba65-1880c6e9042c, username=some_user, password=some_password, roles=[]), Credentials=[PROTECTED], Authenticated=true, Details=WebAuthenticationDetails [RemoteIpAddress=0:0:0:0:0:0:0:1, SessionId=null], Granted Authorities=[]]
2024-11-16T12:38:53.373+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] s.CompositeSessionAuthenticationStrategy : Preparing session with ChangeSessionIdAuthenticationStrategy (1/1)
2024-11-16T12:38:53.373+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking ExceptionTranslationFilter (11/12)
2024-11-16T12:38:53.373+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking AuthorizationFilter (12/12)
2024-11-16T12:38:53.373+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] estMatcherDelegatingAuthorizationManager : Authorizing POST /api/question
2024-11-16T12:38:53.373+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] estMatcherDelegatingAuthorizationManager : Checking authorization on POST /api/question using org.springframework.security.authorization.AuthenticatedAuthorizationManager@30e47d5a
2024-11-16T12:38:53.374+05:00 DEBUG 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Secured POST /api/question
2024-11-16T12:38:53.377+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.s.w.header.writers.HstsHeaderWriter  : Not injecting HSTS header since it did not match request to [Is Secure]
2024-11-16T12:38:53.379+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Trying to match request against DefaultSecurityFilterChain [RequestMatcher=any request, Filters=[org.springframework.security.web.session.DisableEncodeUrlFilter@1dfcb546, org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter@2b5b96af, org.springframework.security.web.context.SecurityContextHolderFilter@23b62cc3, org.springframework.security.web.header.HeaderWriterFilter@695f382c, org.springframework.security.web.authentication.logout.LogoutFilter@17c7cc93, com.arutyun.quiz_server.auth.security.filter.JwtAuthenticationFilter@73ba3c4b, org.springframework.security.web.savedrequest.RequestCacheAwareFilter@a589070, org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter@745c25ed, org.springframework.security.web.authentication.AnonymousAuthenticationFilter@575822e7, org.springframework.security.web.session.SessionManagementFilter@2aec09a3, org.springframework.security.web.access.ExceptionTranslationFilter@1dbe592f, org.springframework.security.web.access.intercept.AuthorizationFilter@18b8518b]] (1/1)
2024-11-16T12:38:53.380+05:00 DEBUG 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Securing POST /error
2024-11-16T12:38:53.380+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking DisableEncodeUrlFilter (1/12)
2024-11-16T12:38:53.380+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking WebAsyncManagerIntegrationFilter (2/12)
2024-11-16T12:38:53.380+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking SecurityContextHolderFilter (3/12)
2024-11-16T12:38:53.381+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking HeaderWriterFilter (4/12)
2024-11-16T12:38:53.381+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking LogoutFilter (5/12)
2024-11-16T12:38:53.381+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.s.w.a.logout.LogoutFilter            : Did not match request to Or [Ant [pattern=''/logout'', GET], Ant [pattern=''/logout'', POST], Ant [pattern=''/logout'', PUT], Ant [pattern=''/logout'', DELETE]]
2024-11-16T12:38:53.382+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking JwtAuthenticationFilter (6/12)
2024-11-16T12:38:53.382+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking RequestCacheAwareFilter (7/12)
2024-11-16T12:38:53.382+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking SecurityContextHolderAwareRequestFilter (8/12)
2024-11-16T12:38:53.382+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking AnonymousAuthenticationFilter (9/12)
2024-11-16T12:38:53.382+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking SessionManagementFilter (10/12)
2024-11-16T12:38:53.382+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking ExceptionTranslationFilter (11/12)
2024-11-16T12:38:53.382+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.security.web.FilterChainProxy        : Invoking AuthorizationFilter (12/12)
2024-11-16T12:38:53.382+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] estMatcherDelegatingAuthorizationManager : Authorizing POST /error
2024-11-16T12:38:53.383+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] estMatcherDelegatingAuthorizationManager : Checking authorization on POST /error using org.springframework.security.authorization.AuthenticatedAuthorizationManager@30e47d5a
2024-11-16T12:38:53.383+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] .s.s.w.c.SupplierDeferredSecurityContext : Created SecurityContextImpl [Null authentication]
2024-11-16T12:38:53.383+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.s.w.a.AnonymousAuthenticationFilter  : Set SecurityContextHolder to AnonymousAuthenticationToken [Principal=anonymousUser, Credentials=[PROTECTED], Authenticated=true, Details=WebAuthenticationDetails [RemoteIpAddress=0:0:0:0:0:0:0:1, SessionId=null], Granted Authorities=[ROLE_ANONYMOUS]]
2024-11-16T12:38:53.383+05:00 TRACE 79872 --- [quiz-server] [nio-8081-exec-6] o.s.s.w.a.ExceptionTranslationFilter     : Sending AnonymousAuthenticationToken [Principal=anonymousUser, Credentials=[PROTECTED], Authenticated=true, Details=WebAuthenticationDetails [RemoteIpAddress=0:0:0:0:0:0:0:1, SessionId=null], Granted Authorities=[ROLE_ANONYMOUS]] to authentication entry point since access is denied

org.springframework.security.access.AccessDeniedException: Access Denied
    at org.springframework.security.web.access.intercept.AuthorizationFilter.doFilter(AuthorizationFilter.java:98) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.wrapFilter(ObservationFilterChainDecorator.java:240) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.doFilter(ObservationFilterChainDecorator.java:227) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$VirtualFilterChain.doFilter(ObservationFilterChainDecorator.java:137) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:126) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:120) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.wrapFilter(ObservationFilterChainDecorator.java:240) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.doFilter(ObservationFilterChainDecorator.java:227) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$VirtualFilterChain.doFilter(ObservationFilterChainDecorator.java:137) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:91) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:85) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.wrapFilter(ObservationFilterChainDecorator.java:240) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.doFilter(ObservationFilterChainDecorator.java:227) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$VirtualFilterChain.doFilter(ObservationFilterChainDecorator.java:137) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:100) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.wrapFilter(ObservationFilterChainDecorator.java:240) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.doFilter(ObservationFilterChainDecorator.java:227) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$VirtualFilterChain.doFilter(ObservationFilterChainDecorator.java:137) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:179) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.wrapFilter(ObservationFilterChainDecorator.java:240) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.doFilter(ObservationFilterChainDecorator.java:227) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$VirtualFilterChain.doFilter(ObservationFilterChainDecorator.java:137) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.wrapFilter(ObservationFilterChainDecorator.java:240) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.doFilter(ObservationFilterChainDecorator.java:227) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$VirtualFilterChain.doFilter(ObservationFilterChainDecorator.java:137) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:101) ~[spring-web-6.1.14.jar:6.1.14]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.wrapFilter(ObservationFilterChainDecorator.java:240) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.doFilter(ObservationFilterChainDecorator.java:227) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$VirtualFilterChain.doFilter(ObservationFilterChainDecorator.java:137) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:107) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:93) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.wrapFilter(ObservationFilterChainDecorator.java:240) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.doFilter(ObservationFilterChainDecorator.java:227) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$VirtualFilterChain.doFilter(ObservationFilterChainDecorator.java:137) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:101) ~[spring-web-6.1.14.jar:6.1.14]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.wrapFilter(ObservationFilterChainDecorator.java:240) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$ObservationFilter.doFilter(ObservationFilterChainDecorator.java:227) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.ObservationFilterChainDecorator$VirtualFilterChain.doFilter(ObservationFilterChainDecorator.java:137) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.context.SecurityContextHolderFilter.doFilter(SecurityContextHolderFilter.java:82) ~[spring-security-web-6.3.4.jar:6.3.4]
    at org.springframework.security.web.context.SecurityContextHolderFilter.doFilter(SecurityContextHolderFilter.java:69) ~[spring-security-web-6.3.4.jar:6.3.4]

', '["java", "authentication", "spring-security", "jwt", "http-status-code-403"]', '2024-11-16 19:51:33', '2024-11-16 22:07:01', 48, 0, 1, 0, 15706263, null),
        (79195161, 'Default method vs concrete method in abstract class?', 'After Java 8, if we have default method in interface and concrete method in abstract class, then what is the significance of default method in interface over concrete method of abstract class?
I thought that default methods are used for common functionality and concrete methods in abstract class have their own functionality.
But, I am not sure about the exact picture regarding both the methods.
', '["java", "abstract-class", "default-method"]', '2024-11-16 20:45:12', '2024-11-16 20:52:37', 29, 0, 0, 0, 23237055, null),
        (79195216, 'How to make transparent JavaFX stage transparent for mouse events?', 'I have a transparent stage and I need when user click inside this stage then mouse event to be passed to a window that is behind my JavaFX stage (for example, if there is a text editor behind my stage then mouse event should be passed to that editor window). By other words I need the Stage to be transparent for mouse events.
This is my code:
public class Test12 extends Application {

    @Override
    public void start(Stage primaryStage) {
        var vBox = new VBox();
        vBox.setStyle("-fx-border-width: 1; -fx-border-color: black");
        vBox.setMouseTransparent(true);
        var scene = new Scene(vBox, 400, 300);
        scene.setFill(Color.TRANSPARENT);
        scene.getStylesheets().add(this.getClass().getResource("test.css").toExternalForm());
        primaryStage.initStyle(StageStyle.TRANSPARENT);
        primaryStage.setScene(scene);
        primaryStage.show();
        primaryStage.setAlwaysOnTop(true);

    }

    public static void main(String[] args) {
        launch(args);
    }
}

CSS
.root { -fx-background-color: transparent; }

Could anyone say how to do it, if it is possible.
', '["java", "javafx"]', '2024-11-16 21:10:56', '2024-11-16 21:31:00', 45, 0, 0, 0, 26656564, null),
        (79195263, 'how to place squares correctly (libgdx)', 'I have a problem with placing three squares in the right place, this is probably the fourth attempt to do it, I tried to watch guides but they are all hopeless and do not explain anything, and there is nothing written about it on libgdx.com
this is what it''s supposed to look like
what does it look like
public class Main extends ApplicationAdapter {
    private Stage stage;

    public Main(){

    }

    public Texture createTexture(Color color, int x , int y){
        Pixmap pixmap = new Pixmap(x,y, Pixmap.Format.RGBA8888);
        pixmap.setColor(color);
        pixmap.fill();

        Texture texture = new Texture(pixmap);
        pixmap.dispose();

        return texture;
    }

    @Override
    public void create() {
        stage = new Stage(new ScreenViewport());
        Gdx.input.setInputProcessor(stage);


        Table root = new Table();
        root.setFillParent(true);
        stage.addActor(root);

        Image button = new Image(createTexture(Color.ROYAL, 300,300));
        Image button2 = new Image(createTexture(Color.ROYAL, 200,100));
        Image button3 = new Image(createTexture(Color.ROYAL, 200,100));

        root.add(button);
        root.row();
        root.add(button2).width(200);
        root.add(button3).width(200);

        root.setDebug(true);
    }

    @Override
    public void render() {
        ScreenUtils.clear(0f, 0f, 0f, 1f);
        stage.act(Gdx.graphics.getDeltaTime());
        stage.draw();
    }


    @Override
    public void resize(int width, int height) {
        stage.getViewport().update(width, height);
    }

    @Override
    public void dispose() {
        stage.dispose();
    }
}


', '["java", "libgdx"]', '2024-11-16 21:42:55', '2024-11-17 02:19:51', 29, 1, 1, 0, 28331233, null),
        (79195377, 'The errors I am encountering indicate that the Spring Boot dependencies are not properly configured in my project', 'BlogappApplication.java:2: error: package org.springframework.boot does not exist
import org.springframework.boot.SpringApplication;
                               ^
BlogappApplication.java:3: error: package org.springframework.boot.autoconfigure does not exist
import org.springframework.boot.autoconfigure.SpringBootApplication;
                                             ^
BlogappApplication.java:4: error: cannot find symbol
@SpringBootApplication
 ^
  symbol: class SpringBootApplication
BlogappApplication.java:7: error: cannot find symbol
                SpringApplication.run(BlogappApplication.class, args);
                ^
  symbol:   variable SpringApplication
  location: class BlogappApplication
4 errors

i tried updating pom.xml file.
Reloaded the dependencies.
validated my main class like this
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class BlogappApplication {

    public static void main(String[] args) {
        SpringApplication.run(BlogappApplication.class, args);
    }
}

i can''t seem to make it work
', '["java", "spring-boot", "maven"]', '2024-11-16 22:46:10', '2024-11-17 01:28:09', 24, -1, 0, 0, 27857994, null),
        (79195409, 'Custom font when printing out to the terminal', 'For a college project, we have the requirement to create a CLI-Project. We are not allowed to use third-party-libraries. I decided to create a chess game and want to print the board for every move. For the pieces, I want to use a custom font, but I don''t know how to use it. All questions/tutorials are about JavaFX/Swing
', '["java"]', '2024-11-16 23:01:43', '2024-11-16 23:01:43', 31, 0, 0, 0, 13052898, null),
        (79195412, 'Your project&#39;s Gradle version is incompatible with the Java version that Flutter is using for Gradle. MAC M4 Flutter', 'There seems to be other similar questions but this one is on the new Mac M4.
distributionUrl=https\\://services.gradle.org/distributions/gradle-8.1-all.zip

Ive followed through on finding a gradle that is apparently compatible with Java 23 but still getting this error
java --version 
java 23.0.1 2024-10-15
Java(TM) SE Runtime Environment (build 23.0.1+11-39)
Java HotSpot(TM) 64-Bit Server VM (build 23.0.1+11-39, mixed mode, sharing)

Your project''s Gradle version is incompatible with the Java version that Flutter is using for Gradle. 

', '["java", "flutter", "gradle"]', '2024-11-16 23:03:13', '2024-11-16 23:23:23', 22, 0, 1, 0, 2904786, null),
        (79195468, 'Add checked object&#39;s id to list passed to model as attribute', 'I need a help with dynamic checkbox list handling. I want to add id of item to list of ids (class name SelectedIds and instance name selectedIds in code) that I passed to my template (its name is laptopIndexPage.html) from index page of Spring controller handler function by clicking on checkbox that located near by each object.
Spring controller code to handle index page (LaptopController.java):
@Controller
@RequestMapping("/manage-laptops")
public class LaptopController 
{
    @Autowired
    public LaptopService laptopService;

    @Autowired
    private DatabaseLaptopService dbLaptopService;
    // private List<String> idList = new ArrayList<>();
    @GetMapping(path = "/home")
    public String handleIndexPage(@RequestParam(required = false) Map<String, Object> allParams, Model model)
    {
        List<Laptop> laptops = new ArrayList<>();
        Pageable pageable = null;
        Page<Laptop> chunk = null;
        int pageSize = 5;
        if (!allParams.isEmpty())
        {

            if (allParams.containsKey("filter_by"))
            {
                
            }

            if (allParams.containsKey("page") && allParams.containsKey("size"))
            {
                String page = (String)allParams.get("page");
                String size = (String)allParams.get("size");

                pageable = PageRequest.of(Integer.parseInt(page) - 1, Integer.parseInt(size));
                chunk = dbLaptopService.getAllLaptops(pageable);
                laptops = chunk.getContent();
            }
            else 
            {
                pageable = PageRequest.of(0, 5);
                chunk = dbLaptopService.getAllLaptops(pageable);
                laptops = chunk.getContent();
            }

            
            HashSet<Laptop> unique = new HashSet<>();
            List<Laptop> tmp = laptops;
            unique.addAll(laptops);
            laptops = new ArrayList<>(tmp);
            laptops.clear();
            laptops.addAll(unique);
        }
        else 
        {
            pageable = PageRequest.of(0, 5);
            chunk = dbLaptopService.getAllLaptops(pageable);
            laptops = chunk.getContent();
        }
        
        

        model.addAttribute("currentPage", chunk.getNumber() + 1);
        model.addAttribute("totalItems", chunk.getTotalElements());
        model.addAttribute("totalPages", chunk.getTotalPages());
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("laptop", new Laptop());
        // model.addAttribute("idList", idList);
        SelectedIds selectedIds = new SelectedIds();
        model.addAttribute("selectedIds", selectedIds);
        model.addAttribute("laptops", laptops);
        
        return "laptopHomePage";
    }
}

HTML page:
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Device Form</title>
    <link rel="stylesheet" th:ref="@{/css/styles.css}">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            padding: 30px;
        }

        .form-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 20px;
        }
    </style>
</head>

<body>

    <div class="container mt-5">
        <div class="form-container p-4 border rounded shadow">
            <h2 class="text-center mb-4">Device Information Form</h2>
            <form th:action="@{add}" method="post" th:object="${laptop}">
                <div class="form-group">
                    <label for="modelName">Model Name</label>
                    <input type="text" id="modelName" class="form-control" th:field="*{modelName}">
                    <p class="text-danger" th:if="${#fields.hasErrors(''modelName'')}" th:errors="*{modelName}"></p>
                </div>
    
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" class="form-control" th:field="*{description}" rows="4" ></textarea>
                    <p class="text-danger" th:if="${#fields.hasErrors(''description'')}" th:errors="*{description}"></p>
                </div>
    
                <div class="form-group">
                    <label for="ramCapacity">RAM Capacity (GB)</label>
                    <input type="number" id="ramCapacity" class="form-control" th:field="*{ramCapacity}" min="1" >
                    <p class="text-danger" th:if="${#fields.hasErrors(''ramCapacity'')}" th:errors="*{ramCapacity}"></p>
                </div>
    
                <div class="form-group">
                    <label for="diskCapacity">Disk Capacity (GB)</label>
                    <input type="number" id="diskCapacity" class="form-control" th:field="*{diskCapacity}" min="1" >
                    <p class="text-danger" th:if="${#fields.hasErrors(''diskCapacity'')}" th:errors="*{diskCapacity}"></p>
                </div>
    
                <button type="submit" class="btn btn-primary btn-block">Submit</button>
            </form>
        </div>
    </div>
    

    

    <div class="container">
        <br>
        <h1 th:text="|Total laptops: ${totalItems}"></h1>

            <div>
                <input type="text" id="model_name_filter">
                <input type="text" id="model_ram_filter">
                <button type="button" onclick="doFilter()">
                    Filter
                </button>
            </div>

            <form th:action="@{delete-selected}" method="post" id="form_del" th:object="${selectedIds}">
                <input th:field="*{ids}" hidden th:value="${selectedIds.ids}"></input>
                <input type="button" value="Delete selected" th:attr="onclick=|alert(${selectedIds.ids.size})|">
            </form>

            
        <table class="table">
            <thead>
                <tr>
                    <th>Select</th>
                    <th>Model Name</th>
                    <th>Model Description</th>
                    <th>Ram</th>
                    <th>Disk capacity</th>
                </tr>
            </thead>
            <tbody>
                <tr th:each="laptop, stat : ${laptops}">
                        <td>
                            <input type="checkbox" th:name="${selectedIds.ids}" th:value="${laptop.id}">
                        </td>
                        <form th:action="@{update}" method="post" th:object="${laptop}">
                            
                            <td hidden><input type="number" name="id" th:value="${laptop.id}"></td>
                            <td>
                                <input type="text" th:value="${laptop.modelName}" th:name="modelName">
                                <p class="text-danger" th:if="${#fields.hasErrors(''modelName'')}" th:errors="*{modelName}"></p>
                            </td>
                            <td>
                                <input type="text" th:value="${laptop.description}" th:name="description">
                                <p class="text-danger" th:if="${#fields.hasErrors(''description'')}" th:errors="*{description}"></p>
                            </td>
                            <td>
                                <input type="number"   th:value="${laptop.ramCapacity}" th:name="ramCapacity">
                                <p class="text-danger" th:if="${#fields.hasErrors(''ramCapacity'')}" th:errors="*{ramCapacity}"></p>   
                            </td>
                            <td>
                                <input type="number"  th:value="${laptop.diskCapacity}" th:name="diskCapacity"></td>
                                <p class="text-danger" th:if="${#fields.hasErrors(''diskCapacity'')}" th:errors="*{diskCapacity}"></p>
                                <td>
                            <input type="submit" value="update">
                        </form>
                    </td>
                    <td>
                        <form method="post"  th:with="rel=''delete/'' + ${laptop.id}"  th:action="${rel}">
                            <input type="submit" value="delete">
                        </form>
                    </td>
                </tr>
            
            </tbody>
        </table>
    </div>

When I select some elements on the page and do post on following form:
<form th:action="@{delete-selected}" method="post" id="form_del" th:object="${selectedIds}">
                <input th:field="*{ids}" hidden th:value="${selectedIds.ids}"></input>
                <input type="submit" value="Delete selected">
            </form>

and see the size of id array in console printed by this function:
@PostMapping(path = "/delete-selected")
public String deleteSelected(@ModelAttribute("selectedIds") SelectedIds selectedIds, Model model)
{
    if (selectedIds != null)
    {
        System.out.println("Selected: " + selectedIds.getIds().size());
    }   
    return "redirect:home";
}

I get:
Selected: 0

So, how to add values to list selectedIds.ids passed by me? Is it impossible?
', '["java", "html", "spring-boot", "templates", "thymeleaf"]', '2024-11-16 23:33:47', '2024-11-17 23:38:28', 22, 0, 0, 0, 20608855, null),
        (79195567, 'java.lang.InternalError: platform encoding not initialized Error occurred during initialization of VM', 'I have a simple "Hello world" program.
I can package and run it without errors with maven on a Raspberry Pi/Linux.
But if I just load the only java file: App.java into Mousepad and save it again (overwriting),
mvn clean package
and then run the jar-file again I get the error.
A restart of the RPI solves the problem unless I don''t save the file App.java again.
', '["java", "maven", "jar"]', '2024-11-17 00:26:46', '2024-11-17 00:26:46', 20, 0, 0, 0, 1768365, null),
        (79195686, 'Java JPA Repository One To One Join Table Wrong Join Variable and Unknown Column Error', 'I am struggling to get a one to one join relationship JPA repository call to work.
I have two tables product and display_name so I made the follow entities
 @Entity
 @Table(name = "product")
 @NoArgsConstructor
 @ToString(callSuper = true)
 @EqualsAndHashCode(callSuper = true, of = "id")
 @Getter
 @Setter
 public class Product {
 
   @Builder
   public Product(
       UUID id,
       ...
       String name) {
     this.id = id
     ...
     this.name = name;
   }
 
   @Id
   @Column(name = "id", nullable = false, updatable = false, unique = true)
   protected UUID id;
 
   ...
 
   @Column(name = "name", nullable = false)
   private String name;
 }

 @Entity
 @Table(name = "display_name")
 @NoArgsConstructor
 @ToString()
 @Getter
 @Setter
 public class DisplayName {
 
   @Builder
   public DisplayName(
       String systemName,
       String displayName) {
     this.systemName = systemName;
     this.displayName = displayName;
   }
 
   @Id
   @Column(name = "system_name", nullable = false)
   private String systemName;
 
   @Column(name = "display_name", nullable = false)
   private String displayName;

And now I want to use my JPA Repository for Product to do something similar to this query that fetches both tables data:
 SELECT * FROM product
 LEFT JOIN display_name
 ON name = system_name;

This a one to one relationship meaning that each name in Product maps to one system_name and the other way too
so I added some foreign keys (not sure if they are needed)
ALTER TABLE display_name
 ADD CONSTRAINT fk_system_name
 FOREIGN KEY (system_name) REFERENCES product (`name`) ON DELETE CASCADE;
 
 ALTER TABLE product
 ADD CONSTRAINT fk_name
 FOREIGN KEY (`name`) REFERENCES display_name (system_name) ON DELETE CASCADE;

then I a added one to one field to Prdouct for DisplayName
   @OneToOne()
   @JoinTable(
       name = "display_name",
       joinColumns = {@JoinColumn(name = "system_name")},
       inverseJoinColumns = {@JoinColumn(name = "name")})
   @Exclude
   private DisplayName displayName;

So now I have this jpa repostiory that I want to get all the Product values from
 public interface ProductRepository
     extends JpaRepository<Product, UUID>, JpaSpecificationExecutor<Product> {
         Page<Product> findAllByName(String name);
     }

but when I call findAllByName in my rest controller I get following error
2024-11-16 10:38:07 2024-11-16 15:38:07.706 ERROR 1 --- [io-10005-exec-2] o.a.c.c.C.[.[.[/].[dispatcherServlet]    : Servlet.service() for servlet [dispatcherServlet] in context with path [] threw exception [Request processing failed: org.springframework.dao.InvalidDataAccessResourceUsageException: JDBC exception executing SQL [
 select p1_0.id,p1_0.name,p1_2.name from product p1_0 left join display_name p1_2 on p1_0.id=p1_2.system_name [(conn=76324) Unknown column ''p1_2.name'' in ''field list''] [n/a]; SQL [n/a]] with root cause [] 
 2024-11-16 10:38:07 
 2024-11-16 10:38:07 java.sql.SQLSyntaxErrorException: (conn=76324) Unknown column ''p1_2.name'' in ''field list''

which I am not sure why it''s joining product.id on display_name.system_name and looking for display_name.name when that does not exit? I probably setup the @OneToOne field wrong but I am not quite sure what the correct syntax should be. Thanks for any help in advance
', '["java", "mysql", "spring-boot", "hibernate", "jpa"]', '2024-11-17 01:14:57', '2024-11-18 02:48:58', 39, 0, 1, 0, 11575493, null),
        (79195775, 'use jacoco instrument command to get probed class and it seems strange', 'this is source code
public class App {

    public static void main(String[] args) throws InterruptedException {
        System.out.println( "invoke invoke main" );
        while( true ) {
            Thread.currentThread().sleep( 1000 );
            System.out.println( new Date() );
        }
    }
}


this is the run command in IDEA
-javaagent:/Users/jiajie.zhuang/gitlab-idea/jacoco-debug/lib/jacocoagent.jar=includes=com.*,output=tcpserver,address=127.0.0.1,port=6300,append=true

use jacoco Instrument to get probed class, and it shows:
public class App {
    public App() {
        boolean[] var2 = (boolean[])"$jacocoData";
        super();
        var2[0] = true;
    }

    public static void main(String[] args) throws InterruptedException {
        boolean[] var2 = (boolean[])"$jacocoData";
        System.out.println("invoke invoke main");
        var2[1] = true;

        while(true) {
            Thread.currentThread();
            Thread.sleep(1000L);
            var2[2] = true;
            System.out.println(new Date());
            var2[3] = true;
        }
    }
}

Why the static field $jacocoData and init method $jacocoInit() are not in the class file?
jdk 11
jacoco master
I run the source code in IDEA with the run-params, and I use Instrument to see the probed class file , but I can not find the $jacocoData and $jacocoInit() in it.
', '["java", "intellij-idea", "jacoco"]', '2024-11-17 02:02:14', '2024-11-17 02:02:14', 13, 0, 0, 0, 24375988, null),
        (79195854, 'Is there any way to lock a process in java to prevent multiple instance at the same time after making an exe file with jpackage', 'I found this code here which basically allow only one instance of the app at one moment. The code works fine when I try to launch two instances af the jar file from the command line but after I use jpackage to make an .exe file I can launch more than one instances of the app at a time. Does anyone know why it behaves like this?
Is there anyway to  lock a process in java to prevent multiple instance of the same app at the same time after making an .exe file with jpackage?
', '["java", "javafx", "jpackage", "single-instance"]', '2024-11-17 02:52:15', '2024-11-17 09:40:54', 64, 1, 1, 0, 22244178, null),
        (79195923, 'JAR cannot find a suitable driver for SQLite JDBC connection even though it is in the classpath', 'Let me begin by saying that I''ve gone through half a dozen questions with the same subject and through the answers that tell to add SQLite JDBC driver to the pom.xml file. My case is different, because the dependency is already there and has always been, since the creation of the project. It runs in Netbeans but does not run on the command line.
Here''s my pom. I removed other dependencies that have no bearing on the question and left only Xerial:
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.myorg</groupId>
    <artifactId>myproj</artifactId>
    <version>1.0-0</version>
    <packaging>jar</packaging>
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <configuration>
                    <archive>
                        <manifest>
                            <addClasspath>true</addClasspath>
                            <mainClass>com.myorg.myproj.myclass</mainClass>
                        </manifest>
                    </archive>
                </configuration>
            </plugin>
        </plugins>
    </build>
    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <exec.mainClass>com.myorg.myproj.myclass</exec.mainClass>
    </properties>
    <dependencies>
        <dependency>
          <groupId>org.xerial</groupId>
          <artifactId>sqlite-jdbc</artifactId>
          <version>3.46.0.1</version>
        </dependency>
    </dependencies>
    <name>myproj</name>
    <description>myproj is</description>
</project>

Here''s my manifest. I also removed the irrelevant dependencies from the classpath:
Created-By: Maven JAR Plugin 3.3.0
Build-Jdk-Spec: 11
Class-Path: <some jars> sqlite-jdbc-3.46.0.1.jar slf4j-api-1.7.36.jar <more jars>
Main-Class: com.myorg.myproj.mymainclass

I do notice that slf4j is in the classpath but not in pom.xml but this should not be a problem, should it? If it''s on the classpath, that should suffice, should it not?
What is still missing for this JAR to be self-contained and run on the command line?
', '["java", "maven", "jar", "pom.xml", "sqlitejdbc"]', '2024-11-17 03:35:26', '2024-11-17 03:35:26', 35, 0, 0, 0, 20531906, null),
        (79196045, 'Implementing a thread safe sliding based rate limiter in java', 'I am designing a sliding window based rate limiter can came up with the following approach
package RateLimiter;

import lombok.Getter;

import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

@Getter
class Request{
    private final String userId;
    private final Long time;

    Request(String userId, Long currentTime){
        this.userId = userId;
        this.time = currentTime;
    }
}

public class RateLimiter {
    Map<String, Queue<Request>> requestsMap;
    int threshold;
    long timeWindow;
    int noOfRequestsServed;
    RateLimiter(int _threshold, int timeWindow, TimeUnit unit){
        requestsMap = new HashMap<>();
        threshold = _threshold;
        this.timeWindow = unit.toMillis(timeWindow);
        noOfRequestsServed = 0;
    }

    public synchronized boolean canAccept(String userId){
        long currentTime = System.currentTimeMillis();
        if(!requestsMap.containsKey(userId))
        {
            requestsMap.computeIfAbsent(userId, k -> new LinkedList<>()).add(new Request(userId, currentTime));
            noOfRequestsServed++;
            return true;
        }

        evict(userId, currentTime);
        if(requestsMap.get(userId).size() >= threshold)
            return false;
        else
        {
            Queue<Request> userList = requestsMap.get(userId);
            userList.add(new Request(userId, currentTime));
            requestsMap.put(userId, userList);
            noOfRequestsServed++;
            return true;
        }
    }

    private synchronized void evict(String userId, long currentTime) {
//        System.out.println("Thread used for eviction is " + Thread.currentThread().getName());
        Queue<Request> userRequestList = requestsMap.get(userId);
        while(!userRequestList.isEmpty() && userRequestList.peek().getTime() + timeWindow < currentTime){
            userRequestList.poll();
        }
        requestsMap.put(userId, userRequestList);
    }

    public static void main(String[] args) throws InterruptedException {
        RateLimiter limiter = new RateLimiter(5, 10, TimeUnit.SECONDS);
        ExecutorService executorService = Executors.newFixedThreadPool(10);
        executorService.execute(() -> {
           for(int i = 0; i<10; i++){
               System.out.println("Request accepted from Thread " + Thread.currentThread().getName() + " " + limiter.canAccept("IshaanDesai"));
           }
        });
        executorService.execute(() -> {
            for(int i = 0; i<10; i++){
                System.out.println("Request accepted from Thread " + Thread.currentThread().getName() + " " + limiter.canAccept("IshaanDesai"));
            }
        });
        executorService.execute(() -> {
            for(int i = 0; i<10; i++){
                System.out.println("Request accepted from Thread " + Thread.currentThread().getName() + " " + limiter.canAccept("IshaanDesai"));
            }
        });

        Thread.sleep(10000);

        System.out.println("Request accepted from Thread " + Thread.currentThread().getName() + " " + limiter.canAccept("IshaanDesai"));

        System.out.println("no of requests served " + limiter.noOfRequestsServed);
    }
}


Now is my implementation really thread safe and how can I improve the implementation?
Trying to create an efficient thread safe sliding window rate limiter
So, I used an Map<String, Queue<Request>> to store the request in the window trying to evict all the requests with have expired on every new request.
So, I was trying to make my code thread safe and how to make a the key i.e the userId in the above code extensible because in real world rateLimiting can be based on any strategy not only on userID.
', '["java", "multithreading", "concurrency"]', '2024-11-17 05:03:47', '2024-11-17 05:03:47', 31, 0, 0, 0, 16324096, null),
        (79196083, 'Spring Boot Controller Not Registering and 404 Error on POST Request', 'I’m working on a Spring Boot application, and I’m having trouble getting my controller to register correctly. When I try to POST data to the /student/add endpoint, I receive a 404 error, indicating that the endpoint cannot be found.
My Controller:
@RestController
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentService studentService;

    @PostConstruct
    public void init() {
        System.out.println("StudentController initialized!"); // Debug statement
    }

    @PostMapping("/add")
    public String add(@RequestBody Student student) {
        studentService.saveStudent(student);
        return "New user Added";
    }

    @GetMapping("/getAll")
    public List<Student> getAllStudents() {
        return studentService.getAllStudents();
    }
}

My Student Model:
@Entity
public class Student {

    @Id
    private String password;
    private String username;
    private String email;

    // Getters and setters
}

Project Setup:
Project Setup
Ensured the controller is in the correct package (under the main application package).
Added @RestController and @RequestMapping("/student") annotations to the controller.
Verified dependencies for Spring Web and Spring Data JPA in pom.xml.
Cleaned and rebuilt the project.
Checked application logs for clues.
', '["java", "spring", "spring-boot", "http-status-code-404", "spring-restcontroller"]', '2024-11-17 05:29:03', '2024-11-17 18:42:53', 57, 1, 3, 0, 28335747, null),
        (79196084, 'Java Tensorflow predictions are zeros', 'I am trying to learn Tensorflow with Java. I exported my model in Python to ".pb" format, and I am trying to do predictions with it. The model works well in Python, but when I try to predict in Java, it fails to give any valid output.
Is there something clearly wrong here? Or does the problem lay in the way the model was exported.
public List<String> predict(ChessBoard chessBoard) {
   // Create a tensor
   TFloat32 inputTensor = chessBoard.encodeBoardToTensor();
    
   // Feed the tensor to the model
   Result res = this.model.call(Collections.singletonMap("input_layer", inputTensor));
   Tensor output = res.get(0);
    
   // Make predictions using the model
   float[] predictions = new float[4672];
   output.asRawTensor().data().asFloats().read(predictions);

   ...
}

I checked the format of the inputTensor, and it matches the one in Python.
The Tensor shape is (1,8,8,12), a chessboard shape with batch data.
', '["java", "tensorflow"]', '2024-11-17 05:29:59', '2024-11-17 05:30:47', 13, 0, 0, 0, 23497973, null),
        (79196103, 'How to make facet search by multiple nested fields in Elasticsearch Java API Client?', 'There are my example documents.
"id" : "1",
"title" : "test",
"description" : "test",
"price" : 100.0,
"category_id" : "1",
"characteristics" : [
  {
    "characteristic_id" : "1",
    "text_value" : "red"
  },
  {
    "characteristic_id" : "2",
    "numeric_value" : 15
  },
  {
    "characteristic_id" : "3",
    "numeric_value" : 20
  }
]

"id" : "2",
"title" : "test",
"description" : "test",
"price" : 200.0,
"category_id" : "1",
"characteristics" : [
  {
    "characteristic_id" : "1",
    "text_value" : "blue"
  },
  {
    "characteristic_id" : "2",
    "numeric_value" : 10
  },
  {
    "characteristic_id" : "3",
    "numeric_value" : 5
  }
]

And a query to my index must be like this. How can i write this using new Java Api Client for Elasticsearch?
GET product/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "nested": {
            "path": "characteristics",
            "query": {
              "bool": {
                "must": [
                  {
                    "term": {
                      "characteristics.characteristic_id": 1
                    }
                  },
                  {
                    "term": {
                      "characteristics.text_value": "blue"
                    }
                  }
                ]
              }
            }
          }
        },
        {
          "nested": {
            "path": "characteristics",
            "query": {
              "bool": {
                "must": [
                  {
                    "term": {
                      "characteristics.characteristic_id": 3
                    }
                  },
                  {
                    "range": {
                      "characteristics.numeric_value": {
                        "gte": 1,
                        "lte": 7
                      }
                    }
                  }
                ]
              }
            }
          }
        },
        {
          "term": {
            "category_id": 1
          }
        },
        {
          "range": {
            "price": {
              "gt": 10.0,
              "lt": 500.0
            }
          }
        }
      ],
      "should": [
        {          
          "match": {
            "title": "te"
          }
        }
      ]
    }
  }
}

There is very little information in the official documentation. Should I even use this API if there is no normal documentation for it and write all the requests manually?
', '["java", "elasticsearch"]', '2024-11-17 05:43:18', '2024-11-17 23:32:07', 22, 0, 0, 0, 25945599, null),
        (79196104, 'How to properly use a try/catch block in a while loop to handle invalid input in Java?', 'I’m trying to write a Java program that asks the user to input a positive integer inside a while loop. The loop should continue until valid input is provided.
I’ve tried using a try/catch block to handle invalid inputs like strings, but I’m still running into issues. For example:

When the user enters a string, the program throws an InputMismatchException and skips re-prompting the user.

I tried adding scanner.nextLine() to clear the input buffer, but it didn’t work as expected.


Here’s the code I’ve written so far:
import java.util.Scanner;

public class InputExample {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int userInput = -1;

        while (userInput < 0) {
            try {
                System.out.print("Enter a positive number: ");
                userInput = scanner.nextInt(); // Crashes if invalid input is entered
            } catch (InputMismatchException e) {
                System.out.println("Invalid input. Please enter a valid number.");
                scanner.nextLine(); // Attempt to clear the buffer, but it doesn''t work
            }
        }

        System.out.println("You entered: " + userInput);
        scanner.close();
    }
}

The issue:

When invalid input (like a string) is entered, the program skips re-prompting the user.

I suspect there’s an issue with how I’m clearing the input buffer using scanner.nextLine().


What I’ve tried:

Wrapping the scanner.nextInt() inside a try/catch block to catch the exception.

Using scanner.nextLine() after catching the exception to clear the input.


My question:
How can I properly handle invalid input in this scenario so that the program keeps re-prompting the user until a valid positive integer is provided?
', '["java", "validation", "exception", "while-loop"]', '2024-11-17 05:43:21', '2024-11-17 21:47:28', 139, 1, 2, 0, 28287411, 79197307),
        (79196243, 'Template for keycloak:23 invitation email', 'Using keycloak in version 23 there''s no preexisting email template for invitation to organization.
It is possible to write a invitation-email.ftl template and it will work just fine. The only thing is that organization.name doesn''t work (I think that the support for that has been added in the later versions). Is there a way of providing the organization''s name variable to the custom template?
', '["java", "keycloak", "freemarker"]', '2024-11-17 07:31:24', '2024-11-17 07:47:58', 17, 0, 0, 0, 16948466, null),
        (79196498, 'Are segment trees good to implement bitwise operations on a range of numbers in efficient time?', 'While solving some questions, I came up across a question where I had to perform XOR operation in efficient time on a specific range of numbers which might be large for some test cases. Can it be done using segment trees efficiently.
I tried regular methods, I was expecting more efficient TC for this.
', '["python", "java", "data-structures"]', '2024-11-17 12:34:15', '2024-11-17 12:34:15', 28, -4, 0, 0, 26923101, null),
        (79196662, 'How does the JVM optimize nested loops with dynamic bounds involving dependent computations?', '
When does it make sense to use parallel streams over traditional loops?

Are there performance or resource drawbacks to parallel streams?
How does data size or task complexity influence this decision?
Could someone explain the trade-offs between these two approaches and provide guidance on when to use each? Any examples or best practices would be appreciated.

', '["java"]', '2024-11-17 15:10:19', '2024-11-17 15:46:26', 37, -1, 0, 0, 28088644, null),
        (79196666, 'WIndows 10 javaw is running in the background taking 30% CPU', 'I have Java installed on Windows 10, current version U60.
I have noticed recently (possibly since latest Java update) that whenever a Java application is run, there''s a "Java SE Platform" process (javaw.exe) running in the background, taking 30% CPU time.
That javaw process seems to be unconnected to the Java application which have started it; it keeps running even when the application is closed, and OTOH while the application keeps running, killing it (by Task Manager, using "End Task") seems to have no effect on the application.
Once this javaw is killed everything is OK, but it restarted every time a Java application is run.
The only answer I could find so far is to uninstall Java and re-install it, but no assurance that this may solve the problem.
', '["java", "javaw"]', '2024-11-17 15:11:13', '2024-11-17 23:29:52', 42, 0, 0, 0, 9904013, null),
        (79196841, 'In FXML, I am trying to scale when I go fullscreen', 'I want the application, upon entering fullscreen, to first expand the stage and adjust all objects. Only after this, the code should run to get the width of the VBox, as I need this value to determine the available space for the objects inside it. Currently, the code runs before the stage expands, but I want the opposite: for the stage to expand first, and then for the instructions to execute to scale the objects.
For example: when I go fullscreen, System.out.println(vboxpai3.getWidth()); gives me 500, but when I exit fullscreen, System.out.println(vboxpai3.getWidth()); gives me 1500.
private HBox root;
@FXML
private VBox vboxpai3;

Platform.runLater(() -> {Stage stage = (Stage) root.getScene().getWindow();

    // Listener to detect when the stage enters or exits fullscreen
    stage.fullScreenProperty().addListener((obs, wasFullScreen, isNowFullScreen) -> {
        // Wait for the layout to update after fullscreen transition
        Platform.runLater(() -> {
            // Ensure the VBox width is updated after the fullscreen transition
            System.out.println("VBox width after fullscreen: " + vboxpai3.getWidth());
        });
    });
});```

', '["java", "javafx", "scale", "fxml", "fullscreen"]', '2024-11-17 17:02:15', '2024-11-18 15:27:48', 13, 0, 0, 0, 27830542, null),
        (79196864, 'I can&#39;t connect by backend to tha database when doing it on docker but it works fine when I do it locally', 'I have an application with Spring Boot and Java for the backend, MySQL for the database, and React + Vite for the frontend. When I try to build an image of the backend and then run the image on a container I get a communications link failure. I''ve tried everything and it doesn''t seem to work, everything works fine when I do it without docker locally. When I try the frontend on docker, it works, but the backend does not work, so I can''t try the docker-compose file. This is the docker-compose file for everything:
version: ''3.8''

services:
  frontend:
    build:
      context: ./Frontend
      dockerfile: Dockerfile
    ports:
      - "5173:5173"
    environment:
      - HOST=0.0.0.0
    depends_on:
      - backend
    networks:
      - journal_system_net

  backend:
    build:
      context: ./Backend
      dockerfile: Dockerfile
    ports:
      - "8080:8080"
    environment:
      - DB_URL=jdbc:mysql://localhost:3306/journalsystem
      - DB_USERNAME=journal_user
      - DB_PASSWORD=journal321
    depends_on:
      - db
    networks:
      - journal_system_net

  db:
    image: mysql:8.0
    environment:
      MYSQL_DATABASE: journalsystem
      MYSQL_USER: journal_user
      MYSQL_PASSWORD: journal321
      MYSQL_ROOT_PASSWORD: rootpassword123
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - journal_system_net

volumes:
  mysql_data:

networks:
  journal_system_net:
    driver: bridge

Here is the dockerfile for the backend:
FROM openjdk:21-jdk-slim

WORKDIR /app

COPY target/Backend-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]

And this is the Dockerfile for the frontend (this one works): 

FROM node:18

WORKDIR /app

COPY . .

RUN npm install

EXPOSE 5173

ENV HOST=0.0.0.0

CMD ["npm", "run", "dev"]

I would appreciate the help so my backend could work and I do not get a "communications link failure" when trying to run the backend image on docker.
I have tried doing my network for it, I have watched multiple YouTube videos, but nothing works.
', '["java", "mysql", "spring-boot", "docker", "dockerfile"]', '2024-11-17 17:16:46', '2024-11-17 18:11:53', 30, -1, 0, 0, 22735175, null),
        (79197174, 'Android java application architecture', 'I am writting an Android application which gets data from URL in JSON format. I use fragments. Where I can do bussiness logic? On fragment ViewModel? The main idea, is get data from JSON URL link, analyze, get current device location, and display analyzed data on fragment. I am quite new in Android programming. Please advice or what is good practice to do it? Should I use android data repository?
Now I have fragment, viewmodel for fragment where I analyze JSON data
', '["java", "android", "json", "fragment"]', '2024-11-17 20:25:14', '2024-11-17 20:51:11', 25, -1, 2, 0, 28341467, null),
        (79197232, 'Batch Size and Fetch Size in Spring Boot JDBC client', 'I am exploring JDBC client of spring boot, and looking options to set batch size and fetch size.
But can not find any document/article explaining the same.
Is there a way preferbly in properties file to instruct spring boot to use it?
', '["java", "spring", "spring-boot", "spring-jdbc"]', '2024-11-17 20:54:27', '2024-11-17 21:08:51', 36, -3, 1, 0, 22179743, null),
        (79197267, 'Spring Boot Flyway not running on startup', 'I have a spring boot application, and I''ve installed the Flyway dependency to run my Postgres migrations. However, when I run the application, nothing happens.
My pom.xml has the following:
<dependency>
    <groupId>org.flywaydb</groupId>
    <artifactId>flyway-core</artifactId>
    <version>10.20.0</version>
</dependency>

In my application.properties I have the following:
spring.flyway.enabled=true
spring.flyway.baseline-on-migrate=true
logging.level.org.flywaydb=DEBUG

spring.datasource.url=jdbc:postgresql://localhost:5432/mydb
spring.datasource.username=username
spring.datasource.password=password

I have my migration sql file inside of resources/db/migration with the name of : V1__initial_migration.init with create table query inside.
And finally, the logs when I run the app is not showing anything related with flyway and in the database nothing changes:


2024-11-17T12:59:30.239Z  INFO 13224 --- [task_management] [           main] c.example.task_management.Application    : No active profile
set, falling back to 1 default profile: "default"
2024-11-17T12:59:31.094Z  INFO 13224 --- [task_management] [
main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring
Data JPA repositories in DEFAULT mode. 2024-11-17T12:59:31.164Z  INFO
13224 --- [task_management] [           main]
.s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data
repository scanning in 60 ms. Found 3 JPA repository interfaces.
2024-11-17T12:59:31.884Z  INFO 13224 --- [task_management] [
main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized
with port 8080 (http) 2024-11-17T12:59:31.904Z  INFO 13224 ---
[task_management] [           main]
o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2024-11-17T12:59:31.904Z  INFO 13224 --- [task_management] [
main] o.apache.catalina.core.StandardEngine    : Starting Servlet
engine: [Apache Tomcat/10.1.31] 2024-11-17T12:59:31.977Z  INFO 13224
--- [task_management] [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring
embedded WebApplicationContext 2024-11-17T12:59:31.978Z  INFO 13224
--- [task_management] [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext:
initialization completed in 1659 ms 2024-11-17T12:59:32.145Z  INFO
13224 --- [task_management] [           main]
com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Starting...
2024-11-17T12:59:32.362Z  INFO 13224 --- [task_management] [
main] com.zaxxer.hikari.pool.HikariPool        : HikariPool-1 - Added
connection org.postgresql.jdbc.PgConnection@2668c286
2024-11-17T12:59:32.364Z  INFO 13224 --- [task_management] [
main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Start
completed. 2024-11-17T12:59:32.437Z  INFO 13224 --- [task_management]
[           main] o.hibernate.jpa.internal.util.LogHelper  :
HHH000204: Processing PersistenceUnitInfo [name: default]
2024-11-17T12:59:32.502Z  INFO 13224 --- [task_management] [
main] org.hibernate.Version                    : HHH000412: Hibernate
ORM core version 6.5.3.Final 2024-11-17T12:59:32.545Z  INFO 13224 ---
[task_management] [           main]
o.h.c.internal.RegionFactoryInitiator    : HHH000026: Second-level
cache disabled 2024-11-17T12:59:32.937Z  INFO 13224 ---
[task_management] [           main]
o.s.o.j.p.SpringPersistenceUnitInfo      : No LoadTimeWeaver setup:
ignoring JPA class transformer 2024-11-17T12:59:33.914Z  INFO 13224
--- [task_management] [           main] o.h.e.t.j.p.i.JtaPlatformInitiator       : HHH000489: No JTA platform
available (set ''hibernate.transaction.jta.platform'' to enable JTA
platform integration) 2024-11-17T12:59:33.917Z  INFO 13224 ---
[task_management] [           main]
j.LocalContainerEntityManagerFactoryBean : Initialized JPA
EntityManagerFactory for persistence unit ''default''
2024-11-17T12:59:34.298Z  WARN 13224 --- [task_management] [
main] JpaBaseConfiguration$JpaWebConfiguration :
spring.jpa.open-in-view is enabled by default. Therefore, database
queries may be performed during view rendering. Explicitly configure
spring.jpa.open-in-view to disable this warning
2024-11-17T12:59:34.800Z  INFO 13224 --- [task_management] [
main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on
port 8080 (http) with context path ''/'' 2024-11-17T12:59:34.813Z  INFO
13224 --- [task_management] [           main]
c.example.task_management.Application    : Started Application in
5.045 seconds (process running for 5.497)


What can be causing this issue?
', '["java", "spring", "flyway"]', '2024-11-17 21:14:05', '2024-11-17 21:54:21', 28, 0, 1, 0, 25087850, null),
        (79197276, 'Can&#39;t change accessibility to field in unit test . getDeclaredField can&#39;t find my field', 'I have the problem that my getDeclaredField can''t find my field, and I can''t find why. Any ideas?
public interface MapInterface<K extends Comparable<K>, V> {

    public void setValue(K key, V value);

    public V getValue(K key);

}

This is the class that implements that interface:
public class RbtMap<K extends Comparable<K>, V> implements MapInterface<K, V> {

    private final RedBlackTree<K, V> tree;

    public <K, V> RbtMap() {
        tree = new RedBlackTree<>();
    }

In my unit test, I try get access to tree
Field treeField = RbtMap.class.getDeclaredField("tree");

but I have that:

Unhandled exception: java.lang.NoSuchFieldException

I don''t know what I should do.
', '["java", "reflection", "private", "final"]', '2024-11-17 21:18:49', '2024-11-17 23:57:57', 43, 0, 1, 0, 22526928, 79197548),
        (79197380, 'How can I sort out my departure flights and landing flights?', 'I am currently working on a project and I have to implement a sorting option. I created one but it only sorts out the loaded data from a csv file. I can''t seem to get it to sort out the flights that are also added onto the departure and landing queues.
I tried changing the format for what the flights are later displayed as but it doesn''t work. I tried to change the sorting to independently sort out each category but it also doesn''t work.
import javafx.application.Application;
import javafx.application.Platform;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.scene.paint.Color;
import javafx.stage.Modality;
import javafx.stage.Stage;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
public class AirportManagementSystem extends Application {
    private static final String FILE_PATH = "/Users/deadpackets/Downloads/124project2-main/landingFlights.csv"; // Ensure your file path is correct
    private ToggleGroup flightType = new ToggleGroup();
    private List<String> departingFlightList = new ArrayList<>();
    private List<String> landingFlightList = new ArrayList<>();
    private List<String[]> allFlights = new ArrayList<>();
    private List<String[]> onTimeFlights = new ArrayList<>();
    private List<String[]> lateFlights = new ArrayList<>();
    private ListView<Label> flightListView = new ListView<>();
    @Override
    public void start(Stage stage) {
        BorderPane border = new BorderPane();
        VBox mainMenu = new VBox(10);
        RadioButton departingButton = new RadioButton("Departing");
        RadioButton landingButton = new RadioButton("Landing");
        departingButton.setToggleGroup(flightType);
        landingButton.setToggleGroup(flightType);
        HBox radioBtnBox = new HBox(10, new Label("Select Queue:"), departingButton, landingButton);
        radioBtnBox.setPadding(new Insets(10));
        Button addButton = createStyledButton("Add Flight", "#4CAF50");
        Button removeButton = createStyledButton("Remove Flight", "#f44336");
        Button displayQueuesButton = createStyledButton("Display Queues", "#2196F3");
        Button sortButton = createStyledButton("Sort", "#FF9800");
        Button filterButton = createStyledButton("Filter", "#03A9F4");
        Button loadDataButton = createStyledButton("Load Data", "#8BC34A");
        Button requeueButton = createStyledButton("Requeue Late Depatures", "#9C27B0");
        Button exitButton = createStyledButton("Exit", "#E91E63");

        exitButton.setOnAction(e -> Platform.exit());

        mainMenu.getChildren().addAll(radioBtnBox, addButton, removeButton, displayQueuesButton, sortButton, filterButton, loadDataButton, requeueButton, exitButton);
        mainMenu.setPadding(new Insets(10));
        departingButton.setStyle("-fx-text-fill: #0056B3;");
        landingButton.setStyle("-fx-text-fill: #0056B3;");
        mainMenu.setStyle("-fx-background-color: #F0F0F0;");
        mainMenu.setBorder(new Border(new BorderStroke(Color.BLACK, BorderStrokeStyle.SOLID, new CornerRadii(5), BorderStroke.THIN)));
        border.setLeft(mainMenu);
        VBox box1 = new VBox(10);
        box1.setPadding(new Insets(10));
        box1.setBorder(new Border(new BorderStroke(Color.BLACK, BorderStrokeStyle.SOLID, new CornerRadii(5), BorderWidths.DEFAULT)));
        box1.setPrefSize(300, 300);
        VBox box2 = new VBox(10);
        box2.setPadding(new Insets(10));
        box2.setBorder(new Border(new BorderStroke(Color.BLACK, BorderStrokeStyle.SOLID, new CornerRadii(5), BorderWidths.DEFAULT)));
        box2.setPrefSize(300, 300);
        VBox box3 = new VBox(10); // New VBox for loaded flight data
        box3.setMaxWidth(400);
        box3.setPadding(new Insets(10));
        box3.setBorder(new Border(new BorderStroke(Color.BLACK, BorderStrokeStyle.SOLID, new CornerRadii(5), BorderWidths.DEFAULT)));
        box3.setPrefWidth(400);
        HBox hb = new HBox(10);
        hb.setPadding(new Insets(10));
        hb.getChildren().addAll(box1, box2, box3);
        border.setCenter(hb);
        Label t1 = new Label("Departing Flights");
        ListView<HBox> lV1 = new ListView<>();
        lV1.setPrefHeight(400);
        lV1.setPrefWidth(200);
        box1.getChildren().addAll(t1, lV1);
        Label t2 = new Label("Landing Flights");
        ListView<HBox> lV2 = new ListView<>();
        lV2.setPrefHeight(400);
        lV2.setPrefWidth(200);
        box2.getChildren().addAll(t2, lV2);
        // Create a ListView for the loaded flight data
        Label t3 = new Label("Loaded Flights");
        flightListView.setPrefHeight(400);
        flightListView.setPrefWidth(200);
        box3.getChildren().addAll(t3, flightListView);
        loadDataButton.setOnAction(e -> handleLoadFlights());
        requeueButton.setOnAction(e -> handleRequeueLateDepartures());
        sortButton.setOnAction(e -> sorting());
        Scene scene = new Scene(border, 950, 400); // Adjusted scene size
        stage.setTitle("Airport Management");
        stage.setScene(scene);
        stage.show();
        addButton.setOnAction(e -> openAddFlight(lV1, lV2));
        removeButton.setOnAction(e -> {
            RadioButton selectedButton = (RadioButton) flightType.getSelectedToggle();
            if (selectedButton != null && selectedButton.getText().equals("Departing")) {
                if (!departingFlightList.isEmpty()) {
                    departingFlightList.remove(departingFlightList.size() - 1);
                    showAlert(Alert.AlertType.INFORMATION, "Success", "Last departing flight added is removed!");
                }
            } else {
                if (!landingFlightList.isEmpty()) {
                    landingFlightList.remove(landingFlightList.size() - 1);
                    showAlert(Alert.AlertType.INFORMATION, "Success", "Last landing flight added is removed!");
                }
            }
            displayQueuesButton.fire();
        });


        displayQueuesButton.setOnAction(e -> {
            lV1.getItems().clear();
            lV2.getItems().clear();


        // Display departing flights with "Remove" button
            for (String flight : departingFlightList) {
            HBox row = new HBox(10);
            Label flightLabel = new Label(flight);
            Button removeButtonInQueue = new Button("Remove");

            removeButtonInQueue.setOnAction(event -> {
                Alert removingAlert = new Alert(Alert.AlertType.CONFIRMATION);
                removingAlert.setTitle("Remove Flight");
                removingAlert.setHeaderText(null);
                removingAlert.setContentText("Are you sure you want to remove this flight?");
                removingAlert.showAndWait().ifPresent(response -> {
                    if (response == ButtonType.OK) {
                        departingFlightList.remove(flight);
                        displayQueuesButton.fire();
                    }
                });
                });

            row.getChildren().addAll(flightLabel, removeButtonInQueue);
            lV1.getItems().add(row);
            }



            for (String flight : landingFlightList) {
                HBox row = new HBox(10); // Create a horizontal layout for each row
                Label flightLabel = new Label(flight); // Create a label for the flight details
                Button removeButtonInQueue = new Button("Remove"); // Create the "Remove" button

                // Add event handler to remove the flight when the button is clicked
                removeButtonInQueue.setOnAction(event -> {
                    Alert removingAlert = new Alert(Alert.AlertType.CONFIRMATION);
                    removingAlert.setTitle("Remove Flight");
                    removingAlert.setHeaderText(null);
                    removingAlert.setContentText("Are you sure you want to remove this flight?");
                    removingAlert.showAndWait().ifPresent(response -> {
                        if (response == ButtonType.OK) {
                            landingFlightList.remove(flight);
                            displayQueuesButton.fire();
                        }
                    });
                });

                    // Add the label and button to the row
                row.getChildren().addAll(flightLabel, removeButtonInQueue);
                    // Add the row to the ListView for landing flights
                    lV2.getItems().add(row);
                }
            });
        }

    private void openAddFlight(ListView<HBox> departingFlights, ListView<HBox> landingFlights) {
        Stage addFlight = new Stage();
        addFlight.initModality(Modality.APPLICATION_MODAL);
        addFlight.setTitle("Add Flight");
        GridPane gridPane = new GridPane();
        gridPane.setVgap(10);
        gridPane.setHgap(10);
        gridPane.setPadding(new Insets(20));
        Label flightNumberLabel = new Label("Flight Number:");
        TextField flightNumberField = new TextField();
        Label airplaneMakeLabel = new Label("Airplane Make:");
        TextField airplaneMakeField = new TextField();
        Label typeLabel = new Label("Type:");
        Button cargoButton = new Button("Cargo");
        Button privateButton = new Button("Private");
        Button commercialButton = new Button("Commercial");
        cargoButton.setStyle("-fx-background-color: #FF5722; -fx-text-fill: white;");
        privateButton.setStyle("-fx-background-color: #3F51B5; -fx-text-fill: white;");
        commercialButton.setStyle("-fx-background-color: #009688; -fx-text-fill: white;");
        Label departureTimeLabel = new Label("Departure Time:");
        TextField departureTimeField = new TextField();
        Label landingTimeLabel = new Label("Landing Time:");
        TextField landingTimeField = new TextField();
        Label flightDurationLabel = new Label("Flight Duration:");
        TextField flightDurationField = new TextField();
        Label additionalFieldLabel = new Label();
        TextField additionalField = new TextField();
        cargoButton.setOnAction(e -> additionalFieldLabel.setText("Cargo Weight:"));
        privateButton.setOnAction(e -> additionalFieldLabel.setText("Owner''s Name:"));
        commercialButton.setOnAction(e -> additionalFieldLabel.setText("Passenger Count:"));
        gridPane.add(flightNumberLabel, 0, 0);
        gridPane.add(flightNumberField, 1, 0);
        gridPane.add(airplaneMakeLabel, 0, 1);
        gridPane.add(airplaneMakeField, 1, 1);
        gridPane.add(typeLabel, 0, 2);
        HBox typeButtonsPane = new HBox(10, cargoButton, privateButton, commercialButton);
        gridPane.add(typeButtonsPane, 1, 2);
        gridPane.add(departureTimeLabel, 0, 3);
        gridPane.add(departureTimeField, 1, 3);
        gridPane.add(landingTimeLabel, 0, 4);
        gridPane.add(landingTimeField, 1, 4);
        gridPane.add(flightDurationLabel, 0, 5);
        gridPane.add(flightDurationField, 1, 5);
        gridPane.add(additionalFieldLabel, 0, 6);
        gridPane.add(additionalField, 1, 6);
        Button addFlightButton = new Button("Add Flight");
        gridPane.add(addFlightButton, 1, 7);
        addFlightButton.setOnAction(e -> {
            try {
                // Validate that the flight number is an integer
                Integer.parseInt(flightNumberField.getText());

                // Validate that the departure and landing times follow the format HH:mm
                DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
                LocalTime.parse(departureTimeField.getText(), timeFormatter);
                LocalTime.parse(landingTimeField.getText(), timeFormatter);

                // Build the flight details
                String flightDetails = "Flight: " + flightNumberField.getText() + ", " + airplaneMakeField.getText();
                if (additionalFieldLabel.getText().equals("Cargo Weight:")) {
                    flightDetails += " - Cargo Weight: " + additionalField.getText();
                } else if (additionalFieldLabel.getText().equals("Owner''s Name:")) {
                    flightDetails += " - Owner''s Name: " + additionalField.getText();
                } else if (additionalFieldLabel.getText().equals("Passenger Count:")) {
                    flightDetails += " - Passenger Count: " + additionalField.getText();
                }

                RadioButton selectedButton = (RadioButton) flightType.getSelectedToggle();
                if (selectedButton != null && selectedButton.getText().equals("Departing")) {
                    departingFlightList.add(flightDetails);
                } else {
                    landingFlightList.add(flightDetails);
                }

                addFlight.close();
                showAlert(Alert.AlertType.INFORMATION, "Success", "Flight added successfully!");
            } catch (NumberFormatException ex) {
                // Show an error alert if the flight number is not an integer
                showAlert(Alert.AlertType.ERROR, "Invalid Input", "Flight Number must be a valid integer.");
            } catch (java.time.format.DateTimeParseException ex) {
                // Show an error alert if the departure or landing time is not in HH:mm format
                showAlert(Alert.AlertType.ERROR, "Invalid Time Format", "Departure and Arrival times must follow the format HH:mm (e.g., 14:30).");
            }
        });
        Scene scene = new Scene(gridPane, 400, 400);
        addFlight.setScene(scene);
        addFlight.show();
}
    private Button createStyledButton(String text, String color) {
        Button button = new Button(text);
        button.setStyle("-fx-background-color: " + color + "; -fx-text-fill: white; -fx-font-weight: bold;");
        button.setPrefWidth(200);
        button.setPadding(new Insets(10));
        return button;
}

    private void handleLoadFlights() {
        if (loadFlightData(FILE_PATH)) {
            displayFlightData(false);
            showAlert(Alert.AlertType.INFORMATION, "Success", "Flight data loaded successfully from: " + FILE_PATH);
        }
        else {
            showAlert(Alert.AlertType.ERROR, "Error", "Failed to load flight data. Please ensure the file exists at: " + FILE_PATH);
        }
    }
    private boolean loadFlightData(String filePath) {
        allFlights.clear();
        onTimeFlights.clear();
        lateFlights.clear();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] flightDetails = line.split(",");
                allFlights.add(flightDetails);
                String status = flightDetails[flightDetails.length - 1].trim();
                if ("ontime".equalsIgnoreCase(status)) {
                    onTimeFlights.add(flightDetails);
                } else if ("late".equalsIgnoreCase(status)) {
                    lateFlights.add(flightDetails);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
    private void handleRequeueLateDepartures() {
        if (!allFlights.isEmpty()) {
            for (String[] flight : lateFlights) {
                flight[3] = addTenMinutes(flight[3]);
                flight[4] = addTenMinutes(flight[4]);
            }
            displayFlightData(true);
            showAlert(Alert.AlertType.INFORMATION, "Requeue Complete", "Late departures have been requeued.");
        } else {
            showAlert(Alert.AlertType.WARNING, "No Flights", "No flights are available to requeue.");
        }
    }
    private String addTenMinutes(String time) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        LocalTime localTime = LocalTime.parse(time, formatter);
        return localTime.plusMinutes(10).format(formatter);
    }

    private void sorting() {
        Stage sortStage = new Stage();
        sortStage.initModality(Modality.APPLICATION_MODAL);
        sortStage.setTitle("Sort Flights");
        VBox sortBox = new VBox(10);
        sortBox.setPadding(new Insets(20));
        Button sortDepartureTime = new Button("Sort by Departure Time");
        Button sortLandingTime = new Button("Sort by Landing Time");
        Button sortFlightNumber = new Button("Sort by Flight Number");
        Button sortFlightDuration = new Button("Sort by Flight Duration");
        sortBox.getChildren().addAll(sortDepartureTime, sortFlightNumber, sortLandingTime, sortFlightDuration);
        sortDepartureTime.setOnAction(e -> handleSortByDepartureTime());
        sortFlightNumber.setOnAction(e -> handleSortByFlightNumber());
        sortLandingTime.setOnAction(e -> handleSortByLandingTime());
        sortFlightDuration.setOnAction(e -> handleSortByFlightDuration());
        Scene scene = new Scene(sortBox, 300, 200);
        sortStage.setScene(scene);
        sortStage.show();
    }

    private void handleSortByDepartureTime() {
        // Sorting all flights based on the departure time
        allFlights.sort((flight1, flight2) -> flight1[3].compareTo(flight2[3]));
        
        // Sorting the departing flight list
        departingFlightList.sort((flight1, flight2) -> {
            String time1 = flight1.split(",")[3]; // Extract departure time
            String time2 = flight2.split(",")[3]; // Extract departure time
            return time1.compareTo(time2); // Compare times
        });
    
        // Sorting the landing flight list (by landing time)
        landingFlightList.sort((flight1, flight2) -> {
            String time1 = flight1.split(",")[4]; // Extract landing time
            String time2 = flight2.split(",")[4]; // Extract landing time
            return time1.compareTo(time2); // Compare landing times
        });
    
     // Refresh the display
    }
    
    private void handleSortByFlightNumber() {
        allFlights.sort((flight1, flight2) -> {
            int number1 = extractFlightNumber(flight1[0]);
            int number2 = extractFlightNumber(flight2[0]);
            return number1 - number2;
        });
        displayFlightData(false);
    }

    private int extractFlightNumber(String flightNumber) {
        String numericPart = flightNumber.replaceAll("[^0-9]", "");
        return Integer.parseInt(numericPart);
    }

    private void handleSortByLandingTime() {
        allFlights.sort((flight1, flight2) -> {
            String time1 = flight1[4];
            String time2 = flight2[4];
            return time1.compareTo(time2);
        });
        displayFlightData(false);
    }

    private void handleSortByFlightDuration() {
        allFlights.sort((flight1, flight2) -> {

            int duration1 = parseDuration(flight1[5]);
            int duration2 = parseDuration(flight2[5]);
            return duration1 - duration2;
        });
        displayFlightData(false);
    }

    private int parseDuration(String duration) {
        int totalMinutes = 0;

        if (duration.contains("h")) {
            int hours = Integer.parseInt(duration.substring(0, duration.indexOf("h")).trim());
            totalMinutes += hours * 60; }

        if (duration.contains("m")) {
            int minutes = Integer.parseInt(duration.substring(duration.indexOf("h") + 1, duration.indexOf("m")).trim());
            totalMinutes += minutes;
        }

        return totalMinutes;
    }

    private void displayFlightData(boolean requeued) {
        flightListView.getItems().clear();
        List<String[]> flightsToDisplay;
        if (requeued) {
            flightsToDisplay = getRequeuedOrder();
        } else {
            flightsToDisplay = allFlights;
        }
        for (String[] flight : flightsToDisplay) {
            Label flightLabel = new Label(String.join(", ", flight));
            if (requeued && "late".equalsIgnoreCase(flight[flight.length - 1])) {
                flightLabel.setTextFill(Color.RED);
            } else {
                flightLabel.setTextFill(Color.DARKGREEN);
            }
            flightListView.getItems().add(flightLabel);
        }
    }
    private List<String[]> getRequeuedOrder() {
        List<String[]> reorderedFlights = new ArrayList<>(onTimeFlights);
        reorderedFlights.addAll(lateFlights);
        return reorderedFlights;
    }
    private void showAlert(Alert.AlertType alertType, String title, String message) {
        Alert alert = new Alert(alertType);
        alert.setTitle(title);
        alert.setContentText(message);
        alert.setHeaderText(null);
        alert.showAndWait();
    }
    public static void main(String[] args) {
        launch(args);
}
}

', '["java", "sorting", "queue", "project"]', '2024-11-17 22:18:28', '2024-11-17 22:18:28', 37, -4, 0, 0, 28340814, null),
        (79197396, 'Tomcat - Oracle JNDI connection - how application can run without ojdbc jar in $CATALINA_HOME/lib', 'I am setting up a legacy Web application and having a few questions. Currently the web application packed ojdbc jar under WEB-INF/lib and Tomcat context.xml has a resource tag referring to JNDI datasoure. It''s Oracle database so the connection string is through oci (I am using Windows system)
<Resource name="jdbc/MainSource" 
      auth="Container" type="javax.sql.DataSource" 
      driverClassName="oracle.jdbc.driver.OracleDriver" 
      url="jdbc:oracle:oci:@username/password@tnsinstance" 
      validationQuery="SELECT sysdate from DUAL;"
      jdbcInterceptors="ConectionState" />

From what I can see, the Tomcat server don''t have any ojdbc.jar under $CATALINA_HOME/lib directory. Then here are my questions

How could the application run on JNDI if ojdbc is only available under WEB-INF/lib?
Does OCI exempt the JNDI from providing the ojdbc jar (my understanding, it should not because Tomcat still look for implementation of driverClassName)?

Updated: A little further details to question2 - there is Oracle client installed on the server and within the installation there is ojdbc jar file, which should be in $PATH after ORACLE_HOME being registered. However I still don''t think Tomcat server will reach out to OS $PATH to get ojdbc jar even if it is an Oracle OCI connection, according to Tomcat JNDI doc
', '["java", "oracle-database", "tomcat", "jndi", "ojdbc"]', '2024-11-17 22:25:53', '2024-11-17 23:49:17', 34, -1, 2, 0, 1233359, null),
        (79197432, 'How to read indexed properties with Apache Commons Configuration', 'The Apache Commons Configuration Java library can easily read repeated properties as lists and/or arrays.
How can I read indexed properties?
Repeated properties
Sample code from the Commons Configuration user guide.
usergui.properties file:
colors.pie = #FF0000
colors.pie = #00FF00
colors.pie = #0000FF

Java code:
Configurations configs = new Configurations();
PropertiesConfiguration config = configs.properties("usergui.properties");

List<String> list = config.getList(String.class, "colors.pie"));
String[] array = config.getStringArray("colors.pie")));

The list and array variables will both contain [#FF0000, #00FF00, #0000FF].
Indexed properties
usergui.properties file:
colors.pie.0 = #FF0000
colors.pie.1 = #00FF00
colors.pie.2 = #0000FF

Is there a way I can use Commons Configuration to read these properties as a list and/or an array?
', '["java", "properties-file", "apache-commons-config"]', '2024-11-17 22:48:28', '2024-11-17 22:48:28', 16, 0, 0, 0, 238421, null),
        (79197465, 'Draw rotated ninepatches with LibGDX and Box2d', 'I''m using Android Studio with Java and LibGDX.
I need to draw the rotated ninepatches correctly, based on their position in the Box2d world.
The Spritebatch.draw method does not handle ninepatches so I have to use NinePatch.draw method.
Box2d uses the center as the origin to apply body rotation.
The problem is that NinePatch.draw rotates the object around the body''s lower left corner instead of around the center (as SpriteBatch.draw does), resulting in an incorrect drawing position. This difference also produces an incorrect rotation for bodies with a RevoluteJoint and a motor.
Note that I place the bricks in the world considering their center as the origin, so in the draw method I''ll do body.getPosition().x - widthInWorld / 2.
game.getBatch() returns a SpriteBatch set with setProjectionMatrix(viewport.getCamera().combined); and the viewport is set as new FitViewport(WORLD_WIDTH, WORLD_HEIGHT);
The brick has a ninepatch png of 130w x 34h pixels (so 128x32 without the patch borders) and its world size is 4 x 1 (as you can see in the screenshots).
These are the rotation angles of the bricks:

Actual working solution
I found this working solution but it causes Android Studio to warn "Possible flush inside a loop" (well said because batch.setTransformMatrix does a flush internally. More info in this SO question).
Matrix4 tempMatrix = new Matrix4();
Matrix4 originalMatrix = new Matrix4();

DelayedRemovalArray<Brick> bricks = ...;

bricks.begin();
for(Brick brick : bricks) {
    brick.draw(game.getBatch());
}
bricks.end();

Brick.draw method:
NinePatchDrawable ninePatchDrawable = ...;

public void draw(SpriteBatch batch) {
    originalMatrix.set(batch.getTransformMatrix());

    tempMatrix.set(originalMatrix);
    
    tempMatrix
        .translate(widthInWorld/2, heightInWorld/2, 0)
        .rotate(0, 0, angle, 10)
        .translate(-widthInWorld/2, -heightInWorld/2, 0);
    batch.setTransformMatrix(tempMatrix);

    ninePatchDrawable.draw(
        batch,
        0,
        0,
        0,
        0,
        widthInWorld,
        heightInWorld,
        1f,
        1f,
        0
    );

    batch.setTransformMatrix(originalMatrix); 
}


Without Matrix4

public void draw(SpriteBatch batch) {
    ninePatchDrawable.draw(
        batch,
        body.getPosition().x - widthInWorld / 2,
        body.getPosition().y - heightInWorld / 2,
        0,
        0,
        widthInWorld,
        heightInWorld,
        1,
        1,
        body.getAngle()  * MathUtils.radiansToDegrees
    );
}



Since batch flush affects performance, is there a better way to achieve this?
Ps. I''ve already searched and read other SO''s answers and web regarding similar issues but haven''t found any better solution.
Thanks a lot
', '["java", "libgdx"]', '2024-11-17 23:05:04', '2024-11-18 02:54:19', 27, 2, 1, 0, 2342558, null),
        (79197562, 'Java deployment problem for my project ,I developed correctly all things in local but when it comes live it totally', 'I had an react.js and java+sql for my project.I have hostringer hosting space too but how to deploy this in realtime by using hostringer.
I deployed a react build files successful. but I had no idea it.Its important for my project.
', '["java", "reactjs", "hosting", "web-hosting"]', '2024-11-17 23:54:48', '2024-11-17 23:54:48', 15, -2, 0, 0, 16751317, null),
        (79197577, 'Customizing external endpoints Springdoc', 'I have specified external APIs in application.yml:
springdoc:
  swagger-ui:
    urls:
      - name: Service1
        url: ${SERVICE1_URL}/v3/api-docs
      - name: Service2
        url: ${SERVICE2_URL}/v3/api-docs
      - name: Service3
        url: ${SERVICE3_URL}/v3/api-docs

I need to add prefixes to the endpoints of these services. I tried to do this through OpenApiCustomizer:
    @Bean
    public OpenApiCustomizer addPrefixToPaths() {
        return openApi -> {
            Paths paths = openApi.getPaths();
            Paths newPaths = new Paths();
            paths.forEach((path, pathItem) -> {
                String newPath = "/ms" + path;
                newPaths.addPathItem(newPath, pathItem);
            });
            openApi.setPaths(newPaths);
        };
    }

but it doesn''t work. Is it possible to customize external endpoints from the code somehow?
', '["java", "spring", "springdoc"]', '2024-11-17 23:59:55', '2024-11-18 01:05:08', 28, 0, 0, 0, 17718607, null),
        (79197596, 'Write data column wise apache poi', 'I am struggling a lot and I am not sure how to solve the problem. My issue is that I am iterating lots of files from a folder. For each file, I am putting data in column specific list. What I want is below output in the Excel using Apache POI but I am able to do it when printing by row but not by column. Can someone help ? Basically I want the fileName to be printed for every corresponding list associated to it.
Output:
FileName,ObjectData,FieldData,AppData
Foo,"Obj1","F1","App1"
Foo,"Obj2","","App2"
Foo,"","","App3"
Foo,"","","App4"
Foo,"","","App5"
Test,"","F1","App1"
Test,"","F2",""
Test,"","F3",""
Test,"","F4",""

package cruft;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class Main {
    private static String outPath = "path";

    public static void main(String[] args) throws Exception{
        SXSSFWorkbook wb = new SXSSFWorkbook();
        Sheet sheet = wb.createSheet("Analysis.xlsx");
        List<String> fileList = Arrays.asList("Foo","Test");
        List<String> fooObjectData = Arrays.asList("Obj1","Obj2");
        List<String> fooFieldData = Arrays.asList("F1");
        List<String> fooAppData = Arrays.asList("App1","App2","App3","App4","App5");
        
        List<String> testObjectData = Arrays.asList("");
        List<String> testFieldData = Arrays.asList("F1","F2","F3","F4","F5");
        List<String> testAppData = Arrays.asList("App1");
        for(String fileName: fileList) {
            Row row = sheet.createRow(0);
            for (int i = 0; i < 3; i++) {
                Cell cell = row.createCell(i);
                if(fileName.equals("Foo")) {
                    for(String s : fooObjectData) {
                        cell.setCellValue(s);
                    }
                    for(String s : fooFieldData) {
                        cell.setCellValue(s);
                    }
                    for(String s : fooAppData) {
                        cell.setCellValue(s);
                    }
                }
                else {
                    for(String s : testObjectData) {
                        cell.setCellValue(s);
                    }
                    for(String s : testFieldData) {
                        cell.setCellValue(s);
                    }
                    for(String s : testAppData) {
                        cell.setCellValue(s);
                    }
                }

            }
        }
        writeToFile(wb);
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

When i run the above, it only prints
App1 App1 App1
I tried running the above command but get below output
App1 App1 App1
', '["java", "apache", "java-8", "apache-poi"]', '2024-11-18 00:08:49', '2024-11-18 00:34:52', 61, -7, 1, 0, 25184778, 79197645),
        (79197684, 'Instead of updating, a new post is being created', 'I''m working on a small CRUD site, and I ran into a problem: when trying to update an existing post, a new one gets created instead of modifying the existing one.
The ID is being passed correctly, I’ve checked that.
@PostMapping("/edit/{id}")
    public String blogPostEdit(@PathVariable(value = "id") long id,@RequestParam String title, @RequestParam String summary, @RequestParam String fullText, /*@AuthenticationPrincipal MyAppUser currentUser,*/ Model model){
        Blog blog = blogRepository.findById(id).orElseThrow();
        blog.setTitle(title);
        blog.setSummary(summary);
        blog.setFullText(fullText);
        blogRepository.save(blog);
        return "redirect:/home";
    }

Here is the Blog class. If you need any additional code, let me know and I''ll send it.
@Entity
public class Blog {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String title;
    private String summary;
    private String fullText;
    private String author;
    private int views;

    public Blog() {
    }

    public Blog(String title, String summary, String fullText, String author) {
        this.title = title;
        this.summary = summary;
        this.fullText = fullText;
        this.author = author;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getFullText() {
        return fullText;
    }

    public void setFullText(String fullText) {
        this.fullText = fullText;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }
}

', '["java", "sql", "spring", "spring-boot", "crud"]', '2024-11-18 00:52:37', '2024-11-18 01:15:37', 52, 1, 1, 0, 23220147, null),
        (79197722, 'Correct and standard way of putting application.properties files in a Springboot multi-module project and deploying as a JAR file', 'I am trying to find the correct and standard way of putting application.properties Files in a Springboot multi-module project and deploying as
as JAR file
I have a Springboot project with two modules- library and application. Library contains only a utility service which needs to be consumed by application(main) module. In the library module I have put application.properties files which contains a key- values pairs:
service.message.test=Hello from Library Module

I am using this property in one of the service class file in library module using the below code:
 @Service
@EnableConfigurationProperties(ServiceProperties.class)


public class MyService {

    @Value("${service.message.test}")
    private String libMessage;



    private final ServiceProperties serviceProperties;

    public MyService(ServiceProperties serviceProperties) {
        this.serviceProperties = serviceProperties;
    }

    public String message() {
        return this.serviceProperties.getMessage()+libMessage; };
    }

Also, i have a application module(main) which also has a application.properties files in the src/main/resources folder.This file contains
other key-value pairs for application
service.message=Hello, World

Now i am using the mvn clean package command to package  the app in a JAR file. But on running the command, i am getting the error as :
Caused by: java.lang.IllegalArgumentException: Could not resolve placeholder ''service.message.test'' in value "${service.message.test}"

Now, I have the following questions:

If we are creating SpribgBoot mullti-module project,can''t we keep application.properties in each module but rather should always use
@ConfigurationProperties("service") only?

I need to pass several properties to various classes in the library module .I am doing this by passing it from properties files at module level using @Value("${xxxx}”) annotation .Since, its giving error, is this not allowed?

Is application.properties file only allowed in application(main) module and not in the dependent individual modules?

What is the standard way of managing properties files in Springboot multi-module project ?



', '["java", "spring", "spring-boot"]', '2024-11-18 01:10:41', '2024-11-18 10:25:01', 25, 0, 1, 0, 9563278, null),
        (79197788, 'How can I create a countdown timer using different types of loops (for, while, do-while) in Java?', 'I am working on a Java program where I need to create a countdown timer that counts down from a user-defined number to 1. The challenge is to use different types of loops (for, while, do-while) to implement the countdown and compare their behavior.
Requirements:
1.Implement the countdown timer using a for loop.
2.Implement the countdown timer using a while loop.
3.Implement the countdown timer using a do-while loop.
Here’s what I have so far for each loop type:
// Countdown using for loop
for (int i = 10; i >= 1; i--) {
    System.out.println(i);
}

// Countdown using while loop
int i = 10;
while (i >= 1) {
    System.out.println(i);
    i--;
}

// Countdown using do-while loop
int i = 10;
do {
    System.out.println(i);
    i--;
} while (i >= 1);



Questions:
•What are the key differences in the behavior of each loop type in this scenario?
•Which loop would be more suitable for situations where the countdown starts at a variable number and how would that affect efficiency?
•Are there any edge cases or performance considerations I should keep in mind when using these loops for this kind of task?
', '["java", "loops"]', '2024-11-18 01:41:51', '2024-11-18 01:41:51', 33, -1, 0, 0, 28062752, null),
        (79197801, 'How can I use a while loop to print only even numbers in Java?', 'I am a beginner in Java and currently learning about loops. I want to use a while loop to print only the even numbers from 1 to 10. I wrote the following code, but it prints all the numbers instead of only the even ones. How can I fix it?
package h1 ;
public class EvenNumbers {
    public static void main(String[] args) {
        int i = 1;
        while (i <= 10) {
            System.out.println(i);
            i++;
        }
    }
}


What changes should I make to this code to print only the even numbers?
', '["java", "loops", "while-loop"]', '2024-11-18 01:47:59', '2024-11-18 01:47:59', 33, -5, 0, 0, 28006081, null),
        (79197819, 'Derby DB in Spring Application. Error creating bean with name &#39;jdbcConverter&#39; in springframework. Unsatisfied dependency', 'Dialect seems to be specified in application.properties, derby dependency is still in pom.xml:
JAVA file
package com.josueborges.recupera_precos_passagem;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class RecuperaPrecosPassagemApplication {

public static void main(String[] args) {
   SpringApplication.run(RecuperaPrecosPassagemApplication.class, args);
}
}

application.properties
 spring.application.name=recupera-precos-passagem
server.port=8080

# Configuração do Derby

spring.datasource.url=jdbc:derby:./target/recupera-precos-passagem;create=true
spring.datasource.driverClassName=org.apache.derby.jdbc.EmbeddedDriver
spring.datasource.username=app_user
spring.datasource.password=app_password

  # Definindo o dialect do Hibernate para o Derby
spring.jpa.database-platform=org.hibernate.dialect.DerbyTenSevenDialect

  # Inicialização do banco de dados
spring.datasource.initialization-mode=always

   # Log detalhado para o Hibernate e Derby
logging.level.org.springframework.jdbc=DEBUG
logging.level.org.apache.derby=DEBUG

pom.xml:
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.3.5</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.josueborges</groupId>
    <artifactId>recupera-precos-passagem</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>recupera-precos-passagem</name>
    <description>Recuperação de Preços Passagens No Google</description>
    <url/>
    <licenses>
        <license/>
    </licenses>
    <developers>
        <developer/>
    </developers>
    <scm>
        <connection/>
        <developerConnection/>
        <tag/>
        <url/>
    </scm>

    <properties>
        <java.version>17</java.version>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding> <!-- Definindo a codificação -->
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding> <!-- Codificação para relatórios -->
    </properties>

    <dependencies>
            <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jdbc</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-jdbc</artifactId>
        </dependency>
       <dependency>
            <groupId>org.apache.derby</groupId>
            <artifactId>derby</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.data</groupId>
            <artifactId>spring-data-jdbc</artifactId>
        </dependency>
        <dependency>
            <groupId>org.apache.derby</groupId>
            <artifactId>derbytools</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>com.toedter</groupId>
            <artifactId>jcalendar</artifactId>
            <version>1.4</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <excludes>
                        <exclude>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </exclude>
                    </excludes>
                </configuration>
            </plugin>

            <!-- Adicionando a configuração para o maven-resources-plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-resources-plugin</artifactId>
                <configuration>
                    <encoding>UTF-8</encoding> <!-- Garantindo que a codificação seja UTF-8 -->
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>

Error:
org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name ''jdbcConverter'' defined in class path resource [org/springframework/boot/autoconfigure/data/jdbc/JdbcRepositoriesAutoConfiguration$SpringBootJdbcConfiguration.class]: Unsatisfied dependency expressed through method ''jdbcConverter'' parameter 4: Error creating bean with name ''jdbcDialect'' defined in class path resource [org/springframework/boot/autoconfigure/data/jdbc/JdbcRepositoriesAutoConfiguration$SpringBootJdbcConfiguration.class]: Failed to instantiate [org.springframework.data.relational.core.dialect.Dialect]: Factory method ''jdbcDialect'' threw exception with message: Cannot determine a dialect for org.springframework.jdbc.core.JdbcTemplate@2db86a7c; Please provide a Dialect
    at org.springframework.beans.factory.support.ConstructorResolver.createArgumentArray(ConstructorResolver.java:795) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.ConstructorResolver.instantiateUsingFactoryMethod(ConstructorResolver.java:542) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.instantiateUsingFactoryMethod(AbstractAutowireCapableBeanFactory.java:1355) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1185) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:562) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:522) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:337) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:335) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:200) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.DefaultListableBeanFactory.preInstantiateSingletons(DefaultListableBeanFactory.java:975) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.context.support.AbstractApplicationContext.finishBeanFactoryInitialization(AbstractApplicationContext.java:971) ~[spring-context-6.1.14.jar:6.1.14]
    at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:625) ~[spring-context-6.1.14.jar:6.1.14]
    at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.refresh(ServletWebServerApplicationContext.java:146) ~[spring-boot-3.3.5.jar:3.3.5]
    at org.springframework.boot.SpringApplication.refresh(SpringApplication.java:754) ~[spring-boot-3.3.5.jar:3.3.5]
    at org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:456) ~[spring-boot-3.3.5.jar:3.3.5]
    at org.springframework.boot.SpringApplication.run(SpringApplication.java:335) ~[spring-boot-3.3.5.jar:3.3.5]
    at org.springframework.boot.SpringApplication.run(SpringApplication.java:1363) ~[spring-boot-3.3.5.jar:3.3.5]
    at org.springframework.boot.SpringApplication.run(SpringApplication.java:1352) ~[spring-boot-3.3.5.jar:3.3.5]
    at com.josueborges.recupera_precos_passagem.RecuperaPrecosPassagemApplication.main(RecuperaPrecosPassagemApplication.java:13) ~[classes/:na]
Caused by: org.springframework.beans.factory.BeanCreationException: Error creating bean with name ''jdbcDialect'' defined in class path resource [org/springframework/boot/autoconfigure/data/jdbc/JdbcRepositoriesAutoConfiguration$SpringBootJdbcConfiguration.class]: Failed to instantiate [org.springframework.data.relational.core.dialect.Dialect]: Factory method ''jdbcDialect'' threw exception with message: Cannot determine a dialect for org.springframework.jdbc.core.JdbcTemplate@2db86a7c; Please provide a Dialect
    at org.springframework.beans.factory.support.ConstructorResolver.instantiate(ConstructorResolver.java:648) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.ConstructorResolver.instantiateUsingFactoryMethod(ConstructorResolver.java:636) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.instantiateUsingFactoryMethod(AbstractAutowireCapableBeanFactory.java:1355) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBeanInstance(AbstractAutowireCapableBeanFactory.java:1185) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:562) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:522) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:337) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:335) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:200) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.config.DependencyDescriptor.resolveCandidate(DependencyDescriptor.java:254) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.DefaultListableBeanFactory.doResolveDependency(DefaultListableBeanFactory.java:1443) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.DefaultListableBeanFactory.resolveDependency(DefaultListableBeanFactory.java:1353) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.ConstructorResolver.resolveAutowiredArgument(ConstructorResolver.java:904) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.ConstructorResolver.createArgumentArray(ConstructorResolver.java:782) ~[spring-beans-6.1.14.jar:6.1.14]
    ... 19 common frames omitted
Caused by: org.springframework.beans.BeanInstantiationException: Failed to instantiate [org.springframework.data.relational.core.dialect.Dialect]: Factory method ''jdbcDialect'' threw exception with message: Cannot determine a dialect for org.springframework.jdbc.core.JdbcTemplate@2db86a7c; Please provide a Dialect
    at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:178) ~[spring-beans-6.1.14.jar:6.1.14]
    at org.springframework.beans.factory.support.ConstructorResolver.instantiate(ConstructorResolver.java:644) ~[spring-beans-6.1.14.jar:6.1.14]
    ... 33 common frames omitted
Caused by: org.springframework.data.jdbc.repository.config.DialectResolver$NoDialectException: Cannot determine a dialect for org.springframework.jdbc.core.JdbcTemplate@2db86a7c; Please provide a Dialect
    at org.springframework.data.jdbc.repository.config.DialectResolver.lambda$getDialect$2(DialectResolver.java:82) ~[spring-data-jdbc-3.3.5.jar:3.3.5]
    at java.base/java.util.Optional.orElseThrow(Optional.java:403) ~[na:na]
    at org.springframework.data.jdbc.repository.config.DialectResolver.getDialect(DialectResolver.java:81) ~[spring-data-jdbc-3.3.5.jar:3.3.5]
    at org.springframework.data.jdbc.repository.config.AbstractJdbcConfiguration.jdbcDialect(AbstractJdbcConfiguration.java:227) ~[spring-data-jdbc-3.3.5.jar:3.3.5]
    at org.springframework.boot.autoconfigure.data.jdbc.JdbcRepositoriesAutoConfiguration$SpringBootJdbcConfiguration.jdbcDialect(JdbcRepositoriesAutoConfiguration.java:151) ~[spring-boot-autoconfigure-3.3.5.jar:3.3.5]
    at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103) ~[na:na]
    at java.base/java.lang.reflect.Method.invoke(Method.java:580) ~[na:na]
    at org.springframework.beans.factory.support.SimpleInstantiationStrategy.instantiate(SimpleInstantiationStrategy.java:146) ~[spring-beans-6.1.14.jar:6.1.14]
    ... 34 common frames omitted*

', '["java", "spring", "spring-data-jpa", "spring-data", "derby"]', '2024-11-18 01:57:51', '2024-11-18 02:12:19', 13, 0, 1, 0, 1646928, null),
        (79197945, 'VarHandle for arrays of dynamic size', 'How can a VarHandle instance be created to access elements of a dynamically sized array (in the context of the Foreign Function and Memory API)?
package org.example;

import java.lang.foreign.*;
import java.lang.invoke.VarHandle;

public class ArrayVarHandle {

    static final StructLayout coordinateLayout = MemoryLayout.structLayout(
            ValueLayout.JAVA_INT.withName("x"),
            ValueLayout.JAVA_INT.withName("y")
    );

    static final SequenceLayout arrayLayout = MemoryLayout.sequenceLayout(1, coordinateLayout);

    static final VarHandle xInArrayVarHandle = arrayLayout.varHandle(
            MemoryLayout.PathElement.sequenceElement(),
            MemoryLayout.PathElement.groupElement("x")
    );

    public static void main(String[] args) {
        try (var arena = Arena.ofConfined()) {
            int count = 10;
            var array = arena.allocate(coordinateLayout, count);
            setXValues(array, count);
        }
    }

    static void setXValues(MemorySegment array, int count) {
        for (int i = 0; i < count; i++)
            xInArrayVarHandle.set(array, 0, i, 100);
    }
}

This code fails with the exception:
Exception in thread "main" java.lang.IndexOutOfBoundsException: Index 1 out of bounds for length 1
    at org.example.ArrayVarHandle.setValues(ArrayVarHandle.java:30)
    at org.example.ArrayVarHandle.main(ArrayVarHandle.java:24)

Obviously, it checks the boundaries of the layout arrayLayout. It is declared with elementCount = 1 (first parameter).
If it is instead declared with elementCount = 999999, the error changes:
Exception in thread "main" java.lang.IndexOutOfBoundsException: Out of bound access on segment MemorySegment{ address: 0x6000014b8140, byteSize: 80 }; new offset = 0; new length = 7999992
    at org.example.ArrayVarHandle.setValues(ArrayVarHandle.java:30)
    at org.example.ArrayVarHandle.main(ArrayVarHandle.java:24)

So it checks the size of the layout against the size of the memory segment, and fails again.
Is it possible to create an array/sequence layout without a fixed size? Or create the VarHandle differently?
In the above example, count has a fixed value. But in the real application, the count is not known at compile-time. And the goal would be to create the VarHandle instance once, and not on every call of the method.
', '["java", "java-ffm", "varhandle"]', '2024-11-18 03:09:13', '2024-11-18 05:06:45', 30, 2, 1, 0, 413337, 79198165),
        (79197954, 'Maximum Loss Allowed with Profit Array as input such that cumulative remains strictly positive', 'You are analyzing the market trends and a model returned an array of integers, PnL (Profit and Loss), for your portfolio representing that in the ith month, you will either gain or lose PnL[i]. All reported PnL values are positive, representing gains.
As part of the analysis, you will perform the following operation on the PnL array any number of times:

Choose any month i (0 ≤ i < n) and multiply PnL[i] by -1

Find the maximum number of months you can afford to face a loss, i.e. have a negative PnL, such that the cumulative PnL for each of the n months remains strictly positive i.e. remains greater than 0.
Note: The cumulative PnL for the ith month is defined as the sum of PnL from the starting month up to the ith month. For example, given PnL = [3, 2, 5, 6, 1] the cumulative PnL to the ith position for the result PnL = [3, -2, 5, -6, 1] is [3, 1, 6, 0, 1].
Is there any optimised solution for this problem other than exponential complexity?
', '["java", "algorithm"]', '2024-11-18 03:14:50', '2024-11-18 16:24:14', 22, 0, 0, 0, 20021530, null),
        (79197970, 'How to prevent repeated error messages for consecutive invalid inputs in Java?', 'I am working on a Java program that requires user input validation. The program asks the user to enter a number greater than 10, and if the input is invalid (e.g., non-numeric or a number ≤ 10), it displays an error message. However, when the user repeatedly enters invalid inputs, the program prints the same error message every time, which feels redundant.
Here’s my current code:
import java.util.Scanner;

public class InputExample {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int number;

        System.out.println("Enter a number greater than 10:");

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
                System.out.println("Invalid input. Please try again.");
                scanner.next(); // Clear the invalid input
            }
        }

        scanner.close();
    }
}

Issue:
Whenever the user keeps entering invalid inputs, the error message (e.g., “Invalid input. Please try again.”) is printed repeatedly. I would like to modify this behavior so that the error message is displayed only once for consecutive invalid inputs.
Question:
How can I adjust my code to avoid redundant error messages for consecutive invalid inputs? Are there better approaches or patterns in Java to simplify input validation in this context?
', '["java", "console-application"]', '2024-11-18 03:24:08', '2024-11-18 08:46:04', 34, 1, 1, 0, 28062752, null),
        (79198029, 'Why the for loop ic Java code not working?', 'for (double i = 1; i <=10; i++) {
int product = number * i;
System.out.println(number + " * " + i + " = " + product);
}


for (double i = 1; i <=10; i++) {
int product = number * i;
System.out.println(number + " * " + i + " = " + product);
}

}
I want code print numbers from 1 to 10
I define for loop with double counter and it shows an error message,how can I solve this problem,and how to convert for loop to while
', '["java", "syntax"]', '2024-11-18 03:49:39', '2024-11-18 03:49:39', 54, -6, 0, 0, 28048085, null),
        (79198141, 'How to extract a json from a json array contained in another json using jackson?', 'Consider the following json example:
{
    "count": 74568,
    "next": "https://gutendex.com/books/?page=2",
    "previous": null,
    "results": [
        {
            "title": "Frankenstein; Or, The Modern Prometheus",
            "authors": [
                {
                    "name": "Shelley, Mary Wollstonecraft",
                    "birth_year": 1797,
                    "death_year": 1851
                }
            ],
            "languages": "en"
        },
        
            //....
        
        {
            "title": "Moby Dick; Or, The Whale",
            "authors": [
                {
                    "name": "Melville, Herman",
                    "birth_year": 1819,
                    "death_year": 1891
                }
            ]
            "languages": "en"
        }
    ]
}

How can I extract a book json from this jumble, using Jackson?
I don''t want to deserialize, nor get a specific json, but a json that contains an attribute passed as a parameter. I want to know if there would be a method like this:
m(fullJSON, "Moby Dick") -> String(json of book that contains "Moby Dick")
', '["java", "json", "jackson"]', '2024-11-18 04:49:30', '2024-11-18 08:12:35', 41, -3, 0, 0, 28347469, null),
        (79198151, 'InfluxDB Client java.lang.IllegalArgumentException: Can not get field of POJO after running tests the second time. Tests fail after hot reload', 'I''m using the InfluxDB Java Client to manage metrics in a Quarkus service.
For that I have created an extension that provides a dev container of InfluxDB 2.
When I start my tests everything works, but when I trigger the hot reload by saving any file the test, that should send the metric to the database fails.
Here is the test. The model is at the bottom:
package mypackage.models.measurements;

import static mypackage.config.InfluxDBConstants.DefaultConstants.BUCKET;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.Duration;
import java.time.Instant;
import java.util.concurrent.TimeUnit;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.TestInstance.Lifecycle;

import com.influxdb.annotations.Column;
import com.influxdb.annotations.Measurement;
import com.influxdb.client.InfluxDBClient;
import com.influxdb.client.InfluxDBClientFactory;
import com.influxdb.client.domain.WritePrecision;

import myextension.quarkus.devservices.influxdb.runtime.InfluxDBConfig;
import mypackage.config.InfluxDBConstants.JobMetricConstants.Fields;
import mypackage.config.InfluxDBConstants.JobMetricConstants.Tags;
import io.quarkus.test.junit.QuarkusTest;
import jakarta.inject.Inject;

/**
 * JobMetricTest
 */
@QuarkusTest
@TestInstance(Lifecycle.PER_CLASS)
public class JobMetricTest {

    @Inject
    InfluxDBConfig config;

    public InfluxDBClient getClient() {
        InfluxDBClient client = InfluxDBClientFactory.create(
                config.url(),
                config.token().toCharArray(),
                config.organization().get(),
                config.bucket().get());
        assertTrue(client.ping());
        return client;
    }

    @Test
    public void testInitialization() throws InterruptedException {
        Instant testTime = Instant.now();
        JobMetric metric = new JobMetric("testJob");
        assertTrue(metric.duration == -1);
        TimeUnit.MILLISECONDS.sleep(1);
        metric.finish();
        assertTrue(metric.duration > 0);
        assertTrue(metric.job.equals("testJob"));
        assertTrue(metric.start.getEpochSecond() >= testTime.getEpochSecond());
    }

    @Test
    public void testInfluxReflection() throws InterruptedException {
        InfluxDBClient client = getClient();
        Metric metric = new Metric();

        metric.job = "job";
        metric.hasError = false;
        metric.duration = Double.valueOf(-1);
        metric.start = Instant.now();
        Instant stop = Instant.now();
        Duration d  = Duration.between(metric.start, stop);
        metric.duration = (double) d.getSeconds();
        metric.duration += ((double) d.toMillisPart()) / 1000;
        client.getWriteApiBlocking()
            .writeMeasurement(          // Line 72: Fails here!
                BUCKET,
                config.organization().get(),
                WritePrecision.NS,
                metric
            );


        
    }
}

@Measurement(name = "metric")
class Metric {
    @Column(timestamp = true)
    public Instant start;

    @Column(tag = true, name = Tags.JOB)
    public String job;

    @Column(name = Fields.HAS_ERROR, tag = false)
    public Boolean hasError;

    @Column(name = Fields.DURATION, tag = false)
    public Double duration;


}

Here is the exception:
2024-11-17 21:42:17,616 ERROR [io.qua.test] (Test runner thread) ==================== TEST REPORT #2 ==================== [Error Occurred After Shutdown]
2024-11-17 21:42:17,616 ERROR [io.qua.test] (Test runner thread) Test JobMetricTest#testInfluxReflextion() failed 
 [Error Occurred After Shutdown]: java.lang.IllegalArgumentException: Can not get java.lang.Double field mypackage.models.measurements.Metric.duration on mypackage.models.measurements.Metric
    at java.base/jdk.internal.reflect.MethodHandleFieldAccessorImpl.newGetIllegalArgumentException(MethodHandleFieldAccessorImpl.java:86)
    at java.base/jdk.internal.reflect.MethodHandleObjectFieldAccessorImpl.get(MethodHandleObjectFieldAccessorImpl.java:61)
    at java.base/java.lang.reflect.Field.get(Field.java:444)
    at com.influxdb.client.internal.MeasurementMapper.getObject(MeasurementMapper.java:130)
    at com.influxdb.client.internal.MeasurementMapper.toPoint(MeasurementMapper.java:68)
    at com.influxdb.client.internal.AbstractWriteClient$BatchWriteDataMeasurement.toLineProtocol(AbstractWriteClient.java:386)
    at java.base/java.util.stream.ReferencePipeline$3$1.accept(ReferencePipeline.java:212)
    at java.base/java.util.stream.ReferencePipeline$3$1.accept(ReferencePipeline.java:212)
    at java.base/java.util.Collections$2.tryAdvance(Collections.java:5074)
    at java.base/java.util.Collections$2.forEachRemaining(Collections.java:5082)
    at java.base/java.util.stream.AbstractPipeline.copyInto(AbstractPipeline.java:556)
    at java.base/java.util.stream.AbstractPipeline.wrapAndCopyInto(AbstractPipeline.java:546)
    at java.base/java.util.stream.ReduceOps$ReduceOp.evaluateSequential(ReduceOps.java:921)
    at java.base/java.util.stream.AbstractPipeline.evaluate(AbstractPipeline.java:265)
    at java.base/java.util.stream.ReferencePipeline.collect(ReferencePipeline.java:702)
    at com.influxdb.client.internal.AbstractWriteBlockingClient.write(AbstractWriteBlockingClient.java:69)
    at com.influxdb.client.internal.WriteApiBlockingImpl.writeMeasurements(WriteApiBlockingImpl.java:253)
    at com.influxdb.client.internal.WriteApiBlockingImpl.writeMeasurement(WriteApiBlockingImpl.java:220)
    at com.influxdb.client.internal.WriteApiBlockingImpl.writeMeasurement(WriteApiBlockingImpl.java:207)
    at mypackage.models.measurements.JobMetricTest.testInfluxReflextion(JobMetricTest.java:72)

As I said a test rerun causes the exception, but stopping the tests and restarting them results in one positive test run until there is a rerun.
When I remove duration from Metric the same error occurs but with the job field.
I''m using Java 21, Quarkus 3.15 and InfluxDBClient 7.2.0
', '["java", "reflection", "quarkus", "influxdb"]', '2024-11-18 04:54:21', '2024-11-18 04:54:21', 17, 0, 0, 0, 5852900, null),
        (79198159, 'check if there is a subarray of length l or smaller with a sum greater than or equal to k', 'I was trying to solve Leetcode 862. Shortest Subarray with Sum at Least K. My approach was to binary search on a sliding window. So I needed a method which checks for a given length sol, if there exists a subarray of nums with length less than or equal to sol, whos sum is greater than or equal to k. This is the code I wrote to solve that question, and I cannot for the life of me understand why it does not work.
    private static boolean checkSol(int sol, int[] nums, int k){

    long sum = 0;
    int tail = 0;
    
    for(int i = 0; i<nums.length; i++){
        sum += nums[i];
        if(tail == i - sol){
            sum -= nums[tail];
            tail++;
        }
        if(sum <= 0){
            sum = 0;
            tail = i+1;
        }
        while(tail <= i && nums[tail] <= 0){
            sum-= nums[tail];
            tail++;
        }
        if(sum >= k){
            System.out.println(i + " " + tail);
            return true;}
    }
    return false;
}

A solution using this code passed most test cases, but failed on some. The one shown had nums.length in the tens of thousands. for sol = 283 it did return true, it also did for sol = 284, all the way to 294. but for sol = 295 or higher it returned false.
I have no idea why as the logic seems valid to me.
', '["java", "sliding-window"]', '2024-11-18 05:03:03', '2024-11-18 06:01:57', 40, 0, 1, 0, 7160078, null),
        (79198243, 'Java Spring Multi Role Authauthentication Authorization Error For One Role', 'package com.codecraft.Crud_app.service;

import com.codecraft.Crud_app.model.Task;
import com.codecraft.Crud_app.repository.TaskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TaskService {

    private final TaskRepository taskRepository;

    @Secured({"ROLE_ADMIN", "ROLE_PERSON"})
    public List<Task> getAllTasks() {
        return taskRepository.findAll();
    }

    @Secured({"ROLE_ADMIN", "ROLE_PERSON"})
    public Optional<Task> getTaskById(Long id) {
        return taskRepository.findById(id);
    }

    @Secured({"ROLE_ADMIN", "ROLE_PERSON"})
    public Task saveTask(Task task) {
        return taskRepository.save(task);
    }

    @Secured({"ROLE_ADMIN", "ROLE_PERSON"})
    public void deleteTaskById(Long id) {
        taskRepository.deleteById(id);
    }
}

i have a service class like this and i have test class like that
package com.codecraft.Crud_app;

import com.codecraft.Crud_app.controller.TaskController;
import com.codecraft.Crud_app.model.Task;
import com.codecraft.Crud_app.service.TaskService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;


@SpringJUnitConfig
@SpringBootTest
@EnableMethodSecurity

class CrudAppApplicationTests11 {

    @Autowired
    private TaskService taskService;

    @DynamicPropertySource
    static void postgresqlProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", () -> "jdbc:postgresql://localhost:5432/crud-db");
        registry.add("spring.datasource.username", () -> "postgres");
        registry.add("spring.datasource.password", () -> "postgres");
    }

    @BeforeEach
    public void setUp() {
        Task task1 = new Task();
        task1.setTitle("Task 1");
        task1.setDescription("Description 1");
        task1.setStatus(0);
        taskService.saveTask(task1);

        Task task2 = new Task();
        task2.setTitle("Task 2");
        task2.setDescription("Description 2");
        task2.setStatus(1);
        taskService.saveTask(task2);
    }

    @AfterEach
    public void tearDown() {
        for (Task task : taskService.getAllTasks()) {
            taskService.deleteTaskById(task.getId());
        }
    }


    @Test
    @Order(1)
    @WithMockUser(username = "admin", roles = {"ADMIN"})
    public void test_getTaskById() {
        ResponseEntity<Task> idTask = null;
        TaskController taskController = new TaskController(taskService);
        for (Task task : taskService.getAllTasks()) {
            idTask = taskController.getTaskById(task.getId());
            if (idTask.getBody().getId() != null) {
                break;
            }
        }
        assertNotNull(idTask.getBody().getId());
    }

    @Test
    @Order(8)
    @WithMockUser(username = "person", roles = {"PERSON"})
    public void test_createTask_person() {
        Task task = new Task();
        String title = "Test title for creatTask";
        String description = "Test description for creatTask";
        int status = 654321;
        task.setTitle(title);
        task.setDescription(description);
        task.setStatus(status);
        TaskController taskController = new TaskController(taskService);
        Task newTask = taskController.createTask(task);
        assertEquals(title, taskController.getTaskById(newTask.getId()).getBody().getTitle());
        assertEquals(description, taskController.getTaskById(newTask.getId()).getBody().getDescription());
        assertEquals(status, taskController.getTaskById(newTask.getId()).getBody().getStatus());
    }

    @Test
    @Order(9)
    @WithMockUser(username = "person", password = "personpassword", roles = {"PERSON"})
    public void testt() {
        int i = 1;
        assertNotNull(i);
    }
}

when i run my PERSON roled tests i am taking error like thiss. by the way, when my code works normally, the authorizations work properly, but only in the part where I test, the authorizations do not work properly.
Hibernate: select t1_0.id,t1_0.asigneed_to,t1_0.description,t1_0.status,t1_0.title from task t1_0

org.springframework.security.access.AccessDeniedException: Access is denied

    at org.springframework.security.access.vote.AffirmativeBased.decide(AffirmativeBased.java:77)
    at org.springframework.security.access.intercept.AbstractSecurityInterceptor.attemptAuthorization(AbstractSecurityInterceptor.java:253)

When I upgraded the authorization in my service class to use @Secured({"ROLE_ADMIN", "ROLE_PERSON"}), all the tests passed successfully.
', '["java", "spring", "postgresql", "junit", "crud"]', '2024-11-18 06:00:30', '2024-11-18 06:00:30', 12, 0, 0, 0, 17845208, null),
        (79198277, 'Java blobleaseclient acquireLease does not return lease to available after due time', 'Using the Azure blob storage SDK I am using the BlobLeaseClient acquirelease method and passing in 15 seconds. However if I kill the process after acquiring the lease the lease remains even after the 15 second duration has passed.
How can I revert the blob lease status to available after a process which took out the lease has crashed? The MS SDK docs are unclear on this usecase.
', '["java", "azure", "sdk", "blob", "azure-storage"]', '2024-11-18 06:21:41', '2024-11-18 06:21:41', 30, 2, 0, 0, 12030997, null),
        (79198290, 'Maven install destroys lombok Builder', 'Im trying to make a Website which stores files.
By now i have a springboot rest-server, a simple frontend, a database that stores just ur name and the url of the file, and a MinIO that should store the file itself.
Everything works fine until u try to do a maven install. Somehow the Maven install deletes the DocumentEntityBuilder and the DocumentDtoBuilder which always throws an error.
On a clean build the target directory clearly shows that lombok annotations worked properly and the entity and dto classes have an associated builder. However when running Maven install or compile it fails with the "cannot find symbol" error and the builder is deleted.
I have tried building and rebuilding the project after a maven clean which didn''t work.
I have tried invalidating IDE cache and reloading the project from files.
I have tried a clean download from the github repository.
I have tried reworking the pom.xml to check for annotations and different versions of lombok.
I have tried uninstalling and reinstalling lombok.
I am using IntelliJ IDEA 2024.3
pom.xml
    <?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.3.4</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>at.fhtw</groupId>
    <artifactId>rest</artifactId>
    <version>0.0.4-SNAPSHOT</version>
    <name>rest</name>
    <description>rest</description>
    <url/>
    <licenses>
        <license/>
    </licenses>
    <developers>
        <developer/>
    </developers>
    <scm>
        <connection/>
        <developerConnection/>
        <tag/>
        <url/>
    </scm>
    <properties>
        <java.version>17</java.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web-services</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-webflux</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>io.projectreactor</groupId>
            <artifactId>reactor-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>jakarta.validation</groupId>
            <artifactId>jakarta.validation-api</artifactId>
            <version>3.1.0</version>
        </dependency>
        <dependency>
            <groupId>org.hibernate.validator</groupId>
            <artifactId>hibernate-validator</artifactId>
            <version>8.0.0.Final</version> <!-- Ensure the version is compatible with your setup -->
        </dependency>
        <dependency>
            <groupId>org.glassfish</groupId>
            <artifactId>jakarta.el</artifactId>
            <version>4.0.2</version> <!-- Required for expression language support -->
        </dependency>
        <dependency>
            <groupId>org.mockito</groupId>
            <artifactId>mockito-core</artifactId>
            <version>4.6.1</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-amqp</artifactId>
        </dependency>
        <dependency>
            <groupId>io.minio</groupId>
            <artifactId>minio</artifactId>
            <version>8.5.2</version> <!-- Prüfe die neueste Version -->
        </dependency>

    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <excludes>
                        <exclude>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </exclude>
                    </excludes>
                </configuration>
            </plugin>
        </plugins>
    </build>

</project>

target after clean and build
target after install
The whole project is available on GitHub
https://github.com/SFSDeco/FHTW_SWKOM_Project
If anybody has any ideas please help
', '["java", "maven", "lombok", "intellij-lombok-plugin"]', '2024-11-18 06:33:32', '2024-11-18 06:44:16', 32, 1, 0, 0, 20529666, null),
        (79198388, 'GSON format date for &quot;2024-11-07T17:33:20+00:00&quot;', 'I''m looking for a way to format the date like "2024-11-07T17:33:20+00:00" when I parse Json record to my object.
', '["java", "gson", "date-formatting"]', '2024-11-18 07:58:29', '2024-11-18 14:14:26', 53, -6, 1, 0, 5561061, 79198442),
        (79198532, 'GSSContext, kerberos authentication, negotiate', 'i''ve simple java endpoint to validate user credentials on server A
(this is where my java application run)
so when user hit /kerberos-auth it should be able validate user identity
that connect to the same AD. User should bring negotiate token
this is the code
public LoginResponse authenticateWithKerberos(String kerberosToken) throws GSSException {

        System.setProperty("java.security.krb5.conf", "C:/Windows/krb5.conf");
        System.setProperty("java.security.auth.login.config", "C:/Windows/jaas.conf");
        System.setProperty("sun.security.krb5.debug", "true");
        System.setProperty("javax.security.auth.useSubjectCredsOnly", "false");
        System.setProperty("sun.security.krb5.disableReferrals", "true");

        kerberosToken = kerberosToken.replace(''-'', ''+'').replace(''_'', ''/'');
        int paddingLength = 4 - (kerberosToken.length() % 4);
        if (paddingLength < 4) {
            kerberosToken += "=".repeat(paddingLength);
        }

        byte[] tokenBytes = Base64.getDecoder().decode(kerberosToken);
        GSSManager gssManager = GSSManager.getInstance();
        Oid kerberosOid = new Oid(kerberosConfig.getOid());
        GSSName targetName = gssManager.createName(kerberosConfig.getServiceprincipal(), GSSName.NT_HOSTBASED_SERVICE);
        GSSContext gssContext = gssManager.createContext(targetName, kerberosOid, null, GSSContext.DEFAULT_LIFETIME);
        gssContext.requestMutualAuth(false);
        gssContext.requestCredDeleg(true);

        try {
            gssContext.initSecContext(tokenBytes, 0, tokenBytes.length);
            int atIndex = gssContext.getSrcName().toString().indexOf(''@'');
            String username = gssContext.getSrcName().toString().substring(0, atIndex);
            DetailUserResponse detailUserResponse = getUserWithSystemDetail(username);
            String token = jwtUtil.generateToken(detailUserResponse.getUser(), detailUserResponse.getSystemDetail());

            return new LoginResponse(token, detailUserResponse.getUser());
        }catch (Exception e){
            throw new UserNotFoundException(MessageConstants.USER_NOT_FOUND);
        }finally{
            gssContext.dispose();
        }
    }

server A used rikim user as credentials/ as service account.
then user B coming with negotiate token with ticket cache on his local as user ariandop
My problem, when user B ariandop make a request.
why my application keep validated as rikim ? instead of ariandop.
is there something wrong with my code ?
please help me, thanks ...
I want it to validate as ariandop which is the real username credentials on their local.
instead authenticated as rikim which is service account.
how can i achieve it
', '["java", "kerberos", "gssapi", "negotiate", "http-negotiate"]', '2024-11-18 10:12:51', '2024-11-18 15:54:53', 26, 0, 1, 0, 28249858, null),
        (79198551, 'Bytebuddy: Redefining works locally but getting error when running inside a docker container', 'Our ByteBuddy implementation is working when running locally via IntelliJ, but once packaged and deployed in a Docker Container it breaks throwing a ClassNotFoundException
We have the following method that Redefines an already existing class. Just adding some annotations to it at runtime basically, I did not use any installation agent (ByteBuddyAgent):
private DynamicType.Loaded<? extends MyClassToRedefine> getLoadedTypeOfResource() {
        if (myClassToRedefineImplLoadedType == null) {
                try (var unloadedResource = new ByteBuddy()
                        .subclass(MyClassToRedefine.class)
                        .annotateType(newAnnotation1)
                        .annotateType(newAnnotation2)
                        .annotateType(newAnnotation3)
                        .make()) {
                 myClassToRedefineImplLoadedType = unloadedResource.load(ClassLoader.getSystemClassLoader());
                }
        }
        return myClassToRedefineImplLoadedType;
}

On my run local (IntelliJ, SpringBoot, JDK21, Maven) my application is starting correctly, the class is redefined accordingly.
But, when I try to package the application into a jar file and run it inside a docker container with the following dockerfile:
FROM openjdk:21-jdk

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

ENTRYPOINT ["java","-jar","/app.jar"]

I''m getting a ClassNotFoundException error:
Caused by: java.lang.ClassNotFoundException: com.abc.def.MyClassToRedefine
        at net.bytebuddy.dynamic.loading.ByteArrayClassLoader.findClass(ByteArrayClassLoader.java:404)
        at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:593)
        at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:526)
        ... 73 common frames omitted

I''ve tried putting some log messages before this line is executed:
              myClassToRedefineImplLoadedType = unloadedResource.load(ClassLoader.getSystemClassLoader());

and it seems the class should be defined, but once the line is executed, it throws the error.
I tried implementing the suggested method here: https://www.baeldung.com/byte-buddy (item no. 6) which is to use a ByteBuddyAgent and a Classloading Strategy ClassReloadingStrategy.fromInstalledAgent() and it now WORKS for BOTH local and DOCKER. Here is the code:
private DynamicType.Loaded<? extends MyClassToRedefine> getLoadedTypeOfResource() {
        ByteBuddyAgent.install();
        if (provisionedCustomResourceImplLoadedType == null) {
                try (var unloadedResource = new ByteBuddy()
                        .subclass(MyClassToRedefine.class)
                        .annotateType(newAnnotation1)
                        .annotateType(newAnnotation2)
                        .annotateType(newAnnotation3)
                        .make()) {
                 myClassToRedefineImplLoadedType = unloadedResource.load(MyClassToRedefine.class.getClassLoader(), ClassReloadingStrategy.fromInstalledAgent());
                }
        }
        return myClassToRedefineImplLoadedType;
    }


Can someone explain why the first approach is working at local intellij run but not in docker container, but the 2nd approach works for both?
What''s the difference between the ClassLoader.getSystemClassLoader() vs MyClassToRedefine.class.getClassLoader() to make them have a different behavior in a local and docker setup?
', '["java", "spring-boot", "docker", "byte-buddy", "classloading"]', '2024-11-18 10:30:35', '2024-11-18 10:32:33', 31, 2, 0, 0, 28342935, null),
        (79198610, 'Change WS Propertie in Discord JDA', 'In JavaScript with Discord.js, there was an option to customize the WebSocket properties by setting the ws property, like changing the browser to something like "Discord iOS." For example:
const client = new Discord.Client({
    intents: [Intents.FLAGS.GUILDS, Intents.FLAGS.GUILD_MESSAGES],
    ws: { properties: { $browser: "Discord iOS" }}
});

Is there a similar way to achieve this in Java using the JDA (Java Discord API)?
I have already tried modifying the WebSocket properties in Java using the JDA (Java Discord API) by working with the WebSocketFactory, but it didn''t seem to change anything. Specifically, I attempted to customize the WebSocket properties, similar to how it''s done in Discord.js, by setting something like the $browser property, but no effect was observed.
', '["java", "websocket", "discord-jda"]', '2024-11-18 11:29:10', '2024-11-18 11:29:10', 11, 0, 0, 0, 16288266, null),
        (79198744, 'Making a Histogram using an Array of integers', 'I’m trying to make a method that takes a String and then fills an array based on the frequency of letters in the string where the array[0] is the number of A’s etc. Then it takes the array and prints out a histogram with all the letters with an asterisk above them in columns for each time a letter appears in the string. I was able to code the part that gets the amount of each letter in a string but I have no idea how to print out the histogram.
void drawHistogram() {
    int[] frequency = new int[26];
    for (int i = 0; i < text.length(); i++) {
        if (Character.isLetter(text.charAt(i))) {
            frequency[Character.getNumericValue(Character.toLowerCase(text.charAt(i))) - 10] += 1;
        }
    }
}

text is a string variable from the class.
For example, if text = "I love problem-solving.", the program should print this histogram
                      *     *   
        *       *     *     *             *           
  *     *   *   *     * * * * *   * *     *       
---------------------------------------------------
a b c d e f g h i j k l m n o p q r s t u v w x y z

There should be one asterisk above b, g, m, n, p, r and s. Two above e, i and v. Three above l and o.
', '["java", "arrays", "string", "integer", "histogram"]', '2024-11-18 13:00:47', '2024-11-18 13:18:47', 42, -1, 1, 0, 28319741, null),
        (79198747, 'Compare two different java Code and measure which one has better performance', 'I am currently doing code optimization on my project so , how do i measure that sonar suggested code changes are making my code more optimized, such as it suggest to use , .equals() to compare string and box types while i was using directly == so , So how do i check it has impacted my code or not and if yes How much ?
', '["java", "optimization", "sonarqube"]', '2024-11-18 13:01:14', '2024-11-18 13:01:14', 30, -1, 0, 0, 23676614, null),
        (79198779, 'Question MariaDB time zone and Application time zone', 'I would like to ask you about the MariaDB time zone.

Application: Asia/Seoul, adding ?serverTimezone= UTC to jdbcurl.
MariaDB(docker): @@global.time_zone, @@session.time_zone,@@system_time_zone set UTC/ docker set UTC


What I expected is that if you put it as KST time in the application, it will be saved as UTC time in the DB, but it will be saved as KST time. Is this a normal flow?
(ex. KST 2024-11-18 14:00:00 insert, i expected UTC 2024-11-18 05:00:00, but db insert 2024-11-18 14:00:00)
I would like to configure the DB as UTC time and the application as Asia/Seoul that I set up, is there a way?

@PostConstruct
void started() {
    TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
}

@PostMapping
public void insertTime() {
    LocalDateTime now = LocalDateTime.now();
    log.info(now.toString());

    TImeTest timeTest = TImeTest.builder()
            .createdAt(now)
            .modifiedAt(now)
            .build();

    timeTestRepository.save(timeTest);
}

url: jdbc:mariadb://localhost:3307/test?serverTimezone=UTC

DB
[

  {
    "@@global.time_zone": "UTC",
    "@@session.time_zone": "UTC",
    "@@system_time_zone": "UTC"
  }
]

', '["java", "spring", "mariadb"]', '2024-11-18 13:30:33', '2024-11-18 16:13:48', 27, 0, 1, 0, 25318955, null),
        (79198852, 'How to Encrypt userPassword in JNDIRealm?', 'I want to encrypt the userPassword in JNDIRealm.
I have set the value encrypted by specifying the encryption method with digest.sh to userPassword in server.xml.
$ $CATALINA_HOME/bin/digest.sh -a PBKDF2WithHmacSHA512 -i 100000 -s 

16 -k 256 -h org.apache.catalina.realm.SecretKeyCredentialHandler password
I have specified the encryption method in credentialHandler.
<Realm className="org.apache.catalina.realm.JNDIRealm"
connectionURL="ldap://test.com:389"
authentication="simple" referrals="follow"
connectionName="CN=testuser,CN=Users,DC=test,DC=com"
connectionPassword="encrypted password" digest="SHA-512"
userSearch=(sAMAccountName={0})
userBase="CN=Users,DC=test,DC=com" userSubtree="true"
userRoleName=memberOf
roleBase="CN=Users,DC=test,DC=com" roleSubtree="true"
roleSearch=(member={0}) roleName="CN" />

<CredentialHandler
    className="org.apache.catalina.realm.SecretKeyCredentialHandler"
    algorithm="PBKDF2WithHmacSHA512"
    iterations="100000"
    keyLength="256"
    saltLength="16" />

Does JNDIRealm support encryption with digest.sh?
', '["java", "authentication", "tomcat9"]', '2024-11-18 14:18:11', '2024-11-18 14:18:11', 10, 0, 0, 0, 11141979, null),
        (79198876, 'Alternative to iText for HTML to PDF conversion with Indian languages support', 'I am using the premium version of iText to convert HTML into PDF''s. The content can be in 12 Indian lanuages (e.g., Hindi, Tamil, Telugu, Bengali) and while iText works well, I''m looking for an alternative due to licensing costs.
Key requirements:
Indian Languages Support Proper rendering of scripts with shaping and positioning.
Html to PDF conversion Support for styled text, images and tables.
I''ve considered Apache PDFBox but am unsure of it''s sustainability.
Can anyone recommend any Java library for this use case?
', '["java", "spring-boot", "pdf-generation", "pdfbox", "html-to-pdf"]', '2024-11-18 14:26:52', '2024-11-18 14:26:52', 13, 0, 0, 0, 28352129, null),
        (79198906, 'How does Firebase collect and actively report custom logs?', 'Can the logs collected by Firebase include custom logs? If so, how to collect them? For example, I want to directly and actively report custom content through Firebase after the application is opened or when the network connection is monitored.
In addition, is it necessary to make other additional configurations in the console?And , how to view custom logs on the console?
I hope that the sample code can be achieved, and if it is necessary to make relevant configurations in the Firebase console, I hope that there can be complete operation steps.
', '["java", "kotlin", "firebase-crash-reporting"]', '2024-11-18 14:40:47', '2024-11-18 14:40:47', 8, 0, 0, 0, 27685199, null),
        (79198917, 'Unable to pull latest library from GH packages', 'Unable to pull latest library from GitHub Packages.
project-commons has 1.10, 1.11, we publish 1.12
If project-service has the following snippet in the build.gradle it still doesn''t pull the latest library 1.12 automatically.
project-service
    Snippet from build.gradle has
    implementation ''com.company.project:project-commons:+''

', '["java", "gradle"]', '2024-11-18 14:45:52', '2024-11-18 14:45:52', 10, 0, 0, 0, 352290, null),
        (79198960, 'How to dynamically get all entities defined in a Quarkus service', 'I have a registry library, which is imported by each Quarkus service. The library registers a service and sends some information about it to a registry service. Currently the registry service receives such information as IP and the name of the service, but I want to extend the functionality so that the names of the entities (classes annotated with @Entity) used by the service are also sent.
One of the possible approaches is to use https://github.com/ronmamo/reflections in combination with @RegisterForReflection (https://github.com/quarkusio/quarkus/discussions/29859)
Reflections reflections = new Reflections(packageName);
Set<Class<?>> entityClasses = reflections.getTypesAnnotatedWith(Entity.class);

However, with this approach each service needs to specify the name of the package where entities are located (e.g in application.propertoes) which I want to avoid. The goal is to be able to get the names of all the entities defined in the class without forcing the service to provide the location of the entities. Is it possible and if yes, how this can be achieved?
', '["java", "quarkus"]', '2024-11-18 15:03:08', '2024-11-18 15:03:08', 21, 0, 0, 0, 10101081, null),
        (79199152, '@OneToOne or @ManyToOne on Instrument.created references an unknown entity: user.User where User is interface', 'I have following error:
@OneToOne or @ManyToOne on Instrument.created references an unknown entity: user.User

User class is public interface with abstract methods. The only class which is implementing User is CommonUser which is annotated with @Entity and @Table(name="users").
So yes, error is correct - User is not an entity but I don''t want it to be because CommonUser is an entity.
What should be the correct approach here?
Do I need to change code to make Instrument class work on concrete CommonUser, not User?
', '["java", "hibernate"]', '2024-11-18 16:10:21', '2024-11-18 16:22:32', 16, 0, 1, 0, 4952262, null),
        (79199294, 'How to Correct Path Format for a File in Java Using Path in Windows', 'I''m working on a Java project running on a Windows machine, and I have a configuration file located in src/main/resources. This file contains an entry for a directory path:
<entry key="myRepo">src/main/resources/myRepo</entry>

In my code, I read the path like this:
Path path = Paths.get(Application.cfg.getString("myRepo"));

Later, I pass this Path to a method in a class imported from a JAR file (I cannot modify the JAR code):
String htmlcda = CdaXSLTransformer.getInstance().transform(cda_xml, "en-GB", Application.cfg.getString("myUrl"), path);

The problem is that when path is processed, it uses backslashes () instead of forward slashes (/), which results in an error because the method expects a properly formatted URI-like path.
For example, the path is processed as:
file://src\\main\\resources\\

This format causes an error. I cannot modify the method to accept a URI instead of a Path.
What I''ve Tried:

Using path.toUri() — but this returns a URI, which I cannot pass to the method.

Question:

How can I ensure the Path is interpreted correctly in Windows and used in a
format compatible with the method, without modifying the JAR file or
the method definition?

', '["java", "path"]', '2024-11-18 17:08:33', '2024-11-18 17:08:33', 9, 0, 0, 0, 1395874, null);