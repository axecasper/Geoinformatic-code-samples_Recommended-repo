from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy


app = Flask(__name__)

ENV = 'dev'

if ENV == 'dev':
    app.debug = True
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:PARSSanane*98@localhost/testload'
else:
    app.debug = False
    app.config['SQLALCHEMY_DATABASE_URI'] = ''

app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)


class Feedback(db.Model):
    __tablename__ = 'TreeWeb'
    Latitude = db.Column(db.Integer, primary_key=True)
    Longtitude = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(200))
    height = db.Column(db.Integer)
    

    def __init__(self, Latitude, Longtitude, name, height):
        self.Latitude = Latitude
        self.Longtitude = Longtitude
        self.name = name
        self.height = height


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/submit', methods=['POST'])
def submit():
    if request.method == 'POST':
        Latitude = request.form['Latitude']
        Longtitude = request.form['Longtitude']
        name = request.form['name']
        height = request.form['height']
        # print(Latitude, Longtitude, name, height)
        if name == '' or height == '':
            return render_template('index.html', message='Please enter required fields')
        if db.session.query(Feedback).filter(Feedback.Latitude == Latitude).count() == 0:
            data = Feedback(Latitude,Longtitude, name, height)
            db.session.add(data)
            db.session.commit()
            
            return render_template('success.html')
        return render_template('index.html', message='You have already submitte feedback')


if __name__ == '__main__':
    app.run()
