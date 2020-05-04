const router = require("express").Router();
const db = require("../config/db");
const to = require("../utils/to");
const uuid = require('uuid/v4');
const sha = require("sha1");
const bcrypt = require('bcrypt');
const saltRounds = 10;

let exp = {};

exp.signup = async (req,res) => {
    let err, result;
    let username = req.body.username;
    let email = req.body.email;
    let password;
    [err , password] = await to(bcrypt.hash(req.body.password , saltRounds));
    let userID = sha(email);
    [err , result] = await to(db.query("insert into users values(?,?,?,?,?,?,?,?)" , [userID, username , email , password , 0 , 0 , null, null]));
    if(err)
      return res.sendError(err);
    return res.sendSuccess("user signed up");
};
  
exp.login = async (req,res) =>{
    let email = req.body.email;
    let password = req.body.password;
    let err , result , userData;
    [err, userData] = await to(db.query("select * from users where email = ?" ,[email] ));
    console.log(userData);
    if(err) return res.sendError("email ID not found");
    [err , result] = await to (bcrypt.compare(password, userData[0].password));
    if(result == false) return res.sendError("incorrect email/password")
    req.session.key = userData[0];
    req.session.save(() => {
      return res.sendSuccess(userData);
    });
};
  
exp.logout = async (req,res) => {
    if (req.session.key)
      req.session.destroy(() => {
        return res.sendSuccess(null, 'logged out');
      });
    return res.sendSuccess(null, 'logged out'); 
};
  
module.exports = exp; 