# Welcome to My Basecamp2 App
MyBaseCamp2 is a web-based project management tool developed using Ruby on Rails framework. 
It allows users to create and manage projects.

# Basecamp URL
https://mybasecampv2.fly.dev

# Admin Login
email: admin@admin.com

password: 123456

## Task
Features
User Registration
Users can create, view, and delete their accounts.

Attachment
Users associated with the project can create attachments. Attachments can be stored in any format (e.g., png, jpg, pdf, txt) and can be displayed on the project#show page.

Session
Users can log in and log out of their accounts.

Role Permission
Admin privileges can be granted or removed by an existing admin user.

Project
Users can create, view, edit, and delete projects. 

## Description
Project
Users can create, view, edit, and delete projects. 


Thread
Threads allow project admins to initiate discussions within a project.

Thread#new: Enables project admins to create new threads.
Thread#edit: Allows project admins to edit existing threads.
Thread#destroy: Permits project admins to delete threads.
Inside a Thread
Message
Users associated with the project can create messages within threads.

Message#new: Allows users to create new messages within a thread.
Message#edit: Allows users to edit their own messages.
Message#destroy: Allows users to delete their own messages.
User Roles and Permissions
Project Admin: Project admins have exclusive permissions to create threads.
All Users: All users associated with the project can create attachments and post messages in threads.

## Installation
Install Ruby on Rails framework.
Clone the repository from Github.
Navigate to the project directory and install the required gems.
Run the server.

## Usage
How to Set First Admin User from console 

    * rails console
    * @last_user = User.last.admin = true
    * @last_user.save

    Note: after admin is set subsequent users can be set from edit on admin panel

Run server

    bundle install

    rails server

    bundle exec puma -C config/puma.rb -b tcp://127.0.0.1:3001

```
./my_project Samuel Adebayo
```

### The Core Team

<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px'></span>
