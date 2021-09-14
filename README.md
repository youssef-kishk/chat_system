# chat_system

## Description:
A simple chat system that allow adding, editing, deleting and searching for applications, chats and messages using different APIs allowed.

## Usage:
- Ruby 2.7.4
- Rails 5
- SideKiq workers (for handling concurrency)
- ElasticSearch (for searching messages body)
- Mysql
- Redis (for local storage)

## Database structure:
<img src="https://github.com/youssef-kishk/chat_system/blob/main/DB_structure.png" width="600" height="400" />
 </p>
 
 ## APIs:
 
 ### Applications
 - Get all applications:
 
    - **URL** : `/applications`

    - **Method** : `GET`

    - **Data constraints** : `{}`

 - Get application by token:
 
    - **URL** : `/applications/[token]`

    - **Method** : `GET`

    - **Data constraints** : `{}`


 - Add application:
 
    - **URL** : `/applications`

    - **Method** : `POST`

    - **Data constraints** : `{ "name": 'test' }`

 - Delete application:
 
    - **URL** : `/applications/[token]`

    - **Method** : `Delete`

    - **Data constraints** : `{}`

 - Edit application:
 
    - **URL** : `/applications/[token]`

    - **Method** : `PUT`

    - **Data constraints** : `{ "name": 'test' }`


### Chats
 - Get all application chats:
 
    - **URL** : `/applications/[token]/chats`

    - **Method** : `GET`

    - **Data constraints** : `{}`

 - Get chat by its number:
 
    - **URL** : `/applications/[token]/chats/number`

    - **Method** : `GET`

    - **Data constraints** : `{}`


 - Add chat:
 
    - **URL** : `/applications/[token]/chats`

    - **Method** : `POST`

    - **Data constraints** : `{}`

 - Delete chat:
 
    - **URL** : `/applications/[token]/chats/number`

    - **Method** : `Delete`

    - **Data constraints** : `{}`


### Messages
 - Get all application chat messages:
 
    - **URL** : `/applications/[token]/chats/[number]/messages`

    - **Method** : `GET`

    - **Data constraints** : `{}`

 - Get message by its number:
 
    - **URL** : `/applications/[token]/chats/[number]/messages/[number]`

    - **Method** : `GET`

    - **Data constraints** : `{}`


 - Add message:
 
    - **URL** : `/applications/[token]/chats/[number]/messages`

    - **Method** : `POST`

    - **Data constraints** : `{ "body": 'test' }`

 - Delete message:
 
    - **URL** : `/applications/[token]/chats/[number]/messages/[number]`

    - **Method** : `Delete`

    - **Data constraints** : `{}`

 - Edit message:
 
    - **URL** : `/applications/[token]/chats/[number]/messages/[number]`

    - **Method** : `PUT`

    - **Data constraints** : `{ "body": 'test' }`

 - Search message body:
 
    - **URL** : `/applications/[token]/chats/[number]/messages/search`

    - **Method** : `POST`

    - **Data constraints** : `{ "search_body": 'test' }`

## Running:
- **cd chat_system**
- **./run.sh**
    - Apllication runs on port 3002 [http://localhost:3002/]

In order to test the **messages/search** API responsible for seaching through messages body, make sure Elastic search is running in your machine:
- For linux envirnoment you can use: [**./elastic_search.sh**]


## To be done:
- Using docker so the app is containerized.
- Add more documentation (Swagger, Postman collection).
- Testing
