# Tu Mascota Tandil - Backend

Sistema web para reportar mascotas perdidas en Tandil.

## 🚀 Tecnologías

- Java 17
- Spring Boot 4.0.2
- MySQL 8.0
- Docker & Docker Compose

## 📋 Requisitos

- Docker y Docker Compose instalados
- Maven (para desarrollo local)

## 🐳 Ejecutar con Docker

### Opción 1: Docker Compose (recomendado - compila automáticamente)

```bash
docker-compose up -d --build
```

### Opción 2: Compilar manualmente primero

```bash
# 1. Compilar el proyecto
mvn clean package -DskipTests

# 2. Levantar los servicios
docker-compose up -d
```

### 3. Ver logs

```bash
docker-compose logs -f backend
```

### 4. Detener servicios

```bash
docker-compose down
```

### 5. Detener y eliminar volúmenes (incluye datos de BD)

```bash
docker-compose down -v
```

## 🔧 Configuración

### Variables de entorno

Puedes configurar las siguientes variables antes de ejecutar `docker-compose up`:

```bash
export ADMIN_USERNAME=admin
export ADMIN_PASSWORD=tu_password_seguro
export ADMIN_CREATE_ON_STARTUP=true
```

### Credenciales por defecto

- **MySQL**: 
  - Usuario: `root`
  - Password: `Hernan007.`
  - Base de datos: `tumascotandil`

- **Admin**:
  - Usuario: `admin` (configurable)
  - Password: Se crea automáticamente si no se especifica (solo desarrollo)

## 📡 Endpoints

### Públicos (sin autenticación)
- `POST /posts` - Crear post de mascota perdida
- `GET /posts` - Listar posts publicados
- `GET /posts/{id}` - Ver post individual

### Admin (requieren autenticación HTTP Basic)
- `GET /posts/pendientes` - Listar posts pendientes
- `PATCH /posts/{id}/aprobar` - Aprobar post
- `PATCH /posts/{id}/rechazar` - Rechazar post

## 🗄️ Base de Datos

La base de datos se crea automáticamente al iniciar el contenedor MySQL.

Para acceder a MySQL desde fuera del contenedor:
```bash
mysql -h localhost -P 3306 -u root -pHernan007.
```

## 📁 Estructura

```
tumascotandil/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/buscatumascotandil/find/
│       │       ├── config/      # Configuraciones
│       │       ├── controller/  # Controladores REST
│       │       ├── dto/         # Data Transfer Objects
│       │       ├── exception/   # Manejo de excepciones
│       │       ├── mapper/      # Mappers
│       │       ├── model/       # Entidades JPA
│       │       ├── repository/  # Repositorios
│       │       └── service/      # Lógica de negocio
│       └── resources/
│           └── application.properties
├── uploads/                     # Imágenes subidas (volumen Docker)
├── Dockerfile
├── docker-compose.yml
└── pom.xml
```

## 🔒 Seguridad

- Los endpoints públicos no requieren autenticación
- Los endpoints de admin requieren autenticación HTTP Basic
- Las contraseñas se encriptan con BCrypt
- Las credenciales se configuran mediante variables de entorno

## 📝 Notas

- Las imágenes se guardan en `./uploads` (volumen de Docker)
- La base de datos persiste en el volumen `mysql_data`
- Para producción, configura `ADMIN_PASSWORD` como variable de entorno
