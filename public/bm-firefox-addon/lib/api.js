var Request = require("sdk/request").Request;

var api_url = "http://lilacpenguin.me:4567/api";


function apiCall(method, data, callback){
  if(callback == undefined){
    callback = data;
    data = undefined;
  }

  var url = api_url + '/' + method.replace('.', '/')+'/';
  console.log("sendind url "+ url);
  var content = undefined;
  if(data){
    content = { data: data };
    console.log('content.data: '+content.data);

  }
    
  
  var request = Request({
      url: url,
      content: content,
      onComplete: function (response) {
        if(callback)
          callback(response);
      }
  });

  if(data)
    request.post();
  else
    request.get();
}

function getFolders(callback){
    apiCall('folders.get', function(response){
      if(callback)
        callback(response.json);
    });
}

function sendNode(node, callback){
    var data = JSON.stringify(node);
    apiCall('node.add', data, function(response){
      if(callback)
        callback();
    });
}


exports.api = {
  sendNode: sendNode,
  getFolders: getFolders,
  apiCall: apiCall
};