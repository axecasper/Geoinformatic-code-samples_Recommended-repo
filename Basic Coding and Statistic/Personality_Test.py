#https://fwmail.net/testler/12-soruda-kisilik-testi
import tkinter as tk
def raise_frame(frame):
    frame.tkraise()
import tkinter.messagebox
pencere=tk.Tk()
f2 = tk.Frame(pencere)
f1 = tk.Frame(pencere)
v=tk.IntVar()
for frame in (f1, f2) :
    frame.grid(row=0, column=0, sticky='news')

tk.Button(f1, text="7-12. Sorulara geç", command=lambda:raise_frame(f2)).grid(row=0,column=0)
tk.Label(f1, text="1-6. sorular").grid(row=0,column=1)
tk.Label(f2, text='7-12. Sorular').grid(row=0,column=1)

tk.Button(f2, text='1-6. Sorulara geç', command=lambda:raise_frame(f1)).grid(row=0,column=0)





score=0
def addscore0():
    global score
    score+=0
def addscore1():
    
    global score
    score+=1
def addscore2():
    global score
    score+=2
def addscore3():
    global score
    score+=3
def addscore4():
    global score
    score+=4
def addscore5():
    global score
    score+=5
def addscore6():
    global score
    score+=6
def addscore7():
    global score
    score+=7

tk.giriş=tk.Label(f1,text="KİŞİLİĞİNİZİ ÖĞRENMEK İÇİN LÜTFEN SORULARI CEVAPLAYINIZ.",bg="Orange",fg="Blue")
tk.giriş.grid(row=1,column=0)
tk.giriş.config(font=("Courier", 14))
tk.giriş1=tk.Label(f2,text="HEM DE HEPSİNİ CEVAPLAYINIZ LÜTFEN.",bg="Orange",fg="Blue")
tk.giriş1.grid(row=1,column=0)
tk.giriş1.config(font=("Courier", 14))

def soru1():
    tk.soru_1=tk.Label(f1,text="1-) Çok kalabalık bir lokantada, sipariş vermek için bekliyorsunuz. Fakat garson sizi 15 dakikadır görmüyor.",bg="pink")
    tk.soru_1.grid(row=2,column=0)
    tk.soru_1.config(font=("Courier", 9))
    tk.Radiobutton(f1,indicatoron=0,text="A) Garsona seslenerek el sallar, dikkatini çekmeye çalışırsınız.",command=addscore5,value=1,variable="gr1",fg="purple",bg="yellow").grid(row=3,column=0)
    tk.Radiobutton(f1,indicatoron=0,text="B) Bir daha yanınızdan geçtiğinde nazikçe gülümser ve kibarca artık sipariş vermek istediğinizi söylersiniz." ,command=addscore2,value=2,variable="gr1",fg="purple",bg="yellow").grid(row=4,column=0)
    tk.Radiobutton(f1,indicatoron=0,text="C) Beklemeye devam edersiniz. Nasıl olsa bir ara sizi görüp gelecektir.",command=addscore1,value=3,fg="purple",bg="yellow",variable="gr1").grid(row=5,column=0)
def soru2():
    tk.soru_2=tk.Label(f1,text="2-) Haksızlık...",bg="pink")
    tk.soru_2.grid(row=6,column=0)
    tk.soru_2.config(font=("Courier", 9))
    tk.Radiobutton(f1,indicatoron=0,text="A)  ... sert bir biçimde cezalandırılmalıdır.",command=addscore6,value=4,fg="purple",bg="yellow",variable="gr2").grid(row=7,column=0)
    tk.Radiobutton(f1,indicatoron=0,text="B)  ... değiştirilemez, en mantıklısı göz yummaktır.",command=addscore2,value=5,fg="purple",bg="yellow",variable="gr2").grid(row=8,column=0)
    tk.Radiobutton(f1,indicatoron=0,text="C) ... karşısında elinizden hiçbir şey gelmez.",command=addscore1,fg="purple",value=6,bg="yellow",variable="gr2").grid(row=9,column=0)
