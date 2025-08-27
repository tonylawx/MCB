# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Docker Environment
```bash
# Start full development environment (includes pgAdmin)
./scripts/dev-start.sh
# or
docker-compose --profile dev up -d

# Start production environment (backend + database only)
docker-compose up -d

# Stop all services
./scripts/dev-stop.sh
# or 
docker-compose down

# View backend logs
./scripts/dev-logs.sh backend
# or
docker-compose logs -f backend

# Restart specific service
docker-compose restart backend
```

### Backend Development
```bash
# Build the backend
cd backend && mvn clean compile

# Run tests
cd backend && mvn test

# Run specific test class
cd backend && mvn test -Dtest=McbApplicationTests

# Package application
cd backend && mvn clean package

# Run Flyway migrations manually
cd backend && mvn flyway:migrate

# Generate database migration
# Create new file: backend/src/main/resources/db/migration/V{version}__description.sql
```

### Database Management
```bash
# Connect to database directly
docker-compose exec postgres psql -U mcb_user -d mcb_db

# Reset database (⚠️ destructive)
docker-compose down -v && docker-compose up -d

# Access pgAdmin (dev profile only)
# http://localhost:5050 (admin@mcb.com / admin)
```

## Architecture Overview

### Technology Stack
- **Backend**: Spring Boot 3.2.0 with Java 21
- **Database**: PostgreSQL 15 with Flyway migrations  
- **Security**: JWT authentication with Spring Security
- **ORM**: MyBatis for database operations
- **Containerization**: Docker with multi-service orchestration
- **Frontend**: Next.js 14 (planned, not yet implemented)

### Key Architectural Decisions
- **Multi-environment profiles**: `dev`, `docker`, `prod` with separate application-{profile}.yml files
- **Database-first approach**: Schema managed through Flyway migrations in `backend/src/main/resources/db/migration/`
- **MyBatis over JPA**: XML mappers in `backend/src/main/resources/mapper/` for complex queries
- **JWT stateless authentication**: No server-side session storage
- **Containerized development**: Full Docker setup with health checks and dependency management

### Project Structure
```
backend/
├── src/main/java/com/mcb/
│   ├── controller/     # REST API endpoints
│   ├── service/        # Business logic layer  
│   ├── repository/     # Data access layer (MyBatis)
│   ├── model/          # Domain entities
│   ├── dto/            # Data transfer objects
│   └── config/         # Spring configuration classes
├── src/main/resources/
│   ├── application*.yml    # Multi-environment configuration
│   ├── db/migration/       # Flyway SQL migration scripts
│   └── mapper/            # MyBatis XML mapper files
```

### Database Schema
Core tables managed through Flyway migrations:
- `users` - User accounts and authentication
- `category` - Income/expense categories (user-specific)
- `exchange_rate` - Currency conversion rates  
- `transaction` - Financial transactions (multi-currency)

### Security Architecture
- JWT-based stateless authentication
- Spring Security configuration in `SecurityConfig.java`
- Password hashing with BCrypt
- CORS configuration for frontend integration
- JWT service disabled by default (`.disabled` extension on `JwtService.java`)

### Environment Configuration
- **Dev profile**: Local development with detailed logging and all actuator endpoints
- **Docker profile**: Containerized environment with PostgreSQL connection
- **Prod profile**: Production-ready configuration with minimal logging
- Environment variables managed through Docker Compose and .env files

### API Structure
- Base path: `/api/v1`
- Health endpoint: `/api/v1/actuator/health`
- Authentication: `/api/v1/auth/*`
- All endpoints return standardized `ApiResponse<T>` format

### Development Workflow
1. Use Docker Compose for consistent development environment
2. Database changes go through Flyway migrations (never manual schema changes)
3. Business logic in service layer, data access through MyBatis repositories
4. All configuration externalized through Spring profiles
5. Health checks and monitoring through Spring Boot Actuator

### Multi-Currency Support
- Amounts stored as minor currency units (cents) for precision
- Exchange rate table for currency conversions
- Transaction records include both original and base currency amounts
- Support for CAD, USD, CNY currencies

## Important Notes

- JWT service is currently disabled (file has `.disabled` extension) - enable by renaming to `JwtService.java`
- Frontend is planned but not yet implemented
- Demo credentials: `demo@mcb.com` / `demo123`
- All services have health checks configured for proper startup sequencing
- Database initialization scripts can be placed in `database/init/` directory
- Logs are mounted to `./logs/` directory for persistence across container restarts