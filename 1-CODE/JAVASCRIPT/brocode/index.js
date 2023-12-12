console.log("I like AWS");
console.log("I like AWS CF");
//window.alert("I really love AWS CF!");
//comment
/*comment
too
*/
let firstname = "Syed Azam";
let lastname = "Sajjad";
let age;
age = 34;

let student = false;

age = age + 1;

console.log("Hello",firstname);
console.log("You are",age,"years old");
console.log("Enrolled:",student);

document.getElementById("p1").innerHTML = "Hello, " + firstname + lastname;
document.getElementById("p2").innerHTML = "You are " + age + " years old";
document.getElementById("p3").innerHTML = "Enrolled: " + student;

let students = 20;
students += 11;
let extrastudents = students % 3; //storing remainder with modulus operator
console.log(extrastudents);

/*how to accept user input
EASY WAY with a window prompt

let username = window.prompt("what's your name?")
console.log(username);

DIFFICULT WAY with HTML Textbox
*/
let username;
document.getElementById("myButton").onclick = function(){

    username = document.getElementById("myText").value;
    console.log(username);
    document.getElementById("myLabel").innerHTML = "Hello, " + username;
}


/*
Type Conversion = change the datatype of a value to another
                   (strings, numbers, booleans)

*/

// let ages = window.prompt("How old are you?");
// ages = Number(age); //number constructor
// ages += 1;

// console.log("Your age will be",age,"when you apply PR");


let x;
let y;
let z;

x = Number("3.14"); // if x = Number("pizza") => NAN not a number
y = String(3.14);
z = Boolean(""); //empty=false, anything written=true

console.log(x, typeof x);
console.log(y, typeof y);
console.log(z, typeof z);


// const = a variable that cannot be changed
// cant be re-assigned
/*
const PI = 3.14159;
let radius;
let circumference;

radius = window.prompt("Enter the Radius of a circle");
radius = Number(radius);

circumference = 2 * PI * radius;
console.log("The Circumference is:", circumference);
*/


// Math Built-in function
// lets round off a value

let xx = 3.74;
let yy = 5;
let zz = 9;
let maximum;
let minimum;
// xx = Math.round(xx);
// xx = Math.floor(xx); //round off to low number
// xx = Math.ceil(xx); // round off to high number
// xx = Math.pow(x, 2); //x to the power of 2
// xx = Math.sqrt(x); // square root
xx = Math.abs(x); //distance from 0 , always positive number

xx = Math.PI; // xx redefined with built-in Constant
maximum = Math.max(xx, yy, zz);
minimum = Math.min(xx, yy, zz);

console.log(xx);
console.log(maximum,minimum);




// calculate perpendicular
let a;
let b;
let c;
/*
a = window.prompt("Enter Side A");
a = Number(a);

b = window.prompt("Enter Side B");
b = Number(b);

c = Math.pow(a, 2) + Math.pow(b, 2);
c = Math.sqrt(c);

console.log("Side C =", c);
*/

document.getElementById("cbutton").onclick = function() {
    a = document.getElementById("aText").value;
    a = Number(a);

    a = document.getElementById("bText").value;
    b = Number(b);

    c = Math.sqrt(Math.pow(a, 2) + Math.pow(b, 2));

    document.getElementById("cLabel").innerHTML = "Side C: " + c;
}





// make a counter on website

let count = 0;
document.getElementById("debutton").onclick = function() {
    count-=1;
    document.getElementById("countlabel").innerHTML = count;

}
document.getElementById("rebutton").onclick = function() {
    count=0;
    document.getElementById("countlabel").innerHTML = count;

}
document.getElementById("inbutton").onclick = function() {
    count+=1;
    document.getElementById("countlabel").innerHTML = count;

}



// generate a random number by pressing a button

let r;
let rr;
let rrr;



document.getElementById("roll").onclick = function() {
   r = Math.floor(Math.random() * 6) + 1;
   rr = Math.floor(Math.random() * 6) + 1;
   rrr = Math.floor(Math.random() * 6) + 1;

   document.getElementById("rlabel").innerHTML = r;
   document.getElementById("rrlabel").innerHTML = rr;
   document.getElementById("rrrlabel").innerHTML = rrr;
}




// Useful String Properties & Methods

let userName = "azam sajjad";
let phoneNumber = "123-456-7890";

console.log(userName);
console.log(userName.length);
console.log(userName.charAt(0));
console.log(userName.indexOf("a"));

userName = userName.toUpperCase();
userName = userName.toLowerCase();

console.log(userName);
console.log(phoneNumber);