def soru3():
    tk.soru_3=tk.Label(f1,text="3-) Çok keyifsiz bir gününüzdesiniz...",bg="pink")
    tk.soru_3.grid(row=10,column=0)
    tk.soru_3.config(font=("Courier", 9))
    tk.Radiobutton(f1,indicatoron=0,text="A) Sinirinizi gizlemeye çalışmaz, neye sinirlendiyseniz belli edersiniz. Böylece keyfiniz tekrar yerine gelir.",value=7,variable="gr3",command=addscore6,fg="purple",bg="yellow").grid(row=11,column=0)
    tk.Radiobutton(f1,indicatoron=0,text="B) Sıkıntınızı sadece yakın arkadaşlarınızla paylaşırsınız. Neşeli halinize geri dönmeniz biraz uzun sürebilir.",value=8,variable="gr3",command=addscore3,fg="purple",bg="yellow").grid(row=12,column=0)
    tk.Radiobutton(f1,indicatoron=0,text="C) Kendi kendinizi dinler, keyfinizi kaçıranın ne olduğunu çözersiniz. Keyfiniz zaten çok çabuk yerine gelir.",value=9,variable="gr3",command=addscore1,fg="purple",bg="yellow").grid(row=13,column=0)
def soru4():
    tk.soru_4=tk.Label(f1,text="4-)  En samimi kız arkadaşınız kuaförde saçlarını yaptırmış, fakat çok kötü görünüyor. Ona ne dersiniz?",bg="pink")
    tk.soru_4.grid(row=14,column=0)
    tk.soru_4.config(font=("Courier", 9))
    tk.Radiobutton(f1,indicatoron=0,text="A) Kuaföre mi gittin? Çok hoş olmuş' diyerek arkadaşınızın moralini bozmamaya çalışırsınız nasılsa olan olmuştur.",value=10,variable="gr4",command=addscore1,fg="purple",bg="yellow").grid(row=15,column=0)
    tk.Radiobutton(f1,indicatoron=0,text="B)'Hala en yakın arkadaşımsın' diyerek, hoş bir şekilde beğenmediğinizi anlatırsınız. ",variable="gr4",command=addscore2,value=11,fg="purple",bg="yellow").grid(row=16,column=0)
    tk.Radiobutton(f1,indicatoron=0,text="C) Eski saçların daha güzeldi' diyip net bir şekilde beğenmediğinizi ona söylersiniz.",value=12,variable="gr4",command=addscore4,fg="purple",bg="yellow").grid(row=17,column=0)
def soru5():
    tk.soru_5=tk.Label(f1,text="5-) Dostane ama sizi sürekli lafa tutan komşunuz, çok aceleniz varken size merdivenlerde rastlarsa... ",bg="pink")
    tk.soru_5.grid(row=18,column=0)
    tk.soru_5.config(font=("Courier", 9))
    tk.Radiobutton(f1,indicatoron=0,text="A) Onu sabırla dinler, lafını kesmezsiniz. Elbet bir ara diyecekleri bitecektir.",value=13,variable="gr5",command=addscore1,fg="purple",bg="yellow").grid(row=19,column=0)
    tk.Radiobutton(f1,indicatoron=0,text="B) Kibarca çok aceleniz olduğunu söyler, hızlı adımlarla uzaklaşırsınız.",value=14,variable="gr5",command=addscore6,fg="purple",bg="yellow").grid(row=20,column=0)
    tk.Radiobutton(f1,indicatoron=0,text="C) Konuşmayı çabucak bitirmesi için kestirme laflarla cevap verir, sizi lafa tutup engellediğini tavırlarınızla belli edersiniz.",value=15,variable="gr5",command=addscore3,fg="purple",bg="yellow").grid(row=21,column=0)
def soru6():
    tk.soru_6=tk.Label(f1,text="6-) Kayınvalideniz yaş gününüzde size çok zevksiz bir kazak hediye etti... ",bg="pink")
    tk.soru_6.grid(row=22,column=0)
    tk.soru_6.config(font=("Courier", 9))
    tk.Radiobutton(f1,indicatoron=0,text="A) Mutlaka teşekkür edersiniz, ama kazağınız dolabınızın en alt çekmecesinde yerini alır.",value=16,variable="gr6",command=addscore2,fg="purple",bg="yellow").grid(row=23,column=0)
    tk.Radiobutton(f1,indicatoron=0,text="B) Hemen içine bakıp, değiştirme kartı olup olmadığını kontrol edersiniz.",variable="gr6",value=17,command=addscore5,fg="purple",bg="yellow").grid(row=24,column=0)
    tk.Radiobutton(f1,indicatoron=0,text="C) Kayınvalidenizin sizin zevkinizi hala anlamamış olması canınızı sıkar ve gecenin ilerleyen saatlerinde bunu kendinize dert edersiniz.",value=18,variable="gr6",command=addscore0,fg="purple",bg="yellow").grid(row=25,column=0)
