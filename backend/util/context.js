const Stack = require("./stack");

class ContextTable{
    constructor(){
        this.map = new Map();
    }

    set(key, value){
        if((typeof this.map.get(key)) == 'undefined'){
            this.map.set(key, new Stack([value]))
        }
        else{
            this.map.get(key).push(value)
        }
    }

    //return an array
    get(key){
        return this.map.get(key).toList()
    }
}


module.exports = new ContextTable();