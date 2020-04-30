const AWS = require('aws-sdk');
const ddb = new AWS.DynamoDB.DocumentClient();

const userTable = process.env.table_name;

exports.handler = async function(event, context) {
    let result = {};

    const params = {
        TableName: userTable,
        Item: {
            'email' : {S: event.params.email},
            'password' : {S: event.params.password},
            'firstName': {S: event.params.firstName},
            'lastName': {S: event.params.firstName}
        }
    };
    const { data, error } = await ddb.putItem(params);
    if(err) {
        result.message = 'failed to save data';
        result.error = error;
    } else {
        result.message = 'success'
        result.data = data;
    }
}