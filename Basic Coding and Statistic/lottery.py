from random import randint
digits=[7,6,5,4,3,2,1]
count=[1,2,3,6,12,6,2]
prize=["jackpot", "6digit1","5digit","4digit","3digit","2digit","amorti"]
F1=[]
def main():
    global F1
    global digits
    digits=sorted(digits,reverse=True)
    for i in range(len(count)):
        exp=False
        for r in range(count[i]):
            if exp==False:
                print(prize[i])
                exp=True
            tmp=makerandom(digits[i])
            print(tmp)
            F1.append(tmp)
            F1.append([prize[i]])
    tmp=checkprize()
    if tmp!="":
        print("you win",tmp)
    else:
        print("you lose")

            
            
        
def makerandom(digits):
    global F1
    while True:
        tmp=""
        for i in range(digits):
            tmp=tmp+str(randint(0,9))
        if not(tmp in F1):
            return tmp
            break
def checkprize():
    prz=""
    while True:
        try:
            print("enter",max(digits),"ticket number",)
            userin=input("")
            tmp=int(userin)
            
            if len(userin)==max(digits):
                break
            else:
                print("enter",max(digits),"digit number ticket")
        except:
            print(" please enter full number ticket")
            
            
    outr=False
    for i in range(len(F1)):
        if outr==True:
            break
        if i%2==0:
            for r in range(len(digits)):
                cutdigits=digits[r]
                if [F1]==userin[max(digits)-cutdigits]:
                    prz=F1[i+1][0]
                    outr=True
                    break
    return prz



main()

