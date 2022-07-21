# Flex Space Project
With this project, you can create a set of isolated workspaces for a large number of users. You can use both ready-made templates for workspaces, and use your own.

## Install project
*Note: for the project to work, you must have docker and docker-compose installed*

Clone the repository

`git clone https://github.com/jurapro/flex-space`

Allow script execution

`sudo chmod u+r -R ./scripts`

## Project Structure

| Directory | Description |
| -----|------|
| tamplates | Directory with workspace templates |
| users | Directory with user workspaces |
| scripts | Directory with helper scripts |

## Adding a new user

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

## Building users workspaces

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