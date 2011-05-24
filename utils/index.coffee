module.exports = (db, load) ->

    for module in load
        # Enable "namespaces" by using this instead:
        # namespace = this[module] = {}
        namespace = this
        require('./'+module+'.coffee')(namespace, db)
    
    # Some general helpers
    this.authed = (req, res) ->
        if not req.session.user
            res.redirect '/login?redirect='+req.url
            return false
        return true

    return this
