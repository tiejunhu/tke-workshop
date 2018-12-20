var express = require('express')
var http = require('http')
var ip = require('ip');
var fs = require('fs');

var app = express();

app.get('/', function (req, res) {
  var contents = "";
  if (fs.existsSync('/var/vol1/text')) {
    contents = fs.readFileSync('/var/vol1/text', 'utf8');
  }
  res.send('hello world from ' + ip.address() + "\n" + contents);
})

http.createServer(app).listen('8888', function() {
  console.log("server started at http://localhost:8888");
});