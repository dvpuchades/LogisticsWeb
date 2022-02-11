const Stack = require("./stack");

class HashTable{
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
        if(typeof this.map.get(key) != 'undefined'){
            return this.map.get(key).toList()
        }
        console.log('no key')
        return []
    }
}

module.exports = HashTable;