const HashTable = require("./hashtable")

class Buffer{
    constructor(){
        this.hashtable = new HashTable()
    }

    //operation ['new', 'updated', 'deleted']

    /**
     * OPERATIONS
     * 'new'
     * 'update'
     * 'delete'
     * 
     * 'activate'   -> for users
     * 'deactivate'
     * 
     * 
     * TYPES
     * 'delivery'
     * 'user'
     * 'location'
     * 'restaurant'
     * 'notification' -> TODO
     */
    set(user, value, operation, type){
        let key
        if(typeof user.restaurant == 'undefined'){
            key = user.brand.toString()
        }else{
            key = user.brand.toString() + user.restaurant.toString()
        }
        this.hashtable.set(key, {content: value, index: Date.now(), operation: operation, type: type})
    }

    get(user, index){
        let restaurant = []
        let brand = []

        if(typeof user.restaurant != 'undefined'){
            let list = this.hashtable.get(user.brand.toString() + user.restaurant.toString())
            if(index < list[0].index){
                return {restaurant: [], brand: [], error: true}
            }
            let element = list.pop()
            while(index >= element.index){
                restaurant.push(element)
                element = list.pop()
            }
        }
        
        /**
         * Using this.hashtable.get(user.brand.toString())
         * you get a reference to the list in the Stack instance,
         * any change in this list will be reflected in the Stack
         * (Don't change that list)
         */
        let list = this.hashtable.get(user.brand.toString())
        if(list.length > 0){
            if(index < list[0].index){
                return {restaurant: [], brand: [], error: true}
            }
            for (let i = (list.length - 1); i > 0 && index <= list[i].index; i--) {
                brand.unshift(list[i]);
            }
        }
        return {restaurant: restaurant, brand: brand, error: false}
    }
}

module.exports = new Buffer()