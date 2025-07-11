```
if(today="sunday") {
    print holiday
}
else {
    print happy learning
}
```
```
if(expression) {
    expression=true
}
else {
    expression=false
}
```

- algorithm
* install git
1. you should be root user, otherwise it will fail

`id -u`: for root user root id is always zero and for normal user is it not zero

*install git
1. check root user or not
2. If not root user, exit the program and inform user to run with sudo access
3. If root user install git
```
root user id -u -> 0
normal user id -u -> not 0
```

#### Shell script by default it will not stop if is faces error, it is our responsibility to check for the error

```
exit status
$? -> stores previous command status
$? -> 0 -> previous command is success
$? -> not 0 -> previous command is failure
```

#### Functions
- you will keep some code inside function which is more often required, and call whenever you require
- functions will do some work on behalf of us and it will update what happened

```
FUNCTION_NAME() {
    here you write your functions and call whereever required
}

FUNCTION_NAME
```

- functions always needs input, then function will give output

- Log files are always important to know what happened

## Redirection
```
ls -l 1> ls.log
ls -l > ls.log
```

```
> -> it will only redirect only success output
1 -> success (1> or > both are same)
2 -> failure
ls -l &> ls.log -> success or failure
lss -l &> ls.log -> success or failure
> -> it will remove previous content and adds new content
>> -> it will not remove it will append
```

`date +%F-%H-%M-%S`

```
colors in shell scripting
\e[31m -> red
\e[32m -> green
\e[0m -> normal
```

`echo -e "\e[31m Hello World!!"`

`echo -e "\e[31m Hello, \e[0World"`

### Loops
- If you ask 10 packages to install
- I want to loop it, then install one by one

```
for(int i=0;i<100;i++){
    print i
}
```

```
for variable in list
do
   write your statement
done
```
sudo scriptname.sh git postfix mysql