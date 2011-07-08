# Database Helpers
module.exports = (u, db) ->
    async = require 'async'

    u.findItem = (type, id, redir, next, cb) ->
        # Hack-ish - if passed thing is already an object...
        if id.name
            return cb(id)
        item = db[type].get id
        if not item
            if next
                return next new u.NotFound("Unknown Item", redir, err)
            else
                console.log "unknown item"
        cb item
    
    u.getAll = (type, cb) ->
        res = []
        cbDone = () ->
            cb(res)
        db[type].forEach cbDone, (key, val) ->
            if val
                res.push(val)

    u.findUser = (id, next, cb) ->
        u.findItem 'users', id, '/users', next, cb

    u.findChore = (id, next, cb) ->
        u.findItem 'chores', id, '/chores', next, cb

    u.findGroup = (id, next, cb) ->
        u.findItem 'groups', id, '/groups', next, cb
        
    u.findLog = (id, next, cb) ->
        u.findItem 'logs', id, '/logs', next, cb
        
    u.findConflict = (id, next, cb) ->
        u.findItem 'conflicts', id, '/logs', next, cb

    u.getLog = (since, userid, choreid, next, cb) ->
        #if userid
        #    query.where('userid', userid)
        #if choreid
        #    query.where('choreid', userid)
        #query.sort('date', -1)
        #query.exec (err, logs) ->
        loglist = []
        cbLoop = () ->
            cb loglist
        db.logs.forEach cbLoop, (key, val) ->
            if true # date younger than since
                #loglist.push({
               loglist.splice(0,0,{
                   log: val
                   user: db.users.get val.userid
                   chore: db.chores.get val.choreid
               })

    console.log "loaded dbhelper"
