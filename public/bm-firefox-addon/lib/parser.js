// parser.js - lpenguin's module
// author: lpenguin

function merge(obj1, obj2){
    for(var key in obj2){
        obj1[key] = obj2[key];
    }
    return obj1;
}

var parserClass = function(params){
    this.url = params.url;
    this.title = params.title;
    
    this.parseLine = function(line, command){
        if(line.match(/(bookmark)/)){
            command.type = 'bookmark';
        }else if(line.match(/(todo)/)){
            command.type = 'todo';
            command.text += line.replace(/(todo)/, '');
        }else if(line.match(/(folder)/)){
            command.folder = line.replace(/(folder)\s*/, '');
        }else if(line.match(/(note)/)){
            command.type = 'note';
            command.name = line.replace(/(note)\s*/, '');
        }else{
            command.text += line + "\n";
        }
        return command;
    }
    this.parse = function(text, params){
        var command = {
            url: this.url(),
            title: this.title(),
            text: ""
        }
        var lines = text.split('\n');
        for(var i in lines){
            var line = lines[i];
            command = this.parseLine(line, command);
        }
    
        
        return this.validate(command);
    }
    
    this.validate = function(command){
        //if(!command.type){
        //    command.type = "note";
    //    }
        if(command.type == 'todo'){
            if(!command.text){
                command.error = 'todo without text';
            }
        }
        return command;
    }
};

var Parser = function(params){
    return new parserClass(params);
}
exports.Parser = Parser;

