defmodule Calc do


  #function to perform operation between two numbers
  def evaluate(num1,num2,sign) do

    result =0

    cond do
      sign == "*" ->
         result = num1 * num2
      sign == "/" ->
         result = div(num1,num2)
      sign == "+" ->
         result = num1 + num2
      sign == "-" ->
        result = num1 - num2

    end

      #result converted to string to push into operand list    
      _pushres = to_string(result)
      _pushres

  end #end of evaluate function 


  #function to calculate the last expression on the stack
  def calculate(operand,operator) do

    if ((length operator) != 0) do 
      sign = hd(operator)
      operator = tl(operator)

      operand = priorityEval(operand,sign)
      
      calculate(operand,operator)

    else
      
      #converting the end result to an integer
      totalRes = String.to_integer(List.first(operand))
      totalRes

    end

  end #end of calculate function


  #function to evaluate the expressions in-between Parenthesis
  def calcParen(operand,operator) do

    sign = hd(operator)
    oplist = tl(operator)
    
    #if the operator is not "("
    if(sign != "(") do
       if((length operand) !=0) do
         operand = priorityEval(operand,sign)
         calcParen(operand,oplist)

       end
    else

    #if the operator is "(", ignore that and consider rest of the operators
       operator = tl(operator)
       exp = [operand] ++ [operator]
       exp
    end

  end #end of calcParen function
  

  #function to send numbers on-top of operand stack to evaluate function
  def priorityEval(operand,sign) do

    num1= String.to_integer(hd(operand))
    operand = tl(operand)
    num2= String.to_integer(hd(operand))
    operand = tl(operand)

    answer = evaluate(num2,num1,sign)

    operand = [answer]++ operand
    operand

  end #end of priorityEval function

  
  # function to parse the expression
  def parseExp(explist,operand,operator) do

    if((length explist)!=0) do
       
       # Head of the explist
       item = hd(explist)

       
       # if it's a number
       if (Regex.match?(~r/^-*[0-9]+$/,item)) do
           
          operand = [item | operand]

       else
          #if the operator list is not empty
          if ((length operator) != 0) do

            cond do
              item == "(" ->
                 operator = ["(" | operator]
              
              #when the item is ")", evaluate the expression till "(" is encountered on #stack
              String.contains?(item, ")") ->

                 result = calcParen(operand,operator)
                 operand = List.first(result)
                 operator = List.last(result)

              #if multiplication or divison should be done
              item == "*" || item == "/" ->
                
                 #if top-of operator list is of lower precendece
                 if( List.first(operator) == "-" || List.first(operator) == "+" || List.first(operator) == "(") do

                  operator = [item | operator]

                 #if top-of list is of higher precendence

                 else

                  sign= hd(operator)
                  operator = tl(operator)

                  operand = priorityEval(operand,sign)
                  operator = [item | operator]

                 end

              #if addition or subtraction should be done

              item == "+" || item == "-" ->

                 #if top-of operator list is of lower precendece

                 if(List.first(operator) == "(") do

                  operator = [item | operator]
                
                 #if top-of list is of higher precendence
                 else

                  sign= hd(operator)
                  operator = tl(operator)


                  operand = priorityEval(operand,sign)
                  operator = [item | operator]

                 end

            end

          else

            operator = [item | operator]
          end

       end

       restlist = tl(explist)
       parseExp(restlist,operand,operator)
    else

       #when the expression list's items are put in either stacks
       totalRes = calculate(operand,operator)
       totalRes
    end
  end


  def eval(exp) do

     #list to hold operands in the expression
     operandstack=[]

     #list to hold operators in the expression
     operatorstack=[]

     #to insert spaces between parenthesis and operand
     expspaces = Regex.replace(~r/\(/, exp, "( ")
     expspaces = Regex.replace(~r/\)/, expspaces, " )")

     #split expression string on spaces
     explist=String.split(expspaces)

     #to parse the input from list to stacks
     result = parseExp(explist,operandstack,operatorstack)
     result

  end #end of eval function

  def main() do
    IO.gets("Please enter an arithmetic expression\n") 
    |> eval 
    |> IO.puts()

    main()
  end #end of main function

end #end of module