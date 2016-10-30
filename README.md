# Java Webapp with RESTful Web Service
Project created using [Maven Webapp Archetype](https://maven.apache.org/archetypes/maven-archetype-webapp/).
List of [Maven Archetypes](https://maven.apache.org/archetypes/).

- Jersey Version: `2.23.2`
- Servlet Version: `3.1` (defined in `web.xml`)

## Application Deployment and Runtime Environments
I've tried to configure 3 deployment environment.
- Grizzly Http Server
- Jetty Web Server
- Tomcat Servlet Container

### Java SE Deployment Environments
> Java based HTTP servers represent a minimalistic and flexible way of deploying Jersey application. The HTTP servers are usually embedded in the application and configured and started programmatically.
> -[Source](https://jersey.java.net/documentation/latest/deployment.html#deployment.javase)

#### Grizzly Http Server
`jersey-container-grizzly2-http` artifact is required.
```
<dependency>
    <groupId>org.glassfish.jersey.containers</groupId>
    <artifactId>jersey-container-grizzly2-http</artifactId>
    <version>2.24</version>
</dependency>
```

### Servlet-based Deployment
> In a Servlet container, JAX-RS defines multiple deployment options depending on the Servlet API version supported by the Servlet container.
> -[Source](https://jersey.java.net/documentation/latest/deployment.html#deployment.servlet)

For this project, I'm using a `Servlet 3.x` container.

#### Servlet 3 Pluggability Overview
| Condition | Jersey action | Servlet Name | web.xml |
|------------------------------------------------------|---------------|---------------------------------|--------------------------------------------------------------------------------------|
| **No Application subclass** | **Adds Servlet** | **javax.ws.rs.core.Application** | **Servlet mapping is required** |
| Application subclass handled by existing Servlet | No action | Already defined | Not required |
| Application subclass NOT handled by existing Servlet | Adds Servlet | FQN of the Application subclass | if no @ApplicationPath on the Application subclass, then Servlet mapping is required |

I will be using the **No Application subclass** style.

The `web.xml` has to be defined as follow
```
<!-- Servlet declaration can be omitted in which case it would be automatically added by Jersey -->
<servlet>
    <servlet-name>javax.ws.rs.core.Application</servlet-name>
</servlet>

<servlet-mapping>
    <servlet-name>javax.ws.rs.core.Application</servlet-name>
    <url-pattern>/api/*</url-pattern>
</servlet-mapping>
```

and the dependency
```
<dependency>
    <groupId>org.glassfish.jersey.containers</groupId>
    <!-- if your container implements Servlet API older than 3.0, use "jersey-container-servlet-core"  -->
    <artifactId>jersey-container-servlet</artifactId>
</dependency>
```

#### Jetty Http Server
To run the jetty server, I'm using the artifact `jetty-maven-plugin`.

To start the server, `mvn jetty:run`

#### Tomcat
For Tomcat, `mvn package` to create a `.war` file.

### Maven Profiles

**Three** different profile
- grizzly-server
- jetty-servlet-container
- servlet-container

To check which profile is activated, `mvn help:active-profiles`.
