# Flex Space Project
With this project, you can create a set of isolated workspaces for a large number of users. You can use both ready-made templates for workspaces, and use your own.

## 1. Install project
*Note: for the project to work, you must have docker and docker-compose installed*

Clone the repository

`git clone https://github.com/jurapro/flex-space`

Allow script execution

`sudo chmod u+r -R ./scripts`

## 2. Project Structure

| Directory | Description |
| -----|------|
| tamplates | Directory with workspace templates |
| users | Directory with user workspaces |
| scripts | Directory with helper scripts |

## 3. Adding a new user

When adding a new user, the directory with the template is copied, and the user's parameters are set in the .env file:

1. USER_LOGIN - user login (can be set via command parameter)
2. USER_PASSWORD - user password (can be set via command parameter)
3. DB_NAME - database name (generated based on user login)
4. USER_DB_PASSWORD - database superuser password (same as user password)
5. SSH_PORT_M1 - access port via ssh for the container 'module1' (random generated from free ones). The access login and password is the same as the user login and password for all containers
6. WEB_PORT - Web port to the proxy container. Web access to other containers is done through it.
7. Etc. depending on template...

*Note: All parameters can be changed manually in the corresponding .env file*

Adding a new user with a random username and password using the default template

`./scripts/adduser.sh`

Adding a new user with a random username and password using the specified template

`./scripts/adduser.sh template=api`

Adding a new user with the specified login and password using the specified template

`/scripts/adduser.sh template=api user=newuser password=12345`

*Note: the order of the parameters does not matter*

## 4. Building users workspaces

Building all workspaces from the users directory

`./scripts/builduser.sh all`

Building a specific container for all users

`./scripts/builduser.sh all module1`

Build the specified user's workspace

`./scripts/builduser.sh user=newuser`

Build the specified container for the specified user

`./scripts/builduser.sh user=newuser module=module1`

`./scripts/builduser.sh user=newuser module=module1 cache=--no-cache`

*Note: commands are wrappers for a command 'docker-compose build'*

## 5. Building and run users workspaces

Building and run all workspaces from the users directory

`./scripts/upuser.sh all`

Building and run a specific container for all users

`./scripts/upuser.sh all module1`

Building and run the specified user's workspace

`./scripts/upuser.sh user=newuser`

Building and run the specified container for the specified user

`./scripts/upuser.sh user=newuser module=module1`

*Note: commands are wrappers for a command 'docker-compose up -d'*

## 6. Stoping users workspaces

Stoping all workspaces from the users directory

`./scripts/stopuser.sh all`

Stoping a specific container for all users

`./scripts/stopuser.sh all module1`

Stoping the specified user's workspace

`./scripts/stopuser.sh user=newuser`

Stoping the specified container for the specified user

`./scripts/stopuser.sh user=newuser module=module1`

*Note: commands are wrappers for a command 'docker-compose stop'*

## 7. Stoping and removes users workspaces

Stoping and removes all workspaces from the users directory

`./scripts/downuser.sh all`

Stoping and removes a specific container for all users

`./scripts/downuser.sh all module1`

Stoping and removes the specified user's workspace

`./scripts/downuser.sh user=newuser`

Stoping and removes the specified container for the specified user

`./scripts/downuser.sh user=newuser module=module1`

*Note: commands are wrappers for a command 'docker-compose down'*

## 8. Show current users workspaces

Show current users workspaces from the users directory

`./scripts/psuser.sh all`

Show the specified user's workspace

`./scripts/psuser.sh user=newuser`

*Note: commands are wrappers for a command 'docker-compose ps'*