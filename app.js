const path = require("path");
require('dotenv').config();
const express = require("express");
const session = require('express-session');
const redisStore = require('./config/redis')(session);

const app = express();

app.use(
  session({
    resave: false,
    saveUninitialized: false,
    secret: 'somenaef',
    store: redisStore,
    cookie: { maxAge: 365 * 24 * 60 * 60 * 1000 }
}));

const bodyParser = require("body-parser");
const redis = require('redis');
// const client = redis.createClient();
const response = require("./utils/response");

const cookieParser = require('cookie-parser');
const server = require("http").Server(app);

const routes = require("./routes");


app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: true
  })
);
app.use(express.static(path.join(__dirname, "public")));
app.use(response);
app.use(cookieParser('secret'));

app.use("/",routes);

const port = process.env.PORT || 3000;

server.listen(port, err => {
  console.log(err || `Listening on port ${port}`);
});

//gracefully exit the app
process
  .on("exit", code => {
    process.exit(code);
  })
  .on("SIGINT", () => {
    process.exit(0);
});

