# Test-task

### Architecture
In this test task, I used the architectural pattern of **MVP**.
I used this pattern, as it allows to move the business logic from **Controller** to **Presenter**.

I was still looking at the **Clean** architecture pattern, but rejected this variant, as it is intended for use in larger projects. 
The main disadvantage of the **Clean** is that its implementation requires the creation of many classes/files.

### Frameworks
I used an external **SDWebImage** framework in the project. 
This library is used to download and cache images.

I didn’t add **gitignore** file so you don’t need to install pods.
But if for some reason you see some pods errors in Xcode, remove the Pods folder from your project and install the pods again.

### Notes
I didn't implement getting favourites movies and add to favourites. 

For **fetch my favourite movies** you need **account_id**. 
To receive it, you need to make a **request Get Details** where should substitute **session_id**. **request_token** required for **request Create Session**. 
A **request Create Request Token** must be made to receive a **token**. 

As a result, it takes 4 requests to get my favourite movies, and the additional request for add a movie to favourites. 

This would take much more time than suggested in the task. 
So I've skipped it for now.

