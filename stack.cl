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
    }};
 };
