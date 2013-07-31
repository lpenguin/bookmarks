(function(){
	if(this.Bookmarks == undefined)
		this.Bookmarks = {};
	var Bookmarks = this.Bookmarks;
	Bookmarks.resources = {
		libs:[
			'lib/jquery.min.js',
			'lib/panel.js',
			'lib/codemirror/lib/codemirror.js',
			'lib/codemirror/addon/hint/show-hint.js',
			'lib/codemirror/addon/hint/bookmark-hint.js',
			'lib/codemirror/mode/bookmark/bookmark.js',
		],
		css: [
    		"lib/codemirror/lib/codemirror.css",
    		"lib/codemirror/addon/hint/show-hint.css",
		]};


	function loadResources(callback){
		appendResources();
		loadcss(Bookmarks.resources.css);
		loadjs(Bookmarks.resources.libs, callback);

	}

	function appendResources(){

		var types = ['libs', 'css'];
		for (var i = 0; i < types.length; i++) {
			var type = types[i];
			for (var i = 0; i < Bookmarks.resources[type].length; i++) {
				Bookmarks.resources[type][i] = Bookmarks.options.root_url + Bookmarks.resources[type][i];
			};
		};
		
	}
	// function loadLocalResource(resource_id, callback){
	// 	return this.loadjs_local(Bookmarks.resources[resource_id], callback);
	// }
var folders = {
        name: "root",
        children: [{
          name: "dev",
          children: [{
            name: "f1",
            children: [{
              name: "f2"
            },{
              name: "f4"
            }]
          },{
            name: "f5"
          }]
        }]
      };

	Bookmarks.create = function(options){
		if(!options)
			options = {};
		Bookmarks.options = options;

		loadResources(function(){
			var panel = new Panel({folders:folders});
		});
	}

	
})(window);