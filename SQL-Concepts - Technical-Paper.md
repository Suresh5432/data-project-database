# SQL Concepts – Technical Paper
---
## 1. ACID
ACID properties helps the databases perform transactions normally
### Atomicity
Atomicity means a transaction is treated as one complete unit.
Either all operations succeed or all operations fail.
For example, during a money transfer, deducting money from one account and adding it to another should happen together.
### Consistency
Consistency ensures that a transaction moves the database from one valid state to another valid state.
### Isolation
one transaction should not incorrectly interfere with another transaction that is executing at the same time.
### Durability
- Durability means that once a transaction has been successfully committed, its changes should remain stored even if the database or system crashes afterward.
---
## 2. CAP Theorem
CAP theorem is mainly associated with distributed data systems.
CAP stands for:
- **Consistency**
- **Availability**
- **Partition Tolerance**
### Consistency
Every node should provide a sufficiently consistent view of the latest data according to the system's consistency model.
### Availability
Every request to a functioning node receives a response, although that response is not necessarily the latest data.
### Partition Tolerance
- The distributed system continues operating even when communication between some nodes is interrupted.
During a network partition, a distributed system generally has to make a trade-off between consistency and availability.
---
## 3. Joins
Joins combine related information from multiple tables.
### INNER JOIN
Returns rows that have matching values in both tables.
### LEFT JOIN
Returns all rows from the left table and matching rows from the right table.
### RIGHT JOIN
Returns all rows from the right table and matching rows from the left table.
### FULL OUTER JOIN
Returns all matching and non-matching rows from both tables.
### CROSS JOIN
Returns every possible combination of rows between two tables.
### SELF JOIN
- A self join joins a table with itself.
- It can be useful when rows inside the same table have relationships with other rows in that table.
---
## 4. Aggregations and Filters
### Aggregate Functions
Aggregate functions calculate a result from multiple rows.
Important aggregate functions include:
```text
COUNT()
SUM()
AVG()
MIN()
MAX()
```
Example:
```sql
SELECT season,
       COUNT(*) AS matches
FROM matchesdata
GROUP BY season;
```
### WHERE
`WHERE` filters individual rows before grouping takes place.
```sql
SELECT *
FROM matchesdata
WHERE season = 2016;
```
### GROUP BY
`GROUP BY` groups rows containing the same values so aggregate functions can be applied to each group.
```sql
SELECT winner,
       COUNT(*)
FROM matchesdata
GROUP BY winner;
```
### HAVING
`HAVING` filters groups after `GROUP BY`.
```sql
SELECT winner,
       COUNT(*) AS wins
FROM matchesdata
GROUP BY winner
HAVING COUNT(*) > 20;
```
---
## 5. Normalization
Normalization helps organizes relational data to reduce unnecessary duplication and avoid modification anomalies.
### First Normal Form – 1NF
A table should:
- Have atomic values and Store one value in each field.
### Second Normal Form – 2NF
A table must:
- Be in 1NF.
- Have no partial dependency of a non-key attribute on only part of a composite candidate key.
### Third Normal Form – 3NF
A table must:
- Be in 2NF.
- Avoid inappropriate transitive dependencies of non-key attributes on keys.
### BCNF
- BCNF is stronger than 3NF.
- For every non-trivial functional dependency:
---
## 6. Indexes
- An index is a database structure that helps PostgreSQL locate rows efficiently without always scanning every row of a table.
Without a useful index, PostgreSQL may perform a sequential scan.
With an appropriate index, PostgreSQL may be able to find the required rows much faster.
---
## 7. Transactions
- A transaction groups database operations into one logical unit of work.
- Transactions are fundamental for maintaining data correctness when multiple related changes must succeed together.
---
## 8. Locking Mechanism
Locks help databases safely manage concurrent access to shared data.
Locks can exist at different levels, including:
- Row-level locks
- Table-level locks
Locks help prevent conflicting operations, but poor locking strategies can cause problems such as:
- Blocking
- Deadlocks
- Reduced performance
---
## 9. Database Isolation Levels
Isolation levels determine how much one transaction can observe the effects of other concurrent transactions.
The standard SQL isolation levels are:
### Read Uncommitted
Provides the weakest isolation in the SQL standard and can allow dirty reads.
### Read Committed
A query sees only data committed before that query begins.
This is PostgreSQL's default isolation level.
### Repeatable Read
Provides a stable snapshot for the transaction, so repeated reads do not normally observe changes committed by other transactions after the transaction's snapshot was established.
## Serializable
- Provides the strongest isolation level.
- The result should be equivalent to transactions having executed serially in some order.
---
## 10. Triggers
A trigger automatically executes a trigger function when a specified database event occurs.