def soru7():
    tk.soru_7=tk.Label(f2,text="7-)  Mutfakta başarılı olmamanıza karşın kek yaptınız...",bg="pink")
    tk.soru_7.grid(row=2,column=0)
    tk.soru_7.config(font=("Courier", 9))
    tk.Radiobutton(f2,indicatoron=0,text="A) Kimse yaptığım kek hakkında yorum yapmaz.",variable="gr7",command=addscore1,fg="purple",bg="yellow",value=19).grid(row=3,column=0)
    tk.Radiobutton(f2,indicatoron=0,text="B) Gülümseyerek inatla insanların kekimi nasıl bulduklarını sorarım.",variable="gr7",command=addscore5,fg="purple",bg="yellow",value=20).grid(row=4,column=0)
    tk.Radiobutton(f2,indicatoron=0,text="C) İkram etmeden önce keki denemek için yaptığımı mutlaka söylerim ve yanında pastaneden aldığım kurabiyeleri de koyarım.",variable="gr7",value=21,command=addscore2,fg="purple",bg="yellow").grid(row=5,column=0)
def soru8():
    tk.soru_8=tk.Label(f2,text="8-) Bir lokantaya giriyorsunuz ve yanınızdaki çiftin insanlara bakarak fısır fısır konuştuklarını fark ediyorsunuz...",bg="pink")
    tk.soru_8.grid(row=6,column=0)
    tk.soru_8.config(font=("Courier", 9))
    tk.Radiobutton(f2,indicatoron=0,text="A) Sinir olurum, başkaları hakkında böyle alenen konuşan insanlardan hiç hoşlanmam.",variable="gr8",value=22,command=addscore7,fg="purple",bg="yellow").grid(row=7,column=0)
    tk.Radiobutton(f2,indicatoron=0,text="B)  Bir şey düşünmem!",variable="gr8",command=addscore0,fg="purple",bg="yellow",value=23).grid(row=8,column=0)
    tk.Radiobutton(f2,indicatoron=0,text="C) Çok şeker bir çift olduklarını ve birbirlerini yeni tanıyan heyecanlı aşıklar olduklarını düşünürüm.",value=24,variable="gr8",command=addscore3,fg="purple",bg="yellow").grid(row=9,column=0)
def soru9():
    tk.soru_9=tk.Label(f2,text="9-)  Sabah koşu yaparken, sizden çok daha genç olan iş arkadaşınızla karşılaşıyorsunuz ve o gülümseyerek sizi hızlıca geçiyor.",bg="pink")
    tk.soru_9.grid(row=10,column=0)
    tk.soru_9.config(font=("Courier", 9))
    tk.Radiobutton(f2,indicatoron=0,text="A) Kalan tüm gücünüzü toplar siz de onu geçersiniz.",variable="gr9",command=addscore7,fg="purple",bg="yellow",value=25).grid(row=11,column=0)
    tk.Radiobutton(f2,indicatoron=0,text="B) Siz de ona nazikçe gülümsersiniz, sporda hızlı olması sizden daha formda ve daha ince olduğunu göstermez.",variable="gr9",value=26,command=addscore3,fg="purple",bg="yellow").grid(row=12,column=0)
    tk.Radiobutton(f2,indicatoron=0,text="C) Temponuzu hiç bozmazsınız, yavaş olmak hiç sorun değilmiş gibi davranırsınız.",variable="gr9",command=addscore1,fg="purple",bg="yellow",value=27).grid(row=13,column=0)
def soru10():
    tk.soru_10=tk.Label(f2,text="10-) Girdiğiniz mağazada tatlı dilli bir tezgahtar size çok yüksek fiyatlı bir pantolonu satmaya uğraşıyor.",bg="pink")
    tk.soru_10.grid(row=14,column=0)
    tk.soru_10.config(font=("Courier", 9))
    tk.Radiobutton(f2,indicatoron=0,text="A) 'Bir daha bu dünyaya ne zaman geleceğim' diye düşünür, pantolonu tereddüt etmeden alırsınız.",value=28,variable="gr10",command=addscore3,fg="purple",bg="yellow").grid(row=15,column=0)
    tk.Radiobutton(f2,indicatoron=0,text="B) Paranıza kıyamaz ve mağazadan çıkarsınız",command=addscore6,fg="purple",bg="yellow",variable="gr10",value=29).grid(row=16,column=0)
    tk.Radiobutton(f2,indicatoron=0,text="C) Tezgahtara tekrar düşüneceğinizi söyler, evinizin yolunu tutarsınız.",command=addscore0,fg="purple",bg="yellow",variable="gr10",value=30).grid(row=17,column=0)
