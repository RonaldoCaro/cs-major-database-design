# CS2 Austin Major – Database Project

This project focuses on designing and testing a relational database based on information from the **CS2 Austin Major**.  
The main goal was to apply **data normalization** and run SQL queries to explore insights about players and teams.

---

## 📂 Repository Structure
DATA DESIGN/
│── players.csv # Player data (name, nationality, role, rating, maps played)
│── teams.csv # Team data (name, stage started, stage ended, final position)
│── csaustingmajor-ERD.png # Entity-Relationship Diagram of the model
│── db.sql # SQL script to create the database

QUERIES/
│── QueriesAnswer.xlsx # Results of some executed queries
│── queries.sql # SQL queries used for testing

---

## 🎯 Project Goals
- Collect and organize information about **players** and **teams** from the Austin Major.  
- Apply **normalization** principles to create a clean relational database with minimal redundancy.  
- Run SQL queries to test the structure and validate the dataset.  

---

## 📊 Main Tables
### Players
- `player_id` (PK)  
- `name`  
- `nationality`  
- `role`  
- `maps_played`  
- `rating`  

### Teams
- `team_id` (PK)  
- `name`  
- `stage_started`  
- `stage_ended`  
- `final_position`  

---

## 🔎 Queries
Some of the queries implemented include:
- Listing players with the highest rating.  
- Joining players with their corresponding teams.  
- Ranking teams based on their final tournament position.  

Results are available in `QueriesAnswer.xlsx`.  

---

📌 Notes

This is an introductory project focused on practicing database design and normalization.
While the structure is simple, it provided hands-on experience with modeling, SQL queries, and documentation.
