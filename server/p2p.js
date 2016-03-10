'use strict';

class p2pMdwr {
  constructor(){
    this.hosts = {};
  }
  open(id, key, timeout){
    if (!(key in this.hosts)){
      if(!timeout){
        timeout = 20000;
      }

      this.hosts[key] = id;
      console.log('Add '+key+' by '+id);
      var that = this;

      setTimeout(function(){
        if(key in that.hosts){
          console.log('Timeout: ' + key);
          delete(that.hosts[key]);
        }
      }, timeout);

    }else{
      console.log('Error key already exist');
    }
  }
  connect(key, user, callback){
    if(key in this.hosts){

      var id = this.hosts[key];
      console.log('Host found: '+ id);
      delete(this.hosts[key]);
      callback(id, user);

    }else {
      console.log('Host not found');
    }
  }
}

module.exports = new p2pMdwr;
