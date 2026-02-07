# Spring Project Builder

**Spring Project Builder** is a powerful code generation tool built with Spring Boot. It automates the creation of standard Spring Boot application layers (Controllers, Services, DTOs, Mappers, etc.) based on a specified Model class, significantly reducing boilerplate code and development time.

## 🚀 Features

*   **Automated Code Generation**: Generates the following components:
    *   REST Controllers
    *   Service Interfaces and Implementations
    *   DTOs (Request and Response)
    *   Mappers (using MapStruct)
    *   Validators
    *   Repositories (JPA)
*   **Highly Configurable**: Customize package names, naming suffixes, and project paths via `application.yaml`.
*   **Template Based**: Uses FreeMarker templates for flexible code generation.
*   **REST API Trigger**: Trigger code generation via a simple REST API call.

## 🛠 Tech Stack

*   **Java**: 17
*   **Framework**: Spring Boot
*   **Template Engine**: FreeMarker
*   **Mapping**: MapStruct
*   **Utilities**: Lombok, JetBrains Annotations
*   **Build Tool**: Maven

## 📋 Prerequisites

*   Java 17 or higher
*   Maven 3.6+

## ⚙️ Configuration

The application is configured via `src/main/resources/application.yaml`. Key configurations include:

*   **Project Settings**: Define the target project path, source root, and base package.
*   **Package Structure**: Customize the package names for generated components (e.g., `controller`, `service`, `dto`).
*   **Naming Conventions**: Define suffixes for generated classes (e.g., `UserRequest`, `UserMapper`).
*   **REST Settings**: Configure base paths and endpoint naming strategies.

### Example Configuration (`application.yaml`)

```yaml
project:
  path: "/path/to/your/project"
  base-package: "com.example.myapp"

packages:
  model: "model"
  dto: "dto"
  controller: "controller"
  # ... other packages

naming:
  suffix:
    dto-request: "Request"
    controller: "Controller"
    # ... other suffixes
```

## 🚀 Build and Run

1.  **Clone the repository**:
    ```bash
    git clone <repository-url>
    cd spring-project-builder
    ```

2.  **Build the project**:
    ```bash
    mvn clean install
    ```

3.  **Run the application**:
    ```bash
    mvn spring-boot:run
    ```
    The server will start on port `8081` (default).

## 🔌 Usage

**Trigger Generation**: Send a `POST` request to the generation endpoint.

**Endpoint:** `POST http://localhost:8081/generate/by/config`

**Request Body:**

```json
{
  "input": {
    "modelClass": "User",
    "generate": {
      "controller": true,
      "service": true,
      "serviceImpl": true,
      "repository": true,
      "dto": true,
      "mapper": true,
      "validator": true
    }
  }
}
```

*   `modelClass`: The name of the entity/model class to generate code for.
*   `generate`: Boolean flags to enable/disable generation of specific components.

## 📂 Project Structure

*   `controller`: Handles the generation API requests.
*   `service`: Orchestrates the code generation process.
*   `engine`: Core logic for processing templates and generating files.
*   `config`: Application configuration properties.
*   `dto`: Data Transfer Objects for the generator API.
*   `resources/templates`: FreeMarker templates used for code generation.

## 📝 Templates

The project uses FreeMarker templates located in `src/main/resources/templates` to generate code. You can customize these templates to match your coding standards.

*   `controller.ftl`: Template for REST Controllers.
*   `service.ftl`: Template for Service classes.
*   `repository.ftl`: Template for JPA Repositories.
*   `dto-request.ftl`: Template for Request DTOs.
*   `dto-response.ftl`: Template for Response DTOs.
*   `mapper.ftl`: Template for MapStruct Mappers.
*   `validator.ftl`: Template for Validators.

## ✅ TODOs

*   [ ] Update EntityPackage without basePackage
*   [ ] Upgrade getModel by each classes.
*   [ ] Validate with switch application.yml by classes - take suggestion from AI
*   [ ] Implement {} dynamicPath in pkg - started inprogress
