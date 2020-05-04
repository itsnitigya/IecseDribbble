const router = require("express").Router();
const db = require("../config/db");
const to = require("../utils/to");
const uuid = require('uuid/v4');
const sha = require("sha1");
const bcrypt = require('bcrypt');
const saltRounds = 10;
const aws = require('aws-sdk');
const multer = require('multer');
const multerS3 = require('multer-s3');

let exp = {};


exp.ping = async (req,res) => {
  return res.sendSuccess("pong");
};


module.exports = exp; 