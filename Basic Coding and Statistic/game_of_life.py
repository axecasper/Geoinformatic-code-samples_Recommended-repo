
import matplotlib.pyplot as plt # önce pip install matplotlib kur #arayüzün çalışması için gerekli import
class dosyaoku:
    def __init__(self,filename):
        self.veri=[]
        self.nextmatris=[] #orjinalden farklı oalrak ilerlemesi için açılmış boş bir liste
        self.msatır=0
        self.msütun=0
        mfile=open(filename,'r')
        a=mfile.readline() #açılan dosyayı satır satır okumak için readline.
        self.msatır=int(a[:-1].split(',')[0]) # dosyayı liste haline getirmek için araya virgül koyuyor.
        self.msütun=int(a[:-1].split(',')[1])        
        for i in range(self.msatır):
            a=mfile.readline()
            b=a.split(' ') #txt dosyamdaki string veriyi parçalıyor 
            c=[int(i) for i in b] # stringi sayısal veriye dönüştürmek için liste içinde
            self.veri.append(c) # boş listeme sayıları atarak txt dosyam python içinde liste halina geliyor.
        print(self.veri)
    def ölüdiribul(self,x,y):
        if x==self.msütun or y==self.msatır:
            return 0,0
        canlı=0
        mefta=0
        for i in range(-1,2): # 2 nin sebebi -1,1 aralığında(1 dahil bakmamız)
            if (x+i<0 or x+i>self.msütun-1): #sütunun dışına çıkıyorsa es geçtiriyo            
                continue
            for j in range(-1,2):
                if (y+j<0 or ((y-j==y)and (x-i==x)) or y+j>self.msatır-1): #satrın dışına çıkıyorsa es geçtiriyo                   
                    continue
                else:
                    if self.veri[j+y][x+i]==1:  #içi dolu kutuları buluyor(sarı renkli)
                        canlı+=1
                    else:                       #içi boş kutuları buluyor(mor renkli)
                        mefta+=1
        return canlı,mefta
    def çalıştır(self):
        self.nextmatris=[]
        for i in range(self.msatır):
                self.nextmatris.append([])
                for j in range(self.msütun):
                    self.nextmatris[i].append(self.veri[i][j])  #txt'yi güncelleyerek bir öncekine göre ilerletiyor orjinale göre değil.          
        while True:            
            for i in range(self.msütun):
                for j in range(self.msatır):
                    
                    
                    alive,dead=self.ölüdiribul(i,j) #içi dolu ve boşları belirliyor
                    if (self.veri[j][i]==1) and (alive==2 or alive ==3):
                        self.nextmatris[j][i]=1
                    else:
                        if  (self.veri[j][i]==0) and (alive==3):
                            self.nextmatris[j][i]=1
                        if  (self.veri[j][i]==1) and (alive==1 or alive<1):                            
                            self.nextmatris[j][i]=0
                        if  (self.veri[j][i]==1) and (alive==4 or alive>4):
                            self.nextmatris[j][i]=0
            self.veri=[]      
            for i in range(self.msatır):
                self.veri.append([])
                for j in range(self.msütun):
                    self.veri[i].append(self.nextmatris[i][j]) 
            plt.matshow(self.veri) #ara yüzü oluşturuyor
            plt.show()
oyun=dosyaoku('berk.txt')
oyun.çalıştır()
