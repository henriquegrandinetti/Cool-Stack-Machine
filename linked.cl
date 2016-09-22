
(*
 *  stack.cl
 *
 *  DCC053 - Henrique Grandinetti Barbosa Amaral
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *
 *)

-- Implements a Stack
class Stack inherits IO {

    -- Implements empty Stack
    isEmpty() : Bool { true };

    -- Returns empty string, element on top
    top()  : String { { abort(); ""; } };

    -- Removes top item
    pop()  : Stack { { abort(); self; } };

    -- Add element to list
    push(i : String) : Stack {
       (new StackItem).init(i, self)
    };

    print() : Object {
        out_string("\n")
    };
 };

class StackItem inherits Stack {

    car : String;   -- Item

    cdr : Stack;    -- The rest of the stack

    isEmpty() : Bool { false };

    top()  : String { car };

    pop()  : Stack { cdr };

    init(i : String, rest : Stack) : Stack {{
        car <- i;
        cdr <- rest;
        self;
    }};

    print() : Object {{
        out_string(top());
        out_string(" ");
        pop().print();
    }};

 };

class Main inherits IO {

    stack : Stack;
    stackCommand : StackCommand;

    main() : Object {{
        stack <- new Stack;
        stackCommand <- new StackCommand;

        while true loop {
            let input : String <- in_string() in {
                stack <- stackCommand.readCommand(stack, input);
            };
        } pool;

        (*let counter : Int <- 0 in
            while (counter < 5) loop {
                stack <- stack.push((new A2I).i2a(counter));
                counter <- counter + 1;
                stack.print();
            } pool;

        while (not stack.isEmpty()) loop {
            stack.print();
            stack <- stack.pop();
        } pool;*)
    }};
 };
(*
   The class A2I provides integer-to-string and string-to-integer
conversion routines.  To use these routines, either inherit them
in the class where needed, have a dummy variable bound to
something of type A2I, or simpl write (new A2I).method(argument).
*)


(*
   c2i   Converts a 1-character string to an integer.  Aborts
         if the string is not "0" through "9"
*)
class A2I {

     c2i(char : String) : Int {
	if char = "0" then 0 else
	if char = "1" then 1 else
	if char = "2" then 2 else
        if char = "3" then 3 else
        if char = "4" then 4 else
        if char = "5" then 5 else
        if char = "6" then 6 else
        if char = "7" then 7 else
        if char = "8" then 8 else
        if char = "9" then 9 else
        { abort(); 0; }  -- the 0 is needed to satisfy the typchecker
        fi fi fi fi fi fi fi fi fi fi
     };

(*
   i2c is the inverse of c2i.
*)
     i2c(i : Int) : String {
	if i = 0 then "0" else
	if i = 1 then "1" else
	if i = 2 then "2" else
	if i = 3 then "3" else
	if i = 4 then "4" else
	if i = 5 then "5" else
	if i = 6 then "6" else
	if i = 7 then "7" else
	if i = 8 then "8" else
	if i = 9 then "9" else
	{ abort(); ""; }  -- the "" is needed to satisfy the typchecker
        fi fi fi fi fi fi fi fi fi fi
     };

(*
   a2i converts an ASCII string into an integer.  The empty string
is converted to 0.  Signed and unsigned strings are handled.  The
method aborts if the string does not represent an integer.  Very
long strings of digits produce strange answers because of arithmetic 
overflow.

*)
     a2i(s : String) : Int {
        if s.length() = 0 then 0 else
	if s.substr(0,1) = "-" then ~a2i_aux(s.substr(1,s.length()-1)) else
        if s.substr(0,1) = "+" then a2i_aux(s.substr(1,s.length()-1)) else
           a2i_aux(s)
        fi fi fi
     };

(*
  a2i_aux converts the usigned portion of the string.  As a programming
example, this method is written iteratively.
*)
     a2i_aux(s : String) : Int {
	(let int : Int <- 0 in	
           {	
               (let j : Int <- s.length() in
	          (let i : Int <- 0 in
		    while i < j loop
			{
			    int <- int * 10 + c2i(s.substr(i,1));
			    i <- i + 1;
			}
		    pool
		  )
	       );
              int;
	    }
        )
     };

(*
    i2a converts an integer to a string.  Positive and negative 
numbers are handled correctly.  
*)
    i2a(i : Int) : String {
	if i = 0 then "0" else 
        if 0 < i then i2a_aux(i) else
          "-".concat(i2a_aux(i * ~1)) 
        fi fi
    };
	
(*
    i2a_aux is an example using recursion.
*)		
    i2a_aux(i : Int) : String {
        if i = 0 then "" else 
	    (let next : Int <- i / 10 in
		i2a_aux(next).concat(i2c(i - next * 10))
	    )
        fi
    };

};
(*
 *  commands.cl
 *
 *  DCC053 - Henrique Grandinetti Barbosa Amaral
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *
 *)

class StackCommand {
    readCommand(stack : Stack, command : String) : Stack {{
        if command = "d" then
            stack.print()
        else if command = "e" then {
            if stack.top() = "+" then
                let sum : Int in {
                    stack <- stack.pop();  -- remove +
                    sum <- (new A2I).a2i(stack.top());  -- add first operand
                    stack <- stack.pop(); -- remove first operand
                    sum <- sum + (new A2I).a2i(stack.top()); -- add second operand
                    stack <- stack.pop(); -- remove second operand
                    stack <- stack.push((new A2I).i2a(sum));
                }
            else if stack.top() = "s" then
                let temp1 : String, temp2 : String in {
                    stack <- stack.pop();  -- remove s
                    temp1 <- stack.top();
                    stack <- stack.pop();
                    temp2 <- stack.top();
                    stack <- stack.pop();

                    stack <- stack.push(temp1).push(temp2);
                }
            else
                stack
            fi fi;
        }
        else
            stack <- stack.push(command)
        fi fi;
        stack;
    }};
};
