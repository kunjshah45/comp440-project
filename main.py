from email import message
from multiprocessing.connection import Connection
from flask import Flask, flash, jsonify, render_template, request, redirect, url_for, session
# from flask_mysqldb import MySQL
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine
from sqlalchemy import text
from datetime import date, datetime
import MySQLdb.cursors
import re
import hashlib
import json

app = Flask(__name__)
# Change this to your secret key (can be anything, it's for extra protection)
app.secret_key = '3iefqkbcgrbk3w'

with open('config.json', 'r') as c:
    params = json.load(c)["params"]

app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True

app.config['UPLOAD_FOLDER'] = params['upload_location']
ALLOWED_EXTENSIONS = set(['jpg', 'jpeg'])
# Intialize MySQL
mysql = SQLAlchemy(app)

class Users(mysql.Model):
    email = mysql.Column(mysql.Integer, unique=True)
    password = mysql.Column(mysql.String(80), nullable=False)
    firstName = mysql.Column(mysql.String(12), nullable=False)
    lastName = mysql.Column(mysql.String(120), nullable=False)
    username = mysql.Column(mysql.String(12), primary_key=True)
    hobbies = mysql.Column(mysql.String(80), nullable=False)
    
class Connections(mysql.Model):
    cid = mysql.Column(mysql.Integer, primary_key=True)
    fromProfile = mysql.Column(mysql.Integer, mysql.ForeignKey('users.username'), nullable=False)
    toProfile = mysql.Column(mysql.Integer, mysql.ForeignKey('users.username'), nullable=False)
    date = mysql.Column(mysql.String(12), nullable=True, default=datetime.now)

class Contacts(mysql.Model):
    sno = mysql.Column(mysql.Integer, primary_key=True)
    name = mysql.Column(mysql.String(80), nullable=False)
    phone_num = mysql.Column(mysql.String(12), nullable=False)
    msg = mysql.Column(mysql.String(120), nullable=False)
    date = mysql.Column(mysql.String(12), nullable=True)
    email = mysql.Column(mysql.String(20), nullable=False)

class Posts(mysql.Model):
    sno = mysql.Column(mysql.Integer, primary_key=True)
    title = mysql.Column(mysql.String(80), nullable=False)
    slug = mysql.Column(mysql.String(40), nullable=False)
    content = mysql.Column(mysql.Text, nullable=False)
    tags = mysql.Column(mysql.Text, nullable=False)
    author = mysql.Column(mysql.String(120), mysql.ForeignKey('users.username'), nullable=False)
    date = mysql.Column(mysql.String(12), nullable=True, default=datetime.now)
    views = mysql.Column(mysql.Integer, default=0)

class Comments(mysql.Model):
    cid = mysql.Column(mysql.Integer, primary_key=True)
    postid = mysql.Column(mysql.Integer, mysql.ForeignKey('posts.sno'), nullable=False) 
    username = mysql.Column(mysql.Integer, mysql.ForeignKey('users.username'), nullable=False)
    commentdate = mysql.Column(mysql.DateTime, nullable=True, default=datetime.now) 
    message = mysql.Column(mysql.String(550), nullable=False)
    commentType = mysql.Column(mysql.Boolean, nullable=False)

if __name__ == '__main__':
    app.run('0.0.0.0', 5000, debug=True, use_debugger=True, use_reloader=True)

@app.route('/login', methods=['GET', 'POST'])
def login():
    # Output message if something goes wrong...
    msg = ''    
    # Check if "username" and "password" POST requests exist (user submitted form)
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        # Create variables for easy access
        username = request.form['username']
        password = request.form['password']
        h = hashlib.md5(password.encode())
        hashedPassword = h.hexdigest()
        # Check if account exists using MySQL
        account = Users.query.filter_by(username=username, password=hashedPassword).first()
        
        # If account exists in users table in out database
        if account:
            # Create session data, we can access this data in other routes
            session['loggedin'] = True
            session['username'] = account.username
            # Redirect to home page
            return redirect(url_for('dashboard'))
        else:
            print("No account found")
            # Account doesnt exist or username/password incorrect
            msg = 'Incorrect username/password!'
    # Show the login form with message (if any)
    return render_template('login.html', msg=msg) 

@app.route('/register', methods=['GET', 'POST'])
def register():
    # Output message if something goes wrong...
    msg = ''
    # Check if "username", "password" and "email" POST requests exist (user submitted form)
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form:
        # Create variables for easy access
        username = request.form['username']
        password = request.form['password']
        h = hashlib.md5(password.encode())
        hashedPassword = h.hexdigest()
        confirmPassword=request.form['confirmPassword']
        email = request.form['email']
        firstname = request.form['firstName']
        lastname = request.form['lastName']
        # hobbies=request.form['hobbies']
        
        if(password == confirmPassword):
            msg = 'Account already exists!'
            account = Users.query.filter_by(username=username, password=hashedPassword).first()
            
            # If account exists show error and validation checks
            if account:
                msg = 'Account already exists!'
            elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
                msg = 'Invalid email address!'
            elif not re.match(r'[A-Za-z0-9]+', username):
                msg = 'Username must contain only characters and numbers!'
            elif not username or not password or not email:
                msg = 'Please fill out the form!'
            else:
                # Account doesnt exists and the form data is valid, now insert new account into users table
                user = Users(email=email, password = hashedPassword, firstName = firstname, lastName=lastname, username = username)

                mysql.session.add(user)
                mysql.session.commit()
                msg = 'You have successfully registered!'
        else:
            msg = "Pasword Does not match"
    elif request.method == 'POST':
        # Form is empty... (no POST data)
        msg = 'Please fill out the form!'
    # Show registration form with message (if any)
    return render_template('register.html', msg=msg)

