const AWS = require('aws-sdk');
const ddb = new AWS.DynamoDB.DocumentClient();

const prescriptionTable = process.env.table_name;

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
        KeyConditionExpression: "userId = :uId", 
        TableName: prescriptionTable
    };
    const { data, error } = await ddb.query(params);

    // result
    if(error){
        result.message = 'failed to retrieve data';
        result.error = error;
    } else{
        result.message = 'success';
        result.data = data.Items;
    }
    return result;
}

