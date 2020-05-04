const router = require("express").Router();
const db = require("../config/db");
const to = require("../utils/to");
const uuid = require('uuid/v4');

let exp = {};

exp.comment = async(req,res) => {
  let commentID = uuid();
  let userID = req.session.key.userID;
  // due to time crunch not implementing threads of comments , would have to write extra code 
  let parentCommentID = commentID;   
  let postID = req.body.postID;
  let body = req.body.body;
  let createdAt = new Date().toISOString().slice(0, 19).replace('T', ' ');
  //this is really bad way of finding mentions something should be implemented on the front end like when somones enters @ then a server request where all user id are stored in tries so that makes autocomplemention of the mention really easy
  // i am searching through the body for @
  //assuming one mention for now per comment
  //send some email/notification to the mentioned person
  let err, result,mentions=null;
  let words = body.split(" ");
  for (var i = 0; i < words.length; i ++) {
    if(words[i].startsWith("@")){
        console.log(words[i]);
        let search = words[i].slice(1);
        [err ,result] = await to(db.query("select * from users where username =?" , [search]));
        if(err) return result.sendError(err);
        [err ,result] = await to(db.query("update users set mentionCount = mentionCount+1  where username= ?" , [search]));
        if(err) return result.sendError(err);
        //before breaking we can either keep a mentions table or add some event in some sort of message queue to notification right away
    }
  }
  [err ,result] = await to(db.query("insert into comments values(?,?,?,?,?,?,?)", [commentID , userID , parentCommentID , postID, body , createdAt , mentions]));
  if(err) return res.sendError(err);
  [err ,result] = await to(db.query("update posts set commentCount = commentCount + 1 where postID =?", [postID]));
  if(err) return res.sendError(err);
  return res.sendSuccess("commented");
};

exp.vote = async (req,res) =>{
  let userID = req.session.key.userID;
  let postID = req.body.postID;
  let err, result;
  [err ,result] = await to(db.query("select * from votes where userID = ? and postID = ?" , [userID , postID]));
  if(result) if(result[0].love) return res.sendSuccess("already voted");
  [err ,result] = await to(db.query("insert into votes values(?,?,?)" , [1 , postID , userID ]));
  if(err) return res.sendError();
  [err ,result] = await to(db.query("update votes set love = ? where userID = ? and postID = ?" , [1, postID , userID]));
  if(err) return res.sendError(err);
  [err ,result] = await to(db.query("update posts set loveCount = loveCount + 1 where postID = ?" , [postID]));
  if(err) return res.sendError(err);
  return res.sendSuccess("voted");
};

exp.follow = async (req,res) =>{
  let userID = req.session.key.userID;
  let followID = req.body.followID;
  let err, result;
  [err ,result] = await to(db.query("insert into follows values(?,?)" , [userID , followID]));
  if(err) return res.sendError(err);
  [err ,result] = await to(db.query("update users set followers = followers + 1 where userID =?" , [followID]) );
  if(err) return res.sendError(err);
  return res.sendSuccess("followed");
};

exp.getPosts = async (req,res) => {
    // posts should be customized to users prefernces like tagging posts but since time crunch returning all posts 
    let err, result ;
    [err ,result] = await to(db.query("select * from posts"));
    if(err) return res.sendError(err);
    return res.sendSuccess(result);
  };
  
exp.getProfile = async (req,res) => {
    // users should be searchable but since time crunch returning all posts 
    let err, result ;
    [err ,result] = await to(db.query("select * from users where userID = ? ", [req.session.key.userID]));
    if(err) return res.sendError(err);
    return res.sendSuccess(result[0]);
};

exp.getAllProfiles = async (req,res) => {
  // users should be searchable but since time crunch returning all posts 
  let err, result ;
  [err ,result] = await to(db.query("select * from users"));
  if(err) return res.sendError(err);
  return res.sendSuccess(result);
};

module.exports = exp; 