var mongoose = require("mongoose");

var UserSchema = new mongoose.Schema({
  name: String,
  company: String,
  telephone: String,
  creationDate: Date,
  enable: Boolean,
  mangerId:String,
  paymentStatus: Boolean,
  applicationVersion: String,
  gender: Boolean,
  age: Number,
  workScope: String,
  comment: String,
  enableComment: String,
  profilePhoto:String,
});

module.exports = mongoose.model("user", UserSchema, "Users");
