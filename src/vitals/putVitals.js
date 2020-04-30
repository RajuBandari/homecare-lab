const AWS = require('aws-sdk');
const ddb = new AWS.DynamoDB.DocumentClient();

const vitalTable = process.env.table_name;

exports.handler = async function(event, context) {
    const result = {};

    //update params
    const params = {
        TableName: vitalTable,
        Key: {
            "id": event.params.userId
        },
        UpdateExpression: "set bmiValue = :x, #bmiColor = :y",
        ExpressionAttributeNames: {
            "#bmiColor": "bg-primary"
        },
        ExpressionAttributeValues: {
            ":x": event.params.bmiValue,
            ":y": event.params.bmiColor
        }
    };
    
    // db query
    const { data, error } = await ddb.updateItem(params);
    if(err) {
        result.message = 'failed to update data';
        result.error = error;
    } else {
        result.message = 'success'
        result.data = data;
    }
    return result;
}