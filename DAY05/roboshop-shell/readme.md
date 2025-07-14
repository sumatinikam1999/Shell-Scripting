1. create instance
2. update route 53 record

netstat -lntp

if id "roboshop" >/dev/null 2>&1; 
/dev/null is a special file in linux(and other unix like systems) that acts like a "black hole" for data. Anything written to it is discarded, and reading from it returns nothing. It's used to supress output you don't need.

The id "roboshop" command checks if the roboshop user exists. If the user exists, it output details(UID, GID);if not, it outputs an error.
By redirecting the output to /dev/null with >/dev/null, we throw away both the success output and any error messages, so they don't clutter the terminal or interfere with the script.
The 2&>1 part redirects error messages to the same place as standard output, which is already going to /dev/null. This ensures all output(success or error)is silenced.

#troubleshoot to check other side server is accessible or not
telnet  IP port
user->redis