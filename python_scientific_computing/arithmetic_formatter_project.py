def do_ex(left, right, operator):
    if operator not in "+-":
        raise Error("Operator must be '+' or '-'.")

    if operator == "+":
        calc = str(int(left) + int(right))
        return [calc, len(calc)]
    calc = str(int(left) - int(right))
    return [calc, len(calc)] 

def arithmetic_arranger(problems, show_answers=False):
    if len(problems) > 5:
        return "Error: Too many problems."

    top = []
    bottom = ["\n"]
    result_line = ["\n"]
    results = ["\n"]

    blank = "x"
    space = "?"*4 
    for pb in problems:
        left, right, op = pb.split()[0], pb.split()[2], pb.split()[1]
        #here : eval function makes step 8 fail?!
        #ANY functions breaks it


        if op!="+" and op!="-":
            return "Error: Operator must be '+' or '-'."
        elif (len(left) > 4) or (len(right) > 4):
            return "Error: Numbers cannot be more than four digits."
        elif not left.isdigit() or not right.isdigit():
            return "Error: Numbers must only contain digits."
        else:
            calc = do_ex(left,right,op)
            
            if len(left) == len(right):
                left = str(blank*2 + left + space)
                right = str(op + blank + right + space)
                r_l = str("-"*(len(left)-4) + space)
                r = str(blank*abs(len(left)-calc[1]-4) + calc[0] + space)
                top.append(left)
                bottom.append(right)
                result_line.append(r_l)
                results.append(r)
            elif len(left) > len(right):
                left = str(blank*2 + left + space)
                right = str(op + blank*abs((len(left)- len(right)-5)) + right + space)
                r_l = str("-"*(len(left) - 4) + space)
                r = str(blank*abs(len(left) - calc[1] - 4) + calc[0] + space)
                top.append(left)
                bottom.append(right)
                result_line.append(r_l)
                results.append(r)
            else:
                right = str(op + blank + right + space)
                left = str(blank*abs(len(right)-len(left)-4) + left + space)
                r_l = str("-"*abs(len(right)-4) + space)
                r = str(blank*abs(len(right)- calc[1] - 4) + calc[0] + space)
                top.append(left)
                bottom.append(right)
                result_line.append(r_l)
                results.append(r)

    top = top[:-1] + [top[-1].rstrip("?")]
    bottom = bottom[:-1] + [bottom[-1].rstrip("?")]
    result_line = result_line[:-1] + [result_line[-1].rstrip("?")]
    results = results[:-1] + [results[-1].rstrip("?")]
    

    #cleaning up the answer string
    answer = []
    answer += top + bottom + result_line
    if show_answers == True:
        answer += results

    answer = "".join(answer).replace("x", " ").replace("?", " ")

    return answer



print(f'\n{arithmetic_arranger(["3801 - 2", "123 + 49"])}')
print(f"\n{arithmetic_arranger(["1 + 2", "1 - 9380"])}")
print(f"\n{arithmetic_arranger(["3 + 855", "3801 - 2", "45 + 43", "123 + 49"])}")
print(f"\n{arithmetic_arranger(["11 + 4", "3801 - 2999", "1 + 2", "123 + 49", "1 - 9380"])}")
print(f"\n{arithmetic_arranger(["44 + 815", "909 - 2", "45 + 43", "123 + 49", "888 + 40", "653 + 87"])}")
print(f"\n{arithmetic_arranger(["3 / 855", "3801 - 2", "45 + 43", "123 + 49"])}")
print(f"\n{arithmetic_arranger(["24 + 85215", "3801 - 2", "45 + 43", "123 + 49"])}")
print(f"\n{arithmetic_arranger(["24 + 85215", "3801 - 2", "45 + 43", "123 + 49"])}")
print(f"\n{arithmetic_arranger(["3 + 855", "988 + 40"], True)}")
print(f"\n{arithmetic_arranger(["32 - 698", "1 - 3801", "45 + 43", "123 + 49", "988 + 40"], True)}")
