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
