const { Mutex } = require("async-mutex");

const two_hours = 7200000 //miliseconds
const four_hours = 14400000 //miliseconds

class Stack{
    constructor(list){
        this.limit = 1000
        this.list = list
        this.lock = new Mutex()

        setInterval(this.clean.bind(this), four_hours)
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

    clean(){
        let current = Date.now()
        let element = this.list[0]
        while((typeof element != 'undefined') && ((current - element.index) > two_hours)){
            this.list.shift()
            element = this.list[0]
        }
    }

    toList(){
        return this.list
    }
}


module.exports = Stack;