from crypt import methods
from sqlite3 import Cursor
from flask import Flask, jsonify, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
import re
import hashlib

app = Flask(__name__)


# Change this to your secret key (can be anything, it's for extra protection)
app.secret_key = '3iefqkbcgrbk3w'

# Enter your database connection details below
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'comp440'
app.config['MYSQL_PASSWORD'] = 'pass1234'
app.config['MYSQL_DB'] = 'comp440'

# Intialize MySQL
mysql = MySQL(app)

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
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        query = "SELECT * FROM users WHERE username='{}' AND password='{}'".format(username, hashedPassword)
        cursor.execute(query)
        # Fetch one record and return result
        account = cursor.fetchone()
        print("I AM HERE, after execution of db")
        # If account exists in users table in out database
        if account:
            print("account found", account)
            # Create session data, we can access this data in other routes
            session['loggedin'] = True
            session['username'] = account['username']
            # Redirect to home page
            return redirect(url_for('home'))
        else:
            print("No account found")
            # Account doesnt exist or username/password incorrect
            msg = 'Incorrect username/password!'
    # Show the login form with message (if any)
    return render_template('index.html', msg=msg)

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
        
        if(password == confirmPassword):
            msg = 'Account already exists!'
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)

            cursor.execute('SELECT * FROM users WHERE username = %s', (username,))
            account = cursor.fetchone()
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
                cursor.execute('INSERT INTO users VALUES (%s, %s, %s, %s, %s)', (email, hashedPassword, firstname, lastname, username))
                mysql.connection.commit()
                msg = 'You have successfully registered!'
        else:
            msg = "Pasword Does not match"
    elif request.method == 'POST':
        # Form is empty... (no POST data)
        msg = 'Please fill out the form!'
    # Show registration form with message (if any)
    return render_template('register.html', msg=msg)

@app.route('/home')
def home():
    # Check if user is loggedin
    if 'loggedin' in session:
        return render_template('home.html', username=session['username'])
    return redirect(url_for('login'))

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

@app.route('/fetchblogs')
def fetchBlogs():
    # fetch all the blogs
    # add pagination later
    pass

@app.route('/fetchblog/<blogid>')
def fetchBlog(blogid):
    # fetch a blog along with all the comments
    # this will also handle one comment per user each blog
    pass

@app.route('/addblogs')
def addBlog():
    # post a blog with the user logged in
    pass

@app.route('/addcomment/<postId>', methods=['POST'])
def addComment(postId):
    # check users comment history no more then 3 comments per day
    print(postId)
    username = request.form['username']
    
    return jsonify(postId)