
Accounts.config
    sendVerificationEmail: false
    forbidClientAccountCreation: false

Accounts.onCreateUser (options, user) ->
    console.log options
    console.log user
    if user.username == "veshnyakov" or user.username == "gostev"
        user.group = 'admin'
    return user