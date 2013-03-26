
Accounts.config
    sendVerificationEmail: false
    forbidClientAccountCreation: true

Accounts.onCreateUser (options, user) ->
    #if user.username == 'admin' or user.username == 'administrator'
    #    user.group = 'admin'
    return user