def soru11():
    tk.soru_11=tk.Label(f2,text="11-) Patavatsızlık yapıp, birilerini kırdığınız oluyor mu?",bg="pink")
    tk.soru_11.grid(row=18,column=0)
    tk.soru_11.config(font=("Courier", 9))
    tk.Radiobutton(f2,indicatoron=0,text="A) Elbette çok sık oluyor.",command=addscore6,fg="purple",bg="yellow",variable="gr11",value=31).grid(row=19,column=0)
    tk.Radiobutton(f2,indicatoron=0,text="B) Hayır asla kırmam çok dikkatli davranırım.",command=addscore2,fg="purple",bg="yellow",variable="gr11",value=32).grid(row=20,column=0)
    tk.Radiobutton(f2,indicatoron=0,text="C) Nadiren olur ama bunu asla kasten yapmam.",command=addscore1,fg="purple",bg="yellow",variable="gr11",value=33).grid(row=21,column=0)
def soru12():
    tk.soru_12=tk.Label(f2,text="12-) İnsanlara iltifat etmeyi sever misiniz?",bg="pink")
    tk.soru_12.grid(row=22,column=0)
    tk.soru_12.config(font=("Courier",9))
    tk.Radiobutton(f2,indicatoron=0,text="A) İltifat etmesini de almasını da çok severim.",command=addscore5,fg="purple",bg="yellow",variable="gr12",value=34).grid(row=23,column=0)
    tk.Radiobutton(f2,indicatoron=0,text="B) Eğer gerçekten öyle düşünüyorsam söylerim, iltifat olsun diye değil.",command=addscore3,fg="purple",bg="yellow",variable="gr12",value=35).grid(row=24,column=0)
    tk.Radiobutton(f2,indicatoron=0,text="C)  Evet ara sıra iltifat ederim, herkes biraz övgü duymak ister.",command=addscore1,fg="purple",bg="yellow",variable="gr12",value=36).grid(row=25
                                                                                                                                                                                      ,column=0)
    
def hesapla():
    if 9<score<25:
        tk.messagebox.showwarning("Sonucunuz","Kesinlikle çevrenizle çok uyumlu birisiniz. İnsanlarla rahat iletişim kurmak, yanlarında kendinizi huzurlu hissetmek sizin için son derece önemli. " +"\n"+" Dikkat etmeniz gerekenler: Tüm gücünüzü insanlara ayırmayın, kendinizle ilgilenmek için de zaman yaratın. Seveceğiniz bir kitap, güzel köpüklü bir banyo ya da doğayla baş başa bir yürüyüş. Tüm bunlar biraz rahatlayıp kendinizle baş başa kalmanızı sağlayacaktır.")
    if 26<score<46:
        tk.messagebox.showwarning("Sonucunuz,","Sempatik bir görüntünün, tüm kapıları açan bir anahtar olduğunun farkındasınız. Çevrenizle ilişkilerinizde kendinize fazlasıyla güveniyorsunuz ve beceriklisiniz."+"\n"+"Dikkat etmeniz gerekenler: Düzgün davranmaya o kadar uğraşıyorsunuz ki, içinizdeki 'ben' bir türlü dışa çıkamıyor. Ara sıra taşkınlıktan çekinmeyin. İçinizdeki 'ben'i dışarıya çıkarın, gerçekten neyi arzuluyorsanız onu yapın ve herkes sizi daha az sevecek diye endişelenmeyin.")
    if 47<score<68:
        tk.messagebox.showwarning("Sonucunuz","İçiniz dışınız bir. Hiç kimse görüş ve düşünceleriniz konusunda ikilemde kalmıyor. Zaten siz de ikilemde kalmayı, kimsenin işi ikircikli bırakmasını istemiyorsunuz."+"\n"+"Dikkat etmeniz gerekenler: Ara sıra zayıf yönünüzü göstermenin bir zararı dokunmaz. Ara sıra çekilin bir kenara ve kendinize biraz soluk aldırın. Hem böylece başkaları siz olmadan da bir şeyler yapmaya çalışacaktır.")
def sıfırla():
    v.set(0)

tk.menubar=tk.Menu(pencere)
tk.filemenu=tk.Menu(tk.menubar,tearoff=0)
tk.filemenu.add_command(label="hesapla",command=hesapla)
tk.filemenu.add_command(label="quit" ,command=pencere.destroy)
tk.filemenu.add_command(label="reset the answers",command=sıfırla)
tk.menubar.add_cascade(label="İşlemler",menu=tk.filemenu)
pencere.config(menu=tk.menubar)



soru1()
soru2()
soru3()
soru4()
soru5()
soru6()
soru7()
soru8()
soru9()
soru10()
soru11()
soru12()
pencere.mainloop()
raise_frame(f1)
