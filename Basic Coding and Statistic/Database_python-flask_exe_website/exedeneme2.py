import psycopg2  #veri tabanına bağlanmak için
from psycopg2 import Error #bağlantı sorunlarını göstermek için
import tkinter.messagebox  #messagebox arayüzü için
import wikipedia  #wikipedia bağlanabilmek için
import tkinter as tk  #exe arayüzü için  
from tkinter import filedialog 
import webbrowser #web sitelerine bağlanabilmek için

import smtplib #Mail atabilmek için
import gmplot  #GoogleMape bağlanabilmek için
pencere=tk.Tk()


tk.seç=tk.Label(pencere,text="işlem yapmak istediğiniz veri tabanını seçiniz")
tk.seç.grid(row=0,column=1)



def ağaç():

    tk.seçmeli=tk.Label(pencere,text="yapmak istediğiniz işlemi seçiniz")
    tk.seçmeli.grid(row=2,column=1)
    def insert():

        tk.bilgi=tk.Label(pencere,text="lütfen girdilerinizin integer olmasına özen gösteriniz")
        tk.bilgi.grid(row=4,column=1)
            
        tk.latit=tk.Label(pencere,text="Latitude")
        tk.latit.grid(row=5,column=1)
        tk.Lati=tk.Entry(pencere)
        tk.Lati.grid(row=6,column=1)
           
        tk.longi=tk.Label(pencere,text="Longtitude")
        tk.longi.grid(row=7,column=1)
        tk.Long=tk.Entry(pencere)
        tk.Long.grid(row=8,column=1)
           
        tk.yüksek=tk.Label(pencere,text="height")
        tk.yüksek.grid(row=9,column=1)
        tk.hei=tk.Entry(pencere)
        tk.hei.grid(row=10,column=1)

        tk.nam=tk.Label(pencere,text="name")
        tk.nam.grid(row=11,column=1)
        tk.isim=tk.Entry(pencere)
        tk.isim.grid(row=12,column=1)

        def ekle():
            try:
                value2=int(tk.Lati.get())
                value3=int(tk.Long.get())
                value4=int(tk.hei.get())
                value1=str(tk.isim.get())

                connection=psycopg2.connect(user="postgres",password="PARSSanane*98",host="localhost",port="5432",database="testload")
                cur=connection.cursor()
                sql="""INSERT INTO treename(name,lat, lon,height) VALUES (%s,%s,%s,%s);"""
                    
                liste=[value1,value2,value3,value4]
                cur.execute(sql,liste)
                
                connection.commit()
                count=cur.rowcount
                tk.messagebox.showwarning(count,"Adding Row Succesful")
                
            except(Exception,psycopg2.Error) as error:
                if(connection):
                    tk.messagebox.showwarning("Failed to adding row",error)
            finally:
                if (connection):
                    cur.close()
                    connection.close()
                    tk.messagebox.showwarning("Postgre is closed")
        tk.Radiobutton(pencere,indicatoron=0 , text="Uygula" , command=ekle , value=5).grid(row=13,column=1)

    def delete():
        tk.bilgi2=tk.Label(pencere,text="Lütfen silmek istediğiniz satırın PK'ları girin")
        tk.bilgi2.grid(row=4,column=2)

        tk.latit2=tk.Label(pencere,text="Latitude")
        tk.latit2.grid(row=5,column=2)
        tk.Lati2=tk.Entry(pencere)
        tk.Lati2.grid(row=6,column=2)
           
        tk.longi2=tk.Label(pencere,text="Longtitude")
        tk.longi2.grid(row=7,column=2)
        tk.Long2=tk.Entry(pencere)
        tk.Long2.grid(row=8,column=2)
           
        tk.nam2=tk.Label(pencere,text="name")
        tk.nam2.grid(row=9,column=2)
        tk.isim2=tk.Entry(pencere)
        tk.isim2.grid(row=10,column=2)

        
        def dele():
           
            try:
                name=str(tk.isim2.get())
                lat=int(tk.Lati2.get())
                lon=int(tk.Long2.get())
                
                connection=psycopg2.connect(user="postgres",password="PARSSanane*98",host="localhost",port="5432",database="testload")
                cursor=connection.cursor()

                sql_delete="""Delete from treename where name=%s and lat=%s and lon=%s"""
                cursor.execute(sql_delete,(name,lat,lon))
                connection.commit()
                count=cursor.rowcount
                tk.messagebox.showwarning(count,"Deleting Row is Succes")
            except(Exception , psycopg2.Error) as error:
                tk.messagebox.showwarning("Failed to Deleting Row" , error)
            finally:
                if(connection):
                    cursor.close
                    connection.close()
                    tk.messagebox.showwarning("postgre closed")
           
        
        tk.Radiobutton(pencere,indicatoron=0,text="Uygula",command=dele, value=6).grid(row=11,column=2)
    def query():
        tk.q=tk.Label(pencere,text="Your Query")
        tk.q.grid(row=4,column=3)
        tk.quer=tk.Entry(pencere)
        tk.quer.grid(row=5,column=3)
        def qum():
            try:
                quar=str(tk.quer.get())
                connection=psycopg2.connect(user="postgres",password="PARSSanane*98",host="localhost",port="5432",database="testload")
                cur=connection.cursor()
                cur.execute(quar)
                tk.messagebox.showwarning("succesful query","Your Query Result added in txt file named query on desktop")
                row=cur.fetchone()
                f=open("query.txt","w")
                while row is not None:
                    f.write(str(row))
                    row=cur.fetchone()
                cur.close()
                f.close()
            except(Exception , psycopg2.DatabaseError) as error:
                tk.messagebox.showwarning("failed to query" ,error)
            finally:
                if connection is not None:
                    connection.close()
        tk.Radiobutton(pencere,indicatoron=0,text="Uygula",command=qum,value=7).grid(row=6,column=3)

    def halk():
        tk.kullanıcı=tk.Label(pencere,text="kimin verisi")
        tk.kullanıcı.grid(row=4,column=4)
        tk.kullan=tk.Entry(pencere)
        tk.kullan.grid(row=5,column=4)
        def kullanıcı():
            try:
                name=str(tk.kullan.get())
                sql='''Select * from treename where name=%s'''
                connection=psycopg2.connect(user="postgres",password="PARSSanane*98",host="localhost",port="5432",database="testload")
                cur=connection.cursor()
                cur.execute(sql,(name,))
                tk.messagebox.showwarning("query","Your Query Result added in txt file named Query on desktop")
                row=cur.fetchone()
                f1=open("Query.txt","w")
                while row is not None:
                    f1.write(str(row))
                    row=cur.fetchone()
                cur.close()
                f1.close
            except(Exception, psycopg2.DatabaseError) as error:
                tk.messagebox.showwarning("Failed to query" ,error)
            finally:
                if connection is not None:
                    connection.close()
            #tk.kullan=tk.Label(pencere,text="Mail atmak istediğiniz kişi")
            #tk.kullan.grid(row=7,column=4)
            #tk.alıcı=tk.Entry(pencere)
            #tk.alıcı.grid(row=8,column=4)

            #def mail():
                #alıcı1=str(tk.alıcı.get())
                #s=smtplib.SMTP("brkkvlcm@gmail.com",587)
                #s.starttls()
               # s.login("brkkvlcm@gmail.com","GİZLİ")
              #  s.sendmail("brkkvlcm@gmail.com",alıcı1,f1)
             #   s.quit
            #tk.Radiobutton(pencere,indicatoron=0,text="Mail at" , command=mail,value=28).grid(row=9,column=4)
            
        tk.Radiobutton(pencere,indicatoron=0,text="Uygula",command=kullanıcı,value=9).grid(row=6,column=4)
        

    def bigdelete():
        tk.bilgi2=tk.Label(pencere,text="Lütfen silmek istediğiniz kullanıcı ismini girin")
        tk.bilgi2.grid(row=4,column=5)

        tk.neym=tk.Label(pencere,text="isim")
        tk.neym.grid(row=5,column=5)
        tk.nayır=tk.Entry(pencere)
        tk.nayır.grid(row=6,column=5)
        def jöle():
           
            try:
                name=str(tk.nayır.get())
                
                
                connection=psycopg2.connect(user="postgres",password="PARSSanane*98",host="localhost",port="5432",database="testload")
                cursor=connection.cursor()

                sql_delete="""Delete from treename where name=%s"""
                cursor.execute(sql_delete,(name,))
                connection.commit()
                count=cursor.rowcount
                tk.messagebox.showwarning(count,"Deleting User is Succes")
            except(Exception , psycopg2.Error) as error:
                tk.messagebox.showwarning("Failed to Deleting User" , error)
            finally:
                if(connection):
                    cursor.close
                    connection.close()
                    tk.messagebox.showwarning("postgre closed")
        tk.Radiobutton(pencere,indicatoron=0 , text="Uygula", command=jöle,value=11).grid(row=7,column=5)

    def csvem():
        tk.yeri=tk.Label(pencere,text="CSV konum ve ismiyle girin")
        tk.yeri.grid(row=4,column=6)

        tk.veri=tk.Entry(pencere)
        tk.veri.grid(row=5,column=6)
        def güzel():
            try:
                konumlu=str(tk.veri.get())
                connection=psycopg2.connect(user="postgres",password="PARSSanane*98",host="localhost",port="5432",database="testload")
                cursor=connection.cursor()
                sql_yap="""Select * from Public."treename" \n COPY Public."treename" from {} DELIMITER  ';' CSV""".format(konumlu)
                cursor.execute(sql_yap,(konumlu,))
                connection.commit()
               
                tk.messagebox.showwarning("Added Succes","Added Succes")
            except(Exception , psycopg2.Error) as error:
                tk.messagebox.showwarning("Failed to Deleting User" , error)
            finally:
                if(connection):
                    cursor.close
                    connection.close()
                    tk.messagebox.showwarning("postgre closed")
        tk.Radiobutton(pencere,indicatoron=0 , text="Uygula" , command=güzel , value=14).grid(row=6,column=6)


    def wiki():
        tk.label=tk.Label(pencere,text="Wikipedia Search")
        tk.label.grid(row=4,column=7)
        tk.ent=tk.Entry(pencere)
        tk.ent.grid(row=5,column=7)
        def search_wiki():
            search=str(tk.ent.get())
            answer=wikipedia.summary(search)
            showinfo("Wiki answer",answer)
        tk.Radiobutton(pencere,indicatoron=0 , text="Search" , command=search_wiki , value=17).grid(row=6,column=7)

    def bilgi():
        def ağaçlar():
            import webbrowser
            webbrowser.open('http://www.leblebitozu.com/turkiyedeki-agac-turleri-ve-ozellikleri/')
        def koordiler():
            import webbrowser
            webbrowser.open('http://www.graftek.com.tr/haberler/tum-makaleler/turkiye-de-kullanilan-koordinat-sistemleri/7/.')
        def hacet():
            import webbrowser
            webbrowser.open('https://www.hacettepe.edu.tr/')
        tk.Radiobutton(pencere,indicatoron=0,text="Ağaç Bilgisi" , command=ağaçlar,value=20).grid(row=4,column=8)
        tk.Radiobutton(pencere,indicatoron=0,text="Koordinat Bilgisi" , command=koordiler,value=21).grid(row=5,column=8)
        tk.Radiobutton(pencere,indicatoron=0,text="Hacettepe sayfası" , command=hacet,value=2).grid(row=6,column=8)

    def poly():
        
        latitude_list = [ 17.45, 17.55, 17.62]
        longitude_list = [ 78.29, 78.00, 77.92 ]
        gmap = gmplot.GoogleMapPlotter(17.438139, 78.3936413, 11)
        gmap.scatter( latitude_list, longitude_list, '# FF0000', size = 40, marker = False)
        gmap.polygon(latitude_list, longitude_list, color = 'cornflowerblue')
        gmap.apikey = "Your_API_KEY"
        gmap.draw( "C:\\Users\\user\\Desktop\\map3.html" )

    def scatter():
        Charminar_top_attraction_lats, Charminar_top_attraction_lons = zip(*[
       (17.3833, 78.4011),(17.4239, 78.4738),(17.3713, 78.4804),(17.3616, 78.4747),
       (17.3578, 78.4717),(17.3604, 78.4736),(17.2543, 78.6808),(17.4062, 78.4691),
       (17.3950, 78.3968),(17.3587, 78.2988),(17.4156, 78.4750)])
        
        gmap3 = gmplot.GoogleMapPlotter(17.3616, 78.4747, 13)
        
        gmap3.scatter( Charminar_top_attraction_lats, Charminar_top_attraction_lons, '#FF0000',size = 50, marker = False )
        
        gmap3.plot(Charminar_top_attraction_lats, Charminar_top_attraction_lons, 'cornflowerblue', edge_width = 3.0)
        
        gmap3.apikey = "API_Key"
        
        gmap3.draw(r"scatter.html")




    
    tk.Radiobutton(pencere,indicatoron=0 , text="insert" , command=insert , value=2).grid(row=3,column=1)
    tk.Radiobutton(pencere,indicatoron=0 , text="query" , command=query , value=3).grid(row=3,column=3)
    tk.Radiobutton(pencere,indicatoron=0 , text="delete" , command=delete , value=4).grid(row=3,column=2)
    tk.Radiobutton(pencere,indicatoron=0 , text="halk için" , command=halk , value=8).grid(row=3,column=4)
    tk.Radiobutton(pencere,indicatoron=0 , text="Toplu kullanıcı delete", command=bigdelete , value=10).grid(row=3,column=5)
    tk.Radiobutton(pencere,indicatoron=0 , text="Csv İçeri atma(çalışmıyor)" , command=csvem , value=15).grid(row=3,column=6)
    tk.Radiobutton(pencere, indicatoron=0, text="Wikipedia(devlet engelli)" , command=wiki , value=16).grid(row=3,column=7)
    tk.Radiobutton(pencere,indicatoron=0,text="Bilgi Al" , command=bilgi,value=19).grid(row=3,column=8)
    tk.Radiobutton(pencere,indicatoron=0 ,text="Polygon" , command=poly , value=199).grid(row=3,column=9)
    tk.Radiobutton(pencere,indicatoron=0 , text="Scatter" , command=scatter , value=188).grid(row=3,column=10)
tk.Radiobutton(pencere, indicatoron=0, text="Ağaç veri tabanı" , command=ağaç , value=1).grid(row=1,column=1)

pencere.mainloop()
