(function(){

	String.prototype.endsWith = function(suffix) {
    	return this.indexOf(suffix, this.length - suffix.length) !== -1;
	};

	function isarray(val){
		return Object.prototype.toString.call( val ) === '[object Array]'
	}

	function load_single_js(src, callback){
		var scriptNode = document.createElement('script');
	    scriptNode.type = 'text/javascript';
	    scriptNode.src = src;

	    var headNode = document.getElementsByTagName('head');
	    if (headNode[0] != null)
	        headNode[0].appendChild(scriptNode);

	    if (callback != null)    
	    {
	        scriptNode.onreadystagechange = callback;            
	        scriptNode.onload = callback;
	    }
	};

	function load_single_css(src, callback){
		var node = document.createElement('link');
	    node.rel = "stylesheet";
	    node.href = src;

	    var headNode = document.getElementsByTagName('head');
	    if (headNode[0] != null)
	        headNode[0].appendChild(node);

	    if (callback != null)    
	    {
	        node.onreadystagechange = callback;            
	        node.onload = callback;
	    }
	};

	function load_single(src, callback){
		if(src.endsWith('.js')){
			return load_single_js(src, callback);
		}else if(src.endsWith('.css')){
			return load_single_css(src, callback);
		}
	}

	function load_multy(sources, callback){
		var src = sources.shift();
		if(src != undefined)
			load_single(src, function(){
				load_multy(sources, callback);
			});
		else
			if(callback){
				callback();
			}
	};


	this.loadcss = this.loadjs = this.load = function(src, callback){
		if(isarray(src))
			return load_multy(src, callback);
		else
			return load_single(src, callback);
	}

	this.load_local = function (content, callback){
		var scriptNode = document.createElement('script');
	    scriptNode.type = 'text/javascript';

	    var headNode = document.getElementsByTagName('head');
	    if (headNode[0] != null)
	        headNode[0].appendChild(scriptNode);

	    if (callback != null)    
	    {
	        scriptNode.onreadystagechange = callback;            
	        scriptNode.onload = callback;
	    }
	    scriptNode.innerHtml = content;		
	}
})(window);