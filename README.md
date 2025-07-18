# Database Project - University Course Evaluation System

*Developed as part of Database Systems course at UFPE (Universidade Federal de Pernambuco)*

## Project Description

This project implements a comprehensive database system for managing university course evaluations. The system allows students to evaluate professors and courses, while maintaining information about universities, courses, prerequisites, monitors, and contacts.

## Objectives

- Design and implement a relational database for university course management
- Create a system for student evaluations and comments
- Demonstrate various SQL operations and query types
- Implement proper database constraints and relationships

## Database Structure

### Main Entities

- **UNIVERSIDADE** (University): Stores university information including name, acronym, and address
- **CADEIRA** (Course): Contains course details like name and workload
- **PROFESSOR** (Professor): Professor information with average ratings
- **ALUNO** (Student): Student data
- **AVALIA** (Evaluation): Student evaluations of professors
- **COMENTARIO** (Comment): Comments on evaluations

### Specialized Tables

- **CADEIRA_ELETIVA** (Elective Course): Tracks which courses are offered as electives
- **CADEIRA_OBRIGATORIA** (Mandatory Course): Manages mandatory courses and their monitors
- **PRE_REQUISITO** (Prerequisite): Defines course prerequisites
- **CONTATOS** (Contacts): Contact information for professors and monitors

## Explored Scenarios

- ✅ Two universities with exclusive disciplines
- ✅ Courses with and without monitors
- ✅ Mandatory and elective courses (some offered)
- ✅ Prerequisites from multiple disciplines
- ✅ Professors with average grades and varied contacts
- ✅ Students evaluating different professors in different courses
- ✅ Comments on evaluations with different opinions

## SQL Queries Demonstrated

The project includes various types of SQL operations:

### Basic Operations
- **GROUP BY / HAVING**: Calculate average evaluation grades per professor
- **INNER JOIN**: Link professors with their mandatory courses and monitors
- **OUTER JOIN**: Show all courses and their elective status

### Advanced Queries
- **SEMI JOIN**: Find students who evaluated professors with high grades
- **ANTI-JOIN**: Identify professors who never received evaluations
- **Subqueries**: 
  - Scalar: Find professor with highest average
  - Row: Get professor with lowest average
  - Table: Professors above general average
- **SET OPERATIONS**: Union of students who evaluated or commented

## Project Structure

```
DataBase-Project/
├── Logic.sql          # Complete database implementation
└── README.md         # Project documentation
```

## How to Run

1. Clone this repository
2. Open `Logic.sql` in your preferred SQL database management system
3. Execute the script to:
   - Create all tables with proper constraints
   - Insert sample data
   - Run example queries

## Key Features

- **Referential Integrity**: Proper foreign key relationships
- **Data Validation**: Check constraints for data consistency
- **Comprehensive Queries**: Examples of various SQL operations
- **Sample Data**: Realistic test data for demonstration

## Technologies Used

- SQL (Standard SQL with DDL, DML, and DQL operations)
- Relational Database Design Principles
- Entity-Relationship Modeling

## Team Members

| Name | Username |
|------|----------------|
| Artur Vinicius Pereira Fernandes | arturvpf |
| Ariel Sharon| asvl |
| Manoel Lira | mlc6|
| Valter Sanches | vsmn |
| Breno Ramos | brsg|
| Caio Cesar nascimento | ccnvb |

## License

This project is developed for educational purposes as part of a database course at UFPE (Universidade Federal de Pernambuco).

## Contributing

This is an academic project. For suggestions or improvements, please contact the team members.

---
*Developed as part of Database Systems course at UFPE (Universidade Federal de Pernambuco)*
