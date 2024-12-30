# 3. Database Modernization

## Status
Proposed

## Context
Current database implementation in PIMS4:
- Uses deprecated mysql_* functions
- Custom database abstraction layer
- Basic transaction management
- Direct SQL queries
- Manual connection handling

Analysis of dbfunc.php shows:
- Custom connection pooling
- Basic query builder
- Manual SQL escaping
- Simple error handling

## Decision
Implement modern database layer using:

1. Doctrine DBAL (Database Abstraction Layer):
   - Replace mysql_* functions
   - Proper connection management
   - Prepared statements
   - Better transaction handling

2. Doctrine ORM (gradually):
   - Entity mapping for core tables
   - Repository pattern
   - Modern query builder
   - Migration system

3. Implementation Phases:
```php
// Phase 1: DBAL Implementation
use Doctrine\DBAL\DriverManager;

$connectionParams = [
    'dbname' => $_ENV['MARIADB_DATABASE'],
    'user' => $_ENV['MARIADB_USER'],
    'password' => $_ENV['MARIADB_PASSWORD'],
    'host' => $_ENV['MARIADB_HOST'],
    'driver' => 'pdo_mysql',
];

$connection = DriverManager::getConnection($connectionParams);

// Phase 2: Entity Mapping
/**
 * @Entity
 * @Table(name="products")
 */
class Product
{
    /**
     * @Id
     * @GeneratedValue
     * @Column(type="integer")
     */
    private $id;
    
    /**
     * @Column(type="string")
     */
    private $name;
}
```

## Rationale
1. Security:
   - Prepared statements prevent SQL injection
   - Better password/sensitive data handling
   - Proper connection management

2. Maintainability:
   - Type-safe database operations
   - Object-oriented approach
   - Better code organization

3. Performance:
   - Connection pooling
   - Query optimization
   - Efficient caching

## Implementation Strategy
1. Initial Setup:
   - Install Doctrine DBAL
   - Create connection configuration
   - Setup development environment

2. Migration Process:
   - Map existing database schema
   - Create entity classes
   - Implement repositories
   - Gradually replace legacy queries

3. Testing:
   - Unit tests for entities
   - Integration tests for repositories
   - Performance benchmarking

## Consequences
### Positive
- Modern, secure database access
- Better code organization
- Improved maintainability
- Type safety
- Better testing capabilities

### Negative
- Learning curve for team
- Migration effort required
- Temporary performance overhead
- Need to maintain both systems during transition

## Monitoring
- Track deprecated function usage
- Monitor query performance
- Document migration progress
- Regular team reviews
