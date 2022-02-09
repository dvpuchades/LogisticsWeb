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
        let restaurant
        let brand

        if(typeof this.hashtable.get(user.brand.toString() + user.restaurant.toString()) == 'undefined'){
            restaurant = []
        }
        else{
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

        if(typeof this.hashtable.get(user.brand.toString()) == 'undefined'){
            brand = []
        }
        else{
            let list = this.hashtable.get(user.brand.toString())
            if(index < list[0].index){
                return {restaurant: [], brand: [], error: true}
            }
            let element = list.pop()
            while(index >= element.index){
                brand.push(element)
                element = list.pop()
            }
        }
        return {restaurant: restaurant, brand: brand, error: false}
    }
}

module.exports = new Buffer()