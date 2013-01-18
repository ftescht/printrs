
Accounts.config
    sendVerificationEmail: false
    forbidClientAccountCreation: false

Accounts.onCreateUser (options, user) ->
    if user.username == "veshnyakov" or user.username == "gostev"
        user.group = 'admin'
    return user