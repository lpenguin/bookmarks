(function(){
	function Panel(options){
		if(!options)
			options = {};
		this.folders = options.folders;
		var div;
		var editor;
		var self = this;

		function constructDiv(){
			div = $("<div></div>");
			div.css({
				position: 'absolute',
				top: '100px',
				left: '100px',
				width: '400px',
				height: '300px',
				'border-style': 'solid',
				'border-width': '1',
				'border-color': 'gray',
				'border-radius': '5px',
				padding: '5px'

			});

			div.append("<textarea id=\"code\" name=\"code\"></textarea>");
			div.appendTo($('body'));
		}
		var completed = false;

		function setupEditor(){
		      CodeMirror.commands.autocomplete = function(cm) {
		        CodeMirror.showHint(cm, CodeMirror.bookmarkHint, {root: self.folders, completeSingle: false});
		      }
		      var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
		        lineNumbers: true,
		        extraKeys: {"Ctrl-Space": "autocomplete"},
		        mode: "bookmark",

		      });
		      editor.on("cursorActivity", function(ed){
		        if (completed){
		          completed = false;
		        }else{
		          if(CodeMirror.bookmarkHint_isPrevFolder(editor)){
		            setTimeout(function(){
		              CodeMirror.showHint(ed, CodeMirror.bookmarkHint, {root: self.folders, completeSingle: false}); 
		            }, 10);  
		          }else{
		              CodeMirror.showHint(ed, CodeMirror.bookmarkHint, {root: self.folders, completeSingle: false}); 
		          }
		          
		        }
		          
		      });


		      editor.on("endCompletion", function(ed){
		        completed = true;
		      });
		      return editor;
		}
		constructDiv();	
		editor = setupEditor();

		this.setFolders = function(folders){
			this.folders = folders;
		}
	};
	this.Panel = Panel;
})(window);