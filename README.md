# MCB — Multi-Currency Book

[![Java](https://img.shields.io/badge/Java-21-orange.svg)](https://openjdk.java.net/projects/jdk/21/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.0-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue.svg)](https://www.postgresql.org/)
[![Next.js](https://img.shields.io/badge/Next.js-14-black.svg)](https://nextjs.org/)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED.svg)](https://docs.docker.com/compose/)

## 📌 Project Purpose

**MCB** (Multi-Currency Book) is a **modern, containerized multi-currency finance tracker** built with enterprise-grade technologies.  

**Perfect for:**
- 👤 **Individuals** tracking personal finances across multiple currencies
- 👨‍👩‍👧‍👦 **Families** managing household budgets and expenses
- 🏢 **Organizations** handling multi-currency transactions
- 🎓 **Learning** modern full-stack development with Docker

**Key Benefits:**
- 💱 Multi-currency support with real-time conversion
- 📊 Visual reports and spending analytics  
- 🐳 **One-command setup** with Docker Compose
- 🔒 Enterprise security with JWT authentication
- 📱 Responsive design for all devices

---

## 🏗️ Architecture Overview

```
┌─────────────────┐    REST/JSON     ┌─────────────────┐    JDBC      ┌─────────────────┐
│   Frontend      │ ◄─────────────► │    Backend      │ ◄─────────► │   Database      │
│                 │                  │                 │              │                 │
│ Next.js 14      │                  │ Spring Boot 3   │              │ PostgreSQL 15   │
│ TypeScript      │                  │ Java 21         │              │ + Flyway        │
│ Tailwind CSS    │                  │ MyBatis         │              │                 │
│ Recharts        │                  │ JWT Security    │              │                 │
└─────────────────┘                  └─────────────────┘              └─────────────────┘
```

---

## 🚀 Quick Start

### Prerequisites

- **Docker** and **Docker Compose** installed
- **Git** for cloning the repository
- **8080** and **5432** ports available

### 1. Clone and Start

```bash
# Clone the repository
git clone <your-repo-url>
cd MCB

# Start all services with one command
docker-compose up -d

# Or use the convenience script (Linux/macOS)
chmod +x scripts/dev-start.sh
./scripts/dev-start.sh
```

### 2. Verify Services

```bash
# Check service status
docker-compose ps

# Test backend API health
curl http://localhost:8080/api/v1/actuator/health

# View logs
docker-compose logs backend
```

### 3. Access Applications

| Service | URL | Description |
|---------|-----|-------------|
| **Backend API** | http://localhost:8080 | Spring Boot REST API |
| **Health Check** | http://localhost:8080/api/v1/actuator/health | Service health status |
| **Database** | localhost:5432 | PostgreSQL (mcb_db) |
| **pgAdmin** | http://localhost:5050 | Database management (dev profile) |

**Demo Credentials:**
- Email: `demo@mcb.com`
- Password: `demo123`

---

## 🛠 Development Setup

### Environment Configuration

```bash
# Copy environment template
cp .env.example .env

# Edit configuration as needed
# Default values work for local development
```

### Available Environments

- **Development** (`dev`): Local development with detailed logging
- **Docker** (`docker`): Containerized environment 
- **Production** (`prod`): Production-ready configuration

### Database Management

```bash
# Access database directly
docker-compose exec postgres psql -U mcb_user -d mcb_db

# Run migrations manually
docker-compose exec backend mvn flyway:migrate

# Reset database (⚠️ destructive)
docker-compose down -v
docker-compose up -d
```

### Useful Scripts

```bash
# Start development environment with pgAdmin
docker-compose --profile dev up -d

# View specific service logs
./scripts/dev-logs.sh backend
./scripts/dev-logs.sh postgres

# Stop all services
./scripts/dev-stop.sh
```

---

## 🎯 MVP Features

### Core Functionality
- ✅ **User Authentication**: Email-based registration and JWT login
- ✅ **Transaction Management**: Record income/expense with categories
- ✅ **Multi-Currency Support**: CAD, USD, CNY with manual exchange rates
- ✅ **Data Persistence**: PostgreSQL with automated migrations
- ✅ **Health Monitoring**: Built-in health checks and metrics

### Transaction Features
- 💰 **Amount Storage**: Precision handling with minor currency units (cents)
- 🏷️ **Categories**: Organized expense/income categorization
- 📅 **Date/Time Tracking**: Precise transaction timestamps
- 📝 **Notes**: Optional transaction descriptions
- 💱 **Exchange Rates**: Automatic conversion to base currency

### Reporting (Coming Soon)
- 📊 **Monthly Reports**: Income/expense totals with category breakdowns
- 📈 **Yearly Reports**: Trend analysis with interactive charts
- 🥧 **Visual Analytics**: Pie charts for spending patterns
- 📊 **Bar Charts**: Monthly income/expense comparisons

---

## 📊 Database Schema

### Core Tables

```sql
users           → User accounts and authentication
category        → Income/expense categories (user-specific)
exchange_rate   → Currency conversion rates
transaction     → Financial transactions (multi-currency)
```

### Key Features
- **Multi-tenant**: User-isolated data
- **ACID Compliance**: PostgreSQL transactions
- **Migration Management**: Flyway versioned schemas
- **Indexing**: Optimized for reporting queries
- **Constraints**: Data integrity enforcement

---

## 🧪 Testing

### API Testing

```bash
# Test authentication endpoint
curl -X POST http://localhost:8080/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"demo@mcb.com","password":"demo123"}'

# Test health endpoint
curl http://localhost:8080/api/v1/actuator/health
```

### Database Testing

```bash
# Connect to test database
docker-compose exec postgres psql -U mcb_user -d mcb_db

# Run sample queries
SELECT * FROM users;
SELECT * FROM category WHERE type = 'EXPENSE';
SELECT * FROM transaction ORDER BY occurred_at DESC LIMIT 5;
```

---

## 📦 Project Structure

```
MCB/
├── 🐳 docker-compose.yml          # Multi-service orchestration
├── 📄 .env.example                # Environment template
├── 📜 .gitignore                  # Git exclusions
│
├── 📁 backend/                    # Spring Boot API
│   ├── 🐳 Dockerfile             # Multi-stage build
│   ├── 📦 pom.xml                # Maven dependencies
│   └── 📁 src/
│       ├── 📁 main/java/com/mcb/
│       │   ├── 🚀 McbApplication.java
│       │   ├── 📁 controller/     # REST endpoints
│       │   ├── 📁 service/        # Business logic
│       │   ├── 📁 repository/     # Data access (MyBatis)
│       │   ├── 📁 model/          # Domain entities
│       │   ├── 📁 config/         # Spring configuration
│       │   └── 📁 dto/            # API data objects
│       └── 📁 resources/
│           ├── ⚙️ application*.yml # Multi-env config
│           ├── 📁 db/migration/    # Flyway SQL scripts
│           └── 📁 mapper/          # MyBatis XML mappers
│
├── 📁 frontend/                   # Next.js Web App (Coming Soon)
│   └── 🚧 (To be implemented)
│
└── 📁 scripts/                    # Development utilities
    ├── 🚀 dev-start.sh           # Quick start script
    ├── 🛑 dev-stop.sh            # Stop services
    └── 📜 dev-logs.sh            # View logs
```

---

## 🔧 Configuration

### Environment Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `POSTGRES_DB` | Database name | mcb_db | ✅ |
| `POSTGRES_USER` | Database user | mcb_user | ✅ |
| `POSTGRES_PASSWORD` | Database password | mcb_password | ✅ |
| `JWT_SECRET` | JWT signing key | auto-generated | ✅ |
| `JWT_EXPIRATION` | Token validity (ms) | 86400000 (24h) | ✅ |

### Port Configuration

| Service | Port | Purpose |
|---------|------|---------|
| Backend API | 8080 | Spring Boot application |
| PostgreSQL | 5432 | Database connections |
| pgAdmin | 5050 | Database management UI |

---

## 🚢 Deployment

### Production Deployment

```bash
# Set production environment
export SPRING_PROFILES_ACTIVE=prod

# Start with production configuration
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

# Health check
curl https://your-domain.com/api/v1/actuator/health
```

### Security Considerations

- 🔐 Change default JWT secret in production
- 🛡️ Use strong database passwords
- 🔒 Enable HTTPS for production deployments
- 🚫 Remove demo data in production builds
- 📝 Configure proper logging levels

---

## 🛣️ Roadmap

### v0.1 — MVP (Current)
- ✅ Email authentication
- ✅ Multi-currency transactions
- ✅ Docker containerization
- ✅ Database migrations

### v0.2 — Core Enhancements
- 🔄 Category management UI
- 🌐 Exchange rate API integration
- 💾 CSV import/export
- 🔍 Transaction search & filters

### v0.3 — Collaboration
- 👥 Multi-user organizations
- 🔐 Role-based permissions  
- 📧 Member invitations
- 🔔 Activity notifications

### v0.4 — Advanced Reports
- 📈 Budget planning tools
- 🔮 Forecasting & trends
- 📊 Advanced analytics
- 📄 PDF/Excel exports

### v0.5 — Cloud Sync
- ☁️ Multi-device synchronization
- 💾 Backup & restore
- 📱 Push notifications
- 🔄 Real-time updates

---

## 🤝 Contributing

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** changes (`git commit -m 'Add amazing feature'`)
4. **Push** to branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Development Guidelines

- ✅ Follow existing code style and conventions
- 🧪 Add tests for new features
- 📝 Update documentation for API changes
- 🐳 Ensure Docker compatibility
- 🔍 Test in multiple environments

---

## 📄 License

This project is licensed under the **Apache License 2.0** - see the [LICENSE](LICENSE) file for details.

### License Strategy
- **Core Edition**: Apache 2.0 — Free for open source usage
- **Commercial Edition**: Paid license for enterprise features  
- **Trademark**: "MCB" name & logo reserved

---

## 🆘 Support

### Getting Help

- 📖 **Documentation**: Check this README and inline code comments
- 🐛 **Issues**: Report bugs via GitHub Issues
- 💬 **Discussions**: Join GitHub Discussions for questions
- 📧 **Contact**: [your-email@example.com]

### Common Issues

**Port conflicts:**
```bash
# Check port usage
lsof -i :8080
lsof -i :5432

# Kill conflicting processes
sudo kill -9 <PID>
```

**Permission issues:**
```bash
# Fix Docker permissions (Linux)
sudo chmod +x scripts/*.sh
sudo chown -R $USER:$USER .
```

**Database connection:**
```bash
# Reset database
docker-compose down -v
docker-compose up -d postgres
docker-compose logs postgres
```

---

**Built with ❤️ for the open source community**
