
file=open('sayfa.txt','w')
satır='Student İD  QuestionID  Question  Right answer  Given answer\n'
file.write(satır)
line= '--------    ----------  --------  ----------    ---------\n'
file.write(line)
#getting student id
def İD():
    while True:
        global id
        id=int(input('Student ID'))
        # for 3-digit number
        if id>=100 and id<=999:
            askQuestion()
            break
        else:
            print('İD must be a 3-digit number')

def askQuestion():
    #random calculations
    import random
    import operator
    ops={'+':operator.add,
         '-':operator.sub,
         '*':operator.mul,
         '/':operator.truediv}
    num1=random.randint(1,100)
    num2=random.randint(1,100)
    op=random.choice(list(ops.keys()))
    #students answers
    answer=ops.get(op)(num1,num2)
    user=int(input('what is {} {} {}? \n'. format(num1,op,num2)))
    while True:
        if user == answer:
            print('correct')
            #make a desicion other question or other student
            global counter , id
            counter +=1
            line=str(id) + '\t\t' +str(counter)+ '\t\t'+str(num1)+ ''+op+''+str(num2)+'\t\t'+str(answer)+'\t\t'+str(user)+'\n'
            file.write(line)                                                                                                                         
            otherquest=str(input('other question (y/n):'))
        
            if otherquest=='y':
                return askQuestion()
            elif otherquest=='n':
                otherstudent=str(input('other student(y/n):'))
                print(otherstudent)
                if otherstudent=='y':
                    return İD()
                break
            else:
                break

        elif user !=answer:
            print('wrong answer')
            counter+=1
            line=str(id) + '\t\t' +str(counter)+ '\t\t'+str(num1)+ ''+op+''+str(num2)+'\t\t'+str(answer)+'\t\t'+str(user)+'\n'
            file.write(line)                                                                                                                          
            otherquest=str(input('next question(y/n):'))
            if otherquest=='y':
                return askQuestion()
            elif otherquest=='n':
                otherstudent=str(input('next student(y/n):'))
                print(otherstudent)
                if otherstudent=='y':
                    return İD()
                
                else:
                    break
            
    else:
        print('not a valid answer')
#değişkeni değişikliğe uğratmak için global
global counter
counter = 0   #satır numarası için                                                                                                                                   
İD()
file.close()
