# MCB — Multi-Currency Book

## 📌 Project Purpose

**MCB** (Multi-Currency Book) is a **simple, multi-currency finance tracker**.  
It is designed for individuals, families, or organizations to:
- Record income and expenses in different currencies
- View monthly and yearly summaries
- Understand spending patterns across categories
- Support collaborative budgeting in the future

---

## 🚀 MVP Features

The first version (MVP) will focus on the essential core:

- Record transactions with:
    - Category
    - Type: INCOME / EXPENSE
    - Amount (stored in the smallest currency unit)
    - Currency (e.g., CAD, USD, CNY)
    - Date & time
    - Optional note
- Multi-currency support with exchange rate conversion to a base currency
- Monthly report:
    - Total income / total expense / balance
    - Expense category breakdown (pie chart)
- Yearly report:
    - Monthly income & expense trend (bar/line chart)
- Local data storage (no authentication for MVP)

---

## 🛠 Tech Stack (MVP)

- **Backend:** Java 21 + Spring Boot 3 + MyBatis + PostgreSQL + Flyway
- **Frontend:** Next.js 14 (App Router, TypeScript) + Tailwind CSS + Recharts

---
