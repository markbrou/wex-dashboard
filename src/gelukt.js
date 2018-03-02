// https://medium.freecodecamp.org/securing-node-js-restful-apis-with-json-web-tokens-9f811a92bb52

module.exports = {
  'secret': 'supersecret'
};


var bcrypt = require('bcryptjs');
var config = require('./routes/config');

function authenticateUser(req, res, next) {
    var email = req.body.email;
    var password = req.body.password;

    db.any('SELECT * FROM users WHERE user_email = $1', [email])
      .then(function (data) {

        // Check if e-mail is found
        if (data.length === 0) {
            return res.status(200).send({
                auth: false,
                message: 'E-mail not found'
            });
        }

        // Compare submitted password with encrypted password hash
        if (!bcrypt.compareSync(password, data[0].user_password)) {
            return res.status(200).send({
                auth: false,
                message: 'Incorrect password'
            });
        }

        // Create a token
        var token = jwt.sign({
            user_id: data[0].user_id,
            user_email: data[0].user_email,
            first_name: data[0].first_name,
            last_name: data[0].last_name
        }, config.secret, {
            expiresIn: 86400
        });


        // Return the token to the client
        res.status(200).send({
            auth: true,
            token: token
        });
    })
    .catch(function (err) {
        return next(err);
    });
}

function testToken(req, res, next) {
        var token = req.headers['x-access-token'];
        if(!token) {
            return res.status(401).send({
                auth: false,
                message: 'Failed to authenticate token'
            });
        }

        jwt.verify(token, config.secret, function(err, decoded) {
            if (err) return res.status(500).send({
                auth: false,
                message: 'Failed to authenticate token'
            });

            res.status(200).send(decoded);
        });
}
