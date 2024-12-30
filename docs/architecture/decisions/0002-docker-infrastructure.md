# 2. Docker Infrastructure

## Status
Proposed

## Context
The existing PIMS4 application has a basic Docker setup using Apache and MariaDB. We need to enhance this for modern development practices while ensuring smooth team collaboration.

Current setup:
- PHP 8.1 with Apache
- MariaDB 10.11
- Basic volume mapping
- PHPMyAdmin for database management

## Decision
Enhance Docker infrastructure with:

1. Base Services:
```yaml
services:
  php-fpm:
    build: 
      context: ./docker/php
      target: ${APP_ENV}
    volumes:
      - ./src:/var/www/html

  nginx:
    image: nginx:alpine
    volumes:
      - ./src:/var/www/html
      - ./docker/nginx/conf.d:/etc/nginx/conf.d

  db:
    image: mariadb:10.11
    volumes:
      - db_data:/var/lib/mysql
```

2. Additional Services:
- Redis for caching
- RabbitMQ for message queue
- Improved backup service

3. Development Tools:
- Xdebug for debugging
- Development-specific PHP configuration
- Enhanced logging

## Rationale
1. PHP-FPM + Nginx:
   - Better performance than Apache
   - More flexible configuration
   - Industry standard setup

2. Enhanced Services:
   - Redis improves performance
   - RabbitMQ enables async processing
   - Better development tools

3. Volume Management:
   - Persistent database storage
   - Efficient development workflow
   - Proper log management

## Consequences
### Positive
- Improved performance
- Better development experience
- More robust architecture
- Easier scaling

### Negative
- More complex setup
- Additional services to maintain
- Higher resource usage

## Implementation Plan
1. Create new Docker configurations
2. Test locally with development team
3. Document setup procedures
4. Plan production deployment
5. Create monitoring strategy

## Notes
- All configurations will be in version control
- Environment-specific settings via .env files
- Documentation maintained in /docs/docker/
