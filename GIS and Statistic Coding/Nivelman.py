import matplotlib.pyplot as plt

a=int(input("kaç tane nokta var"))
list1=[]
list2=[]
for i in range(a-1):
    b=float(input("ölçülen geriyi giriniz lütfen"))
    r=float(input("ölçülen ileriyi giriniz lütfen"))
    k=b-r
    list1.append(k)
    
for i in range(a-2):
    c=list1[i-1]+list1[i]

print("1. nokta ve son nokta arası yükseklik farkı="+str(c))
print("geri-ileri sonuçları"+str(list1))

plt.show()

