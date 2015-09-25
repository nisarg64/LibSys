# LibSys : A Ruby on Rails Application

## Admin Credentials:
Admin Email : admin@ncsu.edu
Admin Password : admin

## New Admin/Member Signup:

* Password should be minimum 5 characters long
* Only Valid email addresses allowed
* Passwords are encrypted and stored in database for security reasons

## Assumptions:

* If a book is checked out, admin won't be able to delete the book until it is available.
* If a library member has an outstanding book which he/she has not returned, admin won't be able to delete that member.
* If a book is deleted by an admin, it won't show up in any member's(who checked out that book at some point of time) checkout history.
* If a member is deleted by an admin, he/she won't show up in any book's(which he/she has checked out at some point of time) checkout history.
* Any user (admin/member) can see the list of all books and search them based on ISBN(exact match), title, description, author, book status using a single input field.
* If an admin wants to assume a role of Library Member, he/she has to sign up as a library member.
* Members can return their outstanding books from their self checkout history page.
* Admins can checkout/return a book on behalf of a library member when viewing details of the book.
