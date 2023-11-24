const express = require("express");
const mongoose = require("mongoose");
const redis = require("redis");
const session = require("express-session");
// let RedisStore = require('connect-redis')(session);
let RedisStore = require("connect-redis")(session);


const { MONGO_USER,
        MONGO_PASSWORD, 
        MONGO_IP, 
        MONGO_PORT,
        REDIS_URL,
        REDIS_PORT,
        SESSION_SECRET,
     } = require("./config/config");

let redisClient = redis.createClient({
    host: REDIS_URL,
    port: REDIS_PORT,
});

// const redisClient = redis.createClient({
//     url: "redis://redis:6379",
// });

const postRouter = require("./routes/postRoutes");
const userRouter = require("./routes/userRoutes");
const { listenerCount } = require("./models/postModel");
const app = express()
const mongoURL = `mongodb://${MONGO_USER}:${MONGO_PASSWORD}@${MONGO_IP}:${MONGO_PORT}/?authSource=admin`;



const connectWithRetry = () => {
    mongoose
        //  .connect("mongodb://azam:password@mongo:27017/?authSource=Admin")
        .connect(mongoURL, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        })
        .then(() => console.log("successfully connected to DB"))
        .catch((e) => {console.log(e)
            setTimeout(connectWithRetry, 5000)
        });
}
connectWithRetry()



//middleware,
app.use(express.json()); 
app.use(session({
    store: new RedisStore({ client: redisClient }),
    secret: SESSION_SECRET,
    cookie: { //under express-session options npmjs.com
        secure: false,
        resave: false,
        saveUninitialized: false,
        httpOnly: true,
        maxAge: 30000
    }
}));

//middleware, ensure that body gets attached to object



app.get("/", (req, res) => {
    res.send("<h1>You are connected!</h1>");
});

//localhost:3000/api/v1/post/  ==> this request will go to postRouter.js
app.use("/api/v1/posts", postRouter);
app.use("/api/v1/users", userRouter);
const port = process.env.PORT || 3000;

app.listen(port, () => console.log(`listening on port ${port}`));