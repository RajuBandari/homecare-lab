const AWS = require('aws-sdk');
const ddb = new AWS.DynamoDB.DocumentClient();

const vitalTable = process.env.table_name;

exports.handler = async function(event, context) {
    let result = {};

    const params = {
        TableName: vitalTable,
        Item: {
            'age' : {S: event.params.age},
            'mobile' : {S: event.params.mobile},
            'heightInInches' : {S: event.params.heightInInches},
            'heightInFeet' : {S: event.params.heightInFeet},
            'systolic' : {S: event.params.systolic},
            'diastolic' : {S: event.params.diastolic},
            'hb1Ac' : {S: event.params.hb1Ac},
            'bloodSugar' : {S: event.params.bloodSugar},
            'meanblood': {S: event.params.meanblood},
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