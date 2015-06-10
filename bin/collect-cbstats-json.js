/*
To run this program, you need to install dependencies by:
$ npm install
*/

var childProcess = require('child_process');
var couchbase = require('couchbase');
var uuid = require('node-uuid');

var hostname = process.argv[2];
var srcBucketName = process.argv[3];

if(typeof(hostname) === 'undefined'){
	console.log('hostname is required.');
	process.exit(1);
}

if(typeof(srcBucketName) === 'undefined') srcBucketName = 'default';

console.log('hostname=' + hostname);
console.log('srcBucketName=' + srcBucketName);


var timeout = null;
var cluster = null;
var bucket = null;
var interval = 5000;

var cbstatsPath = childProcess.exec('./get-cbstats-command.sh',
  function(error, stdout, stderror){
    if(error !== null){
      console.log('exec error: ' + error);
      return 1;
    }

		cluster = new couchbase.Cluster('127.0.0.1:8091');
		bucket = cluster.openBucket('cbstats', function(err, bucket){
			if(err) throw error;

			console.log('Connected to Couchbase.');
			collectStats(stdout.trim());
		});
});

var collectStats = function(cmdPath) {
	execCbstats(cmdPath);
	timeout = setTimeout(collectStats, interval, cmdPath);
}

var execCbstats = function(cmdPath) {

	var opt = ['-b', srcBucketName, '-j', hostname + ':11210', 'all'];
	var cmd = childProcess.spawn(cmdPath, opt);

	var json = '';	
	cmd.stdout.on('data', function (data) {
		json += data;
	});
	
	cmd.stderr.on('data', function (data) {
	  console.log('stderr: ' + data);
	});
	
	cmd.on('close', function (code) {
	  console.log('child process exited with code ' + code);

		var key = uuid.v4();
		bucket.upsert(uuid.v4(), json, function(err, result){
			if(err) throw err;
		});
	});

}

process.on('SIGINT', function(){
	clearTimeout(timeout);
	process.exit();
});


