
sensorW=4000 
sensorH=3000
GSD=20 #in cm
GSDkm=GSD*0.00001 #converting km 
AlanW=GSDkm*sensorW #0.8km width per image
AlanH=GSDkm*sensorH #0.6km height per image
side=60 # in %
end=30 #in %
AreaW=12 #ground distance in km
AreaH=7  #ground distance in km
overw=100-side #kağıt üstünde ilk görüntünün uzunluğunun %100 ünü hesapladıktan sonra diğer görüntülerin %40'ını ekliyerek gittim.
overh=100-end  #İlk görüntüyü %100 almadım. tüm resimler için %70 olarak hesaplayıp yüksekliği üst üste bindirerek 7km'ye denk getirdim. o yüzden işlemlerde +1 kullanmadım heightta.
oran1=(AlanW*overw)/100 #içler dışlar çarpımıyla %'liklerin kaç ettiğini hesaplıyor.
oran2=(AlanH*overh)/100 #içler dışlar çarpımıyla %'liklerin kaç ettiğini hesaplıyor.
x1=AreaW-AlanW #+1 ilk resmi kağıt üstünde tam uzunluk olarak hesaplıdığım için ilk resmin tam uzunluğunu gerçek uzunluktan çıkarıyor
a1=x1/oran1 #kaç adet resim çektiğim.
b1=round(a1)#sayı küsüratlı çıkarsa yuvarlıyor (burda küsüratlı çıkmadı)
yatay=b1+1 #yatayda kaç görüntü olduğu (+1 çünkü ilk resmi %100 olarak ayrı bir görüntü olarak değerlendirdim)
a2=AreaH/oran2
b2=round(a2) #16,3 gibi bir sayı çıkıyor. 17'ye yuvarlıyor
düşey=b2+1
print(yatay,"yataydaki minimum görüntü sayısı")
print(düşey ,"düşeydeki minimum görüntü sayısı \n")
total=yatay*düşey
print(total,"toplam çekilmesi gereken minimum görüntü sayısı\n")

#Uçak görüntüyü alırken width için digital image üzerinden pixel koordinatı hesaplama
first=sensorW/2
list1=[first]
öteleme1=sensorW*overw/100 #her bir resimin principal pointi, width'in %40'ı kadar öteleniyor yana doğru.
for i in range(b1):
    first=first+öteleme1
    list1.append(first)

#Uçak görüntüyü alırken height için digital image üzerinden pixel koordinatı hesaplama
first2=sensorH/2
list2=[first2]
öteleme2=sensorH*overh/100 #her bir resmin principal pointi, height'ın %70'i kadar öteleniyor aşağıya doğru.
for i in range(b2): 
    first2=first2+öteleme2
    list2.append(first2)


# width ve height koordinatlarını yan yana koyarak 612 fotoğraf için 612 adet digital image koordinatı hesaplıyor.
ulx=3000
uly=3000

print("fotoğrafların çekildiği ground kordinatlar")
for i in range(b1+1):
    for j in range(b2+1):
        u=(list1[i]+ulx,list2[j]+uly) #pixel coodinate'te 0,0 pixeli groundta 3000,3000 denk geldiği için +3000 ekliyorum.
        print(u)
        







