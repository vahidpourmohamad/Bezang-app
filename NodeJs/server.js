const express = require("express");
const app = express();
const bodyParser = require("body-parser");
var mongoose = require("mongoose");
const { MongoClient } = require("mongodb");
var UserModel = require("./userschema");

var CustomerModel = require("./customerschema");

var CallModel = require("./callschema");
// create application/json parser
var jsonParser = bodyParser.json();

// create application/x-www-form-urlencoded parser
var urlencodedParser = bodyParser.urlencoded({ extended: false });
//MongoDb Uri
const uri = "";

const client = new MongoClient(uri, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Connecting to database
const db = uri;
mongoose.Promise = global.Promise;
mongoose.connect(
  db,
  { useNewUrlParser: true, useUnifiedTopology: true },
  function (error) {
    if (error) {
      console.log("Error!" + error);
    }
  }
);

client.connect((err) => {
  const collection = client.db("CallSale").collection("CallSale");
  // perform actions on the collection object
  client.close();
});

////////////////////////////////////////////////
////////////////Report//////////////////////////
////////////////////////////////////////////////
function countstatuscalls(p1, startday, endday, userid) {
  CallModel.countDocuments({
    userId: userid,
    //creationDateTime: Date.now(),
    creationDateTime: { $gte: startday, $lt: endday },
    //enable: 1,
    status: p1,
  }).exec(function (err, count) {
    var temp = count;
    console.log(temp);
    return temp;
  });
  return 0;
  // The function returns the product of p1 and p2
}

app.post("/countstatuscalls", jsonParser, function (req, res) {
  var startday = new Date();
  startday.setHours(0, 0, 0);
  var endday = new Date();
  endday.setHours(23, 59, 59);

  CallModel.countDocuments({
    userId: req.body.userId,
    //creationDateTime: Date.now(),
    creationDateTime: { $gte: startday, $lt: endday },
    status: req.body.status,
  }).exec(function (err, count) {
    var temp = count;
    console.log(req.body.userId);
    res.send(temp.toString());
  });
});

app.post("/countprogessscallsmonth", jsonParser, function (req, res) {
  var startday = new Date();
  startday.setHours(0, 0, 0);
  startday.setDate(1);
  var endday = new Date();
  endday.setHours(23, 59, 59);
  endday.setDate(30);

  CallModel.countDocuments({
    userId: req.body.userId,
    //creationDateTime: Date.now(),
    creationDateTime: { $gte: startday, $lt: endday },
    $or: [
      { status: "3" },
      { status: "4" },
      { status: "6" },
      { status: "7" },
      { status: "9" },
    ],
  }).exec(function (err, count) {
    var temp = count;
    console.log(req.body.userId);
    res.send(temp.toString());
  });
});

app.post("/countstatuscallsmonth", jsonParser, function (req, res) {
  var startday = new Date();
  startday.setHours(0, 0, 0);
  startday.setDate(1);
  var endday = new Date();
  endday.setHours(23, 59, 59);
  endday.setDate(30);

  CallModel.countDocuments({
    userId: req.body.userId,
    //creationDateTime: Date.now(),
    creationDateTime: { $gte: startday, $lt: endday },
    status: req.body.status,
  }).exec(function (err, count) {
    var temp = count;
    console.log(req.body.userId);
    res.send(temp.toString());
  });
});

app.post("/countcallsmonth", jsonParser, function (req, res) {
  var startday = new Date();
  startday.setHours(0, 0, 0);
  startday.setDate(1);
  var endday = new Date();
  endday.setHours(23, 59, 59);
  endday.setDate(30);

  CallModel.countDocuments({
    userId: req.body.userId,
    //creationDateTime: Date.now(),
    creationDateTime: { $gte: startday, $lt: endday },
  }).exec(function (err, count) {
    var temp = count;
    console.log(req.body.userId);
    res.send(temp.toString());
  });
});
app.post("/countprogessscalls", jsonParser, function (req, res) {
  var startday = new Date();
  startday.setHours(0, 0, 0);
  var endday = new Date();
  endday.setHours(23, 59, 59);

  CallModel.countDocuments({
    userId: req.body.userId,
    //creationDateTime: Date.now(),
    creationDateTime: { $gte: startday, $lt: endday },
    $or: [
      { status: "3" },
      { status: "4" },
      { status: "6" },
      { status: "7" },
      { status: "9" },
    ],
  }).exec(function (err, count) {
    var temp = count;
    console.log(req.body.userId);
    res.send(temp.toString());
  });
});

app.post("/userreport", jsonParser, function (req, res) {
  var startday = new Date();
  startday.setHours(0, 0, 0);
  var endday = new Date();
  endday.setHours(23, 59, 59);
  var startdaystring = startday.toISOString();
  var enddaystring = endday.toISOString();
  var userid = "616f06f0642e4c03210141d4";
  var CallMonth = 0;
  var CallDay = 0;
  var StatusDay1 = 0;
  var StatusDay2 = 0;
  var StatusDay3 = 0;
  var StatusDay4 = 0;
  var StatusDay5 = 0;
  var StatusDay6 = 0;
  var StatusDay7 = 0;
  var StatusDay8 = 0;
  var StatusDay9 = 0;
  var StatusMonth1 = 301;
  var StatusMonth2 = 302;
  var StatusMonth3 = 303;
  var StatusMonth4 = 304;
  var StatusMonth5 = 305;
  var StatusMonth6 = 306;
  var StatusMonth7 = 307;
  var StatusMonth8 = 308;
  var StatusMonth9 = 309;
  var InProgressCount = 102;
  var NewCustomerMonth = 103;
  //CallMonth*CallDay*status1*....*status2*InProgressCount*NewCoustomerCountMonth
  var StatusDay1 = countstatuscalls("1", startday, endday, userid);

  var StatusDay2 = countstatuscalls("2", startday, endday, userid);

  var StatusDay3 = countstatuscalls("3", startday, endday, userid);

  var StatusDay4 = countstatuscalls("4", startday, endday, userid);

  var StatusDay5 = countstatuscalls("5", startday, endday, userid);

  var StatusDay6 = countstatuscalls("6", startday, endday, userid);

  var StatusDay7 = countstatuscalls("7", startday, endday, userid);

  var StatusDay8 = countstatuscalls("8", startday, endday, userid);

  var StatusDay9 = countstatuscalls("9", startday, endday, userid);

  CallDay =
    StatusDay1 +
    StatusDay2 +
    StatusDay3 +
    StatusDay4 +
    StatusDay5 +
    StatusDay6 +
    StatusDay7 +
    StatusDay8 +
    StatusDay9;
  console.log(startday);
  console.log(StatusDay3);
  console.log(
    CallMonth +
      "*" +
      CallDay +
      "*" +
      StatusDay1 +
      "*" +
      StatusDay2 +
      "*" +
      StatusDay3 +
      "*" +
      StatusDay4 +
      "*" +
      StatusDay5 +
      "*" +
      StatusDay6 +
      "*" +
      StatusDay7 +
      "*" +
      StatusDay8 +
      "*" +
      StatusDay9 +
      "*" +
      StatusMonth1 +
      "*" +
      StatusMonth2 +
      "*" +
      StatusMonth3 +
      "*" +
      StatusMonth4 +
      "*" +
      StatusMonth5 +
      "*" +
      StatusMonth6 +
      "*" +
      StatusMonth7 +
      "*" +
      StatusMonth8 +
      "*" +
      StatusMonth9 +
      "*" +
      InProgressCount +
      "*" +
      NewCustomerMonth +
      "*"
  );
  res.send(
    CallMonth +
      "*" +
      CallDay +
      "*" +
      StatusDay1 +
      "*" +
      StatusDay2 +
      "*" +
      StatusDay3 +
      "*" +
      StatusDay4 +
      "*" +
      StatusDay5 +
      "*" +
      StatusDay6 +
      "*" +
      StatusDay7 +
      "*" +
      StatusDay8 +
      "*" +
      StatusDay9 +
      "*" +
      StatusMonth1 +
      "*" +
      StatusMonth2 +
      "*" +
      StatusMonth3 +
      "*" +
      StatusMonth4 +
      "*" +
      StatusMonth5 +
      "*" +
      StatusMonth6 +
      "*" +
      StatusMonth7 +
      "*" +
      StatusMonth8 +
      "*" +
      StatusMonth9 +
      "*" +
      InProgressCount +
      "*" +
      NewCustomerMonth +
      "*"
  );
  //console.log(req.body._id);
});

/*
This Section For User Group 
*/

app.post("/findusersofgroupbymanagerid", jsonParser, function (req, res) {
  //console.log(req.body.telephone);
  UserModel.find({ mangerId: req.body.mangerId }, function (err, data) {
    if (err) {
      console.log(err);
    } else {
      res.send(data);
      //console.log(req.body._id);
    }
  });
});

app.post("/manageridtonullbyuserid", jsonParser, function (req, res) {
  console.log(req.body._id);
  UserModel.updateOne(
    { _id: req.body._id },
    {
      mangerId: "0",
    },
    function (err, data) {
      if (err) {
        console.log(err);
      } else {
        res.send(data);
        console.log("Data updated!");
      }
    }
  );
});

////////////////////////////////////////////////
////////////this section for User DB Logic//////
////////////////////////////////////////////////

app.post("/finduserbymobile", jsonParser, function (req, res) {
  //console.log(req.body.telephone);
  UserModel.find({ telephone: req.body.telephone }, function (err, data) {
    if (err) {
      console.log(err);
    } else {
      res.send(data);
      //console.log(req.body._id);
    }
  });
});

app.post("/finduserbyname", jsonParser, function (req, res) {
  //console.log(req.body.telephone);
  UserModel.find({ name: req.body.name }, function (err, data) {
    if (err) {
      console.log(err);
    } else {
      res.send(data);
      //console.log(req.body._id);
    }
  });
});

app.post("/finduserbyid", jsonParser, function (req, res) {
  //console.log(req.body._id);
  UserModel.find({ _id: req.body._id }, function (err, data) {
    if (err) {
      console.log(err);
    } else {
      res.send(data);
      //     console.log(req.body._id);
    }
  });
});

app.post("/replaceuser", jsonParser, function (req, res) {
  console.log(req.body._id);
  UserModel.updateOne(
    { _id: req.body._id },
    {
      name: req.body.name,
      company: req.body.company,
      telephone: req.body.telephone,
      creationDate: req.body.creationDate,
      enable: req.body.enable,
      mangerId: req.body.mangerId,
      paymentStatus: req.body.paymentStatus,
      applicationVersion: req.body.applicationVersion,
      gender: req.body.gender,
      age: req.body.age,
      workScope: req.body.workScope,
      comment: req.body.comment,
      enableComment: req.body.enableComment,
    },
    function (err, data) {
      if (err) {
        console.log(err);
      } else {
        res.send(data);
        console.log("Data updated!");
      }
    }
  );
});
app.post("/userinsertone", jsonParser, function (req, res) {
  // console.log(req.body);
  var newUser = new UserModel();
  newUser.name = req.body.name;
  newUser.company = req.body.company;
  newUser.telephone = req.body.telephone;
  newUser.creationDate = req.body.creationDate;
  newUser.enable = req.body.enable;
  newUser.mangerId = req.body.mangerId;
  newUser.paymentStatus = req.body.paymentStatus;
  newUser.applicationVersion = req.body.applicationVersion;
  newUser.gender = req.body.gender;
  newUser.age = req.body.age;
  newUser.workScope = req.body.workScope;
  newUser.comment = req.body.comment;
  newUser.enableComment = req.body.enableComment;
  newUser.save(function (err, data) {
    if (err) {
      console.log(err);
    } else {
      res.send("Data inserted");
    }
  });
});

///////////////////////////////////////////////
////////////this section for Call DB Logic/
///////////////////////////////////////////////

app.post("/findcallbyid", jsonParser, function (req, res) {
  //console.log(req.body.telephone);
  CallModel.find({ _id: req.body._id }, function (err, data) {
    if (err) {
      console.log(err);
    } else {
      res.send(data);
      //console.log(req.body._id);
    }
  });
});

app.post("/findcallbyuser", jsonParser, function (req, res) {
  //console.log(req.body.telephone);
  CallModel.find({ userId: req.body.userId }, function (err, data) {
    if (err) {
      console.log(err);
    } else {
      res.send(data);
      //console.log(req.body._id);
    }
  });
});
app.post("/findcustomercallhistory", jsonParser, function (req, res) {
  //console.log(req.body.telephone);
  CallModel.find(
    { userId: req.body.userId, customerMobile: req.body.mobile },
    function (err, data) {
      if (err) {
        console.log(err);
      } else {
        res.send(data);
        //console.log(req.body._id);
      }
    }
  );
});
app.post("/findenabledinprogresscallbyuser", jsonParser, function (req, res) {
  CallModel.find(
    {
      userId: req.body.userId,
      enable: true,
      setDateTime: { $lte: req.body.fromDate },
    },
    function (err, data) {
      if (err) {
        console.log(err);
      } else {
        res.send(data);
        // console.log(req.body.userId);
        //  console.log("Heloop");
        //console.log(data);
      }
    }
  );
});
app.post("/findenabledcallbyuser", jsonParser, function (req, res) {
  //console.log(req.body.telephone);
  CallModel.find(
    { userId: req.body.userId, enable: true },
    function (err, data) {
      if (err) {
        console.log(err);
      } else {
        res.send(data);
        //console.log(req.body._id);
      }
    }
  );
});
app.post("/findcallbycustomer", jsonParser, function (req, res) {
  //console.log(req.body.telephone);
  CallModel.find({ customerId: req.body.customerId }, function (err, data) {
    if (err) {
      console.log(err);
    } else {
      res.send(data);
      //console.log(req.body._id);
    }
  });
});

app.post("/findcallbycreatedate", jsonParser, function (req, res) {
  //console.log(req.body._id);
  CallModel.find(
    { creationDateTime: req.body.creationDateTime },
    function (err, data) {
      if (err) {
        console.log(err);
      } else {
        res.send(data);
        //     console.log(req.body._id);
      }
    }
  );
});

app.post("/findcallbysetting", jsonParser, function (req, res) {
  console.log(req.body);
  if (req.body.name != "") {
    if (req.body.status != "0") {
      //creation with date from date to and name without status and mobile Condition 1
      //createdAt:{$gte:ISODate("2021-01-01"),$lt:ISODate("2020-05-01"}
      console.log(req.body);
      console.log("Condition 1");
      CallModel.find(
        {
          creationDateTime: { $gte: req.body.datefrom, $lt: req.body.dateto },
          enable: 1,
          status: req.body.status,
          customerName: req.body.name,
          userId: req.body.userId,
        },
        function (err, data) {
          if (err) {
            console.log(err);
          } else {
            res.send(data);
            //     console.log(req.body._id);
          }
        }
      );
    } else {
      //creation with date from date to and name  status without  mobile Condition 2
      console.log(req.body);
      console.log("Condition 2");
      CallModel.find(
        {
          $and: [
            {
              creationDateTime: {
                $gte: req.body.datefrom,
                $lt: req.body.dateto,
              },
            },
            { enable: 1 },
            { userId: req.body.userId },
            { customerName: req.body.name },
          ],
        },
        function (err, data) {
          if (err) {
            console.log(err);
          } else {
            res.send(data);
            console.log(data);
          }
        }
      );
    }
  } else {
    if (req.body.mobile != "") {
      if (req.body.status != "0") {
        //creation with date from date to and name without status and mobile Condition 1
        console.log(req.body);
        console.log("Condition 3");
        CallModel.find(
          {
            creationDateTime: { $gte: req.body.datefrom, $lt: req.body.dateto },
            enable: 1,
            status: req.body.status,
            customerMobile: req.body.mobile,
            userId: req.body.userId,
          },
          function (err, data) {
            if (err) {
              console.log(err);
            } else {
              res.send(data);
              //     console.log(req.body._id);
            }
          }
        );
      } else {
        //creation with date from date to and name  status without  mobile Condition 2
        console.log(req.body);
        console.log("Condition 4");
        CallModel.find(
          {
            creationDateTime: { $gte: req.body.datefrom, $lt: req.body.dateto },
            enable: 1,
            customerMobile: req.body.mobile,
            userId: req.body.userId,
          },
          function (err, data) {
            if (err) {
              console.log(err);
            } else {
              res.send(data);
              //     console.log(req.body._id);
            }
          }
        );
      }
    } else {
      if (req.body.status != "0") {
        //creation with date from date to and name without status and mobile Condition 1
        console.log(req.body);
        console.log("Condition 5");
        CallModel.find(
          {
            creationDateTime: { $gte: req.body.datefrom, $lt: req.body.dateto },
            enable: 1,
            status: req.body.status,
            userId: req.body.userId,
          },
          function (err, data) {
            if (err) {
              console.log(err);
            } else {
              res.send(data);
              //     console.log(req.body._id);
            }
          }
        );
      } else {
        //creation with date from date to and name  status without  mobile Condition 2
        console.log(req.body);
        console.log("Condition 6");
        CallModel.find(
          {
            creationDateTime: { $gte: req.body.datefrom, $lt: req.body.dateto },
            enable: 1,
            userId: req.body.userId,
          },
          function (err, data) {
            if (err) {
              console.log(err);
            } else {
              res.send(data);
              //     console.log(req.body._id);
            }
          }
        );
      }
    }
  }
});
app.post("/findcallbysetdate", jsonParser, function (req, res) {
  //console.log(req.body._id);
  CallModel.find({ setDateTime: req.body.setDateTime }, function (err, data) {
    if (err) {
      console.log(err);
    } else {
      res.send(data);
      //     console.log(req.body._id);
    }
  });
});

app.post("/findcallbydodate", jsonParser, function (req, res) {
  //console.log(req.body._id);
  CallModel.find({ doDateTime: req.body.doDateTime }, function (err, data) {
    if (err) {
      console.log(err);
    } else {
      res.send(data);
      //     console.log(req.body._id);
    }
  });
});

app.post("/replacecall", jsonParser, function (req, res) {
  console.log(req.body._id);
  CallModel.updateOne(
    { _id: req.body._id },
    {
      userId: req.body.userId,
      customerId: req.body.customerId,
      setDateTime: req.body.setDateTime,
      creationDateTime: req.body.creationDateTime,
      status: req.body.status,
      doDateTime: req.body.doDateTime,
      enable: req.body.enable,
      comment: req.body.comment,
      hashtags: req.body.hashtags,
    },
    function (err, data) {
      if (err) {
        console.log(err);
      } else {
        res.send(data);
        console.log("Data updated!");
      }
    }
  );
});

app.post("/callinsertone", jsonParser, function (req, res) {
  // console.log(req.body);
  CallModel.updateMany(
    { userId: req.body.userId, customerId: req.body.customerId },
    { enable: 0 },
    function (err, data) {
      if (err) {
        console.log(err);
      } else {
        // res.send(data);
        console.log("Data updated!");
        var newCallModel = new CallModel();
        newCallModel.userId = req.body.userId;
        newCallModel.customerId = req.body.customerId;
        newCallModel.setDateTime = req.body.setDateTime;
        newCallModel.creationDateTime = req.body.creationDateTime;
        newCallModel.status = req.body.status;
        newCallModel.doDateTime = req.body.doDateTime;
        newCallModel.enable = req.body.enable;
        newCallModel.comment = req.body.comment;
        newCallModel.customerName = req.body.customerName;
        newCallModel.userName = req.body.userName;
        newCallModel.customerMobile = req.body.customerMobile;
        newCallModel.hashTags = req.body.hashTags;
        console.log(req.body);
        newCallModel.save(function (err, data) {
          if (err) {
            console.log(err);
          } else {
            res.send("Data inserted");
            console.log("OK");
          }
        });
      }
    }
  );
});

///////////////////////////////////////////////
////////////this section for Customer DB Logic/
///////////////////////////////////////////////
/*Retrun Customer By bank and User ID */
app.get("/testcount", jsonParser, function (req, res) {
  var status1, status2, status3;
  CallModel.countDocuments({
    userId: req.body.userId,
    creationDateTime: Date.now(),
    //creationDateTime: { $gte: req.body.datefrom, $lt: req.body.dateto },
    //enable: 1,
    //status: req.body.statusID
  }).exec(function (err, count) {
    var countjson = { count: count };
    // Get a random entry
    // Tada! random user
    console.log(count);
    //console.log(Date.now().toLocaleDateString());
    // res.send(count);
    res.contentType("application/json");
    res.send(JSON.stringify(countjson));
  });
});

/*Retrun Customer By bank and User ID */
app.post("/findcustomerbybankandusercall", jsonParser, function (req, res) {
  CustomerModel.count().exec(function (err, count) {
    // Get a random entry
    var random = Math.floor(Math.random() * count);

    // Again query all users but only fetch one offset by our random #
    CustomerModel.findOne({ bank: req.body.bank })
      .skip(random)
      .exec(function (err, result) {
        // Tada! random user
        console.log(result);
        console.log(err);
        res.send(result);
      });
  });
});

app.post("/findcustomerbymobilebybank", jsonParser, function (req, res) {
  //console.log(req.body.telephone);
  CustomerModel.find(
    { bank: req.body.bank, telephone: req.body.telephone },
    function (err, data) {
      if (err) {
        console.log(err);
      } else {
        res.send(data);
        console.log(data);
      }
    }
  );
});

app.post("/findcustomerbymobile", jsonParser, function (req, res) {
  //console.log(req.body.telephone);
  CustomerModel.find({ telephone: req.body.telephone }, function (err, data) {
    if (err) {
      console.log(err);
    } else {
      res.send(data);
      console.log(data);
    }
  });
});

app.post("/findcoustomerbyname", jsonParser, function (req, res) {
  //console.log(req.body.telephone);
  CustomerModel.find({ name: req.body.name }, function (err, data) {
    if (err) {
      console.log(err);
    } else {
      res.send(data);
      //console.log(req.body._id);
    }
  });
});

app.post("/findcustomerbyid", jsonParser, function (req, res) {
  //console.log(req.body._id);
  CustomerModel.find({ _id: req.body._id }, function (err, data) {
    if (err) {
      console.log(err);
    } else {
      res.send(data);
      //     console.log(req.body._id);
    }
  });
});

app.post("/replacecustomer", jsonParser, function (req, res) {
  console.log(req.body._id);
  CustomerModel.updateOne(
    { _id: req.body._id },
    {
      name: req.body.name,
      company: req.body.company,
      telephone: req.body.telephone,
      creationDate: req.body.creationDate,
      enable: req.body.enable,
      bank: req.body.bank,
      workgroup: req.body.workgroup,
      comment: req.body.comment,
      enableComment: req.body.enableComment,
      creationUserList: req.body.creationUserList,
    },
    function (err, data) {
      if (err) {
        console.log(err);
      } else {
        res.send(data);
        console.log("Data updated!");
      }
    }
  );
});

app.post("/customerinsertone", jsonParser, function (req, res) {
  console.log(req.body);
  var newCustomer = new CustomerModel();
  newCustomer.name = req.body.name;
  newCustomer.company = req.body.company;
  newCustomer.telephone = req.body.telephone;
  newCustomer.creationDate = req.body.creationDate;
  newCustomer.enable = req.body.enable;
  newCustomer.bank = req.body.bank;
  newCustomer.workgroup = req.body.workgroup;
  newCustomer.comment = req.body.comment;
  newCustomer.enableComment = req.body.enableComment;
  newCustomer.creationUserList = req.body.creationUserList;
  newCustomer.save(function (err, data) {
    if (err) {
      console.log(err);
    } else {
      res.send("Data inserted");
      console.log("Data inserted");
    }
  });
});

app.get("/username", function (req, res) {
  console.log(`Server tettt listening on چچچچچ${PORT}...`);
  MongoClient.connect(uri, function (err, db) {
    if (err) throw err;
    var dbo = db.db("CallSale");
    var myobj = { name: "Company Inc", address: "Highway 37" };
    dbo.collection("CallSale").insertOne(myobj, function (err, res) {
      if (err) throw err;
      console.log("1 document inserted");
      db.close();
    });
  });
});

var job = [
  { name: "خدماتی", ID: 1 },
  { name: "صنعتی", ID: 2 },
  { name: "کشاورزی", ID: 3 },
  { name: "بازرگانی", ID: 4 },
  { name: "صنایع تبدیلی کشاورزی", ID: 5 },
  { name: "عمومی", ID: 6 },
  { name: "فناوری اطلاعات", ID: 7 },
  { name: "مهندسی", ID: 1 },
  { name: "مواد و ریخته گری", ID: 2 },
  { name: "صنعت خودرو", ID: 3 },
  { name: "صنعت برق", ID: 4 },
  { name: "مبلمان و پرده", ID: 5 },
  { name: "لوازم الکترونیکی", ID: 6 },
  { name: "لوازم خانگی", ID: 7 },
  { name: "شیلات", ID: 1 },
  { name: "دامداری", ID: 2 },
  { name: "حمل و نقل", ID: 3 },
  { name: "جهانگردی و هتلداری", ID: 4 },
  { name: "سلامت", ID: 5 },
  { name: "البسه", ID: 6 },
  { name: "چاپ و بسته بندی", ID: 7 },
  { name: "آموزش", ID: 1 },
  { name: "صنایع با فناوری بالا", ID: 2 },
  { name: "فرهنگ و هنر", ID: 3 },
  { name: "تعاونی", ID: 4 },
  { name: "معدن", ID: 5 },
  { name: "بیمه", ID: 6 },
  { name: "بانک و موسسه مالی", ID: 7 },
];
app.get("/getjob", function (req, res) {
  console.log(`Server tettt listening on چچچچچ${PORT}...`);
  console.log(JSON.stringify(job));
  res.contentType("application/json");
  res.send(JSON.stringify(job));
});
var banks = [
  {
    name: "مدیران شمال کشور",
    Id: 1,
  },
  {
    name: "مدیران خراسانی",
    Id: 2,
  },
];
app.get("/getbanks", function (req, res) {
  res.contentType("application/json");
  res.send(JSON.stringify(banks));
});
app.get("/version", function (req, res) {
  //res.contentType("application/json");
  res.send("0.0.9");
});
app.get("/news", function (req, res) {
  //res.contentType("application/json");
  res.send("سلام خبری هست خبر مهم");
});

app.get("/deletecall", function (req, res) {
  //res.contentType("application/json");
  CallModel.deleteMany({ userId: "6181fb8321c05805400652b4" }, function (err) {
    if (err) console.log(err);
    console.log("Successful deletion");
  });
  CallModel.Delete;
});

// Listen to the App Engine-specified port, or 8080 otherwise
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server tettt listening on port ${PORT}...`);
});
