const router = require("express").Router();
const db = require("../config/db");
const to = require("../utils/to");
const uuid = require('uuid/v4');
const aws = require('aws-sdk');
const multer = require('multer');
const multerS3 = require('multer-s3');

let exp = {}

aws.config.update({
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    region: process.env.AWS_REGION
});
  
const allowedMimetypes = new Set([
    'image / jpeg',
    'image/png',
    'image/jpg',
]);
  
const fileFilter = (req, file, cb) => {
    if (allowedMimetypes.has(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error('Invalid file type!'), false);
    }
};
  
const s3 = new aws.S3();
const uploadObject = multer({
    storage: multerS3({
      fileFilter,
      s3: s3,
      bucket: process.env.AWS_BUCKET,
      acl: 'public-read',
      key: function (req, file, cb) {
        console.log('Uploading..');
        console.log(file);
        cb(null, file.originalname, err => {
          if (err) console.log(err);
        });
      }
    })
}).single('file');

exp.posts = async(req,res) => {
    try {
      uploadObject(req, res, async err => {
        if (err) {
          res.status(400).send({
            message: 'Invalid file type, Please send only valid notes!'
          });
        } else {
            let postID = uuid();
            let userID = req.session.key.userID;
            console.log(req.session.key.username);
            let postURl = req.file.location;
            let title  = req.body.title;
            let username  = req.session.key.username;
            let profileURL = req.session.key.profileURL;
            let loveCount = 0;
            let commentCount = 0;
            let err, result;
            [err, result] = await to (db.query("insert into posts values(?,?,?,?,?,?,?,?)", [postID, userID ,postURl , title , username, profileURL , loveCount, commentCount]));
            if(err) return res.sendError(err);
            return res.sendSuccess('posted');
        }
      });
    } catch (error) {
        return res.sendError(error);
    }
};

module.exports = exp; 