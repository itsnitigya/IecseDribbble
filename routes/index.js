const router = require("express").Router();
const db = require("../config/db");
const to = require("../utils/to");
const auth = require('./auth.js');
const post = require('./post.js');
const user = require('./user.js');
const test = require('./test.js');
const userActions = require('./userActions.js');

function isLoggedIn(req, res, next) {
    if (req.session.key) return next();
    return res.sendError("not logged in")
}

//add joi validation

router.post("/ping" , test.ping);

router.post("/signup" , auth.signup);
router.post("/login" , auth.login);
router.post("/logout" , auth.logout);

router.post("/post" , isLoggedIn , post.posts);

router.post("/addBio" , isLoggedIn , user.addBio);
router.post("/uploadProfilePicture" , isLoggedIn , user.uploadProfilePicture);

router.post("/comment" , isLoggedIn , userActions.comment);
router.post("/vote" , isLoggedIn , userActions.vote);
router.post("/follow" , isLoggedIn , userActions.follow);
router.get("/getPosts" , isLoggedIn , userActions.getPosts);
router.get("/getProfile" , isLoggedIn, userActions.getProfile);
router.get("/getAllProfiles" , isLoggedIn , userActions.getAllProfiles);

module.exports = router;