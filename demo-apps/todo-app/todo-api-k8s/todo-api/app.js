require('dotenv').config();
var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var mongoose = require('mongoose');
var cors = require('cors');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var tasksRouter = require('./routes/tasks');

var app = express();

app.use(cors());

// connect mongodb
//const MONGO_URI = 'mongodb://localhost:27017/todo';
// const MONGO_URI = 'mongodb+srv://devops:share123@cluster0-5kuqc.mongodb.net/todo?retryWrites=true';
const {
    // MONGO_URI = 'mongodb://localhost:27017/todo'
    MONGO_HOST = 'localhost',
    MONGO_PORT = '27017',
    MONGO_DATABASE = 'todo',
    MONGO_USER = '',
    MONGO_PASSWORD = '',
} = process.env;

const MONGO_URI = MONGO_PASSWORD
    ? `mongodb://${MONGO_USER}:${MONGO_PASSWORD}@${MONGO_HOST}:${MONGO_PORT}/${MONGO_DATABASE}?authSource=admin`
    : `mongodb://${MONGO_HOST}:${MONGO_PORT}/${MONGO_DATABASE}?authSource=admin`;

mongoose.connect(MONGO_URI, { useNewUrlParser: true }, (error) => {
    if (error) {
        console.error(error)
        return
    }
    console.log('Connect to MongoDB @', MONGO_URI, ' successfully.');
});

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'hbs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/server-info', (req, res) => {
    res.json({
        pid: process.pid,
        date: new Date(),
    })
});
app.use('/users', usersRouter);
app.use('/tasks', tasksRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
    next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error');
});

module.exports = app;
