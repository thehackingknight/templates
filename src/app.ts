import createError from 'http-errors';
import express from 'express';
import path from 'path';
import cookieParser from 'cookie-parser';
import logger from 'morgan';

import indexRouter from './routes/index';
import usersRouter from './routes/users';
import authRouter from './routes/auth';

const app = express();
import { default as mongoose } from 'mongoose';
import multer from 'multer';
import cors from 'cors';
import { DEV } from './utils/constants';
import dotenv from "dotenv"


dotenv.config()
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');



app.use(cors()) 
 app.use(cors({ 
  origin: '*'
}))
/*------------------ mongodb ----------------------- */
async function connectMongo(){
    let mongoURL = (DEV ? process.env.MONGO_URL_LOCAL : process.env.MONGO_URL )!
    try {
        console.log(mongoURL);
      await mongoose.connect(mongoURL, {dbName: "tb"});
      console.log('Connection established'); 
    }
    catch(e) {
      console.log('Could not establish connection')
     console.log(e); 
    }
  }
  (async function(){await connectMongo()})()
  /*------------------ End mongodb ----------------------- */
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

const parser = multer().none();
app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/auth', authRouter);

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

export default app;
