class Context {
    constructor() {
        this.counter = 0;
        this.setInterval(() => {
            this.counter++;
        }, 1000);
    }
}

let context = new Context();
export default context