const { Mutex } = require("async-mutex");

class Stack{
    constructor(list){
        this.limit = 1000
        this.list = list
        this.lock = new Mutex()
    }

    push(item){
        this.lock.runExclusive(this._push.bind(this, item))
    }

    _push(item){
        if(this.list.length == this.limit){
            this.list.shift()
        }
        this.list.push(item)
    }

    toList(){
        return this.list
    }
}


module.exports = Stack;