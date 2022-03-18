var mongoose = require("mongoose");

var CallSchema = new mongoose.Schema({
  userId: String,
  customerId: String,
  customerName: String,
  userName: String,
  customerMobile: String,
  setDateTime: Date,
  creationDateTime: Date,
  status: String,
  doDateTime: Date,
  enable: Number,
  comment: String,
  hashTags: String,
});

module.exports = mongoose.model("CallStatus", CallSchema, "CallStatus");
