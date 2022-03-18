var mongoose = require("mongoose");


var CustomerSchema = new mongoose.Schema({
  name: String,
  company: String,
  telephone: String,
  creationDate: Date,
  enable: Boolean,
  bank: String,
  workgroup:String,
  comment: String,
  enableComment: String,
  creationUserList: [{type:String}],
});

module.exports = mongoose.model("customer", CustomerSchema, "Customers");
