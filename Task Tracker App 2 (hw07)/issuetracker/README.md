# Issuetracker

http://tasks2.rachnareddym.com/

Flow of the application:
1. User should register with name, email ID and Manager he/she reports to.
2. On clicking submit on the registration form, the user can also edit the
   entered details by clicking "edit" or can login to the app by clicking on
   "Log In".
3. Upon registration, the user details along with implicitly generated user ID
   are stored in the users table. This users table can be viewed,edited or
   deleted by visiting tasks1.rachnareddym.com/users. However, this is not
   accessible to the end user.
4. User may view his/her profile details by clicking on the "My Profile" link on the header.
5. Profile page displays the User details and details of the user's reportees.
6. With the registered email ID, user can login and see the tasks assigned to him and assigned
   by him by clicking on "Go to tasks" link on the application.
7. By clicking the "Details" link of any one of the task, the user can view the details and 
   also can do the following:
   --> Click on "Add Time Block" button, to add a new time instance for that task.
   --> In the table displayed, user can click on "Start time" button to start the timer for the task.
   --> In the table displayed, user can click on "End time" button to end the timer for the task of that time instance.
   --> In the table displayed, user can click on "Delete record" button to remove the time instance from the table.

8. By clicking on the "Add Task" button on tasks, user can create and assign a task only to his reportees.
9. Title, Description, Assignee(Dropdown) are mandatory fields.
   --> Title : holds the title of the tasks
   --> Description : holds the detailed description of the tasks
   --> Assignor : Owner of the task. This is pre-loaded with name of
                  the logged-in user.
   --> Assignee : A dropdown that consists of all the registered users in the system.
   --> Completed : Set to default as false. Should be marked once the assignee
                   completes the task.
10. Once the submit is clicked, the task is created and the details are displayed.
11. On this page, user can edit the created task by clicking on "edit" or can go
   to the tasks listing by clicking on "back".
12. These task details are stored on the issues table on the database. These can
   also be viewed on the tasks1.rachnareddym.com/issues.
13. User can log out by clicking on the "log out" button on the header.
