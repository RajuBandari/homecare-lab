const AWS = require('aws-sdk');
const ddb = new AWS.DynamoDB.DocumentClient();

const prescriptionsTable = process.env.table_name;

exports.handler = async function(event, context) {
    let result = {};

    const params = {
        TableName: prescriptionsTable,
        Item: {
            'text' : {S: event.params.text},
            'date' : {S: new Date()},
            'userId': {S: event.params.userId}
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
    return result;
}