@app.route('/')
def index():
    posts = Posts.query.order_by(Posts.date.desc()).all()
  
    return render_template('index.html', posts=posts)

@app.route('/logout')
def logout():
    # Check if user is loggedin
    if 'loggedin' in session:
        session['loggedin'] = False
        session['username'] = ""
    return redirect(url_for('login'))

@app.route('/initDb')
def initDb():
    fd = open('db.sql', 'r')
    sqlFile = fd.readlines()
    fd.close()
    
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    for command in sqlFile:
        try:
            cursor.execute(str(command))
        except Exception as E:
            print("Command skipped: ", E)
            return render_template('register.html', msg=E)

    msg = "Data initialized successfully"

    return render_template('register.html', msg=msg)


@app.route('/post/<blogid>')
def post(blogid):
    # fetch a blog along with all the comments
    # this will also handle one comment per user each blog

    post = Posts.query.filter_by(slug=blogid).first()
    cocomment=Comments.query.filter_by(postid=post.sno).all()
    post.views += 1
    mysql.session.commit()

    return render_template('blog.html', post=post, cocomment=cocomment)


@app.route('/addcomment', methods=['POST'])
def addComment():
    try:
        # check users comment history no more then 3 comments per day
        if 'loggedin' in session and session["username"] == request.json['username']:

            dt = date.today()
            dateToCheck = datetime.combine(dt, datetime.min.time())

            commentCheck = Comments.query.filter(Comments.commentdate>dateToCheck, Comments.username == session['username']).all()
            if(len(commentCheck) < 4):
                postid = request.json['postid']
                username = request.json['username']
                message = request.json['message']
                commentType = request.json['commentType']

                comment = Comments(postid = postid, username = username, message = message, commentType=int(commentType))

                mysql.session.add(comment)
                mysql.session.commit()
            else:
                return jsonify({"status": False, "message": "Failed to comment, as user is not permitted to comment more than three comment per day."})
        return jsonify({"status": True, "message":"Sucessfully sent"})
    except Exception as E:
        print(E)
        return jsonify({"status": False, "message":"Error"})

@app.route('/edit/<blogid>', methods=['GET', 'POST'])
def edit(blogid):
    try:
        if request.method == 'POST':
            if 'loggedin' in session:
                title = request.form['title']
                slug = title.replace(" ", "-").lower()
                content = request.form['content']
                tags = request.form['tags']

                if blogid=='0':
                    blogCheck = Posts.query.filter_by(author = session['username']).all()
                    if(len(blogCheck)< 2):
                        post = Posts(title = title, slug = slug, content = content, author = session['username'], tags = tags)
                        mysql.session.add(post)
                        mysql.session.commit()
                        return redirect("/")
                    else:
                        flash('Failed to add blog, as user is not permitted to add more then 2 blogs per day.')
                        return redirect('/edit/'+blogid)
                else:
                    post = Posts.query.filter_by(sno=blogid).first()
                    post.title = title
                    post.slug = slug
                    post.content = content
                    post.date = datetime.now()
                    post.tags = tags
                    mysql.session.commit()
                    return redirect('/edit/'+blogid)

        post = Posts.query.filter_by(sno=blogid).first()
        return render_template("edit.html", post=post, sno=blogid)
    except Exception as E:
        print(E)
        return jsonify({"status": False, "message":"Error: "})

@app.route('/dashboard', methods=['GET', 'POST'])
def dashboard():
    try:
        if request.method == 'POST':
            if 'loggedin' in session:
                hobbies = request.form['hobbies'].replace(" ", "_")
                account = Users.query.filter_by(username=session["username"]).first()
                account.hobbies = hobbies
                mysql.session.commit()

        myPost = Posts.query.filter_by(author=session['username']).all()
        account = Users.query.filter_by(username=session['username']).first()
        return render_template("dashboard.html",posts=myPost, account=account)
    except Exception as E:
        print(E)
        return jsonify({"status": False, "message":"Error"})

@app.route('/initBlogs')
def initBlogs():
    engine = create_engine(params['local_uri'], echo=True)
    with engine.connect() as con:
        with open("myblog.sql",encoding='utf-8') as file:
            query = text(file.read())
            con.execute(query)
    
    posts = Posts.query.order_by(Posts.date.desc()).all()
    return render_template('index.html', posts=posts)
     
@app.route('/allfiles')
def allfiles():
    # print(Posts.query.get(Posts.author).distinct().all())
    # query6 = Users.query.filter(Users.username.not_in()).all()
    # print(query6)
    return render_template('allFiles.html')

@app.route('/profile/<username>')
def profile(username):
    following = Connections.query.filter_by(fromProfile=session['username']).count()
    followers = Connections.query.filter_by(toProfile=session['username']).count()
    account = Users.query.filter_by(username=username).first()
    posts = Posts.query.filter_by(author=username).order_by(Posts.date.desc()).all() 
    return render_template('profile.html', account=account, following=following, followers=followers, posts=posts)

@app.route('/follow', methods=['POST'])
def follow():
    try:
        followto = request.form["followto"] 
        checkFollow = Connections.query.filter(Connections.fromProfile==session['username'], Connections.toProfile==followto).first()
        if(checkFollow):
            return jsonify({"status":False, "message":"Already Following this user"})

        connect = Connections(fromProfile=session["username"], toProfile=followto)
        mysql.session.add(connect)
        mysql.session.commit()

        return jsonify({"status":True, "message":"Successfully added this user into your connection."})

    except Exception as E:
        return jsonify({"status":False, "message":E})