phoneNumber = phoneNumber.replaceAll("-", "");
console.log(phoneNumber);


// String Slice Method

let fullName = "Azam Sajjad";
let fName;
let lName;

// fName = fullName.slice(0, 9);
// lName = fullName.slice(10);
fName = fullName.slice(0, fullName.indexOf(" "));
lName = fullName.slice(fullName.indexOf(" ") + 1);

console.log(fName);
console.log(lName);

//Method Chaining

let USERNAME = "azam";
let letter = USERNAME.charAt(0).toUpperCase().trim()
console.log(letter);


// if Statements - Decision Making

let ages = 70;

if(18 >= ages < 65){
    console.log("You are an adult")
}
else if(ages < 0){
    console.log("YOU ARE INHUMAN!")
}
else if(ages >= 65){
    console.log("You are a senior")
}
else{
    console.log("you are a child")
}


// booleans with if

let online = false;
if(online){
    console.log("you are online")
}
else{
    console.log("you are offline")
}


// Subscribe Button

document.getElementById("subscribebutton").onclick = function() {
    
    const myCheckbox = document.getElementById("myCheckbox");
    const visaBtn = document.getElementById("visaBtn");
    const mastercardBtn = document.getElementById("mastercardBtn");
    const paypalBtn = document.getElementById("paypalBtn");
    
    if(document.getElementById("myCheckbox").checked){
        console.log("YOU ARE SUBSCRIBED")
    }
    else{
        console.log("YOU ARE NOT SUBSCRIBED")
    }


    if(visaBtn.checked){
        console.log("YOU ARE PAYING WITH VISA CARD")
    }
    else if(mastercardBtn.checked){
        console.log("YOU ARE PAYING WITH MASTERCARD")
    }
    else if(paypalBtn.checked){
        console.log("YOU ARE PAYING WITH PAYPAL")
    }
    else{
        console.log("You must Select a Payment Type")
    }
}


// Using switches instead of too many if else statements

let grade = "F";

switch(grade){
    case "A":
        console.log("You did great!");
        break;
    case "B":
        console.log("You did good!");
        break;
    case "C":
        console.log("You did nice!");
        break;
    case "D":
        console.log("You barely passed!");
        break;
    case "F":
        console.log("You failed!");
        break;
    default:
        console.log(grade, "is not a Letter Grade");
        break;
}

let graden = 50;

switch(true){
    case graden >= 90:
        console.log("You did great!");
        break;
        case graden >= 70:
        console.log("You did good!");
        break;
        case graden >= 60:
        console.log("You did nice!");
        break;
        case graden >= 50:
        console.log("You barely passed!");
        break;
    case graden < 50:
        console.log("You failed!");
        break;
    default:
        console.log(graden, "is not a Letter Grade");
        break;
}

// And Or


let temp = -5;
let sunny = true;

if(temp > 0 && temp < 30 && sunny){
    console.log("The Weather is Good!")
}
else{
    console.log("The Weather is Bad!")
}



// if(temp <= 0 || temp >= 30){
//     console.log("The Weather is Good!")
// }
// else{
//     console.log("The Weather is Bad!")
// }


// !NOT logical operator
// typically used to reverse a condition's boolean value


if(!(temp > 0)){
    console.log("Its cold outside");
}
else{
    console.log("its warm outside");
}

if(!sunny){
    console.log("Its cloudy outside");
}
else{
    console.log("its sunny outside");
}


// WHILE LOOP = repeat some code
// while some condition is true
// potentially infinite




// let UserName = "";

// while(UserName == ""){
//     UserName = window.prompt("Enter Your Name")
// }
// console.log("Hello", UserName);





// let UserName = "";

// while(UserName == "" || UserName == null){
//     UserName = window.prompt("Enter Your Name")
// }
// console.log("Hello", UserName);

// DO WHILE loop = do something, then check condition, repeat if true

// let UserName;

// do{
//     UserName = window.prompt("Enter Your Name")
// }while(UserName == "")
// console.log("Hello", UserName);





// FOR loop = repeat some code 
//              a certain amount of time

for(let counter = 1; counter <=5; counter+=1){
    console.log(counter);
}

for(let i = 10; i > 0; i-=2){
    console.log(i);
}
console.log("HAPPY NEW YEAR");





// CONTINUE AND BREAK 
// skip 13
for(let j = 1; j <= 20; j+=1){
    if(j == 13){
        continue;
    }
    console.log(j);
}


for(let k = 1; k <= 20; k+=1){
    if(k == 13){
        break;
    }
    console.log(k);
}
