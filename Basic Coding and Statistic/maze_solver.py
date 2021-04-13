from stack import Stack
import random
class Maze:
    def __init__(self,filename):
        file=open(filename,'r')
        self.moves=[]
        self.fate={}
        self.MainStack=Stack()
        self.row=0
        self.col=0
        self.strow=0
        self.stcol=0
        self.erow=0
        self.ecol=0
        self.matris=[]
        s1=file.readline()        
        self.row=int(s1[:-1].split(' ')[0])
        self.col=int(s1[:-1].split(' ')[1])
        s1=file.readline()        
        self.srow=int(s1[:-1].split(' ')[0])
        self.scol=int(s1[:-1].split(' ')[1])
        s1=file.readline()        
        self.erow=int(s1[:-1].split(' ')[0])
        self.ecol=int(s1[:-1].split(' ')[1])         
        for i in range(self.row):
            self.matris.append(list(file.readline()[:-1]))
            print(self.matris[i])        
        file.close()

    def Solve(self,y,x):
        curry=y
        currx=x
        while True:

            if curry==self.erow and currx==self.ecol:
                for i in range(self.row):
                    print(self.matris[i])
                print("Done!")
                break            
            if currx+1<self.col:
                if self.matris[curry][currx+1]=='.':
                    self.MainStack.push([curry,currx])
                    self.matris[curry][currx]='x'
                    print('east')
                    currx+=1
                    continue
            if curry+1<self.row:
                if self.matris[curry+1][currx]=='.':
                    self.MainStack.push([curry,currx])
                    self.matris[curry][currx]='x'
                    print('south')
                    curry+=1
                    continue
            if currx-1>0:
                if self.matris[curry][currx-1]=='.':
                    self.MainStack.push([curry,currx])
                    self.matris[curry][currx]='x'
                    print('west')
                    currx-=1
                    continue
            if curry-1>0:
            
                if self.matris[curry-1][currx]=='.':
                    self.MainStack.push([curry,currx])
                    self.matris[curry][currx]='x'
                    print('north')
                    curry-=1
                    continue
            if self.MainStack.isEmpty()==False:                
                self.matris[curry][currx]='D'
                print(curry,currx)
                if curry==self.ecol and currx==self.erow:
                    print("Done!")
                    break            
                [curry,currx]=self.MainStack.pop()
                print("No Way!")
                continue
             
M1=Maze('maze.txt')
M1.Solve(M1.srow,M1.scol)



