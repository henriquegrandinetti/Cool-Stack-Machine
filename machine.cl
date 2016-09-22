(*
 *  machine.cl
 *
 *  DCC053 - Henrique Grandinetti Barbosa Amaral
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *
 *)

class StackMachine {
    stack : Stack;

    solve_top(command : String) {{
        (new StackCommand).apply_command(stack);
    }}
}
