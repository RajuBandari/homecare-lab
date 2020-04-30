const AWS = require('aws-sdk');
const ddb = new AWS.DynamoDB.DocumentClient();

const userTable = process.env.table_name;

exports.handler = async function(event, context) {
    let result = {};

    // query params
    const userId = event.query.userId;

    //db query
    const params = {
        ExpressionAttributeValues: {
         "uId": {
           S: userId
          }, 
        },
        KeyConditionExpression: "id = :uId", 
        TableName: userTable
    };
    const { data, error } = await ddb.getItem(params);

    // result
    if(error){
        result.message = 'failed to retrieve data';
        result.error = error;
    } else{
        result.message = 'success';
        result.data = data.Item;
    }
    return result;
